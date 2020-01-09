Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824081356BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 11:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAIKTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 05:19:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46722 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAIKTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:19:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so4758706lfl.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yc4QpQbWMkHB15aVjvX5Uf8UyPL+iSSMmYHHhc2yIwo=;
        b=uYzxlv0MH3lWrOqNXTAMC4nSdMn9kXVD7TITYZVX48fhAILr+2N98aficvb6pw7P8p
         0gxJxLCckWdMKiUatQOJ0Nh5o8Xp7tu7YWcluC8wIQj7ZAa7FvXvMolQGh0gMSGueuh6
         oAbECXOL8iUN6kDN+PdXcAstydIMeZCq+cmGmT6MLgXss5c8N0Rgz689E6tMxquB/HoK
         m/NGGSky1xcDkq+0suKtbTwkebL2+gjO51iEwBBnMoV5ZHhAKdD/pkK+M8IBEwJM5UGe
         P11aPxWK1Di+Y9gCax0lRgRyMwlj52m8QVGfQM9Eh59vwTjDUaR1/LCLBqMJoDlIO3p+
         nNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yc4QpQbWMkHB15aVjvX5Uf8UyPL+iSSMmYHHhc2yIwo=;
        b=qdPo00nN7sMpQOgVF8Bzy9RC+SPOoZK1C48X9CKV8ao6ra8P0w7U5BXYxFPrtMURPV
         L3pAiOyxkVyXpq/d/KZQtZ7lhib+AlC+VYZIA7CeRmqv9VVHPfVLuuL+9UuD9EC8UBxe
         tgJ4j3drT7nKeE5fC8FVC/XE3f1bTCSaIi5A6llNvnImDZ8NQc6xfgckVm1WQP4WyXm8
         oKBFnW2ATxL+scCZO996vpr21dyxxC2j66RAnNst37AUJxbzVIqQQTuh6x4O4A8tF07p
         c4A6l1faoFkaRZLDvFY99ZYAU9CidkGnQIJaM4v2aKY6PeFT39qGXWOexsJQZhvfbGWV
         dUBw==
X-Gm-Message-State: APjAAAV7nHQbglDkYUNzGdMtJxq71Vy45HKqgpZqPujmWyjlO484r37h
        JUoVLPpqB3Jog+Zp7juh/CZ5/gX+4/rSOnLoUMsI5g==
X-Google-Smtp-Source: APXvYqxmGTVUfoDgWWWDW+R4ESIx2uJCdDcI1Lqi+Tz0MO4cyGhe0CQU0VdfHQ5e1HYKYj1OvVtzWjMUcdBgFrHWbCU=
X-Received: by 2002:a19:850a:: with SMTP id h10mr5795499lfd.89.1578565176867;
 Thu, 09 Jan 2020 02:19:36 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Thu, 9 Jan 2020 11:19:25 +0100
Message-ID: <CANr-nt0=C+1v=1MU6eNhX0-X4CEvc7D2UEF02oRMNHraQ1FRow@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Omar Sandoval <osandov@fb.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 6:50 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Adding Damien to this thread.
> On 12/10/2019 10:17 PM, Chaitanya Kulkarni wrote:
> > Hi,
> >
> > * Background:-
> > -----------------------------------------------------------------------
> >
> > Linux Kernel Block layer now supports new Zone Management operations
> > (REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).
> >
> > These operations are added mainly to support NVMe Zoned Namespces
> > (ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,
> > user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,
> > Device-mapper in order to support these devices in the field.
> >
> > Over the years Linux kernel block layer tracing infrastructure
> > has proven to be not only extremely useful but essential for:-
> >
> > 1. Debugging the problems in the development of kernel block drivers.
> > 2. Solving the issues at the customer sites.
> > 3. Speeding up the development for the file system developers.
> > 4. Finding the device-related issues on the fly without modifying
> >      the kernel.
> > 5. Building white box test-cases around the complex areas in the
> >      linux-block layer.
> >
> > * Problem with block layer tracing infrastructure:-
> > -----------------------------------------------------------------------
> >
> > If blktrace is such a great tool why we need this session for ?
> >
> > Existing blktrace infrastructure lacks the number of free bits that are
> > available to track the new trace category. With the addition of new
> > REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can
> > track more number of requests.

In addition to tracing the zone operations, it would be greatly
beneficial to add tracing(and blktrace support) for the reported zone
states.
I did something similar[5] for pblk and open channel chunk states, and
that proved invaluable when figuring out whether the disk or pblk was
broken.

In pblk the reported chunk state transitions are traced along with the
expected zone transitions (based on io and management commands
submitted).

[5] https://www.lkml.org/lkml/2018/8/29/457

Thanks!
Hans

> >
> > * Current state of the work:-
> > -----------------------------------------------------------------------
> >
> > RFC implementations [3] has been posted with the addition of new IOCTLs
> > which is far from the production so that it can provide a basis to get
> > the discussion started.
> >
> > This RFC implementation provides:-
> > 1. Extended bits to track new trace categories.
> > 2. Support for tracing per trace priorities.
> > 3. Support for priority mask.
> > 4. New IOCTLs so that user-space tools can setup the extensions.
> > 5. Ability to track the integrity fields.
> > 6. blktrace and blkparse implementation which supports the above
> >      mentioned features.
> >
> > Bart and Martin has suggested changes which I've incorporated in the RFC
> > revisions.
> >
> > * What we will discuss in the proposed session ?
> > -----------------------------------------------------------------------
> >
> > I'd like to propose a session for Storage track to go over the following
> > discussion points:-
> >
> > 1. What is the right approach to move this work forward?
> > 2. What are the other information bits we need to add which will help
> >      kernel community to speed up the development and improve tracing?
> > 3. What are the other tracepoints we need to add in the block layer
> >      to improve the tracing?
> > 4. What are device driver callbacks tracing we can add in the block
> >      layer?
> > 5. Since polling is becoming popular what are the new tracepoints
> >      we need to improve debugging ?
> >
> >
> > * Required Participants:-
> > -----------------------------------------------------------------------
> >
> > I'd like to invite block layer, device drivers and file system
> > developers to:-
> >
> > 1. Share their opinion on the topic.
> > 2. Share their experience and any other issues with blktrace
> >      infrastructure.
> > 3. Uncover additional details that are missing from this proposal.
> >
> > Regards,
> > Chaitanya
> >
> > References :-
> >
> > [1] https://www.spinics.net/lists/linux-block/msg46043.html
> > [2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
> > namespaces-zns-as-go-to-industry-technology/
> > [3] https://www.spinics.net/lists/linux-btrace/msg01106.html
> >       https://www.spinics.net/lists/linux-btrace/msg01002.html
> >       https://www.spinics.net/lists/linux-btrace/msg01042.html
> >       https://www.spinics.net/lists/linux-btrace/msg00880.html
> >
>
