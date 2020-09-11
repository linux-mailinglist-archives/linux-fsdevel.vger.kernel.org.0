Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877782656DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 04:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKCGi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 22:06:38 -0400
Received: from smtp.h3c.com ([60.191.123.50]:12561 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgIKCGi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:06:38 -0400
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
        by h3cspam02-ex.h3c.com with ESMTPS id 08B26Hbl001293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Sep 2020 10:06:17 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 10:06:18 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Fri, 11 Sep 2020 10:06:18 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs: use correct parameter in notes of
 generic_file_llseek_size()
Thread-Topic: [PATCH] fs: use correct parameter in notes of
 generic_file_llseek_size()
Thread-Index: AQHWg1VbepwpzeymnU+ybaV+ROAJcqliuT9Q
Date:   Fri, 11 Sep 2020 02:06:18 +0000
Message-ID: <3808373d663146c882c22397a1d6587f@h3c.com>
References: <20200905071525.12259-1-tian.xianting@h3c.com>
In-Reply-To: <20200905071525.12259-1-tian.xianting@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08B26Hbl001293
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi viro,
Could I get your feedback?
This patch fixed the build warning, I think it can be applied, thanks :) 

-----Original Message-----
From: tianxianting (RD) 
Sent: Saturday, September 05, 2020 3:15 PM
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; tianxianting (RD) <tian.xianting@h3c.com>
Subject: [PATCH] fs: use correct parameter in notes of generic_file_llseek_size()

Fix warning when compiling with W=1:
fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
fs/read_write.c:88: warning: Excess function parameter 'size' description in 'generic_file_llseek_size'

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5db58b8c7..058563ee2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
  * @file:	file structure to seek on
  * @offset:	file offset to seek to
  * @whence:	type of seek
- * @size:	max size of this file in file system
+ * @maxsize:	max size of this file in file system
  * @eof:	offset used for SEEK_END position
  *
  * This is a variant of generic_file_llseek that allows passing in a custom
-- 
2.17.1

