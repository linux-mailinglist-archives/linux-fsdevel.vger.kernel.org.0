Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0B1CFD1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgELSTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:19:44 -0400
Received: from mailrelay115.isp.belgacom.be ([195.238.20.142]:26694 "EHLO
        mailrelay115.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbgELSTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:19:43 -0400
IronPort-SDR: QwZxF3PihmMKDV85CkDhGk+l7HWubEZEZ7MZ5zuKkFcs8411iQAqMzbwzeBuHBDVnqrFi3OJ9V
 CACHe5bE6zV/AZaR1eXoU0mVSyCPzdQfq6+Or/0D6PLNvjjVLF5DVMDbpwziV8uzoVeI/E0i72
 Jlmg6hfpDjj+O7ErukuXp/sxVLOFo7q1kDhanQ1kjjtZPIctaeMoD6x4n0V9TAEPhs0Msq8OQX
 4SX0fsx1hieXeVfOItppXTLtFd7yEKGrrPEx5oJVJ92RdPWOoCUqhreJZFENajX8O/mSG5Ynw7
 GiM=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AUgcCOhSZzK9T29BvLtqnI/LXXNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYByN2/xhgRfzUJnB7Loc0qyK6v2mCDZLuM/R+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi2oAnLssQan4RuJrssxh?=
 =?us-ascii?q?bKv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/WfKgcJyka1bugqsqRxhzYDJbo+bN/1wcazSc94BWW?=
 =?us-ascii?q?ZMXdxcWzBbD4+gc4cCCfcKM+ZCr4n6olsDtRuwChO3C+Pu0DBIgGL9060g0+?=
 =?us-ascii?q?s/DA7JwhYgH9MSv3TXsd74M6kSXvquw6nG1jjDdPBW2Df76IfWbhAtu+qDUq?=
 =?us-ascii?q?xpfMfX1EIgGB/LgE+Kpoz5IzOayP4Ns26D4uRuVu+ij24ppgBxrzSxyMoiip?=
 =?us-ascii?q?TEip4IxlzY9Ch3z4k7KMC2RUNlfNOpEJlduj+VOYdqTM0sTGVltiY6xLEYvZ?=
 =?us-ascii?q?O2ejUBxpc/xxPHb/GLbpKE7g/gWeqPOzt0mXNodbKlixqv8EWtzPD3WNOu31?=
 =?us-ascii?q?ZQtCVFl8HBtnUK1xPO9MeKUuB9/kK92TaX0ADT9/1ELVg0laXFL54hxaY9mY?=
 =?us-ascii?q?ESsUTMES/2hV72jLSRdkUg5+io8P7rYrXhpp+ZKYB4kgD+MqIwlcyjGek1Nh?=
 =?us-ascii?q?UCU3KG9em/yrHv51D1TbRKg/Esj6XUsYjWJcEBqa64Bw9V3Jwj6xG6Dzq+3t?=
 =?us-ascii?q?QXh2IILFxedRKcjIjoO1fOL+7kDfulmFujji9nx+raMb35HpXNMn/Dna/jfb?=
 =?us-ascii?q?ln90FcyxE+zctC55JPFL4NOu78W07pvtzCEhA5KxC0w/rgCNhlzIweXGOPAr?=
 =?us-ascii?q?WbPa7csF+I4vkiI+aJZIAPuTb9L+Ip6OLpjX88gVUdZ7Wm3YMLaHCkGfRrO0?=
 =?us-ascii?q?GZYXvqgtccHmYGpwQ+TPf3h1KcTz5ceXKyUrki5jE0Fo2mF53PRoOzj7yb2i?=
 =?us-ascii?q?e0AJlWanpBClCWHnfib5+EVOsUaCKOPs9hlSQJVba7RIA62xGjrxT6y7lnL+?=
 =?us-ascii?q?rS5CIYqYjv28Nr6L6bqRZn9zV/DOyGznqACWpm2isBQj4sg/t+pWRyz16C1e?=
 =?us-ascii?q?5zhPkLO8ZU4qZnWw07PJiU4fZ3B93oWwnCNoOHQVyoas6lEDc8UpQ7zoldMA?=
 =?us-ascii?q?5GB9y+g0WbjGKRCLgPmunTCQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CsCgB56Lpe/xCltltmglKCKIFkEiy?=
 =?us-ascii?q?NJYV+jBiRWAsBAQEBAQEBAQE0AQIEAQGERIIEJzkFDQIDAQEBAwIFAQEGAQE?=
 =?us-ascii?q?BAQEBBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoNNASMjT3ASgyaCWCmxc4V?=
 =?us-ascii?q?Rg1GBQIE4h12FAYFBP4RfhBWGLQSya4JUgnGVKwwdgkuaby2PcJ88IYFWTSA?=
 =?us-ascii?q?YgyRQGA2fCkIwNwIGCAEBAwlXASIBi0OCRQEB?=
X-IPAS-Result: =?us-ascii?q?A2CsCgB56Lpe/xCltltmglKCKIFkEiyNJYV+jBiRWAsBA?=
 =?us-ascii?q?QEBAQEBAQE0AQIEAQGERIIEJzkFDQIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBA?=
 =?us-ascii?q?QcKAgGETiEBAwEBBQoBQ4I7IoNNASMjT3ASgyaCWCmxc4VRg1GBQIE4h12FA?=
 =?us-ascii?q?YFBP4RfhBWGLQSya4JUgnGVKwwdgkuaby2PcJ88IYFWTSAYgyRQGA2fCkIwN?=
 =?us-ascii?q?wIGCAEBAwlXASIBi0OCRQEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 12 May 2020 20:19:12 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 5/6 linux-next] fsnotify/fdinfo: remove proc_fs.h inclusion
Date:   Tue, 12 May 2020 20:19:06 +0200
Message-Id: <20200512181906.405927-1-fabf@skynet.be>
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

