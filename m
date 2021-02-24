Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74D323689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 05:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhBXE6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 23:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBXE6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 23:58:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E1EC061574;
        Tue, 23 Feb 2021 20:58:01 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j19so1034642lfr.12;
        Tue, 23 Feb 2021 20:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrajYP2hBjaKUlNDr5nfLO5dI2VEsLYw/fRZTXaD8VA=;
        b=ZMmxrY5nQMPOuw6scDp5kDuYNOONNS6FyeSqMA2TydiNEydn5VzajUuNlS+6FCjg52
         co69WuI+FJUhbw5cv6uyYbvJIPdGEGuFONjiN7n7CEjSBcSkK47PSIn/83dDwIZjPNJq
         Bc99HBK+z471EUjv/2nnZGGvJp/vo7jFdbMAlPsQ1RCh3q4g4yMELRcpKYfgS1mz87PD
         dQLRvVz5IpraVECQzwKylQiGaE5qLGQtbFuuea9LWXD4GtMr51zfpdKbYhYqwn2V7uqY
         FCYktNTYMdvVIEunttK0IvC1KekDxUVtDEzPeP5hRuKb778GNss7erwfqplRsaae2Y6Y
         mtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrajYP2hBjaKUlNDr5nfLO5dI2VEsLYw/fRZTXaD8VA=;
        b=NGA7Az4ASmIXmQ5xEKr8iSXFBg+yrn33CL7+6JInPNCrhSIJkRI767vbH5/UZVJXAQ
         h6lk1A/oHws47C80rbLXJN5l66DVwZXZyCG5t2M/WGGOX/EFSDDXK4fXTvZv85MFsZi/
         tsIo0yaw7SVKYuJSbPDEj+AvfKwKVNgUTNIM/SNoXdRXK/rwZHraPQNpIKCedIosjGco
         QK6w2MB3V+D/l2HjIKwMSFRE30pBzjvyYkfdW7346pv5W9FnYM9AqSoiFahYDSrrW14D
         DB8VhjLazFFPMPfD0XYF45jAln7jUCAsW6YLFcApYdzOmmyTImJyQIpG2HfFLgIyBxY/
         dMoQ==
X-Gm-Message-State: AOAM53190DLh3Z3wkfSwVsuOiJ7oMF7ReU7HiHy7ggOfqdhIRKDwPAv/
        srgIxChCkJyJaLyK2zHzTu5DlAnYzfqiuyMUOr/9jJ8h9O9Y+g==
X-Google-Smtp-Source: ABdhPJw6r/na/lmIQBVTZHzL3REpx3JMt6S1bztYIeQ+Q0r5DTYVKTT1II6PMpNnp9XsQr/gpOhg2b3f8C/vYdZxtAM=
X-Received: by 2002:a05:6512:1311:: with SMTP id x17mr17837516lfu.307.1614142679263;
 Tue, 23 Feb 2021 20:57:59 -0800 (PST)
MIME-Version: 1.0
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <9e49f96cd80eaf9c8ed267a7fbbcb4c6467ee790.camel@redhat.com>
 <CAH2r5mvPLivjuE=cbijzGSHOvx-hkWSWbcxpoBnJX-BR9pBskQ@mail.gmail.com>
 <20210216021015.GH2858050@casper.infradead.org> <CAH2r5mv+AdiODH1TSL+SOQ5qpZ25n7Ysrp+iYxauX9sD8ehhVQ@mail.gmail.com>
 <20210223202742.GM2858050@casper.infradead.org>
In-Reply-To: <20210223202742.GM2858050@casper.infradead.org>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 23 Feb 2021 22:57:48 -0600
Message-ID: <CAH2r5ms06hL0f5+ejXJTYE7_8rO4SZRW+-ZeWETNFiXDPu1Jbg@mail.gmail.com>
Subject: Re: [PATCH 00/33] Network fs helper library & fscache kiocb API [ver #3]
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Wysochanski <dwysocha@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Case van Rij <case.vanrij@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 2:28 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 15, 2021 at 11:22:20PM -0600, Steve French wrote:
> > On Mon, Feb 15, 2021 at 8:10 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > The switch from readpages to readahead does help in a couple of corner
> > > cases.  For example, if you have two processes reading the same file at
> > > the same time, one will now block on the other (due to the page lock)
> > > rather than submitting a mess of overlapping and partial reads.
> >
> > Do you have a simple repro example of this we could try (fio, dbench, iozone
> > etc) to get some objective perf data?
>
> I don't.  The problem was noted by the f2fs people, so maybe they have a
> reproducer.
>
> > My biggest worry is making sure that the switch to netfs doesn't degrade
> > performance (which might be a low bar now since current network file copy
> > perf seems to signifcantly lag at least Windows), and in some easy to understand
> > scenarios want to make sure it actually helps perf.
>
> I had a question about that ... you've mentioned having 4x4MB reads
> outstanding as being the way to get optimum performance.  Is there a
> significant performance difference between 4x4MB, 16x1MB and 64x256kB?
> I'm concerned about having "too large" an I/O on the wire at a given time.
> For example, with a 1Gbps link, you get 250MB/s.  That's a minimum
> latency of 16us for a 4kB page, but 16ms for a 4MB page.
>
> "For very simple tasks, people can perceive latencies down to 2 ms or less"
> (https://danluu.com/input-lag/)
> so going all the way to 4MB I/Os takes us into the perceptible latency
> range, whereas a 256kB I/O is only 1ms.
>
> So could you do some experiments with fio doing direct I/O to see if
> it takes significantly longer to do, say, 1TB of I/O in 4MB chunks vs
> 256kB chunks?  Obviously use threads to keep lots of I/Os outstanding.

That is a good question and it has been months since I have done experiments
with something similar.   Obviously this will vary depending on RDMA or not and
multichannel or not - but assuming the 'normal' low end network configuration -
ie a 1Gbps link and no RDMA or multichannel I could do some more recent
experiments.

In the past what I had noticed was that server performance for simple
workloads like cp or grep increased with network I/O size to a point:
smaller than 256K packet size was bad. Performance improved
significantly from 256K to 512K to 1MB, but only very
slightly from 1MB to 2MB to 4MB and sometimes degraded at 8MB
(IIRC 8MB is the max commonly supported by SMB3 servers),
but this is with only one adapter (no multichannel) and 1Gb adapters.

But in those examples there wasn't a lot of concurrency on the wire.

I did some experiments with increasing the read ahead size
(which causes more than one async read to be issued by cifs.ko
but presumably does still result in some 'dead time')
which seemed to help perf of some sequential read examples
(e.g. grep or cp) to some servers but I didn't try enough variety
of server targets to feel confident about that change especially
if netfs is coming

e.g. a change I experimented with was:
         sb->s_bdi->ra_pages = cifs_sb->ctx->rsize / PAGE_SIZE
to
         sb->s_bdi->ra_pages = 2 * cifs_sb->ctx->rsize / PAGE_SIZE

and it did seem to help a little.

I would expect that 8x1MB (ie trying to keep eight 1MB reads in process should
keep the network mostly busy and not lead to too much dead time on
server, client
or network) and is 'good enough' in many read ahead use cases (at
least for non-RDMA, and non-multichannel on a slower network) to keep the pipe
file, and I would expect the performance to be similar to the equivalent using
2MB read (e.g. 4x2MB) and perhaps better than 2x4MB.  Below 1MB i/o size
on the wire I would expect to see degradation due to packet processing
and task switching
overhead.  Would definitely be worth doing more experimentation here.
-- 
Thanks,

Steve
