Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722511CE21E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgEKSAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 14:00:34 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58416 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbgEKSAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 14:00:34 -0400
IronPort-SDR: TGBs/NcPgxU5YwHEhMCt1CkESV440BpfUu/yDaTbJBVBnaS32OzdKLaJ1C/bNvN2a5bT5brIUb
 9+KLZKEJTpDZju8S6dZczdPSitPqhBv9KamLCcNURRKI5V1vogp5aixg4MOIHuZ1FpY6vNkK/b
 P7xGkqC1rye8knMccrvWUUP8c29WyE31IaEl4pSm32IURCld6LkB49vD8eCNlVM/ebPamNWzaF
 +LZNdz5gIeaRXaUBJwkeHp0y6IzgHyQE6zivWP16koTOak6TLW3LXGPQz3INyd4nQ/kEtSXQ4r
 3hI=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AOLdaaBMJrxitgW5zEX4l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/jzrarrMEGX3/hxlliBBdydt6sZzbuO+Pm5AyQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagYb5+NhG7oRneusULnIduNLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyoBKjU38nzYitZogaxbvhyvuhJxzY3Tbo6aO/RzZb/RcNAASG?=
 =?us-ascii?q?ZdRMtdSzBND4WhZIUPFeoBOuNYopH9qVQUthS+BBOjBOXywTFInH/5w7A13P?=
 =?us-ascii?q?o7EQHHwAMgHM8FvXParNrvL6gSX/u4zLLLzTTDafNZxyv95JLTfR8/uPyBW6?=
 =?us-ascii?q?97fsXNx0c1DQzFkkmQppL/PzOTzukDvWuW4u5gW++ui2MrtQ98rDiyy8swl4?=
 =?us-ascii?q?XFmoMYxF/L+yhkzos4O8C1RU55bNO6H5Vcqy+UOYRyT80iQ29kpiI3x7sbsp?=
 =?us-ascii?q?C4ZCgH0JAqywPFZ/CacIWE/AjvWPuQLDp4nn5pZbOyihCv+ka60OL8TNO70F?=
 =?us-ascii?q?NSoypAldnDq24C2gTI6siCVvt95kCh2SuT1wzL6uFLP0Q0la3DJpE6w74wmZ?=
 =?us-ascii?q?UTsVnYHi/tn0X2iLKWdl4+9uio7OTnZ6vpqoedN49ylA7+Lrwjl8iiDegiLw?=
 =?us-ascii?q?QDXHaX9f6h2LDi/UD1WqhGg/wunqncqp/aJMAbpqCjAw9S14Yu8xi/AC2939?=
 =?us-ascii?q?QWhnQHN1FFeRKBj4f3J1HCOuv3Aumnj1S2jDhr3+zGPqHmApjVLHjMiqvufb?=
 =?us-ascii?q?Vm5k5H1Qoz1s5Q64hIBbAAOPjzQFP+tMTEDh8lNAy52/zoCNB81oMEW2+CDK?=
 =?us-ascii?q?6ZMKfJvF+H4+IgOeiMZIsPtDnhLPgl4ubkjWUlll8FYampwZwXZWi8HvRnJU?=
 =?us-ascii?q?WZfHXtjs4PEWcRowUxUvLqh0OGUTNIeXayULwz5ishBIKlE4jDXIatj6KF3C?=
 =?us-ascii?q?uhGZ1WfG9GAEiWEXj0b4WER+sMaCWKL89viDMLTrahRpQ61RGttA76zaRoLv?=
 =?us-ascii?q?bO9iIDq52wnORysu/anhIa7iFvAoKWwSXFRmR1hDxTRjse06V2oEg7wVCGgo?=
 =?us-ascii?q?ZihPkNO9VZ5vpPGikgOJLR1e1xCJimVAvLcP+SS0egT8ngCzxnHYF5+MMHf0?=
 =?us-ascii?q?soQ4bqtRvExSf/W7I=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CPBgACkrle/xCltltmglCCKoFkEiy?=
 =?us-ascii?q?NJYV6jBiRWAsBAQEBAQEBAQE0AQIEAQGERIINJzcGDgIDAQEBAwIFAQEGAQE?=
 =?us-ascii?q?BAQEBBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsEE?=
 =?us-ascii?q?zhVGDVoFAgTiHXYUBgUE/hF+KQgSya4JUgnGVKwwdnTqQHZ86I4FWTSAYgyR?=
 =?us-ascii?q?QGA2fCkIwNwIGCAEBAwlXASIBjggBAQ?=
X-IPAS-Result: =?us-ascii?q?A2CPBgACkrle/xCltltmglCCKoFkEiyNJYV6jBiRWAsBA?=
 =?us-ascii?q?QEBAQEBAQE0AQIEAQGERIINJzcGDgIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBA?=
 =?us-ascii?q?QcKAgGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsEEzhVGDVoFAgTiHX?=
 =?us-ascii?q?YUBgUE/hF+KQgSya4JUgnGVKwwdnTqQHZ86I4FWTSAYgyRQGA2fCkIwNwIGC?=
 =?us-ascii?q?AEBAwlXASIBjggBAQ?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 20:00:32 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 3/9 linux-next] notify: explicit shutdown initialization
Date:   Mon, 11 May 2020 20:00:25 +0200
Message-Id: <20200511180025.214952-1-fabf@skynet.be>
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

