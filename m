Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD6B1CE21A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgEKR7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 13:59:06 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58266 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbgEKR7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 13:59:06 -0400
IronPort-SDR: WCgrKXePoExsesfAu6YdoHKC9RbY4MKgwj8fC2nDoWaUwsOk17Q9vg4b8F9OfPJdVISiBiO2qQ
 Cn4Gr6+IWHHE5S6ZQROylHEspsu3bOzsuddDj9sU7QT5woyv1p87bdBDBedB9FDu+okegTgT4S
 xHeIwqCILZpAbsgKtOVgb5ou8Wwxy+EbMYdoM6vmXbDGdGAAKsk9Tsnf67Vqd3Al80AUXKqygy
 LQnTMZ3ct9xibLcdOAY5/wShZEjQ0QGXqLUanF3iOrG7o/2eM6LUngx4+KBhPg3j7SAGsYvDc8
 gEc=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AQdu0sBayuqsHqjPNTIGL/hr/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsiybnLW6fgltlLVR4KTs6sC17OL9fG4EjVZu96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vLBi6twHcutUZjYd/N6o91A?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDM/7WrZiNF/jLhDrRyhuRJx3oDaboKSOvVxca3QZs8WSG?=
 =?us-ascii?q?lbU8pNTSFNHp+wYo0SBOQBJ+ZYqIz9qkMOoxSkHgasBfngyjlVjXH2x601zf?=
 =?us-ascii?q?kuHh/c3AwhA90Os2nfodL7NKgISu+1wrLFzS7Ab/JW3zfy9pTIfgo6rv6SRL?=
 =?us-ascii?q?99d9faxkYzGQ3flFqQtZDlMC2P1uQLq2WV4eltWOavhWMmqwx9vDaiyMcxh4?=
 =?us-ascii?q?XVm44Z1lHJ+yp2zosoK9C1VlN2bN6mHZZOuC+WK4V4TMwmTm9ouCg21LkLtJ?=
 =?us-ascii?q?imdyYJ0JQq3xrSZ+Gdf4SV4R/vSvydLSp5iX9lYr6zmhe//E69wePmTMa0yk?=
 =?us-ascii?q?xFri9dn9nJsXACygLc59CcSvt44kehwTGP1x3P6u1cIUA7i67bK5k5z7Erl5?=
 =?us-ascii?q?oTvkvDHjLtmEXti6+Wclgk+vOy5+TnZbXmo4GTO5d1igH4LKsuhtSyDOAlPg?=
 =?us-ascii?q?QUQmSW+vqw2Kf+8UD4QLhGlOA6n6jBvJDfP8sbp6q5AwFP0oYk7hayFzmm38?=
 =?us-ascii?q?4DknkJN19FYxGHjojvO17QPPD0F+ywjEq0nDdx2//GJqHhAonKLnXbkrfuZ6?=
 =?us-ascii?q?py601HxQoo0NBf/IxbBqsdL/PyQkXxrsDXDgclMwyoxObqEM9y1oYfWWKVAK?=
 =?us-ascii?q?KUPqLSsVuT6+IgJumDfo4VuDLnJ/c54P7uiGczmUUBcqmxwZsXdHe4E+xiI0?=
 =?us-ascii?q?WYZ3rsn9gAHX4EvgolUePllkOCXiBXZ3upQaI86S80CJi8AYfAWI+tmrqB0z?=
 =?us-ascii?q?m/HpFMYWBGEF+MG2/yd4qYQ/cMdD6SIsh5nzwKT7euUIEh2Aq1tA/5y7tnKP?=
 =?us-ascii?q?Tb+jECuZ34ytcmr9HUwBM7/j9cFNmG3ieGXSU8l2YJXWBt3aRXrkl0y1PF2q?=
 =?us-ascii?q?990NJCEtkGyfpDUw48fbDGwuB3EdH5WUqVcN6DRn69QcSgDC13RN9nkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJAz7E=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BMBwACkrle/xCltltmhE0tgWQSLI0?=
 =?us-ascii?q?lhXqMGJFYCwEBAQEBAQEBATQBAgQBAYREgg0nOBMCAwEBAQMCBQEBBgEBAQE?=
 =?us-ascii?q?BAQQEAWwEAQEHCgIBhE4hAQMBAQUKAQsIMII7IoNCCwEjI09wEoJbS4JYKbB?=
 =?us-ascii?q?BM4VRg1aBQIE4h12FAYFBP4RfikIEmBCaW4JUgnGVKwwdnTotj3CfOyKBVk0?=
 =?us-ascii?q?gGDuCaVAYDYlElUZCMDcCBggBAQMJVwEiAY4IAQE?=
X-IPAS-Result: =?us-ascii?q?A2BMBwACkrle/xCltltmhE0tgWQSLI0lhXqMGJFYCwEBA?=
 =?us-ascii?q?QEBAQEBATQBAgQBAYREgg0nOBMCAwEBAQMCBQEBBgEBAQEBAQQEAWwEAQEHC?=
 =?us-ascii?q?gIBhE4hAQMBAQUKAQsIMII7IoNCCwEjI09wEoJbS4JYKbBBM4VRg1aBQIE4h?=
 =?us-ascii?q?12FAYFBP4RfikIEmBCaW4JUgnGVKwwdnTotj3CfOyKBVk0gGDuCaVAYDYlEl?=
 =?us-ascii?q?UZCMDcCBggBAQMJVwEiAY4IAQE?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 19:59:04 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/9 linux-next] fanotify: prefix should_merge()
Date:   Mon, 11 May 2020 19:58:58 +0200
Message-Id: <20200511175858.214835-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

prefix function with fanotify_ like others

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/fanotify/fanotify.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5435a40f82be..95480d3dcff7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -70,7 +70,7 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 	return !memcmp(fne1->name, fne2->name, fne1->name_len);
 }
 
-static bool should_merge(struct fsnotify_event *old_fsn,
+static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
 			 struct fsnotify_event *new_fsn)
 {
 	struct fanotify_event *old, *new;
@@ -129,7 +129,7 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 		return 0;
 
 	list_for_each_entry_reverse(test_event, list, list) {
-		if (should_merge(test_event, event)) {
+		if (fanotify_should_merge(test_event, event)) {
 			FANOTIFY_E(test_event)->mask |= new->mask;
 			return 1;
 		}
-- 
2.26.2

