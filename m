Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD71054C5F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 12:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347515AbiFOKWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 06:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244130AbiFOKWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:22:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994349F12;
        Wed, 15 Jun 2022 03:21:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so22214541ejj.10;
        Wed, 15 Jun 2022 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ht5yNJv6U/VAL82aX6i5nQDIRsBdgWpM9aDfCPLHOJc=;
        b=aHOydtVyEBWVd0DRrbNy5j5N5WGuuowKT9sw4hEBJ6TZItYU5k6sA4MlZXrtRvYeAg
         XISZ8sfOJaaSbM+n74oZ7e9+3yw23r2pPbIr5lR2bP87N2rSoDMV/pEjtXWqLGFZRuVE
         /D6Eq0e6e43r6vq56RwXwL1alkxk2fjzVw60uZRKFOfILAgja+Ci/AkvFrDG5T4r0GMB
         D66v263NUoGpWEmgwuSt2a/hPVPdYBvGFUmj9kZtztDkEtS09Zzg99jbkgr4LyQ03NmR
         GGf7OyBFh4iy2GygxhM1tiXUqWDzLJOyY3T6Ct0dujnFaMHHgof3ogGi4Ssya/0gIad9
         UVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ht5yNJv6U/VAL82aX6i5nQDIRsBdgWpM9aDfCPLHOJc=;
        b=NeA7wIMlr7YWgt1GZn210IMU72XjM+qBF/FW2tqgGiPchQXBi6zdC1pFGtFxI77KHE
         D1JC85Ry9lJR83YSKV+/m0bg5WRo0k8rcSXTYa+RnB59Csm6Y7xweMhrJeLobGciDo/T
         JBtrx/DgooTXOycgtVkxQllQenNahEqJSmdspGVtjPYqnwRafhFz6pUhPXrBC/DBydNs
         Y32ldMfI4s8KP104eX6O3y0jyhSzxKiUM3JTsQsNr0t+cKqIco6Wc2z6pxh3R3ql5w++
         AurWgwweAjypqShVCzVKHah47b4MsoSLkGbKXGLTyYGBFMX/5CjJ938qa2wh0pzX/aa3
         gmRQ==
X-Gm-Message-State: AJIora+pHiiL8lIXrurTT+iRytWDLhyttfroi5m6BUkwbz9Egj/I7o/w
        SdI2MusoW6AqBfZrcNfr8Q1qzrl59Tao068Wwf0=
X-Google-Smtp-Source: ABdhPJwA0YhVpMtFFLsm5nOXKfp12AEPXdYN/grs2h9+q/PZbwjRdUwlAdKtIvQXKw6771NyM4E7VhAj/uqpfTbYbQA=
X-Received: by 2002:a17:906:739d:b0:713:c3f4:6ef with SMTP id
 f29-20020a170906739d00b00713c3f406efmr8110222ejl.180.1655288457343; Wed, 15
 Jun 2022 03:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220615081212.GF36441@xsang-OptiPlex-9020>
In-Reply-To: <20220615081212.GF36441@xsang-OptiPlex-9020>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jun 2022 13:20:44 +0300
Message-ID: <CAOQ4uxgHPgFTWBOF34=UDtaCOk0EA6f=66szS-Ox62YNPx1b=A@mail.gmail.com>
Subject: Re: [vfs] 0b398f980a: ltp.copy_file_range01.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:12 AM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 0b398f980a75ee5e5d7317a9d0e5860e4c79e9b8 ("vfs: fix copy_file_range() regression in cross-fs copies")
> https://github.com/amir73il/linux copy-file-range-fixes
>
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20220614
> with following parameters:
>
>         disk: 1HDD
>         fs: ext4
>         test: syscalls-03
>         ucode: 0xec
>
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
>
>
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> <<<test_start>>>
> tag=copy_file_range01 stime=1655248189
> cmdline="copy_file_range01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1526: TINFO: Timeout per run is 0h 02m 30s
> tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
> tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports ext3
> tst_supported_fs_types.c:51: TINFO: mkfs.ext3 does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports ext4
> tst_supported_fs_types.c:51: TINFO: mkfs.ext4 does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports xfs
> tst_supported_fs_types.c:51: TINFO: mkfs.xfs does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports btrfs
> tst_supported_fs_types.c:51: TINFO: mkfs.btrfs does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports vfat
> tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
> tst_supported_fs_types.c:115: TINFO: Filesystem exfat is not supported
> tst_supported_fs_types.c:119: TINFO: FUSE does support ntfs
> tst_supported_fs_types.c:51: TINFO: mkfs.ntfs does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports tmpfs
> tst_supported_fs_types.c:38: TINFO: mkfs is not needed for tmpfs
> tst_test.c:1599: TINFO: Testing on ext2
> tst_test.c:1064: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.46.2 (28-Feb-2021)
> copy_file_range.h:36: TINFO: Testing libc copy_file_range()
> copy_file_range01.c:133: TFAIL: copy_file_range() failed: EOPNOTSUPP (95)
> copy_file_range01.c:133: TFAIL: copy_file_range() failed: EOPNOTSUPP (95)
>
> ...
>
> copy_file_range01.c:133: TFAIL: copy_file_range() failed: EOPNOTSUPP (95)
> copy_file_range01.c:133: TFAIL: copy_file_range() failed: EOPNOTSUPP (95)
> copy_file_range01.c:210: TFAIL: non cross-device copy_file_range failed 144 of 144 copy jobs.


First of all, good catch! and thanks for testing my github branches :)
I should not have changed the behavior for non cross-device copy.

Second, the history of cross-device copy is hazy - old kernels do not support
it then v5.3 does support it and now we want to un-support it again,
so it's nice
to see that the work that Petr did on this test to work correctly by first
testing verify_cross_fs_copy_support() works as expected and the test passes
with my fixed patch.

Will post v15 soon...

Thanks,
Amir.
