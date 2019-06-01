Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF831A71
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2019 10:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFAIBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jun 2019 04:01:55 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45805 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFAIBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jun 2019 04:01:55 -0400
Received: by mail-yb1-f194.google.com with SMTP id v1so1755131ybi.12;
        Sat, 01 Jun 2019 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDmUdYrg9m0qcChSj+6fWlPUSW2T+Ou4D7qok42q+lI=;
        b=Q8onXTG6YYdAM90JznYzTaLl+23Fv06aSDtcxn/20VQRAsxpKzkF3P/cP8zuSzgf6z
         zYCcn1xzObUeu/tyIRmSi4q+82cppuJQB6uauq0RNDsegzRKSVkTdtINDo3qjLFp8XgO
         Lu+7eID26mmkxQlPyYw81IIuVYDTP27gSC1HcYlR4yBnib0BetwROb7Ez16UCxdhE2FB
         85xpaDU+X77Er7QfDc+BrbAud5vcoyXVgZzfmvXqwv4tzn6TyJt5q+t7XddsW4p/YkSV
         t/t07H4BLKGxWAZ610L+Jfjqde9PnJlijvXRXULOl8E4dmwcu6PUesgM1+tCFSPuKsqd
         1SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDmUdYrg9m0qcChSj+6fWlPUSW2T+Ou4D7qok42q+lI=;
        b=eYxqi7iMyJbcnSeus3OUl0GePUyASNImAzNgL4Kro4+oua6SUe2ehWx35tfK8yEBAx
         D1xLe55t23qXHBiVNLPggqkj9ujqMw0rwbDcEhB6sSQYriiHfM37y5TUMweVuifxPd77
         X42mFr89bENSTsQoA7mQMWsb5u/EVct91UCqdrBJRtSYEdUkrMDzrxU8GkZ7ayDuZTnT
         b1aHzAtSBOvH4+5OpAU23T2+FG3ykQ7PzlRqWQjqFVtsuqlHIsGWfUvNxMf1PI0eiNOJ
         TZS5u5bMACT77AIKPjhjn5ROliC118N3ryM5Mzlmlx1dCnxshrGXfFIlFPFS+073KK6v
         t8cQ==
X-Gm-Message-State: APjAAAXTSfWhgYTLzWoKqXnUaiAYmM76oH4WumY3vy+jZyYDlI0BbwVM
        fa6iFBuBe/9WnywFuobbNrtDvesK8+JLMl08Ykw=
X-Google-Smtp-Source: APXvYqxltf2hrkqpRMZ8ZR2gGFxjXut4v75QGUWZF3/+eqmqNAyl47GNGLOBkHAxsczxQP8XNYLqwvwbuGUZyN2/lwA=
X-Received: by 2002:a25:4489:: with SMTP id r131mr7095732yba.14.1559376113788;
 Sat, 01 Jun 2019 01:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190527172655.9287-1-amir73il@gmail.com> <20190528202659.GA12412@mit.edu>
 <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
 <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
 <20190531164136.GA3066@mit.edu> <20190531224549.GF29573@dread.disaster.area> <20190531232852.GG29573@dread.disaster.area>
In-Reply-To: <20190531232852.GG29573@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Jun 2019 11:01:42 +0300
Message-ID: <CAOQ4uxi99NDYMrz-Q7xKta4beQiYFX3-MipZ_RxFNktFTA=vMA@mail.gmail.com>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 1, 2019 at 2:28 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Jun 01, 2019 at 08:45:49AM +1000, Dave Chinner wrote:
> > Given that we can already use AIO to provide this sort of ordering,
> > and AIO is vastly faster than synchronous IO, I don't see any point
> > in adding complex barrier interfaces that can be /easily implemented
> > in userspace/ using existing AIO primitives. You should start
> > thinking about expanding libaio with stuff like
> > "link_after_fdatasync()" and suddenly the whole problem of
> > filesystem data vs metadata ordering goes away because the
> > application directly controls all ordering without blocking and
> > doesn't need to care what the filesystem under it does....
>
> And let me point out that this is also how userspace can do an
> efficient atomic rename - rename_after_fdatasync(). i.e. on
> completion of the AIO_FSYNC, run the rename. This guarantees that
> the application will see either the old file of the complete new
> file, and it *doesn't have to wait for the operation to complete*.
> Once it is in flight, the file will contain the old data until some
> point in the near future when will it contain the new data....

What I am looking for is a way to isolate the effects of "atomic rename/link"
from the rest of the users. Sure there is I/O bandwidth and queued
bios, but at least isolate other threads working on other files or metadata
from contending with the "atomic rename" thread of journal flushes and
the like. Actually, one of my use cases is "atomic rename" of files with
no data (looking for atomicity w.r.t xattr and mtime), so this "atomic rename"
thread should not be interfering with other workloads at all.

>
> Seriously, sit down and work out all the "atomic" data vs metadata
> behaviours you want, and then tell me how many of them cannot be
> implemented as "AIO_FSYNC w/ completion callback function" in
> userspace. This mechanism /guarantees ordering/ at the application
> level, the application does not block waiting for these data
> integrity operations to complete, and you don't need any new kernel
> side functionality to implement this.

So I think what I could have used is AIO_BATCH_FSYNC, an interface
that was proposed by Ric Wheeler and discussed on LSF:
https://lwn.net/Articles/789024/
Ric was looking for a way to efficiently fsync a "bunch of files".
Submitting several AIO_FSYNC calls is not the efficient way of doing that.
So it is either a new AIO_BATCH_FSYNC and a kernel implementation
that flushes the inodes and then calls ->sync_fs(), or a new AIO operation
that just does the ->sync_fs() bit and using sync_file_range() for the inodes.

To be more accurate, the AIO operation that would emulate my
proposed API more closely is AIO_WAIT_FOR_SYNCFS, as I do not wish
to impose excessive journal flushes, I just need a completion callback
when they happened to perform the rename/link.

>
> Fundamentally, the assertion that disk cache flushes are not what
> causes fsync "to be slow" is incorrect. It's the synchronous

Too many double negatives. I am not sure I parsed this correctly.
But I think by now you understand that I don't care that fsync is "slow".
I care about frequent fsyncs making the entire system slow down.

Heck, xfs even has a mitigation in place to improve performance
of too frequent fsyncs, but that mitigation is partly gone since
47c7d0b19502 xfs: fix incorrect log_flushed on fsync

The situation with frequent fsync on ext4 at the moment is probably
worse.

I am trying to reduce the number of fsyncs from applications
and converting fsync to AIO_FSYNC is not going to help with that.

Thanks,
Amir.
