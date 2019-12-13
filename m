Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAEC11DB4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 01:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLMAxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 19:53:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38295 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLMAxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:53:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so631985pgm.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 16:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jKD62V/GgSWLb/kYT03Quqy/I04kGB1tDPvuCoyNQ4U=;
        b=R5fOLKwIY0Jwy7hR3DO4eSa2mIRXstoLVyzhLU5rsecsPdsKTBYJshh+IeqAbDCb+t
         t9Ur5P6L1x3A6fZssuOJUHgbPAdyhX4mRmPLwV1k6vKRqBttDJzOOfgDX8tH5zrF+jR9
         Q8bBwl2EiX3ZVMYMZ6mug7OzBqJ07XMdM+/KYDQrs5N7Cq7+XT8KDvst5WodMFKZdxn4
         3qIiuG25k1J/GxPNLBaNVXRYH0UiPVCFB1iADLptsXFJsQdw6hbO8x4t1N4VsrDS2VmD
         ykAdtCfUfwZ9YHJJ6wWnHMbSySIqHX7af7QDY0y1KBl/7nFakBB9Q6nE77YSN5+xzfQ9
         8KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jKD62V/GgSWLb/kYT03Quqy/I04kGB1tDPvuCoyNQ4U=;
        b=LpuGl39YxscTt3Zopon6gZxWYkkqn62hsBJSXiodfCaaqcKGSNnhPwhG3lz3FLpm3b
         N01208+u2xYn//cKENSsW14CyqNaLruzZlfZQ2XaMYR5Bh5GYuCgh0Xasqv1fOCgpzSb
         BYwZ/ELg0x+YopFqAb9uxlEg7EVXHGDyZzbuFuskhbWydbTlc4DtQwqo4jADryQ6rD71
         qVwapKLewoENvf+FK/oK1lG8W7HZNRSNyKxuwLhznhlaqtSgzrG9+03kD36Mfpl/HO0N
         q2aE69vbIsMHfNnAvuLyrP1DAZptHTYFTvfSi4MI39asPhvsTDkerveNLk8UUGr79MGU
         CA4Q==
X-Gm-Message-State: APjAAAWaREZkjk2sZgZmOuo+2yX5qd3frvlLjF251R9E28jodVZzjPQQ
        ugIFWCRE/K1Wq6LLUrkgG/cWSo+0o/NYVg==
X-Google-Smtp-Source: APXvYqxa+YwBZGZdJElOigly+nL4Tl5DxfNpTHH5XEfdndh0Gv3F7DIF6bZAvNMsrBviXox+SlJAGw==
X-Received: by 2002:a63:3104:: with SMTP id x4mr13644888pgx.369.1576198410168;
        Thu, 12 Dec 2019 16:53:30 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m15sm8140291pgi.91.2019.12.12.16.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 16:53:29 -0800 (PST)
Subject: Re: [PATCHSET v4 0/5] Support for RWF_UNCACHED
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
References: <20191212190133.18473-1-axboe@kernel.dk>
Message-ID: <1724f1c7-d404-9ce7-48ab-0d5f6f5dece5@kernel.dk>
Date:   Thu, 12 Dec 2019 17:53:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212190133.18473-1-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 12:01 PM, Jens Axboe wrote:
> Recently someone asked me how io_uring buffered IO compares to mmaped
> IO in terms of performance. So I ran some tests with buffered IO, and
> found the experience to be somewhat painful. The test case is pretty
> basic, random reads over a dataset that's 10x the size of RAM.
> Performance starts out fine, and then the page cache fills up and we
> hit a throughput cliff. CPU usage of the IO threads go up, and we have
> kswapd spending 100% of a core trying to keep up. Seeing that, I was
> reminded of the many complaints I here about buffered IO, and the fact
> that most of the folks complaining will ultimately bite the bullet and
> move to O_DIRECT to just get the kernel out of the way.
> 
> But I don't think it needs to be like that. Switching to O_DIRECT isn't
> always easily doable. The buffers have different life times, size and
> alignment constraints, etc. On top of that, mixing buffered and O_DIRECT
> can be painful.
> 
> Seems to me that we have an opportunity to provide something that sits
> somewhere in between buffered and O_DIRECT, and this is where
> RWF_UNCACHED enters the picture. If this flag is set on IO, we get the
> following behavior:
> 
> - If the data is in cache, it remains in cache and the copy (in or out)
>   is served to/from that. This is true for both reads and writes.
> 
> - For writes, if the data is NOT in cache, we add it while performing the
>   IO. When the IO is done, we remove it again.
> 
> - For reads, if the data is NOT in the cache, we allocate a private page
>   and use that for IO. When the IO is done, we free this page. The page
>   never sees the page cache.
> 
> With this, I can do 100% smooth buffered reads or writes without pushing
> the kernel to the state where kswapd is sweating bullets. In fact it
> doesn't even register.
> 
> Comments appreciated! This should work on any standard file system,
> using either the generic helpers or iomap. I have tested ext4 and xfs
> for the right read/write behavior, but no further validation has been
> done yet. This version contains the bigger prep patch of switching
> iomap_apply() and actors to struct iomap_data, and I hope I didn't
> mess that up too badly. I'll try and exercise it all, I've done XFS
> mounts and reads+writes and it seems happy from that POV at least.
> 
> The core of the changes are actually really small, the majority of
> the diff is just prep work to get there.
> 
> Patches are against current git, and can also be found here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached
> 
>  fs/ceph/file.c          |   2 +-
>  fs/dax.c                |  25 +++--
>  fs/ext4/file.c          |   2 +-
>  fs/iomap/apply.c        |  50 ++++++---
>  fs/iomap/buffered-io.c  | 225 +++++++++++++++++++++++++---------------
>  fs/iomap/direct-io.c    |  57 +++++-----
>  fs/iomap/fiemap.c       |  48 +++++----
>  fs/iomap/seek.c         |  64 +++++++-----
>  fs/iomap/swapfile.c     |  27 ++---
>  fs/nfs/file.c           |   2 +-
>  include/linux/fs.h      |   7 +-
>  include/linux/iomap.h   |  20 +++-
>  include/uapi/linux/fs.h |   5 +-
>  mm/filemap.c            |  89 +++++++++++++---
>  14 files changed, 416 insertions(+), 207 deletions(-)
> 
> Changes since v3:
> - Add iomap_actor_data to cut down on arguments
> - Fix bad flag drop in iomap_write_begin()
> - Remove unused IOMAP_WRITE_F_UNCACHED flag
> - Don't use the page cache at all for reads

Had the silly lru error in v4, and also an XFS flags error. I'm not
going to re-post already due to this, but please use:

https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached

if you're going to test this. You can pull it at:

git://git.kernel.dk/linux-block buffered-uncached

Those are the only two changes since v4. I'll throw a v5 out there a bit
later.

-- 
Jens Axboe

