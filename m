Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3D677450
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 04:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjAWD3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 22:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWD3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 22:29:47 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5B1448C;
        Sun, 22 Jan 2023 19:29:46 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id fd15so8792312qtb.9;
        Sun, 22 Jan 2023 19:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEkC9pUr+UCV2Cz2pZIS9YUG59kfzZzD0JR8q3g/PeY=;
        b=B3NVlRrGcw4YdHWkZ6EEItGqaDMGRX+yV1MSy6UZmQG3jBAlTfftSFQ4RpiDrSQDf1
         jv9myVbWGZFXXgIRkB2DG4fiDGJAYI9y7/+KKhlKE2SgnzYXRi25p83tCOtR3rmcAsRq
         QaINTMh9jhwJVaDOl2WGvF5DSZRdgI06T44a3sNVMe5oDB83gLH54DtDMSu+wQtj9kVp
         fsdIXfNJBLAtYTM3vfEjxnpovMji69TYSORKs9fDuFB4dEARs5263JnvUL5Cj27UzVOu
         i+JbRN2+3fdkIirCvdtWN+E/spIhz0KFh7rJu3sfmVGAt7UtIbvWgPpgI/u6O+UXch5j
         ycDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEkC9pUr+UCV2Cz2pZIS9YUG59kfzZzD0JR8q3g/PeY=;
        b=7HaS+Bz1MgHV2Hywceg3bIdl/r+6VkrzO8ja2e3azjwiJIQxh0YZ2HUXW3EXa5Je1r
         ycJuvuRxWZThwfC4MKztCbi2E+5CMr8J7zr8/iUwepnLGQ33BOjRXJKFeNigLzdSx4HA
         IkkOvSLFYMCjLhcIohS825QYl/xhePEjgfFtlU20JKMTE2uIyzBLECVYYa0ygXgYeUc9
         2WyISjIRVbwICpjZh0Rs3/AduAq5TEBU//zE7I62WUG71tuodA+GRxHp4SpgEyHDGMgm
         H1hZNQxVuO28fTbzpsnB7f2O1edF0ulFFeRIwPHZHf7xYhygQTGtefpnxFJBxRTAEehp
         BKPg==
X-Gm-Message-State: AFqh2kqD+n4mBS3tqg778tumkVU93o4DpzcHEsUb3IMicT+r7w8uVB3/
        UKpVH0Szn5SuJ7M3Vcp6SYtTN+fVt1fn
X-Google-Smtp-Source: AMrXdXvw882JiP/yU35jd2navQhWjO5M0L15eWb3kqKgPgqmFLmRd5kduEz+Ktvu/N4D7+lrLjeg4Q==
X-Received: by 2002:a05:622a:4a83:b0:3b6:3931:640d with SMTP id fw3-20020a05622a4a8300b003b63931640dmr34813029qtb.48.1674444584937;
        Sun, 22 Jan 2023 19:29:44 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id u3-20020ae9c003000000b0070928ee3933sm4875492qkk.75.2023.01.22.19.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 19:29:44 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v5 0/3] Checkpoint Support for Syscall User Dispatch
Date:   Sun, 22 Jan 2023 22:29:39 -0500
Message-Id: <20230123032942.18263-1-gregory.price@memverge.com>
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

v5: automated test for !defined(GENERIC_ENTRY) failed, fix fs/proc
    use ifdef for GENERIC_ENTRY || TIF_SYSCALL_USER_DISPATCH
    note: syscall user dispatch is not presently supported for
          non-generic entry, but could be implemented. question is
          whether the TIF_ define should be carved out now or then

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
 fs/proc/array.c                               | 10 ++++
 include/linux/ptrace.h                        |  2 +
 include/linux/syscall_user_dispatch.h         | 19 +++++++
 include/uapi/linux/ptrace.h                   | 16 +++++-
 kernel/entry/syscall_user_dispatch.c          | 51 +++++++++++++++++++
 kernel/ptrace.c                               | 13 +++++
 7 files changed, 114 insertions(+), 2 deletions(-)

-- 
2.39.0

