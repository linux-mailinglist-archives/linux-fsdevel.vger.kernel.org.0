Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954A7FD78E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 09:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKOIFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 03:05:01 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42926 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfKOIFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:05:00 -0500
Received: by mail-il1-f196.google.com with SMTP id n18so8397400ilt.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2019 00:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMbMATibPBM0co5FG9GFyuRV+GOBOh2GM3ufKgisCZ0=;
        b=cJnEXn1F4OR1rTSnQMIv7C2EMxU1xW+Zg+K/s6Z3dxkxSuTPqdUAwX9FShcT5FxLdx
         x1GNRtmS51ilDsI+waGr5hVlNuRnycYjTX9PQC9B/nHpzsNRnJCcEpFjkJ3LOEG+XAMd
         YIj2j88AFsR4bvzt/AI7EhvvpWnGJoMaWvdL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMbMATibPBM0co5FG9GFyuRV+GOBOh2GM3ufKgisCZ0=;
        b=YXaEfv6vBLDNeeA1YL+GXhjO1hQDPaagHU69xzhTxdRBi5THPtoYCIrJO67sX0Bz2M
         vJzYn4LXmoLXfOkYkTqVOQ65NI0B5HjxV5TGm6WgPZrrXiyPFPDIAY0CMubxBHC09bDy
         o8A03jti9Y7SWHK0Ad3FM8C8FRZaky37Io0BeHtpzkqz8XcQKgvodt9WXHCSmoSK0C/O
         BuLE7Y2k5GdyGqHwTjMeOvpqScDh+jutBEhUGIVVTo3p9OiLJf7julEgmF4/dRYQXIo2
         IINCI5cTnNZ7lQzVRBvhCvFeeMpvx0W0hKPRs4WcxVCg8g2QaDPktkNKg3We5L3U+W4S
         10aA==
X-Gm-Message-State: APjAAAX0VNJ0Pms/qcWQ4D8GvaHx93wd1x3l767boOgRF/VdEfXXM+n/
        qglGepr1XfqmVWmS/uW4TnCzDklkuv7zmCOCvAr4AQ==
X-Google-Smtp-Source: APXvYqxhsEi3ITaM3ZAi2OAPrOgiRFPRnWgsQ5axIUBoPbmVzi82h6sr+qgbCiQ0Hm/G8dAOaZpQjW0vc8xwIraHzGw=
X-Received: by 2002:a92:6407:: with SMTP id y7mr13745597ilb.285.1573805097714;
 Fri, 15 Nov 2019 00:04:57 -0800 (PST)
MIME-Version: 1.0
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
 <20191024023606.GA1884@infradead.org> <20191029160733.298c6539@canb.auug.org.au>
 <514e220d-3f93-7ce3-27cd-49240b498114@plexistor.com> <CAJfpegtT-nX7H_-5xpkP+fp8LfdVGbSTfnNf-c=a_EfOd3R5tA@mail.gmail.com>
 <e723e3cc-210a-4d6d-af86-b3a9c94cb379@plexistor.com>
In-Reply-To: <e723e3cc-210a-4d6d-af86-b3a9c94cb379@plexistor.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 15 Nov 2019 09:04:46 +0100
Message-ID: <CAJfpegsnuJANxUesWfWPBWw2pc+XtJJfRMfqxfYHB3ee1o2ZZA@mail.gmail.com>
Subject: Re: Please add the zuf tree to linux-next
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 5:04 PM Boaz Harrosh <boaz@plexistor.com> wrote:
>
> On 14/11/2019 16:56, Miklos Szeredi wrote:
> > On Thu, Nov 14, 2019 at 3:02 PM Boaz Harrosh <boaz@plexistor.com> wrote:
> >
> >> At the last LSF. Steven from Red-Hat asked me to talk with Miklos about the fuse vs zufs.
> >> We had a long talk where I have explained to him in detail How we do the mounting, how
> >> Kernel owns the multy-devices. How we do the PMEM API and our IO API in general. How
> >> we do pigi-back operations to minimize latencies. How we do DAX and mmap. At the end of the
> >> talk he said to me that he understands how this is very different from FUSE and he wished
> >> me "good luck".
> >>
> >> Miklos - you have seen both projects; do you think that All these new subsystems from ZUFS
> >> can have a comfortable place under FUSE, including the new IO API?
> >
> > It is quite true that ZUFS includes a lot of innovative ideas to
> > improve the performance of a certain class of userspace filesystems.
> > I think most, if not all of those ideas could be applied to the fuse
> > implementation as well,
>
> This is not so:
>
> - The way we do the mount is very different. It is not the Server that does
>   The mount but the Kernel. So auto bind mount works (same device different dir)

This is not a significant difference.  I.e. the following could be
added to the fuse protocol to optionally operate this way:

- server registers filesystem at startup, does not perform any mount
(sends FUSE_NOTIFY_REGISTER)
- on mount kernel sends a FUSE_FS_LOOKUP message, server looks up or
creates filesystem instance and returns a filesystem ID
- filesystem ID is sent in further message headers (there's a 32bit
spare field where this fits nicely)

> - The way zuf owns the devices in the Kernel, and supports multi-devices.

Same as above, one server process could handle as many filesystem
instances (possibly of different type) as necessary.

>   And has support for pmem devices as well as what we call t2 (regular) block
>   devices. And the all API for transfer between them. (The all md.* thing).

Extending the protocol to pass reference to pmem or any other device
is certainly possible.  See the  FUSE2_DEV_IOC_MAP_OPEN in the
prototype.

>   Proper locking of devices.

Care to explain?

> - The way we are true zero-copy both pmem and t2.

See FUSE_MAP request in fuse2 prototype.

> - The way we are DAX both pwrite and mmap.

This is not implemented yet in the prototype, but there's nothing
preventing the mapping returned by the FUSE_MAP request to be cached
and used for mmap and  I/O without any further exchanges with server.

> - The way we are NUMA aware both Kernel and Server.

I've tested the prototype on huge NUMA systems, and it certainly was
very scalable.

> - The way we use shared memory pools that are deep in the protocol between
>   Server and Kernel for zero copy of meta-data as well as protocol buffers.

Again, the fuse2 prototype uses shared memory for communication, and
this helps (though not as much as CPU locality).

> - The way we do pigy-back of operations to save round-trips.

It is not difficult to extend the FUSE protocol to allow bundling of
several requests and replies.

> - The way we use cookies in Kernel of all Server objects so there are no
>   i_ino hash tables or look-ups.

I don't get that.  zuf_iget() calls iget_locked() which does the inode
hash lookup.

> - The way we use a single Server with loadable FS modules. That the ZUSD comes
>   with the distro and only the FS-pluging comes from Vendor. So Kernel=Server API
>   is in sync.

Same abstraction is provided by libfuse.  Pluggable fs modules are
also certainly possible, in fact libfuse already has something like
that: fuse_register_module().

> - The way ZUFS supports root filesystem.

Why is that a unique feature?

> - The way ZUFS supports VM-FS to SHARE same p-memory as HOST-FS
> - The way we do Zero-copy IO, both pmem and bdevs

I think these have been mentioned above already.

> > One of the major issues that I brought up when originally reviewing
> > ZUFS (but forgot to discuss at LSF) is about the userspace API.  I
> > think it would make sense to reuse FUSE protocol definition and extend
> > it where needed.   That does not mean ZUFS would need to be 100%
> > backward compatible with FUSE, it would just mean that we'd have a
> > common userspace API and each implementation could implement a subset
> > of features.
>
> This is easy to say. But believe me it is not possible. The shared structures
> are maybe 20% and not 80% as the theory might feel about it. The projects are
> really structured differently.

Well, I'm not saying it would be an easy job, just sthat doing a
rewrite with the already existing and well established API might well
pay off in the long run.

> I have looked at it long and hard, Many times. I do not know how to this.
> If I knew how I would.
>
> These codes and systems do very different things. It will need tones of
> if()s and operation changes. Sometimes you do a copy/paste of ext4 into
> ffs2 and so on. Because the combination is not always the best and the
> easiest.

Again, I'm not suggesting that you add zufs features to fuse.   I'm
suggesting that you implement zufs features with the fuse protocol,
extending it where needed, but keeping the basic format the same.

>
> > I think this would be an immediate and significant
> > boon for ZUFS, since it would give it an already existing user/tester
> > base that it otherwise needs to build up.  It would also allow
> > filesystem implementation to be more easily switchable between the
> > kernel frameworks in case that's necessary.
> >
>
> Thanks Miklos for your input. I have looked at this problems many times.
> This is not something that is interesting for me. Because these two projects
> come to solve different things.
>
> And it is not so easy to do as it sounds. There are fundamental difference
> between the projects. For example in fuse main() belongs to the FS. That needs
> to supply its own mount application. In ZUFS we do the regular Kernel's /sbin/mount.
> Also ZUS User-mode server has a huge facility for allocating pages, mlocking,
> per-cpu counters per-cpu variables, NUMA memory management. Thread management.
> The API with zuf is very very particular about tons of things. Involving threads
> and special files and mmap calls, and shared memory with Kernel. This will not be so
> easily interchangeable.

I hope to get around to do a review eventually.  API design is hard.
I know how many times I got it wrong in fuse, and how much pain that
has caused.

Thanks,
Miklos
