Return-Path: <linux-fsdevel+bounces-5103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 977BD8080C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 07:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C891F21262
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 06:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7051E48F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZI+91xDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91500D5C
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 22:25:48 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58e30de3933so177937eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 22:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701930348; x=1702535148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Hc+mPiQaNeuf4gnfMuq7zF4MPfoPt0lbfiwHLrs3YI=;
        b=ZI+91xDcsCBQXsuxqT372YrRlZLUkAUD8xQBVY1FfX4NzzN5POmyueEtbN6XBtggda
         ewVkfPfThTDe7Wx6c8TeVn92MVnPR3feHLJOGWN7N9tqpUQd1+3Hu/LYMdEhCCC9DLXQ
         UPLC0UN0VhtFvX6OQasz8RgZu/f8P3B7CrNukA4j8rjV/GoJ+GWcurtTU3NhYKDgEtSN
         2Nez0rtPpgQtC7qbqzpINAmRNWNWJOJnc1uuAalIMJHPM2Lf3CWGnyj28lKBua64+VxJ
         itvDqNFwthgHy7zuULkD8QLRIsEjVHsJvKJqmb5MV7DuAADO78p+zW7PZ3I3vJwqD+ej
         QvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701930348; x=1702535148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Hc+mPiQaNeuf4gnfMuq7zF4MPfoPt0lbfiwHLrs3YI=;
        b=RQoXaPkCHAoZQ8VuI6GNy8C6+IdvcbpfZK31C/jioFUSYUGLJCVmXA4/N+KBShV4Al
         bbwLoaPDCX1MiPzVkJXg6Ze8saJ2kX4EhD28Q9WEryBgJzq0SiKANZtoXIkzoWLiG8Qg
         NEmwfagoAYzvWpvE+Enn8AEviHo3I7T/2tlAhV9NqBGgJACxKMAsI5ERJICS4WQ+tvPr
         h+yG3f0hRbqB0S5ji6byWHUJPHy5/suhz3vgBbiSqwaB6TC+YuTKlpWU+UgoDGEpW4AZ
         6JCUwOuzhEpeqNGCAo1Tgnp7Lkv3vfKnaTifjZT92zulYoruShu4eReLW5+sge+LHaKK
         hZtQ==
X-Gm-Message-State: AOJu0YyJhceRFLMaTqab1xtfvCNp/dTZfY3sdKgrb39Z1xfm9cFdF9d3
	P/BEbBGDJ5/2cbapkveNsuFLYA==
X-Google-Smtp-Source: AGHT+IFCsxUuAOQGHD1mRv24F9ZZmtsSUo1Bmn5R2cOtJ2AK5xAtSohfUoDVBtrWyaVLjbtNDCLDeA==
X-Received: by 2002:a05:6359:2d96:b0:170:1e24:b827 with SMTP id rn22-20020a0563592d9600b001701e24b827mr2156432rwb.40.1701930347863;
        Wed, 06 Dec 2023 22:25:47 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id o123-20020a62cd81000000b006cbafd6996csm550679pfg.123.2023.12.06.22.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 22:25:47 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rB7pQ-004xdH-2k;
	Thu, 07 Dec 2023 17:25:44 +1100
Date: Thu, 7 Dec 2023 17:25:44 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Waiman Long <longman@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cachefs@redhat.com,
	dhowells@redhat.com, gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 04/11] lib/dlock-list: Make sibling CPUs share the same
 linked list
Message-ID: <ZXFlaN8FCC8ryr/R@dread.disaster.area>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-5-david@fromorbit.com>
 <20231207054259.gpx3cydlb6b7raax@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207054259.gpx3cydlb6b7raax@moria.home.lan>

On Thu, Dec 07, 2023 at 12:42:59AM -0500, Kent Overstreet wrote:
> On Wed, Dec 06, 2023 at 05:05:33PM +1100, Dave Chinner wrote:
> > From: Waiman Long <longman@redhat.com>
> > 
> > The dlock list needs one list for each of the CPUs available. However,
> > for sibling CPUs, they are sharing the L2 and probably L1 caches
> > too. As a result, there is not much to gain in term of avoiding
> > cacheline contention while increasing the cacheline footprint of the
> > L1/L2 caches as separate lists may need to be in the cache.
> > 
> > This patch makes all the sibling CPUs share the same list, thus
> > reducing the number of lists that need to be maintained in each
> > dlock list without having any noticeable impact on performance. It
> > also improves dlock list iteration performance as fewer lists need
> > to be iterated.
> 
> Seems Waiman was missed on the CC

Oops, I knew I missed someone important....

> it looks like there's some duplication of this with list_lru
> functionality - similar list-sharded-by-node idea.

For completely different reasons. The list_lru is aligned to the mm
zone architecture which only partitions memory management accounting
and scanning actions down into NUMA nodes. It's also a per-node
ordered list (LRU), and it has intricate locking semantics that
expose internal list locks to external isolation functions that can
be called whilst a lock protected traversal is in progress.

Further, we have to consider that list-lru is tightly tied to
memcgs.  For a single NUMA- and memcg- aware list-lru, there is
actually nr_memcgs * nr_nodes LRUs per list. The memory footprint of
a superblock list_lru gets quite gigantic when we start talking
about machines with hundreds of nodes running tens of thousands of
containers each with tens of superblocks.

That's the biggest problem with using a more memory expensive
structure for the list_lru - we're talking gigabytes of memory just
for the superblock shrinker tracking structure overhead on large
machines. This was one of the reasons why we haven't tried to make
list_lrus any more fine-grained that it absolutely needs to be to
provide acceptible scalability.

> list_lru does the sharding by page_to_nid() of the item, which
> saves a pointer and allows just using a list_head in the item.
> OTOH, it's less granular than what dlock-list is doing?

Sure, but there's a lot more to list_lrus than it being a "per-node
list".  OTOH, dlock_list is really nothing more than a "per-cpu
list"....

> I think some attempt ought to be made to factor out the common
> ideas hear; perhaps reworking list_lru to use this thing, and I
> hope someone has looked at the page_nid idea vs. dlock_list using
> the current core.

I certainly have, and I haven't been able to justify the additional
memory footprint of a dlock_list over the existing per-node lists.
That may change given that XFS appears to be on the theshold of
per-node list-lru lock breakdown at 64 threads, but there's a lot
more to consider from a system perspective here than just
inode/dentry cache scalability....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

