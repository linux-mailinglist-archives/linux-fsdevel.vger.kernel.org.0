Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F401314F431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 22:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgAaVzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 16:55:17 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34581 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgAaVzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:55:17 -0500
Received: by mail-il1-f196.google.com with SMTP id l4so7575210ilj.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 13:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJLKuEX35NSVhvTQlJYhVRr2LGesVMtP5OlVR/IpycQ=;
        b=iZNvIiyjItqprlVWJOc+QjX4oLD8CNv2Q2x1VLnSpeFKpaYaXQVbUSsY3gVNjmwwYd
         RY3SMNJT09sn9qq/gygOrt5VCkwAqj82rcHp556SwxnkxucmAFD3gnQX4DxKvCkEzT4f
         SEgVJ3fYgRtDXmRuaNMCEsqeMzqWZNEdgsSdqHvzi+KyK84qnr6h+3MgqlDtsdOh/T4v
         bHbu4DoiBCtaywhDxKaT40z+ycrt4+5GnTPFr9MKhgQLUoIR/KYt9txLse94Rqux649Y
         s5wOFDO/5JcuSb/GhuXny5IUeo7rvsS5sf9q1UYLK1zH6WdZS5zcN9QtEtkxebwv1zdB
         3Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJLKuEX35NSVhvTQlJYhVRr2LGesVMtP5OlVR/IpycQ=;
        b=hjp1wWFALBYc1bpII5dx4lTIToWuqvWdSqCtBq2Dg8CJkTYE870djhAIG/F0eBB3WJ
         Um5E/GiC9NUQQ1Vc8/mXMXCM4XttZy2EIw0UpKgCBDG+8ugjbQNpzLpwIP3XkdG3MvFP
         tTtkbfOxLBiMUerbgn5/LLcDMhIejyqb6BXD83ZLjNNTplCWPCj1Fo2MTzbQRxG0vSbA
         wg5JxUWcCaEKpW1d7LI4RhkWkbTXjBK28Q18PF09DuW9tcahs/k4AsJOQ0Guqlb5At+z
         k7zWpPPOc+IMoWeRk3QQiHGWl5k+HQr+YCKFybecgSZhzMnevtB2+Zd5k72UKScNjgqg
         yBYA==
X-Gm-Message-State: APjAAAVdyZhX7K8wcwaG1PBDAtItxlIuQVyMyPazZr422KztwrA651RC
        JqnVKVpxvBkngwo/ox5ZvGp692/PF5kL7fTikRw=
X-Google-Smtp-Source: APXvYqyIdsA1uCN8wpvk0+gk9FC7SVkNDabCsMUpdfzfF5O73ByTPj2+JFPhs8/hv+6KmQcagaUhiLXgVyh1SPIphS0=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr4769849ili.72.1580507716524;
 Fri, 31 Jan 2020 13:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20200118022032.GR8904@ZenIV.linux.org.uk> <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader> <20200123034745.GI23230@ZenIV.linux.org.uk>
 <20200123071639.GA7216@dread.disaster.area> <CAOQ4uxhm3tqgqQPYpkeb635zRLR1CJFDUrwGuCZv1ntv+FszdA@mail.gmail.com>
 <20200124212546.GC7216@dread.disaster.area> <20200131052454.GA6868@magnolia>
 <CAOQ4uxj5ZWLALArKLE3eJLK_QmLdFpHNgP_etRpbK-Tn8-O+AQ@mail.gmail.com> <20200131203344.GB787405@vader>
In-Reply-To: <20200131203344.GB787405@vader>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 31 Jan 2020 23:55:05 +0200
Message-ID: <CAOQ4uxit0KYiShpEXt8b8SvN8bWWp3Ky929b+UWNDozTCUeTxg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Fri, Jan 31, 2020 at 10:33 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Fri, Jan 31, 2020 at 09:00:47AM +0200, Amir Goldstein wrote:
> > On Fri, Jan 31, 2020 at 7:27 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Sat, Jan 25, 2020 at 08:25:46AM +1100, Dave Chinner wrote:
> > > > On Thu, Jan 23, 2020 at 09:47:30AM +0200, Amir Goldstein wrote:
> > > > > On Thu, Jan 23, 2020 at 9:16 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 23, 2020 at 03:47:45AM +0000, Al Viro wrote:
> > > > > > > On Wed, Jan 22, 2020 at 02:10:03PM -0800, Omar Sandoval wrote:
> > > > > > >
> > > > > > > > > Sorry for not reading all the thread again, some API questions:
> > > > > > > > > - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
> > > > > > > >
> > > > > > > > I wasn't planning on having that restriction. It's not too much effort
> > > > > > > > for filesystems to support it for normal files, so I wouldn't want to
> > > > > > > > place an artificial restriction on a useful primitive.
> > > > > > >
> > > > >
> > > > > I have too many gray hairs each one for implementing a "useful primitive"
> > > > > that nobody asked for and bare the consequences.
> > > > > Your introduction to AT_REPLACE uses O_TMPFILE.
> > > > > I see no other sane use of the interface.
> > > > >
> > > > > > > I'm not sure; that's how we ended up with the unspeakable APIs like
> > > > > > > rename(2), after all...
> > > > > >
> > > > > > Yet it is just rename(2) with the serial numbers filed off -
> > > > > > complete with all the same data vs metadata ordering problems that
> > > > > > rename(2) comes along with. i.e. it needs fsync to guarantee data
> > > > > > integrity of the source file before the linkat() call is made.
> > > > > >
> > > > > > If we can forsee that users are going to complain that
> > > > > > linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
> > > > > > leaves zero length files behind after a crash just like rename()
> > > > > > does, then we haven't really improved anything at all...
> > > > > >
> > > > > > And, really, I don't think anyone wants another API that requires
> > > > > > multiple fsync calls to use correctly for crash-safe file
> > > > > > replacement, let alone try to teach people who still cant rename a
> > > > > > file safely how to use it....
> > > > > >
> > > > >
> > > > > Are you suggesting that AT_LINK_REPLACE should have some of
> > > > > the semantics I posted in this RFC  for AT_ATOMIC_xxx:
> > > > > https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/
> > > >
> > > > Not directly.
> > > >
> > > > All I'm pointing out is that data integrity guarantees of
> > > > AT_LINK_REPLACE are yet another aspect of this new feature that
> > > > has not yet been specified or documented at all.
> > > >
> > > > And in pointing this out, I'm making an observation that the
> > > > rename(2) behaviour which everyone seems to be assuming this
> > > > function will replicate is a terrible model to copy/reinvent.
> > > >
> > > > Addressing this problem is something for the people pushing for
> > > > AT_LINK_REPLACE to solve, not me....
> > >
> > > Or the grumpy maintainer who will have to digest all of this.
> > >
> > > Can we update the documentation to admit that many people will probably
> > > want to use this (and rename) as atomic swap operations?
> > >
> > > "The filesystem will commit the data and metadata of all files and
> > > directories involved in the link operation to stable storage before the
> > > call returns."
> > >
> > > And finally add a flag:
> > >
> > > "AT_LINK_EATMYDATA: If specified, the filesystem may opt out of
> > > committing anything to disk."
> > >
> >
> > I agree with Christoph that this anomaly is not a good idea, but I also
> > agree with you and Dave that if an operation is meant to be used for
> > atomic swap, we should make it much harder for users to get it wrong.
> >
> > To that end, we can define both flags AT_LINK_REPLACE and
> > AT_ATOMIC in uapi, but also define the combo
> > AT_LINK_ATOMIC_REPLACE and let the documentation be
> > very much focused on this usage.
> >
> > I would like to stress a point, which some who haven't followed [1]
> > closely might have missed - the purpose of AT_ATOMIC is
> > *not* to make the new link durable - it is *not* a replacement for fsync
> > on parent dir. It's purpose is *only* to create a dependency between the
> > durability of the new link and the new data it can expose.
>
> At the risk of spawning another bikeshed subthread, the naming could be
> improved to make that more clear. AT_BARRIER? AT_DEPENDENCY?
>

It crossed my mind a few times, I may have even suggested it, but IMO
this will not help anybody outside the kernel developers community at
getting a better understanding of what the API means.

> > AFAICT, this means that AT_ATOMIC would be implemented
> > as filemap_write_and_wait() in xfs/ext4 and probably fdatasync in btrfs.
> >
> > Really, there is no chance that any user is interested in a non-atomic
> > replace in that respect, so I am not even sure that we need an explicit
> > flag for it. As it is, the AT_REPLACE API design would rank poorly as
> > "The obvious use is wrong."
> >
> > An explicit AT_ATOMIC flag would help is that we could make the same
> > semantics also apply to rename(2) with the same flag.
> >
> > Omar,
> >
> > I do understand why you say that you want to implement AT_REPLACE
> > and let someone else take care of (bike shedding) AT_ATOMIC later.
>
> I'm not in much of a rush to get AT_LINK_REPLACE in, so I'd be okay
> getting it in together with AT_ATOMIC. I don't think I have the
> bandwidth to get yet another VFS interface in, though (since I still
> have to get back to RWF_ENCODED, which is a higher priority for me). Are
> you planning on picking up AT_ATOMIC any time soon?
>

I wasn't planning to. Mind you, there is no actual "work" to do with
AT_ATOMIC - it is only about agreeing on the semantics - the implementation
is trivial. The man page draft I have already posted, but as I said it would
be much more valuable IMO to introduce AT_LINK_ATOMIC_REPLACE
together to man page. I can help with that if needed.

> > The problem with that approach is that man page will have the
> > AT_REPLACE documentation spread out without the mention of
> > AT_ATOMIC_REPLACE and that can generate damage long into the future.
>
> On the other hand, I believe I made this fairly clear in my man-page
> patch:
>
> +This does not guarantee data integrity;
> +see EXAMPLE below for how to use this for crash-safe file replacement with
> +.BR O_TMPFILE .
>
> With the fsync() calls in the example.
>

Heh that is not how humans work ;-)
People don't go reading the entire man page nor follow examples to the letter.
Many get to AT_LINK_REPLACE description and stop reading.
In that case, I prefer that they first get to AT_LINK_ATOMIC_REPLACE.

I don't mind re-posting your patches adding the _ATOMIC_ keyword
and implementation, but it's a very small change, so perhaps you'd
rather do it yourself, or maybe Dave would want to carry this through
if he is in a bigger rush.

Thanks,
Amir.
