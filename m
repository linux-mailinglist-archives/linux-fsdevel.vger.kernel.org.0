Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC985F7E86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJGUNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 16:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJGUNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:13:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329B9259F
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 13:13:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3562f0fb5a7so54920197b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeV/oO6is47iVyXcP5LuzHYXq7ffrhz178EMVmmCZxw=;
        b=NKdZAGJ/hoQUB4fETy8pvFiPHdAarBjfTlnHaJIjJiyHiOybz5nL4dnIYk7W5NjL+c
         X9vxJHi9pb+YWzaNXwMtHOoqvCYWk7VT7hCbL2Z671axs0B1BaIlFVc3Rn2YvDXfT+Kb
         O4anE3O5E52dxTSLEpDDy8DbS+RqQjMjq61zCxtFiNIOyfVkxCpFnyK9c73fATlOkw4E
         9Pe5TOM8LHpHuvhkSd8+S3TnolgDA7Dq6iKgRP4TwsljAo3gFUsxXnHlu3vw9cFFnP+S
         YOxMEYzjw11ecXdq+V/DrjajOyEXf8t7QM2owD9xSEmNVDhF913qTHO908qBXmpsAgEh
         UZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeV/oO6is47iVyXcP5LuzHYXq7ffrhz178EMVmmCZxw=;
        b=Yr6WeLCckOrO1910AhNEt2w/+U+w4sQ5in9/FGzqvZIDO6e0Q6qyp1S26ym5OByoh9
         z6Bl+LCD0i7ndiiN+sGPtxeU3bCs+kH2E0xbVS80HWXpFoVTBuk5+aEuHPQSuz1cx/CD
         QyP8gpDSfexSY8/vdi0F7/f6DwnOOJLuVDIQeRdQELSmBwOmmI+6jBenfzPDwbCWNtNc
         rinrJDptuU2zbehHlfwMpTSVBA18mT7VsybAZA9t1wCtmy1E98R8PKX8NkLiNpP+rIxX
         Bpl0aeuRAKRQ+3DmbuO6pjfxcnbNLWi+RPZnUFKyxxp/Mzk9+f7vO2JEy9ldWBTr0Bw8
         0bXQ==
X-Gm-Message-State: ACrzQf1YH2G4hdyJiWPxL9C85hYBWwWf+lMu2IMB/c8uRxyBw52nyXiB
        ReVEdRgAU65QCXzVxa2Y2iqtOzhBJhcDDxErCyE=
X-Google-Smtp-Source: AMsMyM4YEtZ03hdAxqVrRsO9mX+URt9wi2j6Vm9Rb4R6Fbs4KJlR2KIGkImoRTDrJygPokSaW3y1Ullba7P7Zs/Xe38=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:35a0:96d6:8c4e:f207])
 (user=ndesaulniers job=sendgmr) by 2002:a81:63c6:0:b0:349:37f7:73dd with SMTP
 id x189-20020a8163c6000000b0034937f773ddmr6290110ywb.368.1665173591307; Fri,
 07 Oct 2022 13:13:11 -0700 (PDT)
Date:   Fri,  7 Oct 2022 13:11:40 -0700
In-Reply-To: <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
Mime-Version: 1.0
References: <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665173500; l=2694;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=2c8iFYi9IODS8rz+uI3eXvt5cNoC+Xak1t9Qy2KomwU=;
 b=86PIApGJiSWlXPY7m1LwXuZWF8snbRmlzsAvdJLzZYBQVQJCAa1QN4q97mBW9h9GxBeTXlHbMvxK
 iBEJbg4jBz7K4vSp8B6dSHR26kg/33CjfpMJcJIR5sW51yIDhuuZ
X-Mailer: git-send-email 2.38.0.rc2.412.g84df46c1b4-goog
Message-ID: <20221007201140.1744961-1-ndesaulniers@google.com>
Subject: [PATCH] fs/select: mark do_select noinline_for_stack for 32b
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Effectively a revert of
commit ad312f95d41c ("fs/select: avoid clang stack usage warning")

Various configs can still push the stack useage of core_sys_select()
over the CONFIG_FRAME_WARN threshold (1024B on 32b targets).

  fs/select.c:619:5: error: stack frame size of 1048 bytes in function
  'core_sys_select' [-Werror,-Wframe-larger-than=]

core_sys_select() has a large stack allocation for `stack_fds` where it
tries to do something equivalent to "small string optimization" to
potentially avoid a malloc.

core_sys_select() calls do_select() which has another potentially large
stack allocation, `table`. Both of these values depend on
FRONTEND_STACK_ALLOC.

Mix those two large allocation with register spills which are
exacerbated by various configs and compiler versions and we can just
barely exceed the 1024B limit.

Rather than keep trying to find the right value of MAX_STACK_ALLOC or
FRONTEND_STACK_ALLOC, mark do_select() as noinline_for_stack for 32b
targets.

The intent of FRONTEND_STACK_ALLOC is to help potentially avoid a
dynamic memory allocation. In that spirit, restore the previous
threshold but separate the stack frames for 32b targets.

Link: https://lore.kernel.org/lkml/20221006222124.aabaemy7ofop7ccz@google.com/
Fixes: ad312f95d41c ("fs/select: avoid clang stack usage warning")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 fs/select.c          | 7 +++++++
 include/linux/poll.h | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..945d04b9cf5a 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -476,6 +476,13 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
 		wait->_key |= POLLOUT_SET;
 }
 
+#ifdef CONFIG_64BIT
+#define noinline_for_stack_32b
+#else
+#define noinline_for_stack_32b noinline_for_stack
+#endif
+
+noinline_for_stack_32b
 static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 {
 	ktime_t expire, *to = NULL;
diff --git a/include/linux/poll.h b/include/linux/poll.h
index a9e0e1c2d1f2..d1ea4f3714a8 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -14,11 +14,7 @@
 
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
-#ifdef __clang__
-#define MAX_STACK_ALLOC 768
-#else
 #define MAX_STACK_ALLOC 832
-#endif
 #define FRONTEND_STACK_ALLOC	256
 #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
 #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC

base-commit: 93ed07a23fd08b8613f64cf0a15d7fbdaca010fd
-- 
2.38.0.rc2.412.g84df46c1b4-goog

