Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2E3DC569
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhGaJ2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 05:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhGaJ2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 05:28:03 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDFDC06175F;
        Sat, 31 Jul 2021 02:27:56 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h18so11865474ilc.5;
        Sat, 31 Jul 2021 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42fk0JLlPxngYOLTycnNlC1N05QmALd58V4flGjPUHA=;
        b=h2MgJ0n6Z3GAoD7xS/oEUDOqvqdzuAWs7ChMrUcJk03nNGbyed2kOlsvlEtDRox31S
         k0rzF2dmqCMbctywdfx6dArb4tBP9w57vs98/4kwyWbE8H56ALFEeK0ER1twQ4Fa90Z1
         9NRobu3oDKVkcbSPgnWtTimwsxSmGPzHP1uCjIURzOsd4e9BQaAwMFypXbL/yZ+aAmBJ
         r6DscCwfKztZgF6Lspb9g2NZgwUXm+rDEpP13qGSARW6l28T8jEdd0OUiIdKIiyzfVPM
         P/5VpDFkmztI+i8jCeM+0c04ok24E3easPPWeH3Fw0GMXj95E9PgZQnrIds6CU2LC8Qw
         ROnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42fk0JLlPxngYOLTycnNlC1N05QmALd58V4flGjPUHA=;
        b=oLoq1NERHhPCdq57loM0jOFGtxYS7GFmLYTjRMN3QqXLk447tsAylrlB1qQOTT2mED
         lqiKWSe84zZaxRIuwpT/a35iRfr1ARSRczS+GTRbOasuKCWfWA6RZCZAwUNqt+eFaQ7S
         mNT8peIUw88bPn6SeiMglmaWQpxbNQd0WMUFElL6g1GqnkvkCgpJDV4cMy5hlamQP4KC
         T5Ta9CII8ITGlfDPbHsRdl0Ei+ZLAMJ2WgWuOBP3hDadxtJu2QNfERe+g9ZAfjOBxxAf
         tQKk1Kb3IkkGUxGP+p1Di5sQaLKo8pBjx21wLTwqWAufwczRqWIf8kfmyZ1b2LXkw2QG
         Z1nw==
X-Gm-Message-State: AOAM5320bhxQgoy8hMhQnMlGWMhckt8xt0z2QTxSOPyX4RjOT1bXjtvI
        znbHFsq//k5U1f9Y5YqZGQ1YiKDzHyrXd9rX3xk=
X-Google-Smtp-Source: ABdhPJzy8OmpI+375ShVxrIv6n/AB3ba2KJe0mpXRkR6ianchK12I6/ZodVsN+d8OBiy4VoNEWSIA/pIJmKumEMsEoQ=
X-Received: by 2002:a05:6e02:d93:: with SMTP id i19mr4691245ilj.72.1627723674278;
 Sat, 31 Jul 2021 02:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-9-krisman@collabora.com> <20210731063818.GB18773@xsang-OptiPlex-9020>
In-Reply-To: <20210731063818.GB18773@xsang-OptiPlex-9020>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 31 Jul 2021 12:27:43 +0300
Message-ID: <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
Subject: Re: [fsnotify] 4c40d6efc8: unixbench.score -3.3% regression
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 31, 2021 at 9:20 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed a -3.3% regression of unixbench.score due to commit:
>
>
> commit: 4c40d6efc8b22b88a45c335ffd6d25b55d769f5b ("[PATCH v4 08/16] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info")
> url: https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210721-001444
> base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
>
> in testcase: unixbench
> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
> with following parameters:
>
>         runtime: 300s
>         nr_task: 1
>         test: pipe
>         cpufreq_governor: performance
>         ucode: 0x4003006
>
> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> test-url: https://github.com/kdlucas/byte-unixbench
>
> In addition to that, the commit also has significant impact on the following tests:
>
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -1.3% regression                        |
> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | cpufreq_governor=performance                                                        |
> |                  | mode=thread                                                                         |
> |                  | nr_task=100%                                                                        |
> |                  | test=eventfd1                                                                       |
> |                  | ucode=0x5003006                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>

Gabriel,

It looks like my change throws away much of the performance gain for
small IO on pipes without any watches that was achieved by commit
71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
when there is no watcher").

I think the way to fix it is to lift the optimization in __fsnotify()
to the fsnotify_parent() inline wrapper as Mel considered doing
but was not sure it was worth the effort at the time.

It's not completely trivial. I think it requires setting a flag
MNT_FSNOTIFY_WATCHED when there are watches on the
vfsmount. I will look into it.

Thanks,
Amir.
