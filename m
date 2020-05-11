Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA291CE22A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgEKSCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 14:02:02 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58553 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729305AbgEKSCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 14:02:02 -0400
IronPort-SDR: AzlDzc36Dtnhx6eGgeHaxDmnAyiE2rj/RHcNwXjd4v6PKTlZ3wbdMYfHapkwF/94ZoJXtUgO3y
 oIFRnYJRSqyR5vTRvSo6WduU5evi2vrQL65szH4N9gP1j305Zyq5d6mG0mDueX3c8Z4617gQ4v
 d8KaEifS5ZajQSEhSuH3kbbuFZHwzWVjpBH6OBJViZadgt3yA/u7m55/3ugfitWXBdwqYRKXsL
 YtMI/IxPjDucEpldFBtpiBrNCfQlBHlrJMlcqdu8h21QeqelGI4nl7ntZT6GN7BLsP0WQrPgJs
 zZY=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3A7IJf0xGNRoOUeftMMWWd/p1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yo8SwAkXT6L1XgUPTWs2DsrQY0reQ4virADVaqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5yIRmsqQjdqsYajZZ/Jqov1x?=
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
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2COBgACkrle/xCltltmglCCKoFkEiy?=
 =?us-ascii?q?NJYV6jBiRWAsBAQEBAQEBAQE0AQIEAQGERIINJzcGDgIDAQEBAwIFAQEGAQE?=
 =?us-ascii?q?BAQEBBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoNNASMjT3ASgyaCWCmwdIV?=
 =?us-ascii?q?Rg1aBQIE4h12FAYFBP4RfhBWGLQSya4JUgnGVKwwdgkuaby2PcJ86I4FWTSA?=
 =?us-ascii?q?YgyRQGA2fCkIwNwIGCAEBAwlXASIBi0OCRQEB?=
X-IPAS-Result: =?us-ascii?q?A2COBgACkrle/xCltltmglCCKoFkEiyNJYV6jBiRWAsBA?=
 =?us-ascii?q?QEBAQEBAQE0AQIEAQGERIINJzcGDgIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBA?=
 =?us-ascii?q?QcKAgGETiEBAwEBBQoBQ4I7IoNNASMjT3ASgyaCWCmwdIVRg1aBQIE4h12FA?=
 =?us-ascii?q?YFBP4RfhBWGLQSya4JUgnGVKwwdgkuaby2PcJ86I4FWTSAYgyRQGA2fCkIwN?=
 =?us-ascii?q?wIGCAEBAwlXASIBi0OCRQEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 20:02:00 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 6/9 linux-next] fsnotify/fdinfo: remove proc_fs.h inclusion
Date:   Mon, 11 May 2020 20:01:55 +0200
Message-Id: <20200511180155.215094-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

proc_fs.h was already included in fdinfo.h

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/fdinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index ef83f4020554..f0d6b54be412 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -11,7 +11,6 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/seq_file.h>
-#include <linux/proc_fs.h>
 #include <linux/exportfs.h>
 
 #include "inotify/inotify.h"
-- 
2.26.2

