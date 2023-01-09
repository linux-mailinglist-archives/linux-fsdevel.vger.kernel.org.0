Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDB6662A26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjAIPhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjAIPh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:37:29 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6765A89F;
        Mon,  9 Jan 2023 07:34:09 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id jr10so834838qtb.7;
        Mon, 09 Jan 2023 07:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTNeUY66tN+zyofN7fRlx1+ck2Dw3R2YOLRb1Ot7opA=;
        b=J0ETlLTMA8IqRMNOesdrhvGZG4m13eB7ad1UWiNXTYnIqtC8U67j+aSIMJ7nSHyEus
         U3H6phAaxiJbPRhWFLi1pAqXwQ5RQ1Ob7GZXj/valtT3WlrgUHlno/9zPS8x+AnhpVRO
         kftOQ0zqBmQLZQop3lTM4QUrFPTbqgzfi1rOSWj7wVZR8V7e7GJyifFkMMSyG0oS6mBt
         yZxEVq69I47ZDnSLr5LFS3p2l2mUR/gIGiZWzqDoZ6MRB1w//7Hgl0n5ZJMDGEWHFbnt
         qzcRIcFn7sLdr81HTzIcALoPYjj+aOSFEuN24zI2aBeIHunFkwvNkKdhesJOfsxVM3nJ
         70aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTNeUY66tN+zyofN7fRlx1+ck2Dw3R2YOLRb1Ot7opA=;
        b=LtbI60WxLVI8RcxZryziK9r+FEVyzZ58RBlsuysQwAJRQu8BVqpAAkUV4NHJEQvsQs
         /F7sSEoK20oA+4jCrqtTIbYWS5FcpBPh1cAmMJKbEptLyrufydsiGho8fiG+8iZwKU9l
         WEJpP5IrqQ1y2BZSo4WkBPT9V5PaqkMYhPfeSogUvkWEWC1KANEsHwlIHAKos2kuWm9Y
         J6CZyLhZWt1/V83YkHe4Y4uybkmHsmn0Z4aIQXWG5tRyZFWXQttZ7b1GtqXEHWUdqfDm
         TH6aq19ubOEs+9mY1wLhIRLj8JvJ7VvwgoDHVG7eu24rrifosFLWZ6QRU38QihFo8d3u
         2CIA==
X-Gm-Message-State: AFqh2koT5Ns+3Fkw73BQZXUmyZvNHf/ZTgKxVeAqSXV0dBwinf8wVtfJ
        P4R/ttVU4EObzCO87ykVUnpqUe+hQQ==
X-Google-Smtp-Source: AMrXdXtW46Cl4kgoaQXCPzWzmVXplEzb9LQPfR84ldIiX25KrAXI5QqGUghpW1JY3OSnjyWSbwBEjQ==
X-Received: by 2002:a05:622a:1f13:b0:3a5:3234:cc7b with SMTP id ca19-20020a05622a1f1300b003a53234cc7bmr93726426qtb.65.1673278441996;
        Mon, 09 Jan 2023 07:34:01 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id f1-20020ac81341000000b003a6a19ee4f0sm4687236qtj.33.2023.01.09.07.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:34:00 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 0/3] Checkpoint Support for Syscall User Dispatch
Date:   Mon,  9 Jan 2023 10:33:45 -0500
Message-Id: <20230109153348.5625-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Syscall user dispatch makes it possible to cleanly intercept system
calls from user-land.  However, most transparent checkpoint software
presently leverages some combination of ptrace and system call
injection to place software in a ready-to-checkpoint state.

If Syscall User Dispatch is enabled at the time of being quiesced,
injected system calls will subsequently be interposed upon and
dispatched to the task's signal handler.

This patch set implements 3 features to enable software such as CRIU
to cleanly interpose upon software leveraging syscall user dispatch.

- Implement PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH, akin to a similar
  feature for SECCOMP.  This allows a ptracer to temporarily disable
  syscall user dispatch, making syscall injection possible.

- Implement an fs/proc extension that reports whether Syscall User
  Dispatch is being used in proc/status.  A similar value is present
  for SECCOMP, and is used to determine whether special logic is
  needed during checkpoint/resume.

- Implement a getter interface for Syscall User Dispatch config info.
  To resume successfully, the checkpoint/resume software has to
  save and restore this information.  Presently this configuration
  is write-only, with no way for C/R software to save it.


Signed-off-by: Gregory Price <gregory.price@memverge.com>  


Gregory Price (3):
  ptrace,syscall_user_dispatch: Implement Syscall User Dispatch
    Suspension
  fs/proc/array: Add Syscall User Dispatch to proc status
  prctl,syscall_user_dispatch: add a getter for configuration info

 .../admin-guide/syscall-user-dispatch.rst     | 18 +++++++
 fs/proc/array.c                               |  8 +++
 include/linux/ptrace.h                        |  2 +
 include/linux/syscall_user_dispatch.h         |  7 +++
 include/uapi/linux/prctl.h                    |  3 ++
 include/uapi/linux/ptrace.h                   |  6 ++-
 kernel/entry/syscall_user_dispatch.c          | 19 +++++++
 kernel/ptrace.c                               |  5 ++
 kernel/sys.c                                  |  4 ++
 .../syscall_user_dispatch/sud_test.c          | 54 +++++++++++++++++++
 10 files changed, 125 insertions(+), 1 deletion(-)


-- 
2.37.3

