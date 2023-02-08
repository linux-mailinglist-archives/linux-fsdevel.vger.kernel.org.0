Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E1E68EB01
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 10:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjBHJTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 04:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjBHJSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:18:37 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AAC2D60
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 01:16:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h3so297156eda.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 01:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0udy7VcsFtbEcmMh8LPWGmOLt9m2lp/nW9trRnrvvWw=;
        b=7onzNGExY4AhmonxfVlVCuTAXSL2U+dQnvvd36DNz7YsAp9Ukn2mVFq4HrW2VSi/A8
         aCYx4psumuwW+UKtXkLOBYBhv0Cs8JX+SQVrkFlhxfMq5C5i5r04VgWZdGS/glE6CiN6
         J2rnu2NKLD8LaTPdeTERHOH5MbgMJVhmX5A8/SU1LPUcyDTM6h37cfoU3vTFMbYRejoE
         i6BFY/BBM2ZZ8hWs+MdvOLpQw43oLv6gEF0wR4+5L0P9gozJ6uD8V0cwFDib++iyieIn
         JKXvvCnyykHa/3GIXN0zobeH7SE0Izyx4M+aNtVnyIEHb94Lo4HBxfwphq2WNXnY/Ewv
         vLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0udy7VcsFtbEcmMh8LPWGmOLt9m2lp/nW9trRnrvvWw=;
        b=m2PqYrxGF8LeT6sTqec2YluIGothMfJKfan1qg4LTZ0T6VPa3pRonu7RKsxO5fe4b2
         VPqb8aevEwNkpWXZUBS1tPwCJBROe2Dxek0VxmQasjam9FW+YBXZbwT+btobWOzV2DlE
         zfyoS9iX23dsdrlvf8rSI0uGK7YSvxyArhoRfQPHZ0eVyOax7ZIS6Qm74ymdMRc3tEUF
         nergv4BVVd75TndjPxrqpcFAts8820FhIMdZfvTsogYgztWVz0OcYGQa1wKpbqmcMT7H
         jfT0Xk0gwAXScp5aoIJFDn72TMqX7vjHd1BNYQrQnnNSA6fqnP6Dlk7DPinokcNbnRzU
         zv9A==
X-Gm-Message-State: AO0yUKXv0Dh7b8a/PGhEWuRxQMGoqbfqScoRMAQlC1kJyScSgPVsizq/
        ewdi8Wc95ihr+gwvfKyPTE/tyE0P+M4vTP9WwUjpzA==
X-Google-Smtp-Source: AK7set+zHCr6kqmvcS0ETlTJ5CfnsYxujV7KfYvYeOudBniQrXdw3pIfYyqUvRE3bJT2GJiGC4IWFgZ8RNrG4Dcv3zo=
X-Received: by 2002:a50:cc9e:0:b0:4aa:a333:2b2f with SMTP id
 q30-20020a50cc9e000000b004aaa3332b2fmr1545845edi.76.1675847778315; Wed, 08
 Feb 2023 01:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20230206134148.GD6704@gsv> <22843ea8-1668-85db-3ba3-f5b4386bba38@wdc.com>
 <CANr-nt2q-1GjE6wx4W+6cSV9RULd8PKmS2-qyE2NvhRgMNawXQ@mail.gmail.com> <Y+KOhvnMCyi2NRRZ@zen>
In-Reply-To: <Y+KOhvnMCyi2NRRZ@zen>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 8 Feb 2023 10:16:07 +0100
Message-ID: <CANr-nt1w=JFCXYy3j33HgN1fJCPf5aGtHQ=77=B7Z1b8vr1kPA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block devices
To:     Boris Burkov <boris@bur.io>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?UTF-8?Q?J=C3=B8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 7, 2023 at 6:46 PM Boris Burkov <boris@bur.io> wrote:
>
> On Tue, Feb 07, 2023 at 01:31:44PM +0100, Hans Holmberg wrote:
> > On Mon, Feb 6, 2023 at 3:24 PM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> > >
> > > On 06.02.23 14:41, Hans Holmberg wrote:
> > > > Out of the upstream file systems, btrfs and f2fs supports
> > > > the zoned block device model. F2fs supports active data placement
> > > > by separating cold from hot data which helps in reducing gc,
> > > > but there is room for improvement.
> > >
> > > FYI, there's a patchset [1] from Boris for btrfs which uses different
> > > size classes to further parallelize placement. As of now it leaves out
> > > ZNS drives, as this can clash with the MOZ/MAZ limits but once active
> > > zone tracking is fully bug free^TM we should look into using these
> > > allocator hints for ZNS as well.
> > >
> >
> > That looks like a great start!
> >
> > Via that patch series I also found Josef's fsperf repo [1], which is
> > exactly what I have
> > been looking for: a set of common tests for file system performance. I hope that
> > it can be extended with longer-running tests doing several disk overwrites with
> > application-like workloads.
>
> It should be relatively straightforward to add more tests to fsperf and
> we are happy to take new workloads! Also, feel free to shoot me any
> questions you run into while working on it and I'm happy to help.

Great,, thanks!

>
> >
> > > The hot/cold data can be a 2nd placement hint, of cause, not just the
> > > different size classes of an extent.
> >
> > Yes. I'll dig into the patches and see if I can figure out how that
> > could be done.
>
> FWIW, I was working on reducing fragmentation/streamlining reclaim for
> non zoned btrfs. I have another patch set that I am still working on
> which attempts to use a working set concept to make placement
> lifetime/lifecycle a bigger part of the btrfs allocator.
>
> That patch set tries to make btrfs write faster in parallel, which may
> be against what you are going for, that I'm not sure of. Also, I didn't
> take advantage of the lifetime hints because I wanted it to help for the
> general case, but that could be an interesting direction too!

I'll need to dig into your patchset and look deeper into the btrfs allocator
code, to know for sure, but reducing fragmentation is great for zoned storage
in general.

Filling up zones with data from a single file is the easiest way to reduce
write amplification, and  the optimal from a reclaim perspective.
Entire zone(s) can be reclaimed as soon as the file is deleted.

This works great for lsm-tree based workloads like rocksdb and should
work well for other applications using copy-on-write data structures with
configurable file sizes (like apache kafka [1], which uses 1 gigabyte log
file sizes per default)

When file data from several files needs to be co-located in the same zone
things get more complicated. Then we have to co-locate file data from
more than one file, trying to match up files data that have the same life span.

If the user can tell us about the expected data life time via a hint,
that is great. If the
file system does not have that information, some other heuristic is needed,
like assuming that data being written by different processes or
users/groups have
different life spans. A more advanced scheme, SepBIT [2], has been proposed
for block storage, which may be applicable for file system data as well.

Thanks,
Hans

[1] https://kafka.apache.org/documentation/#topicconfigs_segment.bytes
[2] http://adslab.cse.cuhk.edu.hk/pubs/tech_sepbit.pdf

> If you're curious about that work, the current state of the patches is
> in this branch:
> https://github.com/kdave/btrfs-devel/compare/misc-next...boryas:linux:bg-ws
> (Johannes, those are the patches I worked on after you noticed the
> allocator being slow with many disks.)
>
> Boris
>
> >
> > Cheers,
> > Hans
> >
> > [1] https://github.com/josefbacik/fsperf
