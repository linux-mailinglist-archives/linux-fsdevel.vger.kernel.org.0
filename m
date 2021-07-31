Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0283DC6E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhGaQ1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhGaQ1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 12:27:38 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C70C06175F;
        Sat, 31 Jul 2021 09:27:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i13so631105ilm.11;
        Sat, 31 Jul 2021 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ee50FTv47mz9YSA5BwOWPTMugOsH5ALvkhacKksyiDA=;
        b=tfKTh5XeHtEOhGQy/XAOuqUtEUcePZyKuhzSUfWoP7/nItHS2qy35v+VONq5az6KTh
         vI0xkU3rCrPpu7EoNWcg/7e0aVnYgFoCSD44YwoDVITySsNOSTLRTEhSD3Zf2l/PNhpw
         +btNuqLwZt4ha6X0T9gWD8QZOS4Ic5BIfVGIQfh7hcJQf+rEKStJabkYOczqGEqx1bIN
         uY8RjBXS5WECQBxdPj7hNxyd1Fv7hLJk3UYSW2vTQAbi0AUhbdsz5s/B9SRI5LUDtWVA
         r5hKT9k9+7xbuiv8JQX1KFE5ZuguWT+u0zQ9AtNXU87yY8r8HRLKb+WAvuRRTTbQJCdr
         iZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ee50FTv47mz9YSA5BwOWPTMugOsH5ALvkhacKksyiDA=;
        b=VNCSbHey9f26wr0tKNfeYm7y5eV9KnXb22m64qg5EKK5CMBl9ufqkdYnNoAorKIUoO
         QljrbgokaibnxhGCzxEC0+GsPpXkYRAqiGmhOxsSGwpsD+yen4R3ry4NqJvk9/pU0iSv
         tYQnThvanVpAlW7hdX62upE9o8nDAGncJSD/iwi+cAfmlo5+EZDHjPaAQOJy1fOvZhpV
         rTgtfZImE0TpOLvONj5RTSO88dMVtN9uh7SMXtDOsp1fqfRqeTdCfdqTLYNAZy0Kd1uO
         BYZ1y6QwSRlOhPicOe04ry+407eKmsV8gN7YDw5OMnHxIgMAewHt/SOk5G/0jIJAQuAi
         XlHQ==
X-Gm-Message-State: AOAM531giw6YDPSntK2EsGqCblWtdLHr7GWFSz9UKFt5O+fIFaa7EJd2
        04PMUwFqPhUPOlPImS9z0y2IRSO4g2Fxrtvls20=
X-Google-Smtp-Source: ABdhPJzKOyTYcsRfW1fyXwn6uL+XCJ/SsUhrPRxbGHj33Y2gm774u5U4O1CBy7SOEtspOuHrlMzMp9USWVkD9zMu+Gw=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr5017071ilh.137.1627748850316;
 Sat, 31 Jul 2021 09:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-9-krisman@collabora.com>
 <20210731063818.GB18773@xsang-OptiPlex-9020> <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
In-Reply-To: <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 31 Jul 2021 19:27:19 +0300
Message-ID: <CAOQ4uxh+do6SVyYCcNSM+7dqzSRU_Y-AXYuMyti4ESkmLdm5zQ@mail.gmail.com>
Subject: Re: [fsnotify] 4c40d6efc8: unixbench.score -3.3% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 31, 2021 at 12:27 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, Jul 31, 2021 at 9:20 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Greeting,
> >
> > FYI, we noticed a -3.3% regression of unixbench.score due to commit:
> >
> >
> > commit: 4c40d6efc8b22b88a45c335ffd6d25b55d769f5b ("[PATCH v4 08/16] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info")
> > url: https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210721-001444
> > base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
> >
> > in testcase: unixbench
> > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
> > with following parameters:
> >
> >         runtime: 300s
> >         nr_task: 1
> >         test: pipe
> >         cpufreq_governor: performance
> >         ucode: 0x4003006
> >
> > test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> > test-url: https://github.com/kdlucas/byte-unixbench
> >
> > In addition to that, the commit also has significant impact on the following tests:
> >
> > +------------------+-------------------------------------------------------------------------------------+
> > | testcase: change | will-it-scale: will-it-scale.per_thread_ops -1.3% regression                        |
> > | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > | test parameters  | cpufreq_governor=performance                                                        |
> > |                  | mode=thread                                                                         |
> > |                  | nr_task=100%                                                                        |
> > |                  | test=eventfd1                                                                       |
> > |                  | ucode=0x5003006                                                                     |
> > +------------------+-------------------------------------------------------------------------------------+
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
>
> Gabriel,
>
> It looks like my change throws away much of the performance gain for
> small IO on pipes without any watches that was achieved by commit
> 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
> when there is no watcher").
>
> I think the way to fix it is to lift the optimization in __fsnotify()
> to the fsnotify_parent() inline wrapper as Mel considered doing
> but was not sure it was worth the effort at the time.
>
> It's not completely trivial. I think it requires setting a flag
> MNT_FSNOTIFY_WATCHED when there are watches on the
> vfsmount. I will look into it.
>

Oliver,

Would it be possible to request a re-test with the branch:
https://github.com/amir73il/linux fsnotify-perf

The patch at the tip of that branch is the one this regression report
has blamed.

My expectation is that the patch at fsnotify-perf^ ("fsnotify: optimize the
case of no marks of any type") will improve performance of the test case
compared to baseline (v5.14-rc3) and that the patch at the tip of fsnotify-perf
would not regress performance.

Thanks,
Amir.
