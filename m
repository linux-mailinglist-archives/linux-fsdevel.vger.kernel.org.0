Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617C51CFD10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgELSSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:18:50 -0400
Received: from mailrelay115.isp.belgacom.be ([195.238.20.142]:26638 "EHLO
        mailrelay115.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730978AbgELSSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:18:49 -0400
IronPort-SDR: naegeXBE5vTA3AgOLAzPnFpZ0cCOHR74wGPOWbxeBh16rXhY5FRJsDcaEe3rJO4rILeWPQQ1BX
 MH02uVrBIC6dhxCqKwez6Xe9wgt2m/XtskSmSkx2z70w65tcj6kaorDXHY/ChSq/mPGuGEJu0v
 DOIFJHEPdvzzYFmuwvfiSPkCBOr0LNi0ICI7ogzs99WdgXbUJicHTEwFGAhnGiSnAJ9NM6wUeR
 uAWWlPDJ7z5Ha+DTmMJSh3Z+t7hMKQrjthknRnPsO3+pRBYnkhtBIwOy2FSFH9GtJjEivnoZbA
 SXc=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AABwaFxF2njoKgT/tnRozVp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yo8SwAkXT6L1XgUPTWs2DsrQY0reQ4vqrADVQqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5yIRmsqQjdqMYajZZ/Jqsy1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOjgk+2/Vl8NwlrpWrhK/qRJizYDaY4abO/VxcK7GYd8XRn?=
 =?us-ascii?q?BMUtpLWiBdHo+xaZYEAeobPeZfqonwv1sAogGlCgmtHuzvzCJDiH/s3aIkzu?=
 =?us-ascii?q?suDxvG3A08ENINrX/Zq9v1O70JXuC716TI1jbDbvNQ2Tjj9IjEaAsuru+VUL?=
 =?us-ascii?q?92bMHexlUhGRnfgVWMtYzqISmV1uIVvmaV7OdtUeKhhm8npg1vrDWhxtohhp?=
 =?us-ascii?q?XUio4Jy13K+ip3zZs7KNCmVUN2YdypHYVfuS2GOYV4TccvTWFotiokzrALv4?=
 =?us-ascii?q?OwcisSyJk/wxPTduaLf5WL7x79TuqdPDZ1iXJ/dL6ihhu/91WrxPfmWcmuyl?=
 =?us-ascii?q?lKqzJIktzLtn8QyRPe8tOHSv5h/ke53jaPyhzT5vlEIU8qkarbLIYszaUxlp?=
 =?us-ascii?q?ocvkTDAzT2mF7xjK+Sa0Uk4fKk6+TgYrXjuJCQL450igfgPaQygsGyBfk0Ph?=
 =?us-ascii?q?ITU2WY5+iwzqDv8Ez5TblQk/E7k7HVsJXAKsQaoq65DRVV0oEm6xunATepys?=
 =?us-ascii?q?8XnXccIVJeexKGj47pNE/SIPziFviwnUygkC13yPDeIr3hHpLNI2DBkLj7Yb?=
 =?us-ascii?q?l96FVRyBEuzdBE+Z1YEK0OIfPrUE/rqNPYFgM5MxCzw+v/Etp904IeWXiND6?=
 =?us-ascii?q?KXMaPStUSF5u0qI+aWZY8VvCzxJOQi5/7rlXU5g0MSfbG13ZsLb3C1BvBmI0?=
 =?us-ascii?q?SfYXrxjdYNCGkKvhEjQ+P0ll2NTzpTam2sX6Iz+D47EpiqDYTdSYC3hryOwi?=
 =?us-ascii?q?O7EodRZmBcBVCGCW3oeJmcW/cQdCKSJddskjIeWre6RY8szgqutAz6yrphMO?=
 =?us-ascii?q?XU5jcUuon924s92+qGlxg59hRvEt+QlWqfCyl9m2ISGGQ32IhwpEV8zhGI1q?=
 =?us-ascii?q?0rreZfEIl97vlIWwFyG4TRw+FgCtvxElbPd92HYE2lU9OrHXc7Q4RikJc1f0?=
 =?us-ascii?q?9hFoD63Vj41C2wDupNmg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ChDAAE57pe/xCltltmHQEBPAEFBQE?=
 =?us-ascii?q?CAQkBgV6CKIFkEiyNJYV8jBiKMoU/gWcLAQEBAQEBAQEBNAECBAEBhESCBCc?=
 =?us-ascii?q?4EwIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoN?=
 =?us-ascii?q?NASMjT3ASgyaCWCmxcIVRg1eBQIE4AYdchQGBQT+EX4QVH4YOBLJrglSCcZU?=
 =?us-ascii?q?rDB2dOi2PcJ87IoFWTSAYgyRQGA2fCkIwNwIGCAEBAwlXASIBi0OCRQEB?=
X-IPAS-Result: =?us-ascii?q?A2ChDAAE57pe/xCltltmHQEBPAEFBQECAQkBgV6CKIFkE?=
 =?us-ascii?q?iyNJYV8jBiKMoU/gWcLAQEBAQEBAQEBNAECBAEBhESCBCc4EwIDAQEBAwIFA?=
 =?us-ascii?q?QEGAQEBAQEBBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoNNASMjT3ASgyaCW?=
 =?us-ascii?q?CmxcIVRg1eBQIE4AYdchQGBQT+EX4QVH4YOBLJrglSCcZUrDB2dOi2PcJ87I?=
 =?us-ascii?q?oFWTSAYgyRQGA2fCkIwNwIGCAEBAwlXASIBi0OCRQEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 12 May 2020 20:18:46 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 4/6 linux-next] fanotify: remove reference to fill_event_metadata()
Date:   Tue, 12 May 2020 20:18:36 +0200
Message-Id: <20200512181836.405879-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fill_event_metadata() was removed in commit bb2f7b4542c7
("fanotify: open code fill_event_metadata()")

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 42cb794c62ac..02a314acc757 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -328,7 +328,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	ret = -EFAULT;
 	/*
 	 * Sanity check copy size in case get_one_event() and
-	 * fill_event_metadata() event_len sizes ever get out of sync.
+	 * event_len sizes ever get out of sync.
 	 */
 	if (WARN_ON_ONCE(metadata.event_len > count))
 		goto out_close_fd;
-- 
2.26.2

