Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BBB6765A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 11:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjAUKXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 05:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjAUKXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:23:21 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27EF126C6;
        Sat, 21 Jan 2023 02:23:20 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id q10so5530326qvt.10;
        Sat, 21 Jan 2023 02:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8FmfdWI90uZoPNQFlYSgQIxJfDHEIRg7upexyICW6Y=;
        b=b2J1MH+UBi7wbqbpH/1wus3KKA1QGeEQlX7tJTxlW77qGrQevXQ9ta0HJkl2Ibqqqr
         So4MKCKB/+euIXEFO8vNgCv3tIn7hQ9saSyKjfk7+4l/JKiZl9fsr/q7ta7gKZ8mrnJt
         4uatllenZ9U2qrCSIBzPMZP+opMOXQgMm16W7uHKEl1ncCfN3KGr7sxkhunfLZ2Vv3eG
         0L9HNeQhX77jXX+vtkoSvZhpwQwdkIqgglxgu/JcptYe+cLVGT/xJvNCyUb6W1SSf5un
         140JHEP1l8OiGroWUwEg1WafdoxDQLglOIaS8K40zTCmB6tTbsgQKED2tiFaGvGPWEph
         U0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8FmfdWI90uZoPNQFlYSgQIxJfDHEIRg7upexyICW6Y=;
        b=ADOgLOdlAWh6Zl3W6TQEQUYIkY4Or52joco76MUHeSgXckH2DDq5naLTBCqOR6eSX1
         o7yG+Omogy2lYwu+FeByM7/U1iCKeaq9dSMY9a8S/1z5V6pu7RAC3D0iwMbX+NkPGru4
         uaYaJVfPHz1XVrQFNt4Y1c/jqjSein/WjvhwL6Jc7KfgMrENo9aPy2sXmRIykSL8peAy
         +ivT2catlHAFVdcpFhhdRCHIWqrUU3qoUlJChitwz1JuiF2+6/cMzEBvVFPt5FrvLKG2
         Uaeukfh6spUzgmtZVR98UFA62Npfl8iGHUnND2wJ9jAxQo24eNfP6ot6TNoEUGHQFvW6
         GzIw==
X-Gm-Message-State: AFqh2kqeZXVW741os8vaqawVROAS2vv1Y9YkBzPnYoj3b0UydDtFnTB1
        HRFY/0plA/iF0e7kxB0hkxCP1Ms2Z8jR
X-Google-Smtp-Source: AMrXdXuwkwQM1IKoMRFA/vTNcbT/5ht35IiIsol+boIgF16aC7ZfY0WAbu/Tjlr6RPdNO+qdxkUAEw==
X-Received: by 2002:a0c:f84e:0:b0:535:64bb:fea0 with SMTP id g14-20020a0cf84e000000b0053564bbfea0mr7313731qvo.44.1674296599776;
        Sat, 21 Jan 2023 02:23:19 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a44c200b006e42a8e9f9bsm14128630qkp.121.2023.01.21.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 02:23:19 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v4 0/3] Checkpoint Support for Syscall User Dispatch
Date:   Sat, 21 Jan 2023 05:23:13 -0500
Message-Id: <20230121102316.331935-1-gregory.price@memverge.com>
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

v4: Whitespace
    s/CHECKPOINT_RESTART/CHECKPOINT_RESUME
    check test_syscall_work(SYSCALL_USER_DISPATCH) to determine if it's
    turned on or not in fs/proc/array and getter interface

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
 kernel/entry/syscall_user_dispatch.c          | 51 +++++++++++++++++++
 kernel/ptrace.c                               | 13 +++++
 7 files changed, 112 insertions(+), 2 deletions(-)

-- 
2.39.0

