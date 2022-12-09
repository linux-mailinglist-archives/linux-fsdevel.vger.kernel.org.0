Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7371D647DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 07:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLIGWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 01:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIGWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:22:06 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA9F79C8D;
        Thu,  8 Dec 2022 22:22:04 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NT1By1vc0z5BNRf;
        Fri,  9 Dec 2022 14:22:02 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 2B96Lp24051011;
        Fri, 9 Dec 2022 14:21:51 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 9 Dec 2022 14:21:53 +0800 (CST)
Date:   Fri, 9 Dec 2022 14:21:53 +0800 (CST)
X-Zmail-TransId: 2b066392d40120621de8
X-Mailer: Zmail v1.0
Message-ID: <202212091421536982085@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <corbet@lwn.net>, <kuba@kernel.org>, <bagasdotme@gmail.com>
Cc:     <davem@davemloft.net>, <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjNdIGRvY3M6IHByb2MucnN0OiBhZGQgc29mdG5ldF9zdGF0IHRvIC9wcm9jL25ldCB0YWJsZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B96Lp24051011
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6392D40A.000 by FangMail milter!
X-FangMail-Envelope: 1670566922/4NT1By1vc0z5BNRf/6392D40A.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6392D40A.000/4NT1By1vc0z5BNRf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

/proc/net/softnet_stat exists for a long time, but proc.rst miss it.
Softnet_stat shows some statistics of struct softnet_data of online
CPUs. Struct softnet_data manages incoming and output packets
on per-CPU queues. Note that fastroute and cpu_collision in
softnet_stat are obsolete and their value is always 0.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
Changes since v2: - refine patch subject and git log, thanks to Bagas Sanjaya.
Changes since v1: - refine patch subject
---
 Documentation/filesystems/proc.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e224b6d5b642..9d5fd9424e8b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1284,6 +1284,7 @@ support this. Table 1-9 lists the files and their meaning.
  rt_cache      Routing cache
  snmp          SNMP data
  sockstat      Socket statistics
+ softnet_stat  Per-CPU incoming packets queues statistics of online CPUs
  tcp           TCP  sockets
  udp           UDP sockets
  unix          UNIX domain sockets
-- 
2.15.2
