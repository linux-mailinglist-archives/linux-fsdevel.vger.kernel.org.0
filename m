Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C22748C36F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 12:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352952AbiALLpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 06:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiALLpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:45:49 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14187C06173F
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 03:45:49 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e198so5540635ybf.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1oAWQHZqJjxGspd66xUUwdpCocjq4RF4bRYfPMa0RgM=;
        b=LCxuNDTBSrsTxNHCIoEpEJhzykzI1PqU0Qu7+y1h/2eirkEaNcUWcRKGGAWaV79ru6
         Xv6at+0+iUtpOEe63PUlXlbArXuMTPWdZ+/I9QGm1/Tn/3qseWRDveOL4FnagSPN1A/T
         WQA5lRrrNPqlTtbO2930mHMbqr0IbKawgZZJX2ACEHAPmOPO0eKb5zSkXu2527bDe22H
         qZSNnQTvKG1BZvNckxJgIPiclQ2QGrvZHaHYpAF4Yj1u61rLGVSA/EQd1E9Vbu/Wv0mM
         76FeBD8ggDrgJZACy1k8ttE1LmolWjhAvrPauqbZAqe0sJtrtel+dc7OKUTio8KPUJJT
         BrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1oAWQHZqJjxGspd66xUUwdpCocjq4RF4bRYfPMa0RgM=;
        b=PzTPMcSsajBeWzUmPbEZEmFpA6ZHWHbqJOU6cE0nHYsFdq7tXk29fqIc5iTbmLHQHQ
         PYJ8t0ifDwCWbWRNXY3DukSrnzaZmXXlREevzeBD6rTb52BuCF12gCw/ed0bBfwB5Vxq
         V9DOZ0JinqdlfQ1fUpnrxKiMr2IqTOZj6XLw24eI9RF7pPDksJxdfKCugGMKsqICQTVA
         4swLfLd/IgGAfNRinSSKPEAF7ap2P8SlnawyUHv44Y4Rxf3nBfZfpyN32CVVCy7nZtAo
         9pHuLD213F+SkRKGlJRpJTe0KbQu/MN4ht8rOVbATwRCrDnCB7wTOsgHOZapD/bxjpLg
         Rhlg==
X-Gm-Message-State: AOAM533qpJa90iG0tZ7cAzF0LgVmD5G8d5Gxa7i6UJmBJ+so2OOqZehi
        2+wqXlO2e71KGgQ/bwZKfkRaj8q1+GZ3yaOgHSQ8pQ==
X-Google-Smtp-Source: ABdhPJy833HxrFP8l/AcVNmiqInufp1tn6sOo1ri3JhrVF4Lbfk3FqLKPmb8gT8eZ0+nFbb7F4rgAXM2QRTArxbTsF4=
X-Received: by 2002:a5b:d09:: with SMTP id y9mr7287068ybp.146.1641987948106;
 Wed, 12 Jan 2022 03:45:48 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Jan 2022 17:15:37 +0530
Message-ID: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
Subject: [next]: LTP: getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed:
 ENOSPC (28)
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Cc:     Alexey Gladkov <legion@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
on x86_64, i386, arm and arm64 the following tests failed.

tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
getxattr05.c:87: TPASS: Got same data when acquiring the value of
system.posix_acl_access twice
getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
tst_test.c:391: TBROK: Invalid child (13545) exit value 1

fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
tst_test.c:391: TBROK: Invalid child (14739) exit value 1

sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)

setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)

strace output:
--------------
[pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
[pid   481] clone(child_stack=NULL,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x7f3af0fa7a10) = 483
strace: Process 483 attached
[pid   481] wait4(-1,  <unfinished ...>
[pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git commit: 57c149e506d5bec1b845ad1a8a631063fcac1f6e
  git describe: next-20220110
  arch: x86
  toolchain: gcc-11

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

GOOD: next-20220107
 BAD:    next-20220110

Test logs:
https://lkft.validation.linaro.org/scheduler/job/4301888#L1474
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220110/testrun/7253656/suite/ltp-syscalls-tests/test/getxattr05/log

compare test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220112/testrun/7277164/suite/ltp-syscalls-tests/test/getxattr05/history/

kernel-config:
https://builds.tuxbuild.com/23V6AwGvHW7H3kr6WxZZwueajVS/config

We are investigating this regression.

Steps to reproduce:
   # cd /opt/ltp
   # ./runltp -s getxattr05

--
Linaro LKFT
https://lkft.linaro.org
