<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources key="click-tracking" type="inlinejavascript">
    <script type="text/javascript">
        window.dispatchClickTrackingEvent = event => {
            console.log(`Receive event: \${event}`, event);

            // dispatch a custom event
            document.dispatchEvent(new CustomEvent('ClickTrackingEvent', {
                detail: {
                    name: event.detail?.name,
                    displayableName: event.detail?.displayableName,
                    path: event.detail?.path,
                    src: event.target?.src || event.currentTarget?.src || null,
                    href: event.target?.href || event.currentTarget?.href || null
                }
            }));

            // check if jExperience is enabled
            if (window.wem) {
                // send event to Unomi
                wem.collectEvents({
                    events: [
                        wem.buildEvent('click',
                            wem.buildTarget(event.detail.path, event.target.tagName),
                            wem.buildSourcePage())]
                });
            }
        };
    </script>
</template:addResources>

<template:include view="hidden.wrapper">
    <template:param name="identifier" value="${currentNode.identifier}"/>
</template:include>

<wrap-click-tracking-${currentNode.identifier}>
    ${wrappedContent}
</wrap-click-tracking-${currentNode.identifier}>
