Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D603B14F789
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 11:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgBAKds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 05:33:48 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53515 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbgBAKdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 05:33:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4071D4C4;
        Sat,  1 Feb 2020 05:33:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 01 Feb 2020 05:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=2ixvT2Cpjuf+3JgsEZKQR8NzhQJ
        h/pDTdGylFM212no=; b=BybiAnlYT8fZq9f126FXFlOulEy4SItZLz90jPGnp9B
        sUGzVcPRM2r9tRqYnFpvqb/nOc0rdJ6EpZCsHhawR2lyFIlxJJe74y9Tqb5Ev59G
        Xc7l0brF8nePpYrSY09I0KxrhftKMRSr8tr9N1hFu7fWAz2DWVbflDo+Rd1V1PIm
        9AaDB2OPss3/pE+3LMSTSdYw3rDBB2KGEkBOK8aEkgt5GGh+ixdcbG98RwQtWZ/+
        9oCcKfrEEhJXzqEDSaOz7jTZYtjjeYYdW3YVnJiDOiEphUFD2e06PCpOAS1u8slg
        XlnAKQRthGfcC5yR4ClHdinWIOGYnVi3jgWr9L92NSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2ixvT2
        Cpjuf+3JgsEZKQR8NzhQJh/pDTdGylFM212no=; b=QeL8UH420iudpUpVyBBrLS
        3OwR5xR9+4J2suHdBj8bJV7L18WUhHT8CCnj009U23vJqA6+wKLWHiJqsQKTFo/Y
        zKNnOzmAm3nlP7xamLEFV/P+KfeE9nMFoFMm7Pi3B1DE6HAGsIGCmXRY8MJdlud/
        zIAFZ8ssix864xyIklJbR1XdO10oTd9ytI0hKcnmuJd/M8FbzAWTUiUZnA6KMwpe
        ZrMAsfa26XVrGs1rvuXlpGynYYXqHdUZA44G8Q5TVfmv8+eqknkcWrx7cjulVSgK
        HK4y8NM9bh7/L0HnzPjD1HRux2miLFEH9rYpbpx52bsHbJbnsv7h+dhcHFOTZYBg
        ==
X-ME-Sender: <xms:B1Q1XgZmC_xa8tEhX-OUxnsc1b24BjBK-pCHr2UED78qP3AQ77ewVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgedvgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecukfhppedvud
    dvrdejiedrvdehfedrudejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:B1Q1XigGK0ODk4npDJGsYcZhsyFUTUl7ykGsRlfwa3HmwW03XWMpqw>
    <xmx:B1Q1XtULlI0tUXIhSTqRtwq79amIcdfCct8cwQ2Nf9EOZCBVnwa8kQ>
    <xmx:B1Q1XkVSZqa43b-_uUwzYdO8Ud8aXRkddoFF95E9W8uLEOEJ-Ny0jw>
    <xmx:CVQ1XukHbeh8-wS72xRqv2ATW6Bapoop4o-2t0BeNWD7T2HvtZHQhA>
Received: from intern.anarazel.de (unknown [212.76.253.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 960193060A08;
        Sat,  1 Feb 2020 05:33:43 -0500 (EST)
Date:   Sat, 1 Feb 2020 02:33:42 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Chris Mason <clm@fb.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20200201103342.ktxbrhaqqhbrtg7p@alap3.anarazel.de>
References: <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
 <20191212221818.GG19213@dread.disaster.area>
 <C08B7F86-C3D6-47C6-AB17-6F234EA33687@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C08B7F86-C3D6-47C6-AB17-6F234EA33687@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2019-12-13 01:32:10 +0000, Chris Mason wrote:
> Grepping through the code shows a wonderful assortment of helpers to
> control the cache, and RWF_UNCACHED would be both cleaner and faster
> than what we have today.  I'm on the fence about asking for
> RWF_FILE_RANGE_WRITE (+/- naming) to force writes to start without
> pitching pages, but we can talk to some service owners to see how useful
> that would be.   They can always chain a sync_file_range() in io_uring,
> but RWF_ would be lower overhead if it were a common pattern.

FWIW, for postgres something that'd allow us to do writes that

a) Doesn't remove pages from the pagecache if they're already there.
b) Doesn't delay writeback to some unpredictable point later.

   The later write causes both latency issues, and often under-utilizes
   write bandwidth for a while. For most cases where we write, we know
   that we're not likely to write the same page again soon.

c) Doesn't (except maybe temporarily) bring pages into the pagecache, if
   they weren't before.

   In the cases where the page previously wasn't in the page cache, and
   we wrote it out, it's very likely to have been resident for long
   enough in our cache, that the kernel caching it for the future isn't
   useful.

would be really helpful. Right now we simulate that to some degree by
doing normal buffered writes followed by sync_file_range(WRITE).

For most environments always using O_DIRECT isn't really an option for
us, as we can't rely on settings being tuned well enough (i.e. using a
large enough application cache), as well as continuing to want to
support setups where using a large enough postgres buffer cache isn't an
option because it'd prevent putting a number of variably used database
servers on one piece of hardware.

(There's also postgres side issues preventing us from doing O_DIRECT
performantly, partially because we so far couldn't rely on AIO, due to
also using buffered IO, but we're fixing that now.)


For us a per-request interface where we'd have to fulfill all the
requirements for O_DIRECT, but where neither reads nor writes would
cause a page to move in/out of the pagecache, would be optimal for a
good part of our IO. Especially when we still could get zero-copy IO for
the pretty common case that there's no pagecache presence for a file at
all.

That'd allow us to use zero copy writes for the common case of a file's
data fitting entirely in our cache, and us only occasionally writing the
deta out at checkpoints. And do zero copy reads for the the cases where
we know it's unnecessary for the kernel to cache (e.g. because we are
scanning a few TB of data on a machine with less memory, because we're
re-filling our cache after a restart, or because it's a maintenance
operation doing the reading). But still rely on the kernel page cache
for other reads where the kernel caching when memory is available is a
huge benefit.  Some well tuned workloads would turn that off, to only
use O_DIRECT, but everyone else would benefit with that being the
default.

We can concoct an approximation of that behaviour with a mix of
sync_file_range() (to force writeback), RWF_NOWAIT (to see if we should
read with O_DIRECT) and mmap()/mincore()/munmap() (to determine if
writes should use O_DIRECT). But that's quite a bit of overhead.

The reason that specifying this on a per-request basis would be useful
is mainly that that would allow us to avoid having to either have two
sets of FDs, or having to turn O_DIRECT on/off with fcntl.

Greetings,

Andres Freund
