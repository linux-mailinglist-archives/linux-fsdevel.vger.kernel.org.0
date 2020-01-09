Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3113617F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 21:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgAIUDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 15:03:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40266 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgAIUDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:03:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so7010451oib.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEPP3QvZTscWYv3Miihx0fBYyJilXweNv6Guj9B9KD8=;
        b=tavN+wgvdGNcOGcjKHqkAn5BjiXAReV94+OSH9Ri1PEiPT4LHVwg6b1hXbJyjtNOio
         yt+3CISS4TMH86U9kKgU8YPArehaT0FusWvpSVefSqnA63GewXNc+iMnr6ZN89GHlxNa
         I9xtBLZtZiieLaHNV/YWCS5IF2kdx6cBLmi6/YRneC/5UTcL8YKTe0qVGWfehSZnrWv9
         YsnAn85tdplqslZaJiAyOUvkKc3WlQ6ZG+UvCzJ00JIQxKAKUKINJoyIUTQOONSw3QOj
         1W72+PiwSitSGIes31XNdQt0P0T6DKzDvCP6YPxL/5GB664MG6OsTA5BfZF4LBGWHzr7
         Jvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEPP3QvZTscWYv3Miihx0fBYyJilXweNv6Guj9B9KD8=;
        b=ZVi2y4Z2+hzYJGdRePgRKEjsul30kS9ScvxGj0b4a4pC3BgQwv9/kCvB1LJioTHjsO
         G4VfUW2k08BhYaj9Dmgs13vCyr3fR+qJL6tSS//0GV1Zqny0bzRud28hneKxukxjdgvy
         a8FOc4CB6M4U4z9iW44jWzoXVlSZxhzJynem0Hucu3lbRYDUkRzIfB9xQIJpfYnTdnAx
         uzwTd7KiU0GVQYbDfw/mJQeAYuhjBVcee49eFz9sHQt6b6OT5zP3MyjLMx1Mbi77Wujp
         Jo1jcASAhCeU2gMZh3r0GT/RfMbLfFR8NylK7HZ6/snA5sIXMPbHzO5lF0BSBibUhBuy
         kMUg==
X-Gm-Message-State: APjAAAUp+E1DgB8AKmQkjO7Ml/qSADtQH+Qsh0R9vNZ8t3gXp7m+CBkE
        ca/zUQudf8LVafHcl1yBa0VqyrDntMjrjNYsUtZkxQ==
X-Google-Smtp-Source: APXvYqy8zIIpMCxwYPaK1lH7NGY047llhJ6X2TGv4+wlxidYTW8JIfkG1ylN1wkgzWx+t/HR+ipJvvJ3iI320Zd/2yQ=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr4809955oij.0.1578600191907;
 Thu, 09 Jan 2020 12:03:11 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz>
In-Reply-To: <20200109112447.GG27035@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jan 2020 12:03:01 -0800
Message-ID: <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Jan Kara <jack@suse.cz>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 9, 2020 at 3:27 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 07-01-20 10:49:55, Dan Williams wrote:
> > On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > > dax code refers back to block device to figure out partition offset in
> > > dax device. If we create a dax object corresponding to "struct block_device"
> > > and store sector offset in that, then we could pass that object to dax
> > > code and not worry about referring back to bdev. I have written some
> > > proof of concept code and called that object "dax_handle". I can post
> > > that code if there is interest.
> >
> > I don't think it's worth it in the end especially considering
> > filesystems are looking to operate on /dev/dax devices directly and
> > remove block entanglements entirely.
> >
> > > IMHO, it feels useful to be able to partition and use a dax capable
> > > block device in same way as non-dax block device. It will be really
> > > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > > will work.
> >
> > That can already happen today. If you do not properly align the
> > partition then dax operations will be disabled. This proposal just
> > extends that existing failure domain to make all partitions fail to
> > support dax.
>
> Well, I have some sympathy with the sysadmin that has /dev/pmem0 device,
> decides to create partitions on it for whatever (possibly misguided)
> reason and then ponders why the hell DAX is not working? And PAGE_SIZE
> partition alignment is so obvious and widespread that I don't count it as a
> realistic error case sysadmins would be pondering about currently.
>
> So I'd find two options reasonably consistent:
> 1) Keep status quo where partitions are created and support DAX.
> 2) Stop partition creation altogether, if anyones wants to split pmem
> device further, he can use dm-linear for that (i.e., kpartx).
>
> But I'm not sure if the ship hasn't already sailed for option 2) to be
> feasible without angry users and Linus reverting the change.

Christoph? I feel myself leaning more and more to the "keep pmem
partitions" camp.

I don't see "drop partition support" effort ending well given the long
standing "ext4 fails to mount when dax is not available" precedent.

I think the next least bad option is to have a dax_get_by_host()
variant that passes an offset and length pair rather than requiring a
later bdev_dax_pgoff() to recall the offset. This also prevents
needing to add another dax-device object representation.
