Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032294A6BD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 07:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245044AbiBBGxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 01:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244742AbiBBGwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:38 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D8C06173E;
        Tue,  1 Feb 2022 21:58:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so5003774pjp.0;
        Tue, 01 Feb 2022 21:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZQskbfglYds00Lw2LuF1T37UDp3X/4QsTuyYVY49D4=;
        b=V2UAimiTGBYdn7kGrIea/5T4KORuUdOl9CZJ9G7Z1E9uP+BetrhT2YyHl8BIMLY6Ga
         3J8s3R3xiuvvDKHAIr5bDSv67Dfe6RbEbVb/rLUKdpgBaHCROr66xcWpxWHknnZgox4D
         p75MB7kRK07FM2GbTzqpjrWzHCoINGRAy4TUQModN4fLnmngfDUWie76+5xOByFdQHNl
         5cmw+Z73ArAGEWNVMJnzebbpGyqKXL7/aMsldgd1Srd9Aa/BRbI+M4DBCWLeZ4QoIiqt
         Fv2PQkYjqiMf7p72wvIh+ADbl3I3Sdru7C8+CDuh9TZhiaW3bsZQPHjmVOf7eRVYhDxS
         F4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZQskbfglYds00Lw2LuF1T37UDp3X/4QsTuyYVY49D4=;
        b=y50EEc3BWdGyuyRvVYgq4rdrhiznifT19QSZZuapojS2SEdAxoRixfELkrevRPScys
         +VJfBx0nc6BuvskirNV8A5v5oxLI3Msx6YVbUe6vfl/+tGKwFCi61dHjEe5LZn3apZvb
         3M+sTuNAkURJdXzsLkagR/HQwbKFU+PdrxYOAmKH+UIib/bPlZUp5hZScilHqpg6JJR7
         K3sizFHS2ZZGbIiunqAQKdaAMT/GJ1d88VuyEDbz2ZQPi+ASx+9iaC7oZ38diba9JR+B
         gR9/X6zcpqWYmkDE/7EpTIiv5dMb6Z2eDwPijs5G5JOhYwfqvwn+8GJPYrWrraSOEhds
         ysCQ==
X-Gm-Message-State: AOAM532oEGCI3d4OmiA833fu92Fpzr+CQGiivmHZxgCCMfPQ6pauzYwG
        XWwqoODxsncVTvHFHYNNvDWEyYalFvzUQ3ddhZE=
X-Google-Smtp-Source: ABdhPJyeBo4k/TNkTynsMQzGTravvy1ipnwIWve44CKgxgd4qgZ2/EjFAto44bCHIwoCs/6vMk7KTjcopXMkjlGETB4=
X-Received: by 2002:a17:902:c652:: with SMTP id s18mr29246528pls.1.1643781483598;
 Tue, 01 Feb 2022 21:58:03 -0800 (PST)
MIME-Version: 1.0
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Wed, 2 Feb 2022 11:27:36 +0530
Message-ID: <CA+1E3rJhT_mXiJHWJF14BeE8mz2vRaz4D0gpZRxPJzwr4S-EbQ@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:51 PM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> Hi,
>
> * Background :-
> -----------------------------------------------------------------------
>
> Copy offload is a feature that allows file-systems or storage devices
> to be instructed to copy files/logical blocks without requiring
> involvement of the local CPU.
>
> With reference to the RISC-V summit keynote [1] single threaded
> performance is limiting due to Denard scaling and multi-threaded
> performance is slowing down due Moore's law limitations. With the rise
> of SNIA Computation Technical Storage Working Group (TWG) [2],
> offloading computations to the device or over the fabrics is becoming
> popular as there are several solutions available [2]. One of the common
> operation which is popular in the kernel and is not merged yet is Copy
> offload over the fabrics or on to the device.
>
> * Problem :-
> -----------------------------------------------------------------------
>
> The original work which is done by Martin is present here [3]. The
> latest work which is posted by Mikulas [4] is not merged yet. These two
> approaches are totally different from each other. Several storage
> vendors discourage mixing copy offload requests with regular READ/WRITE
> I/O. Also, the fact that the operation fails if a copy request ever
> needs to be split as it traverses the stack it has the unfortunate
> side-effect of preventing copy offload from working in pretty much
> every common deployment configuration out there.
>
> * Current state of the work :-
> -----------------------------------------------------------------------
>
> With [3] being hard to handle arbitrary DM/MD stacking without
> splitting the command in two, one for copying IN and one for copying
> OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> candidate. Also, with [4] there is an unresolved problem with the
> two-command approach about how to handle changes to the DM layout
> between an IN and OUT operations.
>
> We have conducted a call with interested people late last year since
> lack of LSFMMM and we would like to share the details with broader
> community members.

I'm keen on this topic and would like to join the F2F discussion.
The Novmber call did establish some consensus on requirements.
Planning to have a round or two of code-discussions soon.


Thanks,
-- 
Kanchan
