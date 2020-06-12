Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106A01F7620
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFLJi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgFLJi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:38:27 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B47C03E96F;
        Fri, 12 Jun 2020 02:38:27 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 9so8171047ilg.12;
        Fri, 12 Jun 2020 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaicPOH+dZ5Iktboa0xwfp898xC8kU9RpGqq/bUg94o=;
        b=lmPADEL1QE7uLca5G0SgDmNgtt0R3H+Z37M2M2PMe82alYpfulRyapt7IqaKSWgiEe
         Ehme3eJRiDO8J0MrCs/IroygkGwY6JQ7V8GEQpQg4iBlz7mPa+CildirAIyQL2Puk5I/
         bs17JXmv6lnsQQtX0ijTf0PWPisa1BpyIUhaOcFu2kyxPwovmeB8elqmL7AbXEVAZlv7
         mvXL6q3/fVeSEV4sHrTRJbbRgnux+5zwgUmf2cmA0LaJgRZ+AbtWoHF+WB+WrrRISAVN
         u74Pk6/O1m/pgdPbrbul5+Xj3xzvOpwBGM0oor6gvZu+WIFWWXpEj1rE15e3ah6Qzfxn
         8Zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaicPOH+dZ5Iktboa0xwfp898xC8kU9RpGqq/bUg94o=;
        b=IpT28+CWq1uT/vWzloZtk75Wg9p5Fg0nb92Mw5kl92qUqDAvRg2kFOB+Mb38QYKNsL
         iVaHm4nInomdWmtCMPb7G1Ipv9BuUkSuu/Gfbe3gVf/ZwVLsHwQfIB5aI6xOSkQKvyAo
         Ba9iPEcnsHgFt7KCAXITucKzL5kSQO3M4jtoiTZjlYOjbd/15LC5x+j9CCJIkNkxrnnn
         7UjaORZwCswWP+o1lNNXsRhv9Ygk7lBu4s2LNF8Rus6jZdbiSklvxEa9HRrwjMb+R7P0
         RJQ56JB0ca7eoOSR4S/Xrxr55M8ob5Yd5w7Z4jqboq1Vh21Fv9Hh1+ucqi1ioYnB3M06
         RJPg==
X-Gm-Message-State: AOAM530KHdD2UhPDaB6sQt+AdVicILJ2+5cYJZKWM9n0df/il/QUIMZp
        fgiHwVsfKaRCn3PxeERi0sWV2JPUjm0Tp0SPipnGKQ==
X-Google-Smtp-Source: ABdhPJxfx/BGLWcuK0MV9QvPYJddv2c73grXn4F3GllNy7ffLPXnQM54+k7eLK6VxEBGFhB3V8/GZ0dctPwIVDphlMM=
X-Received: by 2002:a92:c9ce:: with SMTP id k14mr12036308ilq.250.1591954706642;
 Fri, 12 Jun 2020 02:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200608140557.GG3127@techsingularity.net> <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
 <20200608160614.GH3127@techsingularity.net> <CAOQ4uxh=Z92ppBQbRJyQqC61k944_7qG1mYqZgGC2tU7YAH7Kw@mail.gmail.com>
 <20200608180130.GJ3127@techsingularity.net> <CAOQ4uxgcUHuqiXFPO5mX=rvDwP-DOoTZrXvpVNphwEMFYHtyCw@mail.gmail.com>
 <CAOQ4uxhbE46S65-icLhaJqT+jKqz-ZdX=Ypm9hAt9Paeb+huhQ@mail.gmail.com>
 <20200610125920.GM3127@techsingularity.net> <CAOQ4uxhcFO4=e-s7uStbEkZU==8kraD1=owZGu4SWx_iR72gTA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhcFO4=e-s7uStbEkZU==8kraD1=owZGu4SWx_iR72gTA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 12 Jun 2020 12:38:15 +0300
Message-ID: <CAOQ4uxjTFCJa1y2Uq8NztXxkPRmvDvtUUt22QMwPkdd=eJdkyw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 4:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jun 10, 2020 at 3:59 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Mon, Jun 08, 2020 at 11:39:26PM +0300, Amir Goldstein wrote:
> > > > Let me add your optimizations on top of my branch with the needed
> > > > adaptations and send you a branch for testing.
> > >
> > > https://github.com/amir73il/linux/commits/fsnotify_name-for-mel
> > >
> >
> > Sorry for the delay getting back. The machine was busy with other tests
> > and it took a while to reach this on the queue. Fairly good news
> >
> > hackbench-process-pipes
> >                               5.7.0                  5.7.0                  5.7.0                  5.7.0
> >                             vanilla      fastfsnotify-v1r1          amir-20200608           amir-for-mel
> > Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*      0.4967 *  -2.69%*      0.4680 (   3.24%)
> > Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)      1.6587 *  -7.38%*      1.4807 (   4.14%)
> > Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)      2.6400 (  -1.40%)      2.4900 (   4.37%)
> > Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)      3.9040 *  -8.48%*      3.5130 (   2.38%)
> > Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)      6.2593 (  -7.43%)      5.6967 (   2.23%)
> > Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)      8.9940 (  -6.56%)      7.7240 *   8.48%*
> > Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*     11.7247 *  -6.41%*      9.5793 *  13.06%*
> > Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)     14.0290 *  -7.08%*     12.1630 (   7.16%)
> > Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)     14.7140 *  -5.71%*     13.2457 *   4.84%*
> >
> > First two sets of results are vanilla kernel and just my patch respectively
> > to have two baselines. amir-20200608 is the first git branch you pointed
> > me to and amir-for-mel is this latest branch. Comparing the optimisation
> > and your series, we get
> >
> > hackbench-process-pipes
> >                               5.7.0                  5.7.0
> >                   fastfsnotify-v1r1           amir-for-mel
> > Amean     1       0.4630 (   0.00%)      0.4680 (  -1.08%)
> > Amean     3       1.4557 (   0.00%)      1.4807 (  -1.72%)
> > Amean     5       2.4363 (   0.00%)      2.4900 (  -2.20%)
> > Amean     7       3.4757 (   0.00%)      3.5130 (  -1.07%)
> > Amean     12      5.6983 (   0.00%)      5.6967 (   0.03%)
> > Amean     18      8.1327 (   0.00%)      7.7240 (   5.03%)
> > Amean     24     10.0290 (   0.00%)      9.5793 (   4.48%)
> > Amean     30     12.8510 (   0.00%)     12.1630 (   5.35%)
> > Amean     32     13.2410 (   0.00%)     13.2457 (  -0.04%)
> >
> > As you can see, your patches with the optimisation layered on top is
> > comparable to just the optimisation on its own. It's not universally
> > better but it would not look like a regression when comparing releases.
> > The differences are mostly within the noise as there is some variability
> > involved for this workload so I would not worry too much about it (caveats
> > are other machines may be different as well as other workloads).
>
> Excellent!
> Thanks for verifying.
>
> TBH, this result is not surprising, because despite all the changes from
> fastfsnotify-v1r1 to amir-for-mel, the code that is executed when there
> are no watches should be quite similar. Without any unexpected compiler
> optimizations that may differ between our versions, fsnotify hooks called
> for directories should execute the exact same code.
>
> fsnotify hooks called for non-directories (your workload) should execute
> almost the same code. I spotted one additional test for access to
> d_inode and one additional test of:
> dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED
> in the entry to __fsnotify_parent().
>
> > A minor
> > issue is that this is probably a bisection hazard. If a series is merged
> > and LKP points the finger somewhere in the middle of your series then
> > I suggest you ask them to test the optimisation commit ID to see if the
> > regression goes away.
> >
>
> No worries. I wasn't planning on submitted the altered patch.
> I just wanted to let you test the final result.
> I will apply your change before my series and make sure to keep
> optimizations while my changes are applied on top of that.
>

FYI, just posted your patch with a minor style change at the bottom
of my prep patch series.

Thanks,
Amir.
