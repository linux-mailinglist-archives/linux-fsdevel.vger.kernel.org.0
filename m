Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9949C3B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 07:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiAZGdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 01:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiAZGde (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:33:34 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40200C06161C;
        Tue, 25 Jan 2022 22:33:34 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c6so68473871ybk.3;
        Tue, 25 Jan 2022 22:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChJmRDJEm5pXcjV3RhCmm6g5TfXTFkO1Rcc6sHnIoj4=;
        b=GhWYMsUW3Qbr9HHuE1hilXCPJIChi71Nm2odYfcUOh34TGObPJ6KOcMJ+S/hQuxHV5
         F+W+7Msf0GoOhpLBKO05zSE8oWLEp3XTqstMnSDTh7ucRYF+L1RJw58oS5Gby58MOtUC
         LssQfspxrjVVfjjBD5VDWKj7ajonyXUMjFEvFojFx1ET3d3yo6SmYlpibRrbhmc7vYsx
         U0uhAruxNq+sOCzJo6bqt6YqZvyK8ZtKm/m7cvPM6YQIqXgf9emV8BAVuU9E1tiP4ez5
         ILuGa68x6JrWOh8QCeDL2ZNdtxqOD0w4kWaT2xtK7MJ4l2Uv8UT+Fbn8eq9ks8PZMgdy
         AwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChJmRDJEm5pXcjV3RhCmm6g5TfXTFkO1Rcc6sHnIoj4=;
        b=CN+oIciFpwJrtkKfftFfuzZM500ik0F8tdKMmm0JzhOKDEw48HSB7iTBkkgvCO4D3Y
         nKH4RUI1CkgoktnEnKVKGX3HmZPS/z1GCSEBPXh88piVmJsNA4kBlpFe2ZBjY717twjR
         wKVIHvz5IYdyOJrgLcZ0hbNLaye7mw8nyz6dXLVIM/1CJDomOFpVPnikMJb4+QN+T9Am
         8PcRSLf2UbmfqyRTgkuiwTcBNgVvAU0NPOJjWhLhQPwsMChVBAbF/SQGFAfsJ4I8mFn9
         rKyXpNkjUDZae8UJ0crHl7X56Xnf/3rBjI4sdDT6Khks64c79tyUwWJ4XZy0HDf6ypqt
         PThw==
X-Gm-Message-State: AOAM530BqqBsM+ZtXVAGCdad0pC7SnvV4Ui1JguouPhfcNxdY/ebVDfd
        bPQWaYyQnLfAEJqOM88Cne4mDElvzn2Ycc+C0A0=
X-Google-Smtp-Source: ABdhPJyVOElZioeXwIvY64lBpQdHS4C6bPEoMaUFuCbrg+JVWJA/pH6s/0VZ7VCo2DXoBCw92rWh/r2oABcZTMP35VE=
X-Received: by 2002:a05:6902:1107:: with SMTP id o7mr30485838ybu.270.1643178813246;
 Tue, 25 Jan 2022 22:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20220124003342.1457437-1-ztong0001@gmail.com> <202201241937.i9KSsyAj-lkp@intel.com>
 <20220124151611.30db4381d910c853fc0c9728@linux-foundation.org>
 <CADJHv_vh03bhn1FX2-jc6JoH3Hm6cRiWs+iXFO-coGy_yUY1Mw@mail.gmail.com> <CAA5qM4Btrnp9Te2pm0s=OuDk0ASTE3-LyLt8nf0fXKxhehXUgA@mail.gmail.com>
In-Reply-To: <CAA5qM4Btrnp9Te2pm0s=OuDk0ASTE3-LyLt8nf0fXKxhehXUgA@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 25 Jan 2022 22:33:22 -0800
Message-ID: <CAA5qM4DdvMNeG-PndWR9vb_jXTZ3v9aBXpW9QjV66DQFny65Wg@mail.gmail.com>
Subject: Re: [PATCH v1] binfmt_misc: fix crash when load/unload module
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:23 PM Tong Zhang <ztong0001@gmail.com> wrote:
>
> On Tue, Jan 25, 2022 at 9:04 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> >
> > Still panic with this patch on Linux-next tree:
> >
> > [ 1128.275515] LTP: starting binfmt_misc02 (binfmt_misc02.sh)
> > [ 1128.303975] CPU: 1 PID: 107182 Comm: modprobe Kdump: loaded
> > Tainted: G        W         5.17.0-rc1-next-20220125+ #1
> > [ 1128.305264] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> > [ 1128.305992] Call Trace:
> > [ 1128.306376]  <TASK>
> > [ 1128.306682]  dump_stack_lvl+0x34/0x44
> > [ 1128.307211]  __register_sysctl_table+0x2c7/0x4a0
> > [ 1128.307846]  ? load_module+0xb37/0xbb0
> > [ 1128.308339]  ? 0xffffffffc01b6000
> > [ 1128.308762]  init_misc_binfmt+0x32/0x1000 [binfmt_misc]
> > [ 1128.309402]  do_one_initcall+0x44/0x200
> > [ 1128.309937]  ? kmem_cache_alloc_trace+0x163/0x2c0
> > [ 1128.310535]  do_init_module+0x5c/0x260
> > [ 1128.311045]  __do_sys_finit_module+0xb4/0x120
> > [ 1128.311603]  do_syscall_64+0x3b/0x90
> > [ 1128.312088]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [ 1128.312755] RIP: 0033:0x7f929ab85fbd
> >
> > Testing patch on Linus tree.
>
> Hi Murphy,
> Did you apply this patch?
> Link: https://lkml.kernel.org/r/20220124181812.1869535-2-ztong0001@gmail.com
> I tested it on top of the current master branch and it works on my
> setup using the reproducer I mentioned.
> Could you share your test script?
> Thanks,
> - Tong

I can find binfmt_misc02.sh on github, and running the following
command shows: failed 0.

./runltp -s binfmt_misc
Running tests.......
<<<test_start>>>
tag=binfmt_misc01 stime=1643178454
cmdline="binfmt_misc01.sh"
contacts=""
analysis=exit
<<<test_output>>>
[   90.908282] LTP: starting binfmt_misc01 (binfmt_misc01.sh)
binfmt_misc01 1 TINFO: timeout per run is 0h 5m 0s
binfmt_misc01 1 TPASS: Failed to register a binary type
binfmt_misc01 2 TPASS: Failed to register a binary type
binfmt_misc01 3 TPASS: Failed to register a binary type
binfmt_misc01 4 TPASS: Failed to register a binary type
binfmt_misc01 5 TPASS: Failed to register a binary type
binfmt_misc01 6 TPASS: Failed to register a binary type
binfmt_misc01 7 TPASS: Failed to register a binary type
binfmt_misc01 8 TPASS: Failed to register a binary type
binfmt_misc01 9 TPASS: Failed to register a binary type

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=2 cstime=17
<<<test_end>>>
<<<test_start>>>
tag=binfmt_misc02 stime=1643178454
cmdline="binfmt_misc02.sh"
contacts=""
analysis=exit
<<<test_output>>>
[   91.133399] LTP: starting binfmt_misc02 (binfmt_misc02.sh)
incrementing stop
binfmt_misc02 1 TINFO: timeout per run is 0h 5m 0s
binfmt_misc02 1 TPASS: Recognise and unrecognise a binary type as expected
binfmt_misc02 2 TPASS: Recognise and unrecognise a binary type as expected
binfmt_misc02 3 TPASS: Recognise and unrecognise a binary type as expected
binfmt_misc02 4 TPASS: Recognise and unrecognise a binary type as expected
binfmt_misc02 5 TPASS: Fail to recognise a binary type
binfmt_misc02 6 TPASS: Fail to recognise a binary type

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=3 cstime=25
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20220121-9-g010e4f783

       ###############################################################

            Done executing testcases.
            LTP Version:  20220121-9-g010e4f783
       ###############################################################
