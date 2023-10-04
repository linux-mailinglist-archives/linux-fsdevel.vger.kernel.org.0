Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A159E7B96C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjJDWAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 18:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjJDWAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:00:05 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDDFC9
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 15:00:01 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57b811a6ce8so170264eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696456800; x=1697061600; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8zIzwqHlLY+Qfqxn8xlWssJN81SYfup2U1XurU6Xi68=;
        b=EEsBWVzU+YlG+VxpFQzcNAw2kIE3vUf5gEiwamx30JyP1rWhj/pWLF/x85MuAmm7Im
         Fhc+/iZ3ahszA46KKhd8KPeT640NJ03WDqLcsHiRqKwz5/VWRuZB6sH/HBE/YfQGqgDb
         ZZ/YaxLUoyI+SpuepUdLc+PydKCmt0FiiDDZEV60sVI/J2iBrSVVcs3UMpcbPmcGJYeN
         UF/3bNj5pVWbPRPKnuC0eX73dS9kLksZdcRMe1LIN5pEmI+OoymOInzcxOpaWbJOxXeN
         NYSTvh0x/PY4bdhoILNSCCtJw+rfNX2GorI9aHo5ErbMqkTsxPGLBYQbh6FbURpAYFjv
         B92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696456800; x=1697061600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zIzwqHlLY+Qfqxn8xlWssJN81SYfup2U1XurU6Xi68=;
        b=VfxCQfD+fM0QbhnJD634JdqgFCNhsOw9OBNvPkfHZAYZiIHMn609wUloHiTsBNdnKR
         Mgcpg4Vn0M6p2LR/VY1ktU6O1KG3P3kwsO3Dzdet2oX1he8ctlCQQzTAVaB4uWD8JbRn
         H9MYViJNnBQfczd9pXgxL42jgQvMJXgGznbmANSSNiIPFF6nuhTkA3XHn/3IjsOR6cOH
         /UuVIFWlYX9vexCSO9n+hxPtypadcxooXqJhxPjQgJ5Mnv2JhwkRYymiVQ3UQ71geU+V
         5sn8DqPXSNBkggNeOshleOIGoyc0EQrLh4gSAQ/PiTQhG8mdyOlEYj3ugs6qTQy1S+nD
         Nh2w==
X-Gm-Message-State: AOJu0Yw9x7kVCxCC+9QHX8QDA2VCqBW8EaSbE7dUeS1i5yBKW1fvXnmQ
        l+Gwzszb7RpoTMbvtUtTPhlAsg==
X-Google-Smtp-Source: AGHT+IH/h109J3vK2RjmtyBZliPuvZyDqqzD7Zzri4BtaZwGs/8k8SoTtzUNYozX75NqP2QFf8pgiw==
X-Received: by 2002:a05:6358:8a2:b0:14b:86a3:b3f0 with SMTP id m34-20020a05635808a200b0014b86a3b3f0mr3841093rwj.5.1696456800389;
        Wed, 04 Oct 2023 15:00:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a018900b00274a43c3414sm2236230pjc.47.2023.10.04.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 14:59:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qo9uO-009W7k-1F;
        Thu, 05 Oct 2023 08:59:56 +1100
Date:   Thu, 5 Oct 2023 08:59:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZR3gXHfIpn3eybh0@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
 <8e2f4aeb-e00e-453a-9658-b1c4ae352084@acm.org>
 <d981dea1-9851-6511-d101-22ea8d7fd31e@oracle.com>
 <e6c7b33c-38ba-402b-abdc-b783d4402402@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6c7b33c-38ba-402b-abdc-b783d4402402@acm.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:34:13AM -0700, Bart Van Assche wrote:
> On 10/4/23 02:14, John Garry wrote:
> > On 03/10/2023 17:45, Bart Van Assche wrote:
> > > On 10/3/23 01:37, John Garry wrote:
> > > > I don't think that is_power_of_2(write length) is specific to XFS.
> > > 
> > > I think this is specific to XFS. Can you show me the F2FS code that
> > > restricts the length of an atomic write to a power of two? I haven't
> > > found it. The only power-of-two check that I found in F2FS is the
> > > following (maybe I overlooked something):
> > > 
> > > $ git grep -nH is_power fs/f2fs
> > > fs/f2fs/super.c:3914:    if (!is_power_of_2(zone_sectors)) {
> > 
> > Any usecases which we know of requires a power-of-2 block size.
> > 
> > Do you know of a requirement for other sizes? Or are you concerned that
> > it is unnecessarily restrictive?
> > 
> > We have to deal with HW features like atomic write boundary and FS
> > restrictions like extent and stripe alignment transparent, which are
> > almost always powers-of-2, so naturally we would want to work with
> > powers-of-2 for atomic write sizes.
> > 
> > The power-of-2 stuff could be dropped if that is what people want.
> > However we still want to provide a set of rules to the user to make
> > those HW and FS features mentioned transparent to the user.
> 
> Hi John,
> 
> My concern is that the power-of-2 requirements are only needed for
> traditional filesystems and not for log-structured filesystems (BTRFS,
> F2FS, BCACHEFS).

Filesystems that support copy-on-write data (needed for arbitrary
filesystem block aligned RWF_ATOMIC support) are not necessarily log
structured. For example: XFS.

All three of the filesystems you list above still use power-of-2
block sizes for most of their metadata structures and for large data
extents. Hence once you go above a certain file size they are going
to be doing full power-of-2 block size aligned IO anyway. hence the
constraint of atomic writes needing to be power-of-2 block size
aligned to avoid RMW cycles doesn't really change for these
filesystems.

In which case, they can just set their minimum atomic IO size to be
the same as their block size (e.g. 4kB) and set the maximum to
something they can guarantee gets COW'd in a single atomic
transaction. What the hardware can do with REQ_ATOMIC IO is
completely irrelevant at this point....

> What I'd like to see is that each filesystem declares its atomic write
> requirements (in struct address_space_operations?) and that
> blkdev_atomic_write_valid() checks the filesystem-specific atomic write
> requirements.

That seems unworkable to me - IO constraints propagate from the
bottom up, not from the top down.

Consider multi-device filesystems (btrfs and XFS), where different
devices might have different atomic write parameters.  Which
set of bdev parameters does the filesystem report to the querying
bdev?  (And doesn't that question just sound completely wrong?)

It also doesn't work for filesystems that can configure extent
allocation alignment at an individual inode level (like XFS) - what
does the filesystem report to the device when it doesn't know what
alignment constraints individual on-disk inodes might be using?

That's why statx() vectors through filesystems to all them to set
their own parameters based on the inode statx() is being called on.
If the filesystem has a native RWF_ATOMIC implementation, it can put
it's own parameters in the statx min/max atomic write size fields.
If the fs doesn't have it's own native support, but can do physical
file offset/LBA alignment, then it publishes the block device atomic
support parameters or overrides them with it's internal allocation
alignment constraints. If the bdev doesn't support REQ_ATOMIC, the
filesystem says "atomic writes are not supported".

-Dave.
-- 
Dave Chinner
david@fromorbit.com
