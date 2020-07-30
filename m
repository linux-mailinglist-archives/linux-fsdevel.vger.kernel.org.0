Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1452332A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgG3NIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 09:08:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29560 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728323AbgG3NIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596114519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWaKeY39EULxcPQEMCGaeW0bHOFmCjPvx3LSrbbV7xY=;
        b=K1B86N++3/ou7F8sd5Tz/rH/Q0/L50bL/tW3TWW9RFSo3tJ3E3HNUctpWN2P2Em45fPu+o
        /j1csYK6HePcZOGhFP1H/+9rK75W3Nqxslxj1D1o7n+r+7P6lDDYrajX763rwMrL/xfQQc
        AJ0Xlsycu8AFP8WgtTgcowt+ckm0x8E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-892tpwLCNhCnGZRJuwKt9A-1; Thu, 30 Jul 2020 09:08:35 -0400
X-MC-Unique: 892tpwLCNhCnGZRJuwKt9A-1
Received: by mail-qt1-f199.google.com with SMTP id n12so581613qtr.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 06:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gWaKeY39EULxcPQEMCGaeW0bHOFmCjPvx3LSrbbV7xY=;
        b=lcLW964ZDVuIpJOJijC83/SyomeluXfCd/lNcAKscVvhwx6yUjHqGwwnaT5L4bAH0x
         BpY0mvvCV/tLoMqo/8rv/c11QHWbwByw6DC7zBibXYzLB0jG4EGctJhA4bnHvIMr2wxp
         p4/JDBTWwpsEswwvkUS6+aHpjXX0mbYhzDVoI8Q0xgynIYxUO9qGwitkP9QMpaFAqRD8
         w2tqMOKBinQUWBqL8ghrjRUBUQlUe5CKNzVI8EfOAeDGDpY11oT/Wf38u92UYxVtpvrb
         qDRZuFq47E6g6GzMwtXj4c2AJQMpoxoYTqWE0RFz17QhvReYMDdC9K1LWEqFihxqDvbz
         BAmw==
X-Gm-Message-State: AOAM531eJlHI0ggtJeVnM5nHEjueGUhsY60cWiuYNoTyLXOfyvxezYRh
        1vlBcSSl3bJX1O6sAOgNleny1zyQu12PzKPDGHJ0Qa27WUgYpUIYCWZdAZkJLxcaeouZyAPc5rJ
        ZaQyxHTVyXZ8SFZ5B44RcYmnWzA==
X-Received: by 2002:ac8:454f:: with SMTP id z15mr2627671qtn.351.1596114514355;
        Thu, 30 Jul 2020 06:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE3m4VK7ilMGfBwsUtRjmSKljYtJpn8E03df8J9j67dNo1Fgsoe+A7NDnW7aFB+gXKH74gBg==
X-Received: by 2002:ac8:454f:: with SMTP id z15mr2627612qtn.351.1596114513855;
        Thu, 30 Jul 2020 06:08:33 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id 8sm4314260qkh.77.2020.07.30.06.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 06:08:33 -0700 (PDT)
Message-ID: <2db05b3eb59bfb59688e7cb435c1b5f2096b8f8a.camel@redhat.com>
Subject: Re: Upcoming: fscache rewrite
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 30 Jul 2020 09:08:32 -0400
In-Reply-To: <447452.1596109876@warthog.procyon.org.uk>
References: <447452.1596109876@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-07-30 at 12:51 +0100, David Howells wrote:
> Hi Linus, Trond/Anna, Steve, Eric,
> 
> I have an fscache rewrite that I'm tempted to put in for the next merge
> window:
> 
> 	https://lore.kernel.org/linux-fsdevel/159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk/
> 
> It improves the code by:
> 
>  (*) Ripping out the stuff that uses page cache snooping and kernel_write()
>      and using kiocb instead.  This gives multiple wins: uses async DIO rather
>      than snooping for updated pages and then copying them, less VM overhead.
> 
>  (*) Object management is also simplified, getting rid of the state machine
>      that was managing things and using a much simplified thread pool instead.
> 
>  (*) Object invalidation creates a tmpfile and diverts new activity to that so
>      that it doesn't have to synchronise in-flight ADIO.
> 
>  (*) Using a bitmap stored in an xattr rather than using bmap to find out if
>      a block is present in the cache.  Probing the backing filesystem's
>      metadata to find out is not reliable in modern extent-based filesystems
>      as them may insert or remove blocks of zeros.  Even SEEK_HOLE/SEEK_DATA
>      are problematic since they don't distinguish transparently inserted
>      bridging.
> 
> I've provided a read helper that handles ->readpage, ->readpages, and
> preparatory writes in ->write_begin.  Willy is looking at using this as a way
> to roll his new ->readahead op out into filesystems.  A good chunk of this
> will move into MM code.
> 
> The code is simpler, and this is nice too:
> 
>  67 files changed, 5947 insertions(+), 8294 deletions(-)
> 
> not including documentation changes, which I need to convert to rst format
> yet.  That removes a whole bunch more lines.
> 
> But there are reasons you might not want to take it yet:
> 
>  (1) It starts off by disabling fscache support in all the filesystems that
>      use it: afs, nfs, cifs, ceph and 9p.  I've taken care of afs, Dave
>      Wysochanski has patches for nfs:
> 
> 	https://lore.kernel.org/linux-nfs/1596031949-26793-1-git-send-email-dwysocha@redhat.com/
> 
>      but they haven't been reviewed by Trond or Anna yet, and Jeff Layton has
>      patches for ceph:
> 
> 	https://marc.info/?l=ceph-devel&m=159541538914631&w=2
> 
>      and I've briefly discussed cifs with Steve, but nothing has started there
>      yet.  9p I've not looked at yet.
> 
>      Now, if we're okay for going a kernel release with 4/5 filesystems with
>      caching disabled and then pushing the changes for individual filesystems
>      through their respective trees, it might be easier.
> 
>      Unfortunately, I wasn't able to get together with Trond and Anna at LSF
>      to discuss this.
> 
>  (2) The patched afs fs passed xfstests -g quick (unlike the upstream code
>      that oopses pretty quickly with caching enabled).  Dave and Jeff's nfs
>      and ceph code is getting close, but not quite there yet.


That was my experience on cephfs+fscache too -- it often crashed down in
the fscache code. I'd support the approach in (1) above -- put this in
soon and disable the caches in the filesystems. Then push the changes to
reenable it via fs-specific trees.

The ceph patch series is more or less ready. It passes all of the
xfstest "quick" group run (aside from a few expected failures on
cephfs).

The only real exception is generic/531, which seems to trigger OOM kills
in my testing. The test tries to create a ton of files and leak the file
descriptors. I tend to think that workload is pretty unusual, and given
that fscache was terribly unstable and crashed before, this is still a
marked improvement.

>  (3) Al has objections to the ITER_MAPPING iov_iter type that I added
> 
> 	https://lore.kernel.org/linux-fsdevel/20200719014436.GG2786714@ZenIV.linux.org.uk/
> 
>      but note that iov_iter_for_each_range() is not actually used by anything.
> 
>      However, Willy likes it and would prefer to make it ITER_XARRAY instead
>      as he might be able to use it in other places, though there's an issue
>      where I'm calling find_get_pages_contig() which takes a mapping (though
>      all it does is then get the xarray out of it).
> 
>      Instead I would have to use ITER_BVEC, which has quite a high overhead,
>      though it would mean that the RCU read lock wouldn't be necessary.  This
>      would require 1K of memory for every 256K block the cache wants to read;
>      for any read >1M, I'd have to use vmalloc() instead.
> 
>      I'd also prefer not to use ITER_BVEC because the offset and length are
>      superfluous here.  If ITER_MAPPING is not good, would it be possible to
>      have an ITER_PAGEARRAY that just takes a page array instead?  Or, even,
>      create a transient xarray?
> 
>  (4) The way object culling is managed needs overhauling too, but that's a
>      whole 'nother patchset.  We could wait till that's done too, but its lack
>      doesn't prevent what we have now being used.
> 
> Thoughts?
> 
> David
> 

-- 
Jeff Layton <jlayton@redhat.com>

