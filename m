Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B7F6757A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjATOpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjATOpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:45:02 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1832BCFD26;
        Fri, 20 Jan 2023 06:44:38 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id q130so2537422iod.4;
        Fri, 20 Jan 2023 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDCYG8WxS/pUjt/n8MvGqQ4mEBFsqI4uxAOlI7paeNc=;
        b=ZKv2kJnbHZoYZy1tJyO4tdeh91R61byMjNI2lb14x8KJae1X5W0y4SjIBSNS1kHRdb
         oigCmrD81gGVVGUbcrqhcIFKQz6nDsSr5DazytIj3JGvflF/m2P6KyFYPTlTVvVuTxKF
         +CCZvCHJ20T0wdFaUFkadoTZO92RW8K6iiqfnrrGwPtJz5XlVdOVELQkcnQwSlf8vekW
         jLCkuE7eZFleOD4LEysRktAkKxR/OUdQDMYlodZFOEgM2s3cv73ohw2KPUYkZVt3G/ct
         2WD1tWGgvuTcdRDQ8D6tW9faTAs/szW+tedVcUEXKO15Ibc57FL/ptN/1uFkGrw3wXIz
         pqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDCYG8WxS/pUjt/n8MvGqQ4mEBFsqI4uxAOlI7paeNc=;
        b=a1hcwUn/ThxYlF+tuzUb2bA5ERssRJcEX+0n+IZZ8iYCf67WCeSePo4CAoBrmyc6vS
         ymY8EUbAz6Ur6ZhtUd/PGeEfDJYriVKDPkzBUr0IhZ0vmi3h8cW3FBaN1lS2hbiFzyN3
         4P8NuKgJD7LOM0lArSelE1kkS8L9dfkSls6uxrB70/fpWdcFhBRKlN2CbPtXtPKxq75G
         Hfn4QyEDJbRrY3b0Y3hXfasHCTFXHPetS+7Hq2x/knELXQJO2fhCw8Pd1LneR6k/E34B
         JPD52OpBXb04X6b4/sGJyrr78MTbeTqqZzIIP+sk6fHZNQuJXFRs1KNyg1HFbzjkcaBi
         JXEA==
X-Gm-Message-State: AFqh2koFdht3Qx1OpBMLifFfRDlOkhQjvw3xqWI5cdw8Q+CWxBIZbRZT
        knKbX+9ea2jTv7fSyZFCFb3TpTVunD68
X-Google-Smtp-Source: AMrXdXuMycxFXCNiEYKeHDhmhI7Qlr14maanOHP2VLUa80rQsKw4EVW4q2yPZ6+LLLQfFL6ThMcBsA==
X-Received: by 2002:a5d:8348:0:b0:6e3:c112:3339 with SMTP id q8-20020a5d8348000000b006e3c1123339mr9578231ior.16.1674225846816;
        Fri, 20 Jan 2023 06:44:06 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id p185-20020a0229c2000000b003a7c47efde0sm1513852jap.11.2023.01.20.06.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 06:44:06 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 0/3] Checkpoint Support for Syscall User Dispatch
Date:   Fri, 20 Jan 2023 09:43:53 -0500
Message-Id: <20230120144356.40717-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
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

v3: Kernel test robot static function fix
    Whitespace nitpicks

v2: Implements the getter/setter interface in ptrace rather than prctl

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

  This was done in ptrace because syscall user dispatch is not part of
  uapi. The syscall_user_dispatch_config structure was added to the
  ptrace exports.


Gregory Price (3):
  ptrace,syscall_user_dispatch: Implement Syscall User Dispatch
    Suspension
  fs/proc/array: Add Syscall User Dispatch to proc status
  ptrace,syscall_user_dispatch: add a getter/setter for sud
    configuration

 .../admin-guide/syscall-user-dispatch.rst     |  5 +-
 fs/proc/array.c                               |  8 +++
 include/linux/ptrace.h                        |  2 +
 include/linux/syscall_user_dispatch.h         | 19 +++++++
 include/uapi/linux/ptrace.h                   | 16 +++++-
 kernel/entry/syscall_user_dispatch.c          | 54 +++++++++++++++++++
 kernel/ptrace.c                               | 13 +++++
 7 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.39.0

