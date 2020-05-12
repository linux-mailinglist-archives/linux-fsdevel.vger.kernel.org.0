Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0DC1CFD0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgELSSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:18:10 -0400
Received: from mailrelay115.isp.belgacom.be ([195.238.20.142]:26587 "EHLO
        mailrelay115.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgELSSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:18:10 -0400
IronPort-SDR: Kyn4xYby3BztO1uLKn1HLcsQr2f0KuC6Oz/BnuClbNQTsknOMVdeuoqnAn89T9l7IKtS7x7isj
 tIlhIa1QMfGRuNnvvfsh+GZTqayB1los43JVgGuQecoO75UY9GfhRY5M7CvDC74OiEDFi12ugR
 q2mqzi8t0umX9GY9obTPhPv2cNjnxFBTsQgs2su42zrvR0pWm+Na7xqrW+ovPcd1I75yvLa6ys
 X02dx8abase9ZvVAu/jUHA+WDtjgwlKJbQzPL3QjoG/O81jZx5F3ukeuMP+wiZtSQq/7ZIBH8b
 6pU=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AV/EkSBapINfSme96pxLrUYz/LSx+4OfEezUN45?=
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
 =?us-ascii?q?DV4FAgTiHXYUBgUE/hF+KQgSya4JUgnGVKwwdgkuab5AdnzsigVZNIBiDJFA?=
 =?us-ascii?q?YDZBMF44nQjA3AgYIAQEDCVcBIgGOCAEB?=
X-IPAS-Result: =?us-ascii?q?A2BKBwAE57pe/xCltltmhHqBZBIsjSWFfIwYkVgLAQEBA?=
 =?us-ascii?q?QEBAQEBNAECBAEBhESCBCc4EwIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBAQcKA?=
 =?us-ascii?q?gGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsT0zhVGDV4FAgTiHXYUBg?=
 =?us-ascii?q?UE/hF+KQgSya4JUgnGVKwwdgkuab5AdnzsigVZNIBiDJFAYDZBMF44nQjA3A?=
 =?us-ascii?q?gYIAQEDCVcBIgGOCAEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 12 May 2020 20:18:08 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 3/6 linux-next] notify: add mutex destroy
Date:   Tue, 12 May 2020 20:18:03 +0200
Message-Id: <20200512181803.405832-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

destroy mutex before group kfree

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/group.c b/fs/notify/group.c
index f2cba2265061..0a2dc03d13eb 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -25,6 +25,7 @@ static void fsnotify_final_destroy_group(struct fsnotify_group *group)
 		group->ops->free_group_priv(group);
 
 	mem_cgroup_put(group->memcg);
+	mutex_destroy(&group->mark_mutex);
 
 	kfree(group);
 }
-- 
2.26.2

