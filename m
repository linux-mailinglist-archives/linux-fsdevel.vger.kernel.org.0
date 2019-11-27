Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593EC10B339
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 17:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK0Q3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 11:29:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56182 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbfK0Q3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574872189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcyN5dGoMhhF+8wU9SDW3LRuwC7oWgcs+VV9XVwODaY=;
        b=cAS73JCD+nO+Xquvs5svzUBvD7QBcWuve9WQBgF5D1dGk1eiV5fNx9oUGBoGfpBj5PlzQ6
        ffj0G1lumi/9LswcL6NWRHpd3Z21a1pLMSP03EfX99eHI+0qXQJkZ46v/gmwwb0+bkA9p4
        J7X+Vv3mIOusZluLwGQnQbkuWSHBB3o=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Y4z0AUziPQGZAp7ge7BSXg-1; Wed, 27 Nov 2019 11:29:48 -0500
Received: by mail-oi1-f198.google.com with SMTP id n30so11396889oij.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 08:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIu1VyYGNbaIKqeZUoUtiDvput7821e7oFhQavConxk=;
        b=BOJZc7a3zwVV9tdDYLPzFe+NUxl4pKdu+n1Xdkvb0pvdFZISGhIbAkYwWHhAwHW3ix
         1OXIbj7boG+27r+Ze4xgy/HNpljasmwOHEXBXH7wAey0fCuZMk5jsYGjQv5wOo1updrc
         W2gAWYv0LI6zqKUOdETFSjCsL1xvJhuETJ5lzOXxz2lLK/zZzXYcBEYQ/l/YdMuM0Gqg
         ShSU2sPDplFDZ2rlsz+a8Ki/mSChT+g1NVgIv8FsWQmBPAqfUTKSo2zwA/+HLRQ02gr8
         au2Syww17ysbI+0bmz97nTcZJadNg8pBzG+1GUd2IezPNUWPrdstPqq1AtcOUIBfFMQ1
         g2NA==
X-Gm-Message-State: APjAAAXglVl/oRRjsr2ZeBS2UOkE1/57OSI7KlDRpYNHYypWcGMBKiDP
        NHbS00uiTMPSwNrRcmi+C+McN51ORj5PFlkdB/ThEY7VaNJPEqqwr8OKZl6sX/Q+p+LUujzZl0E
        VrNG5k5wd/wsW2JyGmZEbDt2XRJZvnUjioEibHzW4KQ==
X-Received: by 2002:aca:d14:: with SMTP id 20mr4877846oin.178.1574872187661;
        Wed, 27 Nov 2019 08:29:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3yLKNT7wsw1AqyVf2knKKoyFNMFDOQF5O+7hYYWvVBZw57Km8zJVbATfvGULvCZMZmqbPRh8opF4b2Zj5pdE=
X-Received: by 2002:aca:d14:: with SMTP id 20mr4877821oin.178.1574872187328;
 Wed, 27 Nov 2019 08:29:47 -0800 (PST)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
 <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com> <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
 <640bbe51-706b-8d9f-4abc-5f184de6a701@redhat.com> <CAHpGcM+o2OwXdrj+A2_OqRg6YokfauFNiBJF-BQp0dJFvq_BrQ@mail.gmail.com>
 <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com> <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
 <cdd48a4d-42a4-dd15-2701-e08e26fef17f@redhat.com>
In-Reply-To: <cdd48a4d-42a4-dd15-2701-e08e26fef17f@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 27 Nov 2019 17:29:36 +0100
Message-ID: <CAHc6FU4Mx_=qMYOBc0VYdn-paFXKVffq=k72LCJgTWONv9chng@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Bob Peterson <rpeterso@redhat.com>
X-MC-Unique: Y4z0AUziPQGZAp7ge7BSXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 4:42 PM Steven Whitehouse <swhiteho@redhat.com> wro=
te:
> Hi,
>
> On 25/11/2019 17:05, Linus Torvalds wrote:
> > On Mon, Nov 25, 2019 at 2:53 AM Steven Whitehouse <swhiteho@redhat.com>=
 wrote:
> >> Linus, is that roughly what you were thinking of?
> > So the concept looks ok, but I don't really like the new flags as they
> > seem to be gfs2-specific rather than generic.
> >
> > That said, I don't _gate_ them either, since they aren't in any
> > critical code sequence, and it's not like they do anything really odd.
> >
> > I still think the whole gfs2 approach is broken. You're magically ok
> > with using stale data from the cache just because it's cached, even if
> > another client might have truncated the file or something.
>
> If another node tries to truncate the file, that will require an
> exclusive glock, and in turn that means the all the other nodes will
> have to drop their glock(s) shared or exclusive. That process
> invalidates the page cache on those nodes, such that any further
> requests on those nodes will find the cache empty and have to call into
> the filesystem.
>
> If a page is truncated on another node, then when the local node gives
> up its glock, after any copying (e.g. for read) has completed then the
> truncate will take place. The local node will then have to reread any
> data relating to new pages or return an error in case the next page to
> be read has vanished due to the truncate. It is a pretty small window,
> and the advantage is that in cases where the page is in cache, we can
> directly use the cached page without having to call into the filesystem
> at all. So it is page atomic in that sense.
>
> The overall aim here is to avoid taking (potentially slow) cluster locks
> when at all possible, yet at the same time deliver close to local fs
> semantics whenever we can. You can think of GFS2's glock concept (at
> least as far as the inodes we are discussing here) as providing a
> combination of (page) cache control and cluster (dlm) locking.
>
> >
> > So you're ok with saying "the file used to be X bytes in size, so
> > we'll just give you this data because we trust that the X is correct".
> >
> > But you're not ok to say "oh, the file used to be X bytes in size, but
> > we don't want to give you a short read because it might not be correct
> > any more".
> >
> > See the disconnect? You trust the size in one situation, but not in ano=
ther one.
>
> Well we are not trusting the size at all... the original algorithm
> worked entirely off "is this page in cache and uptodate?" and for
> exactly the reason that we know the size in the inode might be out of
> date, if we are not currently holding a glock in either shared or
> exclusive mode. We also know that if there is a page in cache and
> uptodate then we must be holding the glock too.
>
>
> >
> > I also don't really see that you *need* the new flag at all. Since
> > you're doing to do a speculative read and then a real read anyway, and
> > since the only thing that you seem to care about is the file size
> > (because the *data* you will trust if it is cached), then why don't
> > you just use the *existing* generic read, and *IFF* you get a
> > truncated return value, then you go and double-check that the file
> > hasn't changed in size?
> >
> > See what I'm saying? I think gfs2 is being very inconsistent in when
> > it trusts the file size, and I don't see that you even need the new
> > behavior that patch gives, because you might as well just use the
> > existing code (just move the i_size check earlier, and then teach gfs2
> > to double-check the "I didn't get as much as I expected" case).

We can identify short reads, but we won't get information about
readahead back from generic_file_read_iter or filemap_fault. We could
try to work around this with filesystem specific flags for ->readpage
and ->readpages, but that would break down with multiple concurrent
readers in addition to being a real mess. I'm currently out of better
ideas that avoid duplicating the generic code.

> >                   Linus
>
> I'll leave the finer details to Andreas here, since it is his patch, and
> hopefully we can figure out a good path forward. We are perhaps also a
> bit reluctant to go off and (nearly) duplicate code that is already in
> the core vfs library functions, since that often leads to things getting
> out of sync (our implementation of ->writepages is one case where that
> happened in the past) and missing important bug fixes/features in some
> cases. Hopefully though we can iterate on this a bit and come up with
> something which will resolve all the issues,
>
> Steve.

Thanks,
Andreas

