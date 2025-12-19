<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <%-- 목록 영역(menuListContainer)에 실시간으로 갈아끼워질 HTML 조각입니다. JSTL <c:forEach>를 사용하여 서버에서 전달받은 메뉴 목록을 순회하며 카드 UI를
            생성합니다.
            --%>
            <c:choose>
                <c:when test="${empty menuList}">
                    <div class="empty-state">
                        <span class="empty-state-icon">🍽️</span>
                        <div class="empty-state-text">등록된 메뉴가 없습니다 😅</div>
                        <p style="font-size: 0.9rem; margin-top: 10px; color: #bbb;">새로운 메뉴를 등록해보세요!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="menu" items="${menuList}">
                        <%-- 카드 각 요소에 data-* 속성을 부여하여 클린업된 검색/필터 접근이 용이하게 합니다. onclick 이벤트 시 상세 모달 오픈 함수(openModal)에 DB
                            데이터를 인자로 전달합니다. --%>
                            <div class="menu-card" data-name="${menu.menuName}" data-price="${menu.menuPrice}"
                                data-category-code="${menu.categoryCode}"
                                onclick="openModal('${menu.menuCode}', '${menu.menuName}', '${menu.menuPrice}', '${menu.categoryName}', '${menu.categoryCode}', '${menu.orderableStatus}')">
                                <div class="menu-icon">🍽️</div>
                                <div class="menu-info">
                                    <div class="menu-name">
                                        ${menu.menuName} <!-- EL을 이용한 메뉴명 출력 -->
                                        <%-- 동적 클래스 부여 (주문가능: status-y, 품절: status-n) --%>
                                            <span
                                                class="menu-status ${menu.orderableStatus == 'Y' ? 'status-y' : 'status-n'}">
                                                ${menu.orderableStatus == 'Y' ? '주문가능' : '품절'}
                                            </span>
                                    </div>
                                    <div class="menu-price">${menu.menuPrice}원</div>
                                    <%-- 카테고리 정보 표시 --%>
                                        <div style="font-size: 0.8rem; color: #888; margin-top: 5px;">
                                            ${menu.categoryName}</div>
                                </div>
                            </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>