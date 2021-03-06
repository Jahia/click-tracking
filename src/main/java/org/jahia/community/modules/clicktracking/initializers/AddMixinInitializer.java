package org.jahia.community.modules.clicktracking.initializers;

import org.jahia.services.content.nodetypes.ExtendedPropertyDefinition;
import org.jahia.services.content.nodetypes.ValueImpl;
import org.jahia.services.content.nodetypes.initializers.ChoiceListValue;
import org.jahia.services.content.nodetypes.initializers.ModuleChoiceListInitializer;
import org.osgi.service.component.annotations.Component;

import java.util.*;
import java.util.stream.Collectors;

@Component(service = ModuleChoiceListInitializer.class, immediate = true)
public class AddMixinInitializer implements ModuleChoiceListInitializer {
    @Override
    public void setKey(String s) {
        // Do nothing
    }

    @Override
    public String getKey() {
        return "addMixinInitializer";
    }

    @Override
    public List<ChoiceListValue> getChoiceListValues(ExtendedPropertyDefinition extendedPropertyDefinition, String param, List<ChoiceListValue> values, Locale locale, Map<String, Object> map) {
        return Arrays.stream(extendedPropertyDefinition.getValueConstraints())
                .map(mixin -> new ChoiceListValue(mixin, Collections.singletonMap("addMixin", mixin), new ValueImpl(mixin)))
                .collect(Collectors.toList());
    }
}
