Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE81CFD0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgELSRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:17:47 -0400
Received: from mailrelay115.isp.belgacom.be ([195.238.20.142]:26549 "EHLO
        mailrelay115.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgELSRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:17:47 -0400
IronPort-SDR: ROQLGba36rQBfJwvHnvLW47/ccwB3RyK0+20xl7Syr62SWeufBQz9H5aAjyjjd+g8AIuVFv6Ug
 4xB05T8YRMoKspb+NuuggNiEOSd+iNKn1EVn0fKi15OXngDCYAfU2xqtePh8GkOjF/6Yxfea4u
 vx+mQE9C31MbX7AZQ1Jo5mAHPHM5B3FHzSRQSgzCaAIqkgjOI3mD2NUN0Zvrtkyr/gazsPrpWq
 p3KXfEqmV9St4rNAz8KLbmHseldkf2GTxF4HUIxmYbLfZLgznYQiRj+5fl1ziGY8x8IvY7bUti
 KnQ=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3ARM4YBBZjAr2OFv2eF90WIN3/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsiybnLW6fgltlLVR4KTs6sC17OL9fG6EjVZsd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vLBi6twHcutcZjYd/N6o8yQ?=
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
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BKBwAE57pe/xCltltmhHqBZBIsjSW?=
 =?us-ascii?q?FfIwYkVgLAQEBAQEBAQEBNAECBAEBhESCBCc4EwIDAQEBAwIFAQEGAQEBAQE?=
 =?us-ascii?q?BBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsT0zhVG?=
 =?us-ascii?q?DV4FAgTiHXYUBgUE/hF+KQgSya4JUgnGVKwwdnTqQHZ87IoFWTSAYgyRQGA2?=
 =?us-ascii?q?fCkIwNwIGCAEBAwlXASIBjggBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BKBwAE57pe/xCltltmhHqBZBIsjSWFfIwYkVgLAQEBA?=
 =?us-ascii?q?QEBAQEBNAECBAEBhESCBCc4EwIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBAQcKA?=
 =?us-ascii?q?gGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsT0zhVGDV4FAgTiHXYUBg?=
 =?us-ascii?q?UE/hF+KQgSya4JUgnGVKwwdnTqQHZ87IoFWTSAYgyRQGA2fCkIwNwIGCAEBA?=
 =?us-ascii?q?wlXASIBjggBAQ?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 12 May 2020 20:17:45 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 2/6 linux-next] notify: explicit shutdown initialization
Date:   Tue, 12 May 2020 20:17:40 +0200
Message-Id: <20200512181740.405774-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kzalloc should already do it but explicitly initialize group
shutdown variable to false.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/group.c b/fs/notify/group.c
index 133f723aca07..f2cba2265061 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -130,6 +130,7 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
 	INIT_LIST_HEAD(&group->notification_list);
 	init_waitqueue_head(&group->notification_waitq);
 	group->max_events = UINT_MAX;
+	group->shutdown = false;
 
 	mutex_init(&group->mark_mutex);
 	INIT_LIST_HEAD(&group->marks_list);
-- 
2.26.2

