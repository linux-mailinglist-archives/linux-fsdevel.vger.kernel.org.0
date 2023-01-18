Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F473672907
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 21:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjARULG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 15:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjARULE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:11:04 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4323FF21;
        Wed, 18 Jan 2023 12:11:02 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id m15so108028ilq.2;
        Wed, 18 Jan 2023 12:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqkT+QmK2KIssOkkk5DoPD7psYtC/238Mb5aHhbynNg=;
        b=lO44+T/q5sHH1uw6NEy2aoDcR+DLa/Gleze2rSa1HbU0RF/lw8xi2WuFdvkB7pORWo
         pCbbW656aKlq/Obfc0HBReXK3OQmbeB+qzhSwAhhoW07ptWce+VyzbC9pHOO+/S9i92z
         375DxO/oPxKGbx9xHaKmVlfLw6tDuqOHmmXLlUe2U7utN5TfPsAAQOQ1YzwJYVib7o/n
         DDMLwFvwKKcDxuJShZcCp8mKGiIMAItf0vitJxUBp1zN0YbPbAEd9jn4xIMVOTuHt2jc
         Fom+Tw0aBHegRLc2ZUtescJ/8S3RgdjQEzG9LeymC97ia48Yzx9fuEj2NJ5xgT07hJk6
         oPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqkT+QmK2KIssOkkk5DoPD7psYtC/238Mb5aHhbynNg=;
        b=fJ/c9v0bXCltLe02LGg10o+iFmODThorWAIqhCYP2pABc+BeEWfbHUeybSHxZ+lHdB
         sImWku6laTWvbxdzrUkHSWC3SP3LCjmjxAcbSnv1G8nv2w61ZKBLx2s7BvT01nUzcRdO
         tM9B6PU0htRI3yBwdzH3ejurotxMAFPCGzHkfXKXhJn7axDMM31K5bcWv/VeCYvg9D5I
         EJUMxZh6FOmORk9NifaYBc/v8nQ3lgzYHD8fLClufFY90Was5daqy4cZr3aslaGtVApv
         Wd2ZPQSxGc2epjf6Z6Qo4oVBhdzUUQqBUebPQgoeIQkD5cZuf//hKyphjmYKigNk2LrA
         K6TQ==
X-Gm-Message-State: AFqh2ko8i2h3CD1A+gVE9uUC8lyztCjKlV/PmTofI6VH1ex0/H2ch9oB
        x9vOvbUBMhrOTIardfsqwxMiln+Q7bD/
X-Google-Smtp-Source: AMrXdXvcZyxRhVCL6sfQO5Ha4QFxz4VASfPYIbsOHFDFRU0JOs30GwVbI/nN5IJqaTvvDMXjOFEgMg==
X-Received: by 2002:a92:ce92:0:b0:30d:934c:f71e with SMTP id r18-20020a92ce92000000b0030d934cf71emr6426762ilo.0.1674072661811;
        Wed, 18 Jan 2023 12:11:01 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id i5-20020a92c945000000b0030bfbc121a1sm10299998ilq.79.2023.01.18.12.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:11:01 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v2 0/3] Checkpoint Support for Syscall User Dispatch
Date:   Wed, 18 Jan 2023 15:10:52 -0500
Message-Id: <20230118201055.147228-1-gregory.price@memverge.com>
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
  uapi.  The syscall_user_dispatch_config structure was added to the
  ptrace exports.


Signed-off-by: Gregory Price <gregory.price@memverge.com>

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
 kernel/ptrace.c                               | 14 +++++
 7 files changed, 116 insertions(+), 2 deletions(-)

-- 
2.39.0

