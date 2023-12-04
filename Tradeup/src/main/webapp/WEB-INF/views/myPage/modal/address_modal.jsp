<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- 

<button
  type="button"
  class="btn btn-primary"
  data-bs-toggle="modal"
  data-bs-target="#largeModal"
>
  Large
</button>
                        
 -->

<!-- Large Modal -->
<div class="modal fade" id="addressModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel1">주소 수정</h5>
				<button
				type="button"
				class="btn-close"
				data-bs-dismiss="modal"
				aria-label="Close"
				></button>
			</div>
			
			<form action="">
			
				<div class="modal-body">
					<div class="card-body demo-vertical-spacing demo-only-element">
					
						<label class="form-label" for="address_name">배송지명</label>
						<div class="input-group">
							<input
								type="text"
								id="address_name"
								class="form-control"
								value="${address.address_name }"
							/>
						</div>
						
						<label class="form-label" for="recipient_name">받으시는 분</label>
						<div class="input-group">
							<input
								type="text"
								id="recipient_name"
								class="form-control"
								value="${address.recipient_name }"
							/>
						</div>
						
						<label class="form-label" for="phone_num">전화번호</label>
						<div class="input-group">
							<input
								type="text"
								id="phone_num"
								class="form-control"
								value="${address.recipient_phone_num }"
							/>
						</div>
						
						<label class="form-label" for="address1">주소</label>
						<div class="input-group">
							<input
								type="text"
								id="address1"
								class="form-control"
								value="${address.address1 }"
							/>
						</div>
						
						<label class="form-label" for="address2">상세주소</label>
						<div class="input-group">
							<input
								type="text"
								id="address2"
								class="form-control"
								value="${address.address2 }"
							/>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary">저장</button>
				</div>
				
			</form>
			
		</div>
	</div>
</div>


