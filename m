Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8483F8352
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 09:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhHZHrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbhHZHrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:47:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA449C061757;
        Thu, 26 Aug 2021 00:46:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o10so4815798lfr.11;
        Thu, 26 Aug 2021 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFfBSeUoIkVFq2c+wyysTynFg5YjCpP2+vF7k66ApRg=;
        b=uyQzTrBldhPBh5nnQ72jaL9ktwnDpjD+4r8yAyDP7End8hK4tImCX0vowpGHE7hmLS
         8izi65eqLg79JdYWSVhXIsX+BCZfavs+2RzUBWIrPpKo0Op9znWybT+xFyfGrOzNy8m/
         e2jotR+rDmbQ7VRtpLgSYvBI27SHetTz8WHtP8fmLYjEIooMCsXjvYsfy64tH6oChXA/
         wXochubuastNo9MazCpWht5fF4C5FhRNPgBm0M9HSKDpjkoh9vsRCZ5UPxq/aJy0NheJ
         TK4XrpeBYwfk9KSL5aW8NGnWHFvupKUfr0mRT1s83xaNu35b+c2Ni4GeM4IJe36Ichhv
         Clhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFfBSeUoIkVFq2c+wyysTynFg5YjCpP2+vF7k66ApRg=;
        b=dUh8LO9bM3+oniQWD4dJGObmSUsC2jgy9Qfgefi6F0+LfFQZ/9BNzk2NuAToxjl+pu
         iBjsm5GPuNTAX9876yL0tojLWjUWUzoZcDjmm7VbLFziRLHCArckiAtBG4VmMvBG03xU
         dJZw+Uent+Wk1UG8fFTL2fPO1CEjUVLNAJs0JEDM0s2lAtcL/FGEY66w1BbIkgDs81jR
         1qD3pz4TZuuNTwXql6yLc8YlbKeYHo3SZh8FiybxRfoROOcyaL7aRE9vjkOpl4BlSsT2
         bwRxJBquMI3CcOgk39/2N2fXdvUKerTOAnbIb7PGLAXAo5bl992W3+lsL34rPV+b16dN
         LZ0g==
X-Gm-Message-State: AOAM531s+99oqnXGLoHuyMRncZzZFHFDNkifz4M1l4DtkN1oGPYaa6lK
        JPC5h0XRQarj7ORmZQHB0aKNtJ7VTCS9dyLAa9Y=
X-Google-Smtp-Source: ABdhPJyjbSulKVzeS1ayorUS6e0PDTdjH/3YKsApr3OabyEwjGfG27IO4vB7ZiqR7/y8lcLFPtK9qboXnc4pB3rdlck=
X-Received: by 2002:a05:6512:1114:: with SMTP id l20mr1781869lfg.550.1629964017693;
 Thu, 26 Aug 2021 00:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com> <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
 <CA+1E3rK2ULVajQRkNTZJdwKoqBeGvkfoVYNF=WyK6Net85YkhA@mail.gmail.com> <fb9931ae-de27-820a-1333-f24e020913ff@acm.org>
In-Reply-To: <fb9931ae-de27-820a-1333-f24e020913ff@acm.org>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Thu, 26 Aug 2021 13:16:46 +0530
Message-ID: <CAOSviJ1uQo=O8trN71t5p+qYU8GRgGerSvkE9y5tDR+4pM4f1g@mail.gmail.com>
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, kch@kernel.org,
        mpatocka@redhat.com, "Darrick J. Wong" <djwong@kernel.org>,
        agk@redhat.com, Selva Jove <selvajove@gmail.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        KANCHAN JOSHI <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bart,Mikulas,Martin,Douglas,

We will go through your previous work and use this thread as a medium for
further discussion, if we come across issues to be sorted out.

Thank you,
Nitesh Shetty

On Sat, Aug 21, 2021 at 2:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 8/20/21 3:39 AM, Kanchan Joshi wrote:
> > Bart, Mikulas
> >
> > On Tue, Aug 17, 2021 at 10:44 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> On 8/17/21 3:14 AM, SelvaKumar S wrote:
> >>> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> >>> bio with control information as payload and submit to the device.
> >>> Larger copy operation may be divided if necessary by looking at device
> >>> limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
> >>> submitted to zoned device.
> >>> Native copy offload is not supported for stacked devices.
> >>
> >> Using a single operation for copy-offloading instead of separate
> >> operations for reading and writing is fundamentally incompatible with
> >> the device mapper. I think we need a copy-offloading implementation that
> >> is compatible with the device mapper.
> >>
> >
> > While each read/write command is for a single contiguous range of
> > device, with simple-copy we get to operate on multiple discontiguous
> > ranges, with a single command.
> > That seemed like a good opportunity to reduce control-plane traffic
> > (compared to read/write operations) as well.
> >
> > With a separate read-and-write bio approach, each source-range will
> > spawn at least one read, one write and eventually one SCC command. And
> > it only gets worse as there could be many such discontiguous ranges (for
> > GC use-case at least) coming from user-space in a single payload.
> > Overall sequence will be
> > - Receive a payload from user-space
> > - Disassemble into many read-write pair bios at block-layer
> > - Assemble those (somehow) in NVMe to reduce simple-copy commands
> > - Send commands to device
> >
> > We thought payload could be a good way to reduce the
> > disassembly/assembly work and traffic between block-layer to nvme.
> > How do you see this tradeoff?  What seems necessary for device-mapper
> > usecase, appears to be a cost when device-mapper isn't used.
> > Especially for SCC (since copy is within single ns), device-mappers
> > may not be too compelling anyway.
> >
> > Must device-mapper support be a requirement for the initial support atop SCC?
> > Or do you think it will still be a progress if we finalize the
> > user-space interface to cover all that is foreseeable.And for
> > device-mapper compatible transport between block-layer and NVMe - we
> > do it in the later stage when NVMe too comes up with better copy
> > capabilities?
>
> Hi Kanchan,
>
> These days there might be more systems that run the device mapper on top
> of the NVMe driver or a SCSI driver than systems that do use the device
> mapper. It is common practice these days to use dm-crypt on personal
> workstations and laptops. LVM (dm-linear) is popular because it is more
> flexible than a traditional partition table. Android phones use
> dm-verity on top of hardware encryption. In other words, not supporting
> the device mapper means that a very large number of use cases is
> excluded. So I think supporting the device mapper from the start is
> important, even if that means combining individual bios at the bottom of
> the storage stack into simple copy commands.
>
> Thanks,
>
> Bart.
>
