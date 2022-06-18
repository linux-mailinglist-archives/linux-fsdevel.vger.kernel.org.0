Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E40550384
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 10:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiFRIip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFRIio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 04:38:44 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADEB2251B;
        Sat, 18 Jun 2022 01:38:43 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id m30so2957395vkf.11;
        Sat, 18 Jun 2022 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uY0TpH6fhXPpvM9WbmSUlK+90F2lBqCcQkVTKLAuqF8=;
        b=DAoztmmFdBXZFL3yc0Hmfj7YDQBMJqpxMbcvvG+7J4Vsu3f7oCtkK2H/8QqoK91r5p
         ZYIVPPC8JWQvBZZKtW0JCJiXKop5psLuykTOyOzWhJxVglKBienlXdMqnLYuTBV8QezG
         lcUlT88q3BL4JtD3JWXECZUBsYa+e6ToLfD2TfosIqGduaw064bZz6CTCOwGaHCooZc8
         MJZUZ/w7yzlRyaTrZG5eVWGOkxbOBdtzQlfD3te1CfcqH6hV14W8cQbA4VEcgdTO+I5u
         Yg40EQCWEKI+wwJWVROZK5Cp/6Z+fIf+gfK+EdLCsrgxOOwY0OSHLmcoYW3GujSABViN
         igaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uY0TpH6fhXPpvM9WbmSUlK+90F2lBqCcQkVTKLAuqF8=;
        b=SaFnzRpmLGSzcF59ichYiK5TcS4Nxjz2cEO+19Ms3AePefOZ24m0ZMSqteFJbuCCVS
         YYV9+c1ZtjvEIFccIG4K/DUVwEUFnv0tDJF0iDI7xP6pQUP7JcKEuEDI/wXpur+i2745
         fcOvXA4iEZW6hjldGW+SYJd1sQ3VXrRXGqxafI9Lxe/qTIJaTwRQGt09rJrY5XHyhTSR
         FF7pLjELuRa2MuPTvQHdU9aRWcCvqwz7zfiIYvDkgz8IRlGtKHuoFXHMGkp5fmRfFWYj
         oHoXesFl984nEZJWjeEeIROJGyd5QOU3u0Vg9FkWIODXwqknbGrlOfFBrCgd54A8fk/z
         88cg==
X-Gm-Message-State: AJIora/5dxjwaLexoONt3sCYHmXsMlanmpTScp6xfmb47yVptGtRHEjQ
        M8YFLi6tPODnOB1umCuRoS7RmUk+z2Qz0sNczl0=
X-Google-Smtp-Source: AGRyM1sWnR2nroXroTyTRQrujcDU4cOBvdAnbB8/E0FI42lW7c5wI8sG7+bWTg8Nkarc6LdYBeUgBVilbnv++SDezM0=
X-Received: by 2002:a1f:e044:0:b0:36b:e8e4:176f with SMTP id
 x65-20020a1fe044000000b0036be8e4176fmr824111vkg.11.1655541521607; Sat, 18 Jun
 2022 01:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190404165737.30889-1-amir73il@gmail.com> <20190404211730.GD26298@dastard>
 <CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com>
 <20190407232728.GF26298@dastard> <CAOQ4uxgD4ErSUtbu0xqb5dSm_tM4J92qt6=hGH8GRc5KNGqP9A@mail.gmail.com>
 <20190408141114.GC15023@quack2.suse.cz> <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz> <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3>
In-Reply-To: <20220617151135.yc6vytge6hjabsuz@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 18 Jun 2022 11:38:30 +0300
Message-ID: <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw workload
To:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 6:11 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 17-06-22 17:48:08, Amir Goldstein wrote:
> > On Tue, Apr 9, 2019 at 11:26 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 08-04-19 20:41:09, Amir Goldstein wrote:
> > > > On Mon, Apr 8, 2019 at 5:11 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Mon 08-04-19 12:02:34, Amir Goldstein wrote:
> > > > > > On Mon, Apr 8, 2019 at 2:27 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 05, 2019 at 05:02:33PM +0300, Amir Goldstein wrote:
> > > > > > > > On Fri, Apr 5, 2019 at 12:17 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Apr 04, 2019 at 07:57:37PM +0300, Amir Goldstein wrote:
> > > > > > > > > > This patch improves performance of mixed random rw workload
> > > > > > > > > > on xfs without relaxing the atomic buffered read/write guaranty
> > > > > > > > > > that xfs has always provided.
> > > > > > > > > >
> > > > > > > > > > We achieve that by calling generic_file_read_iter() twice.
> > > > > > > > > > Once with a discard iterator to warm up page cache before taking
> > > > > > > > > > the shared ilock and once again under shared ilock.
> > > > > > > > >
> > > > > > > > > This will race with thing like truncate, hole punching, etc that
> > > > > > > > > serialise IO and invalidate the page cache for data integrity
> > > > > > > > > reasons under the IOLOCK. These rely on there being no IO to the
> > > > > > > > > inode in progress at all to work correctly, which this patch
> > > > > > > > > violates. IOWs, while this is fast, it is not safe and so not a
> > > > > > > > > viable approach to solving the problem.
> > > > > > > > >
> > > > > > > >
> > > > > > > > This statement leaves me wondering, if ext4 does not takes
> > > > > > > > i_rwsem on generic_file_read_iter(), how does ext4 (or any other
> > > > > > > > fs for that matter) guaranty buffered read synchronization with
> > > > > > > > truncate, hole punching etc?
> > > > > > > > The answer in ext4 case is i_mmap_sem, which is read locked
> > > > > > > > in the page fault handler.
> > > > > > >
> > > > > > > Nope, the  i_mmap_sem is for serialisation of /page faults/ against
> > > > > > > truncate, holepunching, etc. Completely irrelevant to the read()
> > > > > > > path.
> > > > > > >
> > > > > >
> > > > > > I'm at lost here. Why are page faults completely irrelevant to read()
> > > > > > path? Aren't full pages supposed to be faulted in on read() after
> > > > > > truncate_pagecache_range()?
> > > > >
> > > > > During read(2), pages are not "faulted in". Just look at
> > > > > what generic_file_buffered_read() does. It uses completely separate code to
> > > > > add page to page cache, trigger readahead, and possibly call ->readpage() to
> > > > > fill the page with data. "fault" path (handled by filemap_fault()) applies
> > > > > only to accesses from userspace to mmaps.
> > > > >
> > > >
> > > > Oh! thanks for fixing my blind spot.
> > > > So if you agree with Dave that ext4, and who knows what other fs,
> > > > are vulnerable to populating page cache with stale "uptodate" data,
> > >
> > > Not that many filesystems support punching holes but you're right.
> > >
> > > > then it seems to me that also xfs is vulnerable via readahead(2) and
> > > > posix_fadvise().
> > >
> > > Yes, this is correct AFAICT.
> > >
> > > > Mind you, I recently added an fadvise f_op, so it could be used by
> > > > xfs to synchronize with IOLOCK.
> > >
> > > And yes, this should work.
> > >
> > > > Perhaps a better solution would be for truncate_pagecache_range()
> > > > to leave zeroed or Unwritten (i.e. lazy zeroed by read) pages in page
> > > > cache. When we have shared pages for files, these pages could be
> > > > deduped.
> > >
> > > No, I wouldn't really mess with sharing pages due to this. It would be hard
> > > to make that scale resonably and would be rather complex. We really need a
> > > proper and reasonably simple synchronization mechanism between operations
> > > removing blocks from inode and operations filling in page cache of the
> > > inode. Page lock was supposed to provide this but doesn't quite work
> > > because hole punching first remove pagecache pages and then go removing all
> > > blocks.
> > >
> > > So I agree with Dave that going for range lock is really the cleanest way
> > > forward here without causing big regressions for mixed rw workloads. I'm
> > > just thinking how to best do that without introducing lot of boilerplate
> > > code into each filesystem.
> >
> > Hi Jan, Dave,
> >
> > Trying to circle back to this after 3 years!
> > Seeing that there is no progress with range locks and
> > that the mixed rw workloads performance issue still very much exists.
> >
> > Is the situation now different than 3 years ago with invalidate_lock?
>
> Yes, I've implemented invalidate_lock exactly to fix the issues you've
> pointed out without regressing the mixed rw workloads (because
> invalidate_lock is taken in shared mode only for reads and usually not at
> all for writes).
>
> > Would my approach of pre-warm page cache before taking IOLOCK
> > be safe if page cache is pre-warmed with invalidate_lock held?
>
> Why would it be needed? But yes, with invalidate_lock you could presumably
> make that idea safe...

To remind you, the context in which I pointed you to the punch hole race issue
in "other file systems" was a discussion about trying to relax the
"atomic write"
POSIX semantics [1] of xfs.

There was a lot of discussions around range locks and changing the fairness
of rwsem readers and writer, but none of this changes the fact that as long as
the lock is file wide (and it does not look like that is going to
change in the near
future), it is better for lock contention to perform the serialization
on page cache
read/write and not on disk read/write.

Therefore, *if* it is acceptable to pre-warn page cache for buffered read
under invalidate_lock, that is a simple way to bring the xfs performance with
random rw mix workload on par with ext4 performance without losing the
atomic write POSIX semantics. So everyone can be happy?

In addition to Dave's concerns about stale page cache races with hole punch,
I found in the original discussion these concern from Darrick:

> Reads and writes are not the only thing xfs uses i_rwsem to synchronise.
> Reflink remap uses it to make sure everything's flushed to disk and that
> page cache contents remain clean while the remap is ongoing. I'm pretty
> sure pnfs uses it for similar reasons when granting and committing write
> leases.

To reiterate, pNFS leases are not the common case. To address this issue,
I intend to opt-out of pre-warm optimization when pNFS leases are present,
either globally, or per file, whatever xfs developers tell me to do.

From my understanding of the code, xfs_reflink_remap_prep() takes care
of taking invalidate_lock(s), so populating page cache under invalidate_lock
should be safe also w.r.t reflink/dedupe.

Darrick, am I missing anything?

Thanks,
Amir.

[1] https://lore.kernel.org/all/CAOQ4uxgSc7hK1=GuUajzG1Z+ks6gzFFX+EtuBMULOk0s85zi3A@mail.gmail.com/
[2] https://lore.kernel.org/linux-xfs/20190325154731.GT1183@magnolia/
