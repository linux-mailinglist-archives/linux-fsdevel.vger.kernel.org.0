Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213B114E906
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 08:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAaHBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 02:01:01 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36499 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAaHBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 02:01:00 -0500
Received: by mail-il1-f195.google.com with SMTP id b15so5311966iln.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 23:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQGMyysIAHIVUD/6knFjdLEpdoD5R3akeTYBR9gujSw=;
        b=BjJJ/mwqPN7nBQgk/WqjfPhU4t9E+g0hxfoJddxssl8IpcTxlm0cItgjyd4p/rU7qK
         pC444ZJPvvEup8RBfYBPqgKrjhiv3GjqqmI/aJp3bOIzURKBWpsWajpdI/6U19qXI88k
         n8vQOS9qQ4hxYpo8U4QPTy3T5G3bwjapbdCsxDOkas6Trd/f5p0NFVz31KXAZ+4nQH6j
         4hta+18PVp3RAm8YpeeL6fLaHeANVpG0062xp+9jCSZyhljRl2VFdSpV2EoQQSdNzdVs
         CDPY/iVnWWmNe1pz5ZdXbR6Th8ua2QxpIHcgQxS5i1nhT/HmZCcbRvkPANjDe7PkNqnN
         9G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQGMyysIAHIVUD/6knFjdLEpdoD5R3akeTYBR9gujSw=;
        b=dm/JLnC6wQXED6uvsrKbEDCIrRsKsXYt00l9NkN6Z9QfWfG2maH5R3a9qXpsr+BGhr
         iukoDxK3Lb+7rSkAXniaepvm68l/wy7U8/YK4nYvSIaXM0qRF4U/UHzJW2QdX/lOc4iN
         clA2MYOJI8QZSiDzzzS7fby95VkTNEnetwKkzdcZOuEGQjTL3zHKPwZR9oqDr2A8OGUr
         Uv9XabSdaQboZaoNNv1dBjusG3mMQoNoI0D99JEOv1aWUk/2mA1b6yDUEzSwk6t+EXoW
         GcbQK/H+3vLvnNc0RDqSA/T11+tFdTt6iNGEUJCpYxWphXRigSrMPynWfX9c6adLaZwE
         ef1Q==
X-Gm-Message-State: APjAAAUiYw6r4GrM/TZ1Ud29YtU91/igxM+mQ+BR8YLkeYWfO0akRZot
        F2pIWDf9nDMldBc6mgoPOGvSMAY8FGvnRGQj5Ag=
X-Google-Smtp-Source: APXvYqxlyucFws1QW+CjhtBOEB/Gu77AYsAlqV31aQd7i84dA2JafnQ6/T5rgaasxomyVm+BrWhWsqQxj+d5I8Kz6kw=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr1366949ilq.250.1580454058454;
 Thu, 30 Jan 2020 23:00:58 -0800 (PST)
MIME-Version: 1.0
References: <20200118004738.GQ8904@ZenIV.linux.org.uk> <20200118011734.GD295250@vader>
 <20200118022032.GR8904@ZenIV.linux.org.uk> <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader> <20200123034745.GI23230@ZenIV.linux.org.uk>
 <20200123071639.GA7216@dread.disaster.area> <CAOQ4uxhm3tqgqQPYpkeb635zRLR1CJFDUrwGuCZv1ntv+FszdA@mail.gmail.com>
 <20200124212546.GC7216@dread.disaster.area> <20200131052454.GA6868@magnolia>
In-Reply-To: <20200131052454.GA6868@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 31 Jan 2020 09:00:47 +0200
Message-ID: <CAOQ4uxj5ZWLALArKLE3eJLK_QmLdFpHNgP_etRpbK-Tn8-O+AQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 7:27 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Sat, Jan 25, 2020 at 08:25:46AM +1100, Dave Chinner wrote:
> > On Thu, Jan 23, 2020 at 09:47:30AM +0200, Amir Goldstein wrote:
> > > On Thu, Jan 23, 2020 at 9:16 AM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Thu, Jan 23, 2020 at 03:47:45AM +0000, Al Viro wrote:
> > > > > On Wed, Jan 22, 2020 at 02:10:03PM -0800, Omar Sandoval wrote:
> > > > >
> > > > > > > Sorry for not reading all the thread again, some API questions:
> > > > > > > - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
> > > > > >
> > > > > > I wasn't planning on having that restriction. It's not too much effort
> > > > > > for filesystems to support it for normal files, so I wouldn't want to
> > > > > > place an artificial restriction on a useful primitive.
> > > > >
> > >
> > > I have too many gray hairs each one for implementing a "useful primitive"
> > > that nobody asked for and bare the consequences.
> > > Your introduction to AT_REPLACE uses O_TMPFILE.
> > > I see no other sane use of the interface.
> > >
> > > > > I'm not sure; that's how we ended up with the unspeakable APIs like
> > > > > rename(2), after all...
> > > >
> > > > Yet it is just rename(2) with the serial numbers filed off -
> > > > complete with all the same data vs metadata ordering problems that
> > > > rename(2) comes along with. i.e. it needs fsync to guarantee data
> > > > integrity of the source file before the linkat() call is made.
> > > >
> > > > If we can forsee that users are going to complain that
> > > > linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
> > > > leaves zero length files behind after a crash just like rename()
> > > > does, then we haven't really improved anything at all...
> > > >
> > > > And, really, I don't think anyone wants another API that requires
> > > > multiple fsync calls to use correctly for crash-safe file
> > > > replacement, let alone try to teach people who still cant rename a
> > > > file safely how to use it....
> > > >
> > >
> > > Are you suggesting that AT_LINK_REPLACE should have some of
> > > the semantics I posted in this RFC  for AT_ATOMIC_xxx:
> > > https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/
> >
> > Not directly.
> >
> > All I'm pointing out is that data integrity guarantees of
> > AT_LINK_REPLACE are yet another aspect of this new feature that
> > has not yet been specified or documented at all.
> >
> > And in pointing this out, I'm making an observation that the
> > rename(2) behaviour which everyone seems to be assuming this
> > function will replicate is a terrible model to copy/reinvent.
> >
> > Addressing this problem is something for the people pushing for
> > AT_LINK_REPLACE to solve, not me....
>
> Or the grumpy maintainer who will have to digest all of this.
>
> Can we update the documentation to admit that many people will probably
> want to use this (and rename) as atomic swap operations?
>
> "The filesystem will commit the data and metadata of all files and
> directories involved in the link operation to stable storage before the
> call returns."
>
> And finally add a flag:
>
> "AT_LINK_EATMYDATA: If specified, the filesystem may opt out of
> committing anything to disk."
>

I agree with Christoph that this anomaly is not a good idea, but I also
agree with you and Dave that if an operation is meant to be used for
atomic swap, we should make it much harder for users to get it wrong.

To that end, we can define both flags AT_LINK_REPLACE and
AT_ATOMIC in uapi, but also define the combo
AT_LINK_ATOMIC_REPLACE and let the documentation be
very much focused on this usage.

I would like to stress a point, which some who haven't followed [1]
closely might have missed - the purpose of AT_ATOMIC is
*not* to make the new link durable - it is *not* a replacement for fsync
on parent dir. It's purpose is *only* to create a dependency between the
durability of the new link and the new data it can expose.

AFAICT, this means that AT_ATOMIC would be implemented
as filemap_write_and_wait() in xfs/ext4 and probably fdatasync in btrfs.

Really, there is no chance that any user is interested in a non-atomic
replace in that respect, so I am not even sure that we need an explicit
flag for it. As it is, the AT_REPLACE API design would rank poorly as
"The obvious use is wrong."

An explicit AT_ATOMIC flag would help is that we could make the same
semantics also apply to rename(2) with the same flag.

Omar,

I do understand why you say that you want to implement AT_REPLACE
and let someone else take care of (bike shedding) AT_ATOMIC later.
The problem with that approach is that man page will have the
AT_REPLACE documentation spread out without the mention of
AT_ATOMIC_REPLACE and that can generate damage long into the future.

TBH, I don't think there were any actual objections to the final
AT_ATOMIC_DATA proposal (which was Jan's idea by the way).
Dave was claiming that introducing a new API requires proof of improvement,
so he suggested (for the sake of debate) that I compare the performance of
atomic links to using batched AIO_FSYNC with rename/linkat completion
callbacks and I did not follow up on that.

The situation now is different. You are proposing a new API and the improvement
is clear, so the concern is to get the API right, not to show that it
performs better
than another API.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/
