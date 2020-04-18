Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418EC1AF35C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgDRSlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726382AbgDRSlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A68C0610D5;
        Sat, 18 Apr 2020 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=LOicRCPeL82g+7UhQ7W6knJ0Xcg7BEBtrZpHvQi2Xvs=; b=qUPAX78GmStmrzI/GjQeS30C2C
        pf+JS26rMvDzwnc2Eicv/E6iYddiBqeB8nvkVcgSW2j/uHe3NwddNiMvUjPHgrYQrMTB6NBEJ6Q4j
        Rmevyte62j1lID7vgkcJqqYHGR2MOeuzttD0VlNCXVRCcyTVd3GSoufQdGDlcNf+0ThcfvOl9CRWa
        Ht+LS8ZEFX/rH894i3z4iad3ZPVXY1Udf3RqCd/qSxW56OPRStx5/BhopFFsaYXhXitaPPN84WLos
        fDoyVBiGWJ7uO4FMNjLq8+6J2A3ZeS/prafMTg+o4HUDBJXsY7KFv8UjH8Xb/sVT1g7Gs5uV5n4n7
        om//euPw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsOz-0007rZ-FM; Sat, 18 Apr 2020 18:41:17 +0000
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
Subject: [PATCH 4/9] sound: fix empty-body warning in vx_core.c
Date:   Sat, 18 Apr 2020 11:41:06 -0700
Message-Id: <20200418184111.13401-5-rdunlap@infradead.org>
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

../sound/drivers/vx/vx_core.c:515:3: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 sound/drivers/vx/vx_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20200327.orig/sound/drivers/vx/vx_core.c
+++ linux-next-20200327/sound/drivers/vx/vx_core.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <sound/core.h>
@@ -512,7 +513,7 @@ irqreturn_t snd_vx_threaded_irq_handler(
 	 * received by the board is equal to one of those given to it).
 	 */
 	if (events & TIME_CODE_EVENT_PENDING)
-		; /* so far, nothing to do yet */
+		do_empty(); /* so far, nothing to do yet */
 
 	/* The frequency has changed on the board (UER mode). */
 	if (events & FREQUENCY_CHANGE_EVENT_PENDING)
