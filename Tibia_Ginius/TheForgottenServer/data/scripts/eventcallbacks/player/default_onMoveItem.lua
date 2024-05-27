local event = Event()

event.onMoveItem = function(self, item, count, fromPosition, toPosition,
                            fromCylinder, toCylinder)
	if toPosition.x ~= CONTAINER_POSITION then return true end

	if item:getTopParent() == self and (toPosition.y & 0x40) == 0 then
		local itemType, moveItem = ItemType(item:getId())
		if (itemType:getSlotPosition() & SLOTP_TWO_HAND) ~= 0 and toPosition.y ==
			CONST_SLOT_LEFT then
			moveItem = self:getSlotItem(CONST_SLOT_RIGHT)
		elseif itemType:getWeaponType() == WEAPON_SHIELD and toPosition.y ==
			CONST_SLOT_RIGHT then
			moveItem = self:getSlotItem(CONST_SLOT_LEFT)
			if moveItem and
				(ItemType(moveItem:getId()):getSlotPosition() & SLOTP_TWO_HAND) == 0 then
				return true
			end
		end

		if moveItem then
			local parent = item:getParent()
			if parent:isContainer() and parent:getSize() == parent:getCapacity() then
				self:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(
					                     RETURNVALUE_CONTAINERNOTENOUGHROOM))
				return false
			else
				return moveItem:moveTo(parent)
			end
		end
	end

	return true
end

event:register()
