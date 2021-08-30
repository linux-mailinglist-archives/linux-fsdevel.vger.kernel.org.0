Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BBF3FB8A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhH3PB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbhH3PBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:01:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F78C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 08:00:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m11so11917188ioo.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uaK2+hT9Cr9iBiV8An6P07bSAyLYfCn6s0omnwnea1o=;
        b=NVkiXYagNesao6pfsU1zzyuQ8XlRLlZO2YIjrn0aqu2uBvpO721KUnhMfbEfPJ7sbt
         dr9yC/do146cPEeTEz3Xq6Lk7qFzBAdV5OAWDzigWwGnt5bdVWefQdml470WG+i+grmX
         Kz4svxPTTyFR64/14qyiypHnFtq6wK/9NZGB5rGRDJQI3d8Cn714HmFQ8yRRv1bOmTpf
         WtRXBK8iMfJPgm02CtFw2O+shPOHle3HPdnZjukHz8vql/2E8wB96yKSx+w0o5lfi6+s
         TmjoUb59X0oxGYIIU49G+tjefSnj0f7r9imIyFrI5GMlAeuqNYeVK2YcRG1kkJhvTBLS
         /jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uaK2+hT9Cr9iBiV8An6P07bSAyLYfCn6s0omnwnea1o=;
        b=U09SqwAguuTVtgPA03ayskVnumlOkxGOZ7RKxsc2IQFaQVrMlAZ58IcTT+R7qnYPL+
         VNCQsQ/jUExUVa+W3/czw6MGEwhfFpzBdZpeXQ4tWR9zrqJHLSk4Kae5ZNxMKJyAuu+z
         SAlOQkVtAoHlqC0SIo9+la3X2Nx0i8mS6WvP/br3zi7NV5HEwhkMy+k8f4cqfDunj44+
         KDMk+GQseX3NbjD4YSGJ51T/zXMEXiuRDw+V1iEoWdKc8JNcrqpV0fupgJhMM+j+74P+
         k7FRLtPy1WxSlqhuacdQz7Kug42lTmnxQvO0a6ataE11+MdBiM1bmgFiTq4ECBvt5vIR
         S4Gg==
X-Gm-Message-State: AOAM5338KPvidQyLpP8FHuWXu5GL3U5grW/0ufY39Emzih0n9jm+Q11r
        CtFXFRYTnpODTyvEXZXr0wSFlJznOkoTDg==
X-Google-Smtp-Source: ABdhPJyqkzUMO3MKRMYNjICP0Qbh9LCT3pqQ6GujIiIWRk0sqZeNtawuaKK5HYTCi9dXAzd5sHnADg==
X-Received: by 2002:a02:6a55:: with SMTP id m21mr21156804jaf.74.1630335627929;
        Mon, 30 Aug 2021 08:00:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a1sm9205960ila.40.2021.08.30.08.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:00:27 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Dmitry Kadashev <dkadashev@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring mkdirat/symlinkat/linkat support
Message-ID: <13fee4ce-eb96-2297-8a68-ff33f76684c8@kernel.dk>
Date:   Mon, 30 Aug 2021 09:00:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On top of the 5.15 io_uring core branch, this pull request adds io_uring
support for mkdirat, symlinkat, and linkat.

Please pull!


The following changes since commit 26578cda3db983b17cabe4e577af26306beb9987:

  io_uring: add ->splice_fd_in checks (2021-08-23 13:13:00 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.15/io_uring-vfs-2021-08-30

for you to fetch changes up to cf30da90bc3a26911d369f199411f38b701394de:

  io_uring: add support for IORING_OP_LINKAT (2021-08-23 13:48:52 -0600)

----------------------------------------------------------------
for-5.15/io_uring-vfs-2021-08-30

----------------------------------------------------------------
Dmitry Kadashev (11):
      namei: ignore ERR/NULL names in putname()
      namei: change filename_parentat() calling conventions
      namei: make do_mkdirat() take struct filename
      namei: make do_mknodat() take struct filename
      namei: make do_symlinkat() take struct filename
      namei: add getname_uflags()
      namei: make do_linkat() take struct filename
      namei: update do_*() helpers to return ints
      io_uring: add support for IORING_OP_MKDIRAT
      io_uring: add support for IORING_OP_SYMLINKAT
      io_uring: add support for IORING_OP_LINKAT

 fs/exec.c                     |   8 +-
 fs/internal.h                 |   8 +-
 fs/io_uring.c                 | 198 ++++++++++++++++++++++++++++++++++
 fs/namei.c                    | 239 ++++++++++++++++++++++++------------------
 include/linux/fs.h            |   1 +
 include/uapi/linux/io_uring.h |   4 +
 6 files changed, 348 insertions(+), 110 deletions(-)

-- 
Jens Axboe

