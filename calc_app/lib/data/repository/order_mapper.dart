import 'package:calc_app/data/models/component_model.dart';
import 'package:calc_app/data/models/order_model.dart';
import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';

class OrderMapper {
  OrderModel orderEntityToDataModel(OrderEntity orderEntity) {
    return OrderModel(
        id: orderEntity.id,
        name: orderEntity.name,
        description: orderEntity.description,
        component: orderEntity.component);
  }

  OrderEntity orderDataModelToEntity(OrderModel orderModel) {
    return OrderEntity(
        id: orderModel.id,
        name: orderModel.name,
        description: orderModel.description,
        component: orderModel.component);
  }

  ComponentModel componentEntityToDataModel(ComponentEntity componentEntity) {
    return ComponentModel(
        name: componentEntity.name,
        id: componentEntity.id,
        material: componentEntity.material,
        height: componentEntity.height,
        length: componentEntity.length,
        quantity: componentEntity.quantity,
        weightPerCubMeter: componentEntity.weightPerCubMeter,
        width: componentEntity.width,
        pricePerCubMeter: componentEntity.pricePerCubMeter);
  }

  ComponentEntity componentDataModelToEntity(ComponentModel componentModel) {
    return ComponentModel(
        name: componentModel.name,
        id: componentModel.id,
        material: componentModel.material,
        height: componentModel.height,
        length: componentModel.length,
        quantity: componentModel.quantity,
        weightPerCubMeter: componentModel.weightPerCubMeter,
        width: componentModel.width,
        pricePerCubMeter: componentModel.pricePerCubMeter);
  }
}

// class ShopListMapper {
//
//   fun mapEntityToDbModel(shopItem: ShopItem) = ShopItemDbModel(
//   id = shopItem.id,
//   name = shopItem.name,
//   count = shopItem.count,
//   enabled = shopItem.enabled
//   )
//
//   fun mapDbModelToEntity(shopItemDbModel: ShopItemDbModel) = ShopItem(
//   id = shopItemDbModel.id,
//   name = shopItemDbModel.name,
//   count = shopItemDbModel.count,
//   enabled = shopItemDbModel.enabled
//   )
//
//   fun mapListDbModelToListEntity(list: List<ShopItemDbModel>) = list.map {
//   mapDbModelToEntity(it)
// }
// }
