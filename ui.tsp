import "@typespec/json-schema";

using JsonSchema;

@jsonSchema
namespace Schemas;

model UI {
  version: string;
  systems: Record<System>;
}

model System {
  id: string;
  title: string;
  pages: Record<Page>;
}

model Page {
  @key id: string;
  title: string;
  items: Item[];
  events: Event[];
}

model Item {
  id: string;
  title: string;
  type: ItemType;
  display?: ItemDisplay;
  events?: Event[];
  validations?: Validation[];
}

model Event {
  type: EventType;
  handler: string;
}

enum EventType {
  click,
  change,
  submit,
  load,
  unload,
  focus,
  blur,
}

model Validation {
  type: ValidationType;
  value: string | integer | boolean;
}

enum ValidationType {
  required,
  minLength,
  maxLength,
  pattern,
  min,
  max,
}

enum ItemType {
  button,
  static,
  textfield,
  textarea,
  radio,
  checkbox,
  select,
  file,
  date,
}

enum ItemDisplay {
  inline,
  block,
}
