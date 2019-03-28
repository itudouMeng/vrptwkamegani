function routes=PFIH(A, B, capacity)

r=0;
route=[];
routes=[];
costs=minimumCost(A,B);
sortedCosts=sortrows(costs')';
sortedCustomers=sortedCosts(2,:);
reverseCustomers=0;
needNewRoute=0;

while not(isempty(sortedCustomers))
    routes(r+1,1:length(route))=route;
    r=r+1;
    firstCustomer=0;
    routeCapacity=capacity;
    for i=1:length(sortedCustomers)
        j=sortedCustomers(i);
        if(B(1,j+1)<A(j,5))&&(A(j,3)<routeCapacity)
            firstCustomer=j;
            sortedCustomers(i)=[];
            break
        end
    end
    if (firstCustomer == 0)
        fprintf ('Solu玢o inexistente');
        routes=0;
        return
    end
    route = firstCustomer;
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
            if (i==0)
                needNewRoute=1;
            end
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
end
