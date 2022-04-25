package org.jahia.community.modules.clicktracking.filters;

import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.filter.AbstractFilter;
import org.jahia.services.render.filter.RenderChain;
import org.jahia.services.render.filter.RenderFilter;
import org.osgi.service.component.annotations.Component;

@Component(service = RenderFilter.class, immediate = true)
public class ClickTrackingEventFilter extends AbstractFilter {
    public ClickTrackingEventFilter() {
        setApplyOnNodeTypes("jcmix:clickTrackingEvent");
        setSkipOnEditMode(true);
        setApplyOnConfigurations(Resource.CONFIGURATION_MODULE + "," + Resource.CONFIGURATION_WRAPPEDCONTENT);
        setPriority(17.0f);
    }

    @Override
    public String prepare(RenderContext renderContext, Resource resource, RenderChain chain) {
        resource.pushWrapper(Resource.CONFIGURATION_WRAPPER);
        return null;
    }
}
