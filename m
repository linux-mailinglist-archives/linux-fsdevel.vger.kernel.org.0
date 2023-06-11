Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BB72B37F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFKTG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFKTG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:06:26 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26F1B9;
        Sun, 11 Jun 2023 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686510380;
        bh=8ml7v+xU/fb8GPueIIAwZGo3QlTjbtM+C3EF4n/SEqs=;
        h=From:To:Cc:Subject:Date;
        b=QkPBh4vQ5XsOUo8r6E89KkC0QoJdLQurRA2Nz0H+7BszcFuxxGCrCcmZEbnCmdTv4
         z+Ea+ODfiP99gG9y8WxF+gbj3RMMjCehgWTm7HytQdXzxSzNcsh4/ph0h52i10YWP1
         bUDGDRvs9JPom/BkbUoQOBnX5pMrpeF976Jc0KG0=
Received: from wen-VirtualBox.. ([240e:331:cb9:1200:2421:564d:c6df:cf15])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 231CFF; Mon, 12 Jun 2023 03:00:02 +0800
X-QQ-mid: xmsmtpt1686510002t1ci3qfia
Message-ID: <tencent_59C3AA88A8F1829226E5D3619837FC4A9E09@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7PwLIoGFEU7ENLv7uL9cJpfNRVZ+kKV7utWSXonFNPZOs6b2OxN
         nWmrih+zZaMQgAgK0yvupnrYte2rU+g4bkbqY2oshAlwiOmpB3c/oySOpEeKkdbDqwXC7FQqPv1G
         Q1YgWJ+Y8JXtUxeXYsFzxo6Phy6Sqby4bG+R7Fzxvz+2BBurbqyNh8V/k/a1q/5QGABp1tZaPweL
         gYCm2vWA+WrzSliKKF4m0O5ADUB5trKItyJ2oO/mb/k2KeJD4ToYnOImfXe1U96oiLD5tnfkHZsI
         Ds7JREU5UDlQGqlZi+8Z/mdFvO3Ey0Ld/OsOvj+5uHRA1L8Z+T1oXOhOYw9uNx+e1s5CCohWSan5
         Mdw7+twfcitizmWe+2Pl5zDjNxisVtl0hU9nAON3upGbiCXD8n58k4Y8RCWtjo+Zy9fN49dDb3FL
         U+aVHBvq/aFad7bHVXTegdYrWY3RsR/kOIy0R1BShVIBEWS3wDRsxpsd1e7IHYbHXEQLEbMmJ1xw
         4ClL1nSk4y485J1sMVxqotMDI9IRu1y05HK8dySItCSivtY05NlVC3pbqlASHEfoEbSsyGOeYhMh
         HPFEUMWfZiB4unwY+LG98T3PXctbveHx7KEywHYhozdQRIFLVvOaRP35fmhnZck/inTEHuKR0Hsw
         nr2dPk9R51r8sOUV3Rz7X23I6nUR5S1kEAy9mDonxlcuQ3IPxKrwtz9MNtvtsawYdB6i7u9XxYz7
         vYQwuwVpeBNzCP5H+IRPV/+UEtI6mEjUtavqIxm8qt9DNJiWQL6X7e1Xb/cYE7dVWjAebtHB8jcl
         yeZMANbgJwikVdHys2YqaxwaH64VcRK4QDZjbYm/wCM08oKxCgNC6co7FhwAOC7IlHgGLE6BFgSI
         XTGvBsuOvvHXYGdNGl6f8Lzx24uOT6IMuinPVjiuXWRMPqVtmox7wHxeBBiuDZRhLkeKZAqFRvoX
         VGM1V6wicO8RCDek7k0kERT8PzQMpBjyzAPcNxejxbDwD4tJxUSW0MMXVlfqUD8H5G7arJ/zJoXo
         PitgszsngPhaxtiX7I6glkPDXlXbO3F9NxnurIziQv6f2w7C/dkd0gNowKvf5wFO616/T19g==
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: show flags in fdinfo
Date:   Mon, 12 Jun 2023 02:59:47 +0800
X-OQ-MSGID: <20230611185947.2208-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

The flags should be displayed in fdinfo, as different flags
could affect the behavior of eventfd.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 6c06a527747f..5b5448e65f6f 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -33,10 +33,10 @@ struct eventfd_ctx {
 	/*
 	 * Every time that a write(2) is performed on an eventfd, the
 	 * value of the __u64 being written is added to "count" and a
-	 * wakeup is performed on "wqh". A read(2) will return the "count"
-	 * value to userspace, and will reset "count" to zero. The kernel
-	 * side eventfd_signal() also, adds to the "count" counter and
-	 * issue a wakeup.
+	 * wakeup is performed on "wqh". If EFD_SEMAPHORE flag was not
+	 * specified, a read(2) will return the "count" value to userspace,
+	 * and will reset "count" to zero. The kernel side eventfd_signal()
+	 * also, adds to the "count" counter and issue a wakeup.
 	 */
 	__u64 count;
 	unsigned int flags;
@@ -301,6 +301,7 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 		   (unsigned long long)ctx->count);
 	spin_unlock_irq(&ctx->wqh.lock);
 	seq_printf(m, "eventfd-id: %d\n", ctx->id);
+	seq_printf(m, "eventfd-flags: 0%o\n", ctx->flags);
 }
 #endif
 
-- 
2.34.1

