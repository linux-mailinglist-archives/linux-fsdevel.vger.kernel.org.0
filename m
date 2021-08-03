Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A653DF257
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 18:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhHCQT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbhHCQT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:19:26 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67DC06179B;
        Tue,  3 Aug 2021 09:19:15 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k3so20005397ilu.2;
        Tue, 03 Aug 2021 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TO/BEShdVdtfrOssLTeZLTNZdChzJThwgKAZS+uU6WE=;
        b=i81DPzn/BiTioiDp/Ve7BcxQSmjsCCMcgtiXVDMLq/Sk6dSis4FHhbK0cnROYddV0m
         aKiCid+i9D1/QT0cYtoIQFcg592rmZu79qo0b3IchATIW6nOjztnmpgGL/0gcmabLeAW
         UNvQh+dvJ+3Bm6pMGUWrCqMMmX1Vz2Qlohl5ylFB6UnlqdSqvrO32bT07av/57vqcmNF
         EdgMK4gumjFPqp4829XHYQt9kGoboPhXOZNCN1uofzkMAKXaiowCQoeSG8N0wCzS2G0z
         y/IX4qo+4mLaB8IlecDIw+d8+/KitD2GVnY3Z28lzyq78ckWSoCFHO5xdMS/VIIK32kc
         lbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TO/BEShdVdtfrOssLTeZLTNZdChzJThwgKAZS+uU6WE=;
        b=rm0EpSqTO5MWwwF5tdSBKn6TcbyIz9VFm9TGGchStty2ql3KzFAMSde49jzCX2yxuI
         WasrY2OscDlqdkfU72+ku2lPBhbjnxy0DRntyHwB6YkKQi5nbKYORgXgdaKSk+7fMWkP
         GenIptpmftnUpd9byuMCibi7T5n9+7MlfSdYswRgGFdr1S7Eyuu+IS97sW/Sakf/L+ao
         yjRSCC7qOQJ7aVkBdevFLLrciHjSve1aXa1Zi32kooCL8mXajXFfK0NRc0zaoO1GAWmx
         kG29MTPHtMtu3BYLuCTPJA/+pzgXfINXsZDZoBAqSjUmegr1/kS/HA26XcZ5V+qdyRg8
         vH8A==
X-Gm-Message-State: AOAM530P7X7uwft2rZ0UU36OCMdGMOmTDwNwpiFv5DiCw8Mci6tfc/xb
        mfW1sYFjsDVCZDa9z1Dnyeo2MfGSeIlofdic0Zk=
X-Google-Smtp-Source: ABdhPJxlIyQ1ozmFNJ+nS254bJf1C4kbaAEZc34gOakhC4ep3Q1V2GSYBNyRa6UeNzJpFeJ/dUJfDkDfdRefsK3w56Y=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr1391454ilh.137.1628007554960;
 Tue, 03 Aug 2021 09:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-9-krisman@collabora.com>
 <20210731063818.GB18773@xsang-OptiPlex-9020> <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
 <CAOQ4uxh+do6SVyYCcNSM+7dqzSRU_Y-AXYuMyti4ESkmLdm5zQ@mail.gmail.com> <20210803142225.GA28609@xsang-OptiPlex-9020>
In-Reply-To: <20210803142225.GA28609@xsang-OptiPlex-9020>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Aug 2021 19:19:04 +0300
Message-ID: <CAOQ4uxisyDjVpWX1M6O4ugxBbcX+LWWf4NQJ+LQY1-3-9tN+BA@mail.gmail.com>
Subject: Re: [fsnotify] 4c40d6efc8: unixbench.score -3.3% regression
To:     Oliver Sang <oliver.sang@intel.com>
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

> > Oliver,
> >
> > Would it be possible to request a re-test with the branch:
> > https://github.com/amir73il/linux fsnotify-perf
> >
> > The patch at the tip of that branch is the one this regression report
> > has blamed.
> >
> > My expectation is that the patch at fsnotify-perf^ ("fsnotify: optimize the
> > case of no marks of any type") will improve performance of the test case
> > compared to baseline (v5.14-rc3) and that the patch at the tip of fsnotify-perf
> > would not regress performance.
>
> we tested this branch and the results meet your expectation.
>
> fsnotify-perf^ improves performance comparing to v5.14-rc3. tip is a little worse
> than its parent (-3.3%), but still better than v5.14-rc3.
>
> below is detail data.
>
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/1/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2sp4/pipe/unixbench/0x4003006
>
> commit:
>   v5.14-rc3
>   23050d041 ("fsnotify: optimize the case of no marks of any type")
>   7446ba772 ("fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info")
>
>        v5.14-rc3 23050d0419441a02185e4ed5170 7446ba772ae107ab937cd04e880
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>       1562            +8.0%       1688            +4.5%       1633        unixbench.score

Hi Oliver,

Thanks a lot for testing!

I don't know what to make of the (-3.3%) degradation because I was expecting
that fsnotify-perf^ would optimize out the calls to fsnotify() and fsnotify-perf
only changes code from fsnotify() and below.

But I guess it doesn't matter much as Gabriel said, its a cleanup patch and
we can drop it.

But now that I have this report I can post the fsnotify-perf^ patches :-)

Thanks,
Amir.
