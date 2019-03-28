function routes=PFIH(A, B, capacity)

r=0;
route=[];
routes=[];
costs=minimumCost(A,B);
sortedCosts=sortrows(costs')';
sortedCustomers=sortedCosts(2,:);
reverseCustomers=0;

while not(isempty(sortedCustomers))
    r=r+1;
    routeCapacity=capacity;
    j=sortedCustomers(1);%firstCustomer
    sortedCustomers(1)=[];
    route=j;
    routeCapacity = routeCapacity - A(j,3);
    i=length(sortedCustomers);
    reverseCustomers = fliplr(sortedCustomers);
    if (isempty(reverseCustomers))
        routes(r,1:length(route))=route;
    end
    while i>0
        j=reverseCustomers(i);
        if (A(j,3)<routeCapacity)
            routeCapacity = routeCapacity - A(j,3);
            costs = costToAdd(route, j, B);
            costs = sortrows(costs')';
            routePosition = costs(2,1);
            if (isTimeFactible(A, B, route, routePosition+1, j))
                route = addAt(route, j, routePosition);
                reverseCustomers = removeElement(reverseCustomers, i, 1);
            end
            i = i-1;
            sortedCustomers= fliplr(reverseCustomers);
        else
            routes(r,1:length(route))=route;
            i=i-1;
            sortedCustomers= fliplr(reverseCustomers);
        end
    end
    if(isempty(sortedCustomers))
        routes(r,1:length(route))=route;
    end  
    routes(r,1:length(route))=route;
end
