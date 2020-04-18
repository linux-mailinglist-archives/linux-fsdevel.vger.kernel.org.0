Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0E1AF35F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgDRSlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbgDRSlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E464C061A0C;
        Sat, 18 Apr 2020 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=PcYjWQQ7jWfjWjAXgVV1SYCf3duL2j5Dyqo6dTDCrvc=; b=JDXvnRUeifNZ+Ac5TUneCkXEfw
        xGm7FAIuWAOT5gimqOHdhp/grioqH8IcST+jg0KLZY3liAOqyk+QRxz88gfFrn1pGspjvVf4kn+9z
        6WnDEql0MbixpKyaGExg7dKQXpW5xcLjkR6Sghi8cCQI/hTO1yXq4UDTbsHmGn4nDqmEnHzJuU3K1
        xD7HyAbbCak26otzJily36UMy3pM+4gOlaaVkoFKBllnKTlL2HIrqBh3/P+uJ7g73UIIdgCRYZljh
        6KJkixDPOYB+DeexXaN99s1T3haGNSH+ia9YOZZ2bNW49PZ2AL6kZXsFv+3C4ILtQ3Sm08S03mSqL
        JJuwddgw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsP4-0007rZ-33; Sat, 18 Apr 2020 18:41:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: [PATCH 9/9] target: fix empty-body warning in target_core_pscsi.c
Date:   Sat, 18 Apr 2020 11:41:11 -0700
Message-Id: <20200418184111.13401-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix gcc empty-body warning when -Wextra is used:

../drivers/target/target_core_pscsi.c:624:5: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: target-devel@vger.kernel.org
---
 drivers/target/target_core_pscsi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20200417.orig/drivers/target/target_core_pscsi.c
+++ linux-next-20200417/drivers/target/target_core_pscsi.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/genhd.h>
+#include <linux/kernel.h>
 #include <linux/cdrom.h>
 #include <linux/ratelimit.h>
 #include <linux/module.h>
@@ -621,7 +622,7 @@ static void pscsi_complete_cmd(struct se
 
 			buf = transport_kmap_data_sg(cmd);
 			if (!buf)
-				; /* XXX: TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE */
+				do_empty(); /* XXX: TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE */
 
 			if (cdb[0] == MODE_SENSE_10) {
 				if (!(buf[3] & 0x80))
