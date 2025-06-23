import "@typespec/json-schema";

using JsonSchema;

@jsonSchema
namespace Schemas;

model UI {
  @pattern("^\\d+\\.\\d+\\.\\d+$")
  ui: string;

  systems: Record<System>;
  description?: string;
}

model System {
  @key
  @pattern("^[a-z][a-z0-9_]*$")
  id: string;

  title: string;
  pages: Record<Page>;
  description?: string;
  todo?: string;
}

model Page {
  @key
  @pattern("^[a-z][a-z0-9_]*$")
  id: string;

  title: string;
  type: PageType;
  events: Record<PageEvent>;
  description?: string;
  todo?: string;
  elements: Record<
    | ButtonElement
    | TextElement
    | TextInputElement
    | TextAreaElement
    | PasswordInputElement
    | CheckboxElement
    | RadioElement
    | SelectElement
    | FileUploadElement
    | FileDownloadElement
    | DateInputElement
    | TimeInputElement
    | ImageElement
    | IconElement
    | LinkElement
    | PaginationElement
    | TableElement>;
}

enum PageType {
  screen,
  popup,
}

@discriminator("type")
model Element {
  @key
  @pattern("^[a-z][a-z0-9_]*$")
  id: string;

  name: string;
  type: ElementType;
  display?: ElementDisplay;
  disable?: string;
  visible?: string;
  events?: Record<ElementEvent>;
  description?: string;
  todo?: string;
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
  fileUpload,
  fileDownload,
  date,
  time,
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

model TextInputElement extends InputElement {
  type: ElementType.textfield;
}

model TextAreaElement extends InputElement {
  type: ElementType.textarea;
  rows?: integer;
}

model PasswordInputElement extends InputElement {
  type: ElementType.password;
}

model CheckboxElement extends InputElement {
  type: ElementType.checkbox;
  checked?: boolean;
}

model RadioElement extends InputElement {
  type: ElementType.radio;
  checked?: boolean;
}

model SelectElement extends InputElement {
  type: ElementType.select;
  options: Record<SelectOption>;
}

model SelectOption {
  @key
  @pattern("^[a-z][a-z0-9_]*$")
  id: string;

  label: string;
  value: string;
}

model FileUploadElement extends InputElement {
  type: ElementType.fileUpload;
  accept?: string; // e.g. "image/*,application/pdf"
}

model FileDownloadElement extends Element {
  type: ElementType.fileDownload;
}

model DateInputElement extends InputElement {
  type: ElementType.date;
  format?: string; // e.g. "YYYY-MM-DD"
}

model TimeInputElement extends InputElement {
  type: ElementType.time;
  format?: string; // e.g. "HH:mm:ss"
}

model TableElement extends Element {
  type: ElementType.table;
  columns: Record<TableColumn>;
  selectable?: boolean;
  sortable?: boolean;
}

model TableColumn {
  @key
  @pattern("^[a-z][a-z0-9_]*$")
  id: string;

  title: string;
  sortable?: boolean;
  filterable?: boolean;
  format?: string;
  description?: string;
  todo?: string;
}

model PaginationElement extends Element {
  type: ElementType.pagination;
}

model ImageElement extends Element {
  type: ElementType.image;
  src: string;
}

model IconElement extends Element {
  type: ElementType.icon;
  name: string;
  size?: string;
}

model LinkElement extends Element {
  type: ElementType.link;
  href: string; // URL the link points to
  target?: string; // e.g., "_blank" for opening in a new tab
}

model Bind {
  source: string; // $API(get, /users/me).response.name
  target: string; // $Item(item).text
}

model PageEvent {
  type: PageEventType;
  handler: string;
}

enum PageEventType {
  load,
  unload,
}

model ElementEvent {
  type: ElementEventType;
  handler: string;
}

enum ElementEventType {
  click,
  change,
  focus,
  blur,
}

enum ElementDisplay {
  inline,
  block,
}

@discriminator("type")
model Validation {
  type: ValidationType;
  value: string | integer | boolean;
}

enum ValidationType {
  required,
  minLength,
  maxLength,
  pattern,
  integer,
  minInteger,
  maxInteger,
  date,
  email,
  url,
}

model RequiredValidation extends Validation {
  type: ValidationType.required;
  value: boolean;
}

model MinLengthValidation extends Validation {
  type: ValidationType.minLength;
  value: integer;
}

model MaxLengthValidation extends Validation {
  type: ValidationType.maxLength;
  value: integer;
}

model PatternValidation extends Validation {
  type: ValidationType.pattern;
  value: string;
}

model IntegerValidation extends Validation {
  type: ValidationType.integer;
  value: boolean;
}

model MinIntegerValidation extends Validation {
  type: ValidationType.minInteger;
  value: integer;
}

model MaxIntegerValidation extends Validation {
  type: ValidationType.maxInteger;
  value: integer;
}

model DateValidation extends Validation {
  type: ValidationType.date;
  value: string;
}

model EmailValidation extends Validation {
  type: ValidationType.email;
  value: string;
}

model UrlValidation extends Validation {
  type: ValidationType.url;
  value: string;
}
