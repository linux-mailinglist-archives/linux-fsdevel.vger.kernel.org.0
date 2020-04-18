Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142141AF376
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgDRSl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727936AbgDRSlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C45C061A0C;
        Sat, 18 Apr 2020 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=RAwgh7dK6Aq2GUmD2z2q67RSpKe0Qba5fsNnenVzxMI=; b=j5q/SQ1+k3/+/NWSTV/WCIkHyr
        zch6FAcwYZsrW1PmSwaW8sUH6ZWeOC45ea2Cw5ovOtRwJLJOkQhRg13tWis5r+icV/DhjmdEjwv79
        s2h+fCIcRl3RnLCdtSGFczimDTd9m/8AzLPWV2hp+UzgF8z2XnH0R/f/a5DQg9nNd3Y73Ad9ZrO4P
        SE8YtJq+oauVuVNS6MyEi2RLVp6TVtw40sWJHw1JEOXlVu7aGBz0X1bug3Vw49BLE3fO57MGGN/q0
        Pmq5oXAMF6sIRcv8GgeZALDInNNSJ4NKJzYxSO84gAsonX87pABbmdSy94HL9m+wa0jkyxTrzud66
        2h6YWfaA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsP3-0007rZ-5p; Sat, 18 Apr 2020 18:41:21 +0000
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
Subject: [PATCH 8/9] dax: fix empty-body warnings in bus.c
Date:   Sat, 18 Apr 2020 11:41:10 -0700
Message-Id: <20200418184111.13401-9-rdunlap@infradead.org>
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

../drivers/dax/bus.c:93:27: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
../drivers/dax/bus.c:98:29: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/dax/bus.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20200417.orig/drivers/dax/bus.c
+++ linux-next-20200417/drivers/dax/bus.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2017-2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
 #include <linux/device.h>
+#include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -90,12 +91,12 @@ static ssize_t do_id_store(struct device
 			} else
 				rc = -ENOMEM;
 		} else
-			/* nothing to remove */;
+			do_empty(); /* nothing to remove */
 	} else if (action == ID_REMOVE) {
 		list_del(&dax_id->list);
 		kfree(dax_id);
 	} else
-		/* dax_id already added */;
+		do_empty(); /* dax_id already added */
 	mutex_unlock(&dax_bus_lock);
 
 	if (rc < 0)
