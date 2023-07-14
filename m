Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D9875325D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjGNG6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjGNG6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:58:09 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696E32707
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 23:58:08 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2MkJ2S1CzBR9sv
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 14:58:00 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689317880; x=1691909881; bh=5mGWjZ7vweUu5MUVjKWp/pFRO8o
        CNjW6DZ1h7SDItd4=; b=QPTPuMmCBiAzXVe4QSk+wwxH/34QvgBmiEAhOxzJ8jy
        ZVRlE0Vludb2MT9GdpzWDnBMC0iLyvep7wxMtIvq9XvWFR51bX4EErn+JG9Paikj
        mN24gv5Oj3MhBQ3iVosqYC5wF0VeKs2BRScCXCvx52RJbzqW5K7ELQCnX5JjIWAW
        BoIht24NJBmPUVDgq4fTlmYpFb66hKvsLpHuFS8rKvag6FWFs8RHSS+/g5IF6I9V
        /CciR6UYKBTTYqn8rftoNmxFonAP35dgPFeA81VBKOAiKkpeItcXRoHbfolp3EM3
        afdK90K3oXz6ybrGeO4ArCigiztYe3qFiP63WeTC4Ig==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lTzupdTobm0R for <linux-fsdevel@vger.kernel.org>;
        Fri, 14 Jul 2023 14:58:00 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2MkH6z1yzBJFS7;
        Fri, 14 Jul 2023 14:57:59 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 14:57:59 +0800
From:   huzhi001@208suo.com
To:     pmladek@suse.com, tglx@linutronix.de, senozhatsky@chromium.org,
        adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: Fix four errors in kmsg.c
In-Reply-To: <tencent_053A1A860EFB7AAD92B2409B9D5AE06AB507@qq.com>
References: <tencent_053A1A860EFB7AAD92B2409B9D5AE06AB507@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <2f88487fa9f29eeb5a5bd4b6946a7e4c@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following checkpatch errors are removed:
ERROR: "foo * bar" should be "foo *bar"
ERROR: "foo * bar" should be "foo *bar"
ERROR: "foo * bar" should be "foo *bar"
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  fs/proc/kmsg.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/kmsg.c b/fs/proc/kmsg.c
index 2fc92a13f9f8..64025da60e2a 100644
--- a/fs/proc/kmsg.c
+++ b/fs/proc/kmsg.c
@@ -17,12 +17,12 @@

  #include <asm/io.h>

-static int kmsg_open(struct inode * inode, struct file * file)
+static int kmsg_open(struct inode *inode, struct file *file)
  {
      return do_syslog(SYSLOG_ACTION_OPEN, NULL, 0, SYSLOG_FROM_PROC);
  }

-static int kmsg_release(struct inode * inode, struct file * file)
+static int kmsg_release(struct inode *inode, struct file *file)
  {
      (void) do_syslog(SYSLOG_ACTION_CLOSE, NULL, 0, SYSLOG_FROM_PROC);
      return 0;
