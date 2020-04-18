Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B956F1AF37C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgDRSmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727902AbgDRSlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78995C061A0C;
        Sat, 18 Apr 2020 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=Z/ABBV2vtDLyfRcjamC38HwxTrQtSwsZcb0OzbkWsUE=; b=rJ3FSC6+DaZYG5qDC0wUPtN1SQ
        6kc24pbTmZHwpWQG5VbJcOvhSND5w9lvWyU0STq3J5awSJ+mQGR6mBrLgoi2n3O6n9Jw35QUg9Y74
        9mmpZhqsG2g9ClzjoUATTOR7PYeSeWpeoKr+IpZYuUcbVJVRFfFgNbPYgpOz2vwvO1ArJnNTugkXf
        e5UqMYAoTNEErclRAZHOgSgCt9idLwF4FUQ0aYMp3ZrqvF+UofS5GPLc/CzBRVxKIeIMKMq5oaCq0
        LHXEtvPs6ntRLkN71ahJU4FlZPCqVhnccZu4pp1C/uv0wBPvLn5xg26bBKm46QINfwvrPOOMyxieh
        11sA8ibQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsP2-0007rZ-8t; Sat, 18 Apr 2020 18:41:20 +0000
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
Subject: [PATCH 7/9] drivers/base: fix empty-body warnings in devcoredump.c
Date:   Sat, 18 Apr 2020 11:41:09 -0700
Message-Id: <20200418184111.13401-8-rdunlap@infradead.org>
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

../drivers/base/devcoredump.c:297:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/base/devcoredump.c:301:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/base/devcoredump.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20200417.orig/drivers/base/devcoredump.c
+++ linux-next-20200417/drivers/base/devcoredump.c
@@ -9,6 +9,7 @@
  *
  * Author: Johannes Berg <johannes@sipsolutions.net>
  */
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/devcoredump.h>
@@ -294,11 +295,11 @@ void dev_coredumpm(struct device *dev, s
 
 	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
 			      "failing_device"))
-		/* nothing - symlink will be missing */;
+		do_empty(); /* nothing - symlink will be missing */
 
 	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
 			      "devcoredump"))
-		/* nothing - symlink will be missing */;
+		do_empty(); /* nothing - symlink will be missing */
 
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
