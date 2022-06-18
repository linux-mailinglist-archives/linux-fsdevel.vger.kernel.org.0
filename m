Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1A550528
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiFRNkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiFRNkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:40:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435EE1A81F
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 06:40:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso6872472pjg.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=GdSotkFN7xY3H7yLa8iAdQvEWwbU2aQlVUpsAnr2Raw=;
        b=Wn2f8SpBFOlOS3n7pJXCp2sl/67ky5Av1UvjzsFgckxwqLdlivyVWbmrobeQdE83UP
         0PRfm+t6SDWh1IYN8VK5U//PWWXtqXZRc8SV3KI1t7/7eaqVRzHYKs/eFJNG01gQyJYW
         dpB0CY/JDKYP/bCE1HLFG0EVRcla9te5yCPD6BR8EIEk0pAwQiYwNuNcUhF7TLOa/ocq
         fLg7+nH5r+rfAwh6H4DhzAvBFhGX87FY3LpD8x5jVp1EupANL0w0+L3VpxvA+VWLIjwA
         oavZIYtStOnGcdsqpNkPYWTfESTI4gCi2BuszsJtEGhrMoCFqkoSbVHxCJf4mqL8vHL7
         8vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=GdSotkFN7xY3H7yLa8iAdQvEWwbU2aQlVUpsAnr2Raw=;
        b=6cfcaoQYUE76TxxRMS/GZyK3Pjypj9qFyD6I8p4O9973lhEcbZ1tAU2hfi7130YyxU
         VF419I2l/sAZ/yK71hS9Ijfmhdz51u6/B9lL1Ezf/QeJPoUqqYeNuvYJL9sVIOUD39Wv
         TnHoZLLA+i4W2wbAAZS6XwVjkkcbLgwrwKF6E+Q00QVBvKdeU0+Ow8rcajhgHFou569i
         iCYtgCBu88iDk3Nla7zZ1wLmQcB62qrGuyrYojzOUORwyIALubOmj6MZzwj/l5+LakIu
         9EM75I8yYDgWbJXuzUmds7F/DVxPai8CJrANsP0mEpVtPEaDBW0Wo6UoH841vKQzuWQN
         iFAQ==
X-Gm-Message-State: AJIora/oDCtSPzjoufiFz5K8WX6MLVJSBVOuiNyguCrKFlF8J2//ymG3
        h5cbnGqNiZyM9JkH/hthBenujWToR1FSsg==
X-Google-Smtp-Source: AGRyM1shuNAwmh2QwAZydZ/xxpoJgAmLyQYb5MQ2Q2MVRWquAn0PW3xhdqrvHlrp1dZlXVg+h69cHA==
X-Received: by 2002:a17:90b:464b:b0:1e8:7881:b238 with SMTP id jw11-20020a17090b464b00b001e87881b238mr27299567pjb.166.1655559637716;
        Sat, 18 Jun 2022 06:40:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d15-20020a621d0f000000b0052513b5d078sm204197pfd.31.2022.06.18.06.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 06:40:37 -0700 (PDT)
Message-ID: <9d3418e3-7674-e9e6-0518-dbb4a6c921cc@kernel.dk>
Date:   Sat, 18 Jun 2022 07:40:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] iov_iter: fix bad parenthesis placement for iter_type check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Due to some unfortunate placement of the parenthesis for the iter_type
check in iov_iter_restore(), we can generate spurious triggers of the
type WARN_ON_ONCE() even if the iter is of the correct type.

While in there, correct the comment on what types can be used with the
save/restore helpers, and fix an extra word in the function description.

Fixes: 6696361cc3d8 ("new iov_iter flavour - ITER_UBUF")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0973c622d3c0..f569190f8685 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1925,15 +1925,15 @@ int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
  * @i: &struct iov_iter to restore
  * @state: state to restore from
  *
- * Used after iov_iter_save_state() to bring restore @i, if operations may
- * have advanced it.
+ * Used after iov_iter_save_state() to restore @i, if operations may have
+ * advanced it.
  *
- * Note: only works on ITER_IOVEC, ITER_BVEC, and ITER_KVEC
+ * Note: only works on ITER_IOVEC, ITER_BVEC, ITER_KVEC, and ITER_UBUF.
  */
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
-	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i)) &&
-			 !iov_iter_is_kvec(i) && !iter_is_ubuf(i))
+	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
+			 !iov_iter_is_kvec(i) && !iter_is_ubuf(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;

-- 
Jens Axboe

