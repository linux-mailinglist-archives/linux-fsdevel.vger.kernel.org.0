Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4833DCA5D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhHAGdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 02:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHAGdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:33:00 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0FC06175F;
        Sat, 31 Jul 2021 23:32:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k3so13666086ilu.2;
        Sat, 31 Jul 2021 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUClev66k2CwNGVehotJ41c5fU9e0u4+Aw/nkEdVSo4=;
        b=Vor6uuwaFPIL6tI6kQNkUjJBadv0llFfR5CYI6gj3wgECMJLXhN8hg3InrXzdHHw6x
         v9zDzDwZrBxZAcGVOhvymBCPk2UZZZD7TE+EL+mty8S27t8FQDf4NpTcBEsxZHaum6y2
         3d0A2nn07EApu+KWWgSNxbgjokNSOjRHtla+4d2rAcFKVGCatM2ZE2N5s9tKeMu6a/CM
         pRDEWT/JCaNndYE6sLyMVTDlq5XAulCKN+/9cZ2bJ3T/9sjK5EPOtpjLffGuKojj1MGt
         ocfbZFSrsbWmB6T1ogXtulec1lpogOHEpVI0cE2oF/9LBTDgyysS6fWvrh9+gqf+y41G
         RVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUClev66k2CwNGVehotJ41c5fU9e0u4+Aw/nkEdVSo4=;
        b=NXcRw/ACQKNQbke/stUq/d0xbJnDfiexL6k+/AAdpSXUTszGpTUpuEXq61XXtkevlM
         +nh44rjKwJov2oyIlvkg1Zc07hzSKnI6ybs5gyLuqX+sop+YD0BLT6PZ4bLmEg3hzzcK
         UhP6gxIkGlyZeHusKKHJZr8kdZRMD6aYIucs25zMsS7oZYl53rfS4zecuKT0bJ8aa7sK
         AyRBYOQR8q3AH4ZVmAoRxpEjsMDOxumQ3FkKDq249FDBG98zu7iMmbQtvf0j6rXGLo0D
         m7PJF1habaQFbQZjxOdBU9a3dYEUsMYo0M5Ox6ygO8R6l6ND4FQoqPAHxZlMW775ejfy
         N8kA==
X-Gm-Message-State: AOAM533U8+FFVDcJjZjCFGeDP/oFrNj5sSAj7JFGcTPQ18bYlwddII50
        Vi0axjNTjLnDQRHA37wtlNq2FukHlZUAEtAjYWzqB51C
X-Google-Smtp-Source: ABdhPJz2A1YHGrY91aq4xNrHBpd0Fw24qT58iA89MIoLql0jpWOElyATTepmR5ts870yyPm/tMwh/otaM060TJQrreE=
X-Received: by 2002:a92:d28b:: with SMTP id p11mr3097565ilp.250.1627799571702;
 Sat, 31 Jul 2021 23:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-9-krisman@collabora.com>
 <20210731063818.GB18773@xsang-OptiPlex-9020> <CAOQ4uxgtke-jK3a1SxowdEhObw8rDuUXB-DSGCr-M1uVMWarww@mail.gmail.com>
 <87lf5mi7mv.fsf@collabora.com>
In-Reply-To: <87lf5mi7mv.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 1 Aug 2021 09:32:40 +0300
Message-ID: <CAOQ4uxhsb_iVBTWVVreS7eSRCUapFFcyhXwnekaqptbMJSm1KQ@mail.gmail.com>
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

On Sat, Jul 31, 2021 at 10:51 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Sat, Jul 31, 2021 at 9:20 AM kernel test robot <oliver.sang@intel.com> wrote:
> >>
> >>
> >>
> >> Greeting,
> >>
> >> FYI, we noticed a -3.3% regression of unixbench.score due to commit:
> >>
> >>
> >> commit: 4c40d6efc8b22b88a45c335ffd6d25b55d769f5b ("[PATCH v4 08/16] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info")
> >> url: https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210721-001444
> >> base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
> >>
> >> in testcase: unixbench
> >> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
> >> with following parameters:
> >>
> >>         runtime: 300s
> >>         nr_task: 1
> >>         test: pipe
> >>         cpufreq_governor: performance
> >>         ucode: 0x4003006
> >>
> >> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> >> test-url: https://github.com/kdlucas/byte-unixbench
> >>
> >> In addition to that, the commit also has significant impact on the following tests:
> >>
> >> +------------------+-------------------------------------------------------------------------------------+
> >> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -1.3% regression                        |
> >> | test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> >> | test parameters  | cpufreq_governor=performance                                                        |
> >> |                  | mode=thread                                                                         |
> >> |                  | nr_task=100%                                                                        |
> >> |                  | test=eventfd1                                                                       |
> >> |                  | ucode=0x5003006                                                                     |
> >> +------------------+-------------------------------------------------------------------------------------+
> >>
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >>
> >
> > Gabriel,
> >
> > It looks like my change throws away much of the performance gain for
> > small IO on pipes without any watches that was achieved by commit
> > 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
> > when there is no watcher").
> >
> > I think the way to fix it is to lift the optimization in __fsnotify()
> > to the fsnotify_parent() inline wrapper as Mel considered doing
> > but was not sure it was worth the effort at the time.
> >
> > It's not completely trivial. I think it requires setting a flag
> > MNT_FSNOTIFY_WATCHED when there are watches on the
> > vfsmount. I will look into it.
>
> Amir,
>
> Since this patch is a clean up, would you mind if I drop it from my
> series and base my work on top of mainline? Eventually, we can rebase
> this patch, when the performance issue is addressed.
>
> I ask because I'm about to send a v5 and I'm not sure if I should wait
> to have this fixed.

I guess you mean that you want to add the sb to fsnotify() args list.
I don't mind, it's up to Jan.

Thanks,
Amir.
