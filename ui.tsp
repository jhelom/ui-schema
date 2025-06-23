import "@typespec/json-schema";

using JsonSchema;

@jsonSchema
namespace Schemas;

model UI {
  ui: string;
  systems: Record<System>;
  description?: string;
}

model System {
  @key id: string;
  title: string;
  pages: Record<Page>;
  description?: string;
}

model Page {
  @key id: string;
  title: string;
  type: PageType;
  description?: string;
  elements: Array<TextElement | ButtonElement | TextFieldElement>;
  events: Event[];
}

enum PageType {
  screen,
  popup,
}

@discriminator("type")
model Element {
  id: string;
  name: string;
  type: ElementType;
  display?: ElementDisplay;
  disable?: string;
  events?: Event[];
  description?: string;
}

enum ElementType {
  button,
  text,
  textfield,
  textarea,
  password,
  radio,
  checkbox,
  select,
  file,
  date,
  table,
  pagination,
  image,
  icon,
  link,
}

model TextElement extends Element {
  type: ElementType.text;
}

model InputElement extends Element {
  placeholder?: string;
  validations?: Validation[];
  value: string;
}

model ButtonElement extends InputElement {
  type: ElementType.button;
}

model TextFieldElement extends InputElement {
  type: ElementType.textfield;
}

model PasswordFieldElement extends InputElement {
  type: ElementType.password;
}

model Bind {
  source: string; // $API(get, /users/me).response.name
  target: string; // $Item(item).text
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

enum ElementDisplay {
  inline,
  block,
}
