class ApiData {
  Filters? filters;
  Join? join;
  List<Orders>? orders;
  List<String>? fields;
  int? perPage;
  int? page;
  String? token;

  ApiData({this.filters, this.join, this.orders, this.fields, this.perPage, this.page, this.token});

  ApiData.onePage() : this(perPage: 99999, page: 1);

  ApiData.fromJson(Map<String, dynamic> json) {
    filters = json['filters'] != null ? Filters.fromJson(json['filters']) : null;
    join = json['join'] != null ? Join.fromJson(json['join']) : null;
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders?.add(Orders.fromJson(v));
      });
    }
    fields = json['fields'].cast<String>();
    perPage = json['perPage'];
    page = json['page'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filters != null) {
      data['filters'] = filters?.toJson();
    }
    if (join != null) {
      data['join'] = join?.toJson();
    }
    if (orders != null) {
      data['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    data['fields'] = fields;
    data['perPage'] = perPage;
    data['page'] = page;
    data['token'] = token;
    return data;
  }

  void addFilter({required field, required value, required condition}) {
    filters ??= Filters();
    filters?.filter ??= <FieldsToFilterSearch>[];

    filters?.filter?.add(
      FieldsToFilterSearch(
        field: field,
        value: value,
        condition: condition,
      ),
    );
  }

  void addSearch({required field, required value, required condition}) {
    filters ??= Filters();
    filters?.search ??= <FieldsToFilterSearch>[];

    filters?.search?.add(
      FieldsToFilterSearch(
        field: field,
        value: value,
        condition: condition,
      ),
    );
  }

  void addLeftJoin({required table, required primaryKey, required foreignKey}) {
    join ??= Join();
    join?.left ??= <Left>[];

    join?.left?.add(
      Left(
        table: table,
        primaryKey: primaryKey,
        foreignKey: foreignKey,
      ),
    );
  }

  void addOrder({required orderBy, required direction}) {
    orders ??= <Orders>[];

    orders?.add(
      Orders(
        orderby: orderBy,
        direction: direction,
      ),
    );
  }
}

class Filters {
  List<FieldsToFilterSearch>? filter;
  List<FieldsToFilterSearch>? search;

  Filters({this.filter, this.search});

  Filters.fromJson(Map<String, dynamic> json) {
    if (json['filter'] != null) {
      filter = <FieldsToFilterSearch>[];
      json['filter'].forEach((v) {
        filter?.add(FieldsToFilterSearch.fromJson(v));
      });
    }
    if (json['search'] != null) {
      search = <FieldsToFilterSearch>[];
      json['search'].forEach((v) {
        search?.add(FieldsToFilterSearch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filter != null) {
      data['filter'] = filter?.map((v) => v.toJson()).toList();
    }
    if (search != null) {
      data['search'] = search?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FieldsToFilterSearch {
  String? field;
  String? value;
  String? condition;

  FieldsToFilterSearch({this.field, this.value, this.condition});

  FieldsToFilterSearch.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    value = json['value'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field'] = field;
    data['value'] = value;
    data['condition'] = condition;
    return data;
  }
}

class Join {
  List<Left>? left;

  Join({this.left});

  Join.fromJson(Map<String, dynamic> json) {
    if (json['left'] != null) {
      left = <Left>[];
      json['left'].forEach((v) {
        left?.add(Left.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (left != null) {
      data['left'] = left?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Left {
  String? table;
  String? primaryKey;
  String? foreignKey;

  Left({this.table, this.primaryKey, this.foreignKey});

  Left.fromJson(Map<String, dynamic> json) {
    table = json['table'];
    primaryKey = json['primaryKey'];
    foreignKey = json['foreignKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['table'] = table;
    data['primaryKey'] = primaryKey;
    data['foreignKey'] = foreignKey;
    return data;
  }
}

class Orders {
  String? orderby;
  String? direction;

  Orders({this.orderby, this.direction});

  Orders.fromJson(Map<String, dynamic> json) {
    orderby = json['orderby'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderby'] = orderby;
    data['direction'] = direction;
    return data;
  }
}