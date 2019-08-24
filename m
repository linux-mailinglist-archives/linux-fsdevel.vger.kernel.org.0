Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B33899BB58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 05:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfHXDSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 23:18:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40030 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfHXDSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 23:18:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id w16so7820384pfn.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2019 20:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XDGdcSXIqyLF2qZ43wb756VbO6pNmebjNMnWc+tm5r4=;
        b=vVkcS0BH1V3C7/yaOR0KizQZ/EGsGfBWmtOyOkj5sVrYjRJfkvjsaNZT240Pq7uTvl
         LTWIq57t2cfCpi/xbmO7BvVlBJn93Y/u4o842j3+0pYPYXsBoTRq134I8cdJ+cc8puqV
         b0LGAYW6aIYp3w0Nh5bdGHqxQu8ZJNFRowvmGorsZ9cgDYsXeIxtiMk5zLHbnRTZpZTl
         gXUL+8BxPNtoZqvhimksXZUaGXSpfkPMLOiRw0B2CnfX2CP8ycJV4shtnR/+xqTXgtdt
         h27KfT+YraZz+g+TbnRJtdJxQYFS9xsphKM6E15brPmLCpMQdCM8YunfEA04aj46i0ye
         Sh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XDGdcSXIqyLF2qZ43wb756VbO6pNmebjNMnWc+tm5r4=;
        b=AkaDD+KTY+/m20IeWuW33iDazFSnuL6UC+NZCcPEm+iXJWn9N7c3ZUR8GlgDZXCQiY
         Z2ijZ0ABhyUuoq/y5wc7DvRghDQnd2KQU2BDHNVCbGueEq6G7b5tSBwc2bf5McswuzgC
         F/Q1mKElL0j32eKHkCt4XlslxBBnofS5LArTewHdUB8AItWPqAMK1TH7LtXjE8EnphdC
         0e2PIepHpFMFV8g949bvuJJ4wF7etXwiuWxb/I8wfqW4kxX9mMV5Ewc+oXCopMHMbJ4d
         d25r4vWgmaiqoiN9H1iz7uGZFMiws0h+IXwbWd7+eJVPN8NylBFQFczJjnbzkplRJX3Z
         nSlg==
X-Gm-Message-State: APjAAAVvSyXicBWLwR+zlEboRJzbfhrfMqVG5b7hxvahZUUfCs0KLtC+
        gkpFAYqrR/GVL19tvZXUF8eO
X-Google-Smtp-Source: APXvYqwhKmqG0S7uZCKEa+SXvnIdTU5R2pSMzZyYYcUHuahJVlklR9GLTUg5uhWq/Fs0FkS1KV4D+w==
X-Received: by 2002:a17:90a:d146:: with SMTP id t6mr8549240pjw.76.1566616719260;
        Fri, 23 Aug 2019 20:18:39 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id f63sm4695894pfa.144.2019.08.23.20.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 20:18:38 -0700 (PDT)
Date:   Sat, 24 Aug 2019 13:18:31 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, aneesh.kumar@linux.ibm.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190824031830.GB2174@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
 <20190821131405.GC24417@poseidon.bobrowski.net>
 <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 07:41:25PM +0530, Ritesh Harjani wrote:
> 
> 
> On 8/22/19 5:30 PM, Matthew Bobrowski wrote:
> > On Wed, Aug 21, 2019 at 11:14:07PM +1000, Matthew Bobrowski wrote:
> > > On Tue, Aug 13, 2019 at 05:57:22PM +0530, RITESH HARJANI wrote:
> > > > But what I meant was this (I may be wrong here since I haven't
> > > > really looked into it), but for my understanding I would like to
> > > > discuss this -
> > > > 
> > > > So earlier with this flag(EXT4_STATE_DIO_UNWRITTEN) we were determining on
> > > > whether a newextent can be merged with ex1 in function
> > > > ext4_extents_can_be_merged. But now since we have removed that flag we have
> > > > no way of knowing that whether this inode has any unwritten extents or not
> > > > from any DIO path.
> > > > 
> > > > What I meant is isn't this removal of setting/unsetting of
> > > > flag(EXT4_STATE_DIO_UNWRITTEN) changing the behavior of this func -
> > > > ext4_extents_can_be_merged?
> > > 
> > > OK, I'm stuck and looking for either clarity, revalidation of my
> > > thought process, or any input on how to solve this problem for that
> > > matter.
> > > 
> > > In the current ext4 direct IO implementation, the dynamic state flag
> > > EXT4_STATE_DIO_UNWRITTEN is set/unset for synchronous direct IO
> > > writes. On the other hand, the flag EXT4_IO_END_UNWRITTEN is set/unset
> > > for ext4_io_end->flag, and the value of i_unwritten is
> > > incremented/decremented for asynchronous direct IO writes. All
> > > mechanisms by which are used to track and determine whether the inode,
> > > or an IO in flight against a particular inode have any pending
> > > unwritten extents that need to be converted after the IO has
> > > completed. In addition to this, we have ext4_can_extents_be_merged()
> > > performing explicit checks against both EXT4_STATE_DIO_UNWRITTEN and
> > > i_unwritten and using them to determine whether it can or cannot merge
> > > a requested extent into an existing extent.
> > > 
> > > This is all fine for the current direct IO implementation. However,
> > > while switching the direct IO code paths over to make use of the iomap
> > > infrastructure, I believe that we can no longer simply track whether
> > > an inode has unwritten extents needing to be converted by simply
> > > setting and checking the EXT4_STATE_DIO_UNWRITTEN flag on the
> > > inode. The reason being is that there can be multiple direct IO
> > > operations to unwritten extents running against the inode and we don't
> > > particularly distinguish synchronous from asynchronous writes within
> > > ext4_iomap_begin() as there's really no need. So, the only way to
> > > accurately determine whether extent conversion is deemed necessary for
> > > an IO operation whether it'd be synchronous or asynchronous is by
> > > checking the IOMAP_DIO_UNWRITTEN flag within the ->end_io()
> > > callback. I'm certain that this portion of the logic is correct, but
> > > we're still left with some issues when it comes to the checks that I
> > > previously mentioned in ext4_can_extents_be_merged(), which is the
> > > part I need some input on.
> > > 
> > > I was doing some thinking and I don't believe that making use of the
> > > EXT4_STATE_DIO_UNWRITTEN flag is the solution at all here. This is not
> > > only for reasons that I've briefly mentioned above, but also because
> > > of the fact that it'll probably lead to a lot of inaccurate judgements
> > > while taking particular code paths and some really ugly code that
> > > creeps close to the definition of insanity. Rather, what if we solve
> > > this problem by continuing to just use i_unwritten to keep track of
> > > all the direct IOs to unwritten against running against an inode?
> > > Within ext4_iomap_begin() post successful creation of unwritten
> > > extents we'd call atomic_inc(&EXT4_I(inode)->i_unwritten) and
> > > subsequently within the ->end_io() callback whether we take the
> > > success or error path we'd call
> > > atomic_dec(&EXT4_I(inode)->i_unwritten) accordingly? This way we can
> > > still rely on this value to be used in the check within
> > > ext4_can_extents_be_merged(). Open for alternate suggestions if anyone
> > > has any...
> > 
> > Actually, no...
> > 
> > I've done some more thinking and what I suggested above around the use
> > of i_unwritten will also not work properly. Using iomap
> > infrastructure, there is the possibility of calling into the
> > ->iomap_begin() more than once for a single direct IO operation. This
> > means that by the time we even get to decrementing i_unwritten in the
> > ->end_io() callback after converting the unwritten extents we're
> > already running the possibility of i_unwritten becoming unbalanced
> > really quickly and staying that way. This also means that the
> > statement checking i_unwritten in ext4_can_extents_be_merged() will be
> > affected and potentially result in it being evaluated incorrectly. I
> > was thinking that we could just decrement i_unwritten in
> > ->iomap_end(), but that seems to me like it would be racy and also
> > lead to incorrect results. At this point I'm out of ideas on how to
> > solve this, so any other ideas would be appreciated!
> 
> I will let others also comment, if someone has any other better approach.
> 
> 1. One approach is to add the infrastructure in iomap with
> iomap_dio->private which is filesystem specific pointer. This can be
> updated by filesystem in ->iomap_begin call into iomap->private.
> And in case of iomap_dio_rw, this iomap->private will be copied to
> iomap_dio->private if not already set.
> 
> But I think this will eventually become hacky in the sense when you will
> have to determine on whether the dio->private is already set or not when
> iomap_apply will be called second time. It will become a problem with AIO
> DIO in ext4 since we use i_unwritten which tells us whether there is any
> unwritten extent but it does not tell whether this unwritten extent is due
> to a DIRECT AIO DIO in progress or a buffered one.
> 
> So we can ignore this approach - unless you or someone else have some good
> design ideas to build on top of above.

I'm not sure whether _this_ is the solution or not, so let's maybe
wait for others to comment. One thing that I and probably the iomap
maintainers would like to avoid is adding any special case code to
iomap infrastructure, if possible. I mean, from what you suggest it
seems to be rather generic and not overly intrusive, although I know
for a fact that iomap infrastructure exists because stuff like
buffer_heads and the old direct IO code ended up accommodating so many
different edge cases making it almost unmodifiable and unmaintainable.

> 2. Second approach which I was thinking is to track only those extents which
> are marked unwritten and are under IO. This can be done in ext4_map_blocks.
> This way we will not have to track a particular inode has any unwritten
> extents or not, but it will be extent based.
> Something similar was also done a while ago. Do you think this approach will
> work in our case?
> 
> So with this extents will be scanned in extent status tree to see if any
> among those are under IO and are unwritten in func
> ext4_can_extents_be_merged.
> 
> https://patchwork.ozlabs.org/patch/1013837/

Maybe this would be a better approach and I think that it'd
work. Based upon what I read within in that thread there weren't
really any objections to the idea, although I can't see that it made
it upstream, so I may be missing something?

--M
