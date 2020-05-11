Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D01CE237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgEKSDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 14:03:39 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58693 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgEKSDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 14:03:39 -0400
IronPort-SDR: VUq4jO75KW4H3TgsSOFgBFUo9vAEUdMNiSd5BWXN7y18LYE7ofKn66OXrim0BUh82D5eNZjRca
 f06kf1ferT2TBmt785tOOesjePmPcSZv5NQrw9iHAPRF36soHC85WyyQ1GqEwGysj5Mg1zyxFW
 pVTpxrmEkWRxgwEyR8WnV4Ow/40jghhQs2Kp1A1Mf//y/9Z3YbpgseKsUq3HTnNx2sP7jdBUEy
 rg0A421F+Pk0unSujCPB0jeXS6ivyTFVOcQpziXnaogGG54tmG1faJkWxNjDqmy897kEwGG2o4
 +lA=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AZUoO0hJEWyVjs6zkjdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLvTxwZ3uMQTl6Ol3ixeRBMOHsq8C2rKd6vm7EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCe9bL9oKBi6sQrdutQLjYZsN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhSEaPDA77W7XkNR9gqJFrhy8qRJxwInab46aOvdlYq/QfskXSX?=
 =?us-ascii?q?ZbU8pNSyBMBJ63YYsVD+oGOOZVt4nzqEEVohu/HwasAv7kxD9ShnDowKI1zf?=
 =?us-ascii?q?4hEQDa0wwjAtkDt3rUo8/uO6ccSu2116rIzDXFb/xIxTfx8pPHfQ44rPyKQL?=
 =?us-ascii?q?l/ftbfx1M1GAPZklWft5blPzWN2+oDsGWW6+puWOOvhmI5pQx/oiWiytsxho?=
 =?us-ascii?q?XVh48bxV/K+Dh3zYsrONC1SEx2bMCrHpdMuS+UOI97TMMiTW12vCs3zKANt5?=
 =?us-ascii?q?2jfCUSzJkr2gTTZ+GEfoSW+B7vSeecLDdiiH54eb+ygQu5/1K6xe3mTMa01U?=
 =?us-ascii?q?5Hri9CktbRqH8AzwfT6s2bSvtl+UehxCqP2xjT6u5aJUA0krLWJIUgwr4/mZ?=
 =?us-ascii?q?oTrF/DHjTxmEXyka+WbV8o+uiv6+TifLrqvp6cN4lqhQHiKqkjntGzDf4lPg?=
 =?us-ascii?q?UNQWSX4/mw2bzj8EHjXblHj+U6kqzDv5DbIcQbqLS5AwhQ0os75RawFSyp0N?=
 =?us-ascii?q?oDkHkcL1JEeBSHgJb1O13UO//3E++zg06wnzdz2/DGIrrhD43PLnfZjLjhfq?=
 =?us-ascii?q?1w61VByAoo099T/Y5bC7AZKvLpRkDxrMDYDgM+MwGs2ennDdR91pkcVG+BA6?=
 =?us-ascii?q?+ZNLjfsVCN5u01IumMYJUZtyr6K/gg//Tul2M2mUcBfam12psacHS4HvVgI0?=
 =?us-ascii?q?WEbnvgm9kBEXwXsQUgUuzlllmCXCVNZ3a9Qa08/Cs3CIG4AofZQICinriB0D?=
 =?us-ascii?q?28Hp1MaWBMEkqMHmvwd4WYR/cMbzqfIsF7nTMfW7isUJQh1RKutQ/81bVnMv?=
 =?us-ascii?q?DY9TYGusGr6N8g5eTYljkp6Cd5Sc+PlymESmBuwTgJQxc52al+pQp2zVLQ/7?=
 =?us-ascii?q?J/hql2HNZS7vUBfB03OZPGzud5Q4T8UwjPVsyKWVCrXpOsDGdiHZoK39YSbh?=
 =?us-ascii?q?MlSJ2ZhRfZ0n/yDg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BLBwAhk7le/xCltltmhHqBZBIsjSW?=
 =?us-ascii?q?FeowYijKHJgsBAQEBAQEBAQE0AQIEAQGERIINJzgTAgMBAQEDAgUBAQYBAQE?=
 =?us-ascii?q?BAQEEBAFsBAEBBwoCAYROIQEDAQEFCgFDgjsig0ILASMjT3ASgyaCWCmwRDO?=
 =?us-ascii?q?FUYNXgUCBOIddhQGBQT+EX4QGhjwEjkakJYJUgnGVKwwdnTotj3CfOyKBVk0?=
 =?us-ascii?q?gGDuCaVAYDZBMF44nQjA3AgYIAQEDCVcBIgGLVII0AQE?=
X-IPAS-Result: =?us-ascii?q?A2BLBwAhk7le/xCltltmhHqBZBIsjSWFeowYijKHJgsBA?=
 =?us-ascii?q?QEBAQEBAQE0AQIEAQGERIINJzgTAgMBAQEDAgUBAQYBAQEBAQEEBAFsBAEBB?=
 =?us-ascii?q?woCAYROIQEDAQEFCgFDgjsig0ILASMjT3ASgyaCWCmwRDOFUYNXgUCBOIddh?=
 =?us-ascii?q?QGBQT+EX4QGhjwEjkakJYJUgnGVKwwdnTotj3CfOyKBVk0gGDuCaVAYDZBMF?=
 =?us-ascii?q?44nQjA3AgYIAQEDCVcBIgGLVII0AQE?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 20:03:16 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 9/9 linux-next] fsnotify: fsnotify_clear_marks_by_group() massage
Date:   Mon, 11 May 2020 20:03:05 +0200
Message-Id: <20200511180305.215252-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

revert condition and remove clear label

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/mark.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 1d96216dffd1..ca2eba786bb6 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -724,28 +724,27 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	LIST_HEAD(to_free);
 	struct list_head *head = &to_free;
 
-	/* Skip selection step if we want to clear all marks. */
-	if (type_mask == FSNOTIFY_OBJ_ALL_TYPES_MASK) {
+	if (type_mask != FSNOTIFY_OBJ_ALL_TYPES_MASK) {
+	       /*
+		* We have to be really careful here. Anytime we drop mark_mutex,
+		* e.g. fsnotify_clear_marks_by_inode() can come and free marks.
+		* Even in our to_free list so we have to use mark_mutex even
+		* when accessing that list. And freeing mark requires us to drop
+		* mark_mutex. So we can reliably free only the first mark in the
+		* list. That's why we first move marks to free to to_free list
+		* in one go and then free marks in to_free list one by one.
+		*/
+		mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
+		list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
+			if ((1U << mark->connector->type) & type_mask)
+				list_move(&mark->g_list, &to_free);
+		}
+		mutex_unlock(&group->mark_mutex);
+	} else {
+		/* Skip selection step if we want to clear all marks. */
 		head = &group->marks_list;
-		goto clear;
 	}
-	/*
-	 * We have to be really careful here. Anytime we drop mark_mutex, e.g.
-	 * fsnotify_clear_marks_by_inode() can come and free marks. Even in our
-	 * to_free list so we have to use mark_mutex even when accessing that
-	 * list. And freeing mark requires us to drop mark_mutex. So we can
-	 * reliably free only the first mark in the list. That's why we first
-	 * move marks to free to to_free list in one go and then free marks in
-	 * to_free list one by one.
-	 */
-	mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
-	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
-		if ((1U << mark->connector->type) & type_mask)
-			list_move(&mark->g_list, &to_free);
-	}
-	mutex_unlock(&group->mark_mutex);
 
-clear:
 	while (1) {
 		mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
 		if (list_empty(head)) {
-- 
2.26.2

