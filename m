Return-Path: <linux-fsdevel+bounces-1976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82497E10F8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 21:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD10280C63
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111DB249E8;
	Sat,  4 Nov 2023 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sayOeULR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE5199C6
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 20:51:09 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924FD51
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 13:51:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b565722c0eso1956609b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Nov 2023 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1699131066; x=1699735866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pE0K/9VnOJCGWvF4gF1lqA6403pQnDy2sJItLf7z9PQ=;
        b=sayOeULRT5cIYkcJ3S8/LQ/Guw2qFNKr7+3iAf3CTMm+td67yOu9Pmsi5UAr0j+Bco
         QxmRzU611riqXqvyMQQPAGTxDBh3hpCbYkPAlYLkof6bS/P0IQu5OhrE4+Uezc5dce+U
         ELpyEm1pvRRUlZMIIUKoGQp7NoQ3bW48lAOtMWT4P/ZYN69nEal8k9iGbk07tEczAuTg
         OPwgFstlHRHlZBUqj867lHbT+l7SoXoBuc0uv0MuFI9xSUaS4mz5NhjMAzV/oMIpQQSD
         GNN3MuktAsziIadOn5wrY0Agti2zRoxYXfT5OQmnXivm1QpCeZsx3C/mqLo1pnkGtmBR
         fr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699131066; x=1699735866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE0K/9VnOJCGWvF4gF1lqA6403pQnDy2sJItLf7z9PQ=;
        b=uxJ+VsvTFvqe92MhaHcBb3U18rF2FUU+byw466i/ky+bVokDOTB25HyboegjeCFkp2
         Zp3KAFqsyGa/PmpGqmPSJ3oEEqbouIGs5SoINtPKLZAOl5/AZ19woHRzeYXlToYmP2I/
         I9JZJaJLyl8e/khOFLY8NbpB+On5zRZ3VfsUK7sFu3xraxXUlK/yhYNbLC1KDcPm55wY
         CSt53YCLF7SzNSS9agsRa4nkMXD8sqHhH/ExQLvcRMY1Wfcvt4zCXBKR2jj2RveOVnpC
         aCvRruHrVToCqZrhSu7tAd7gRjmyOZCAUoEKsUu99QVpLQY5ojUoyw5crovJk7VyVinN
         L0jw==
X-Gm-Message-State: AOJu0YwnpHjPuPmTYgeVr+R/Fiqn84AkyUueEePKO+8mBFn/gX5DdiGP
	GTw88CqggcaSFL5ikQHXQw6gcQ==
X-Google-Smtp-Source: AGHT+IESpBjkAr5VpW5cchvNy6u10H1qaU2fJIdWZ/8c14jdwPGnvFGsmXjjI+SZ/37k5I5RvY+xeA==
X-Received: by 2002:a05:6808:1207:b0:3b5:6604:a8ba with SMTP id a7-20020a056808120700b003b56604a8bamr16729517oil.36.1699131066074;
        Sat, 04 Nov 2023 13:51:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id q4-20020a056a0002a400b006be4bb0d2dcsm3375711pfs.149.2023.11.04.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 13:51:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qzNbi-008FsO-21;
	Sun, 05 Nov 2023 07:51:02 +1100
Date: Sun, 5 Nov 2023 07:51:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <ZUautmLUcRyUqZZ+@dread.disaster.area>
References: <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f>
 <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area>
 <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
 <ZTYAUyiTYsX43O9F@dread.disaster.area>
 <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>
 <20231031-proviant-anrollen-d2245037ce97@brauner>
 <20231102023615.jsv2ffe4rbivgsja@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102023615.jsv2ffe4rbivgsja@moria.home.lan>

On Wed, Nov 01, 2023 at 10:36:15PM -0400, Kent Overstreet wrote:
> On Tue, Oct 31, 2023 at 12:02:47PM +0100, Christian Brauner wrote:
> > > The follow up including a statement about "being arsed" once more was
> > > to Christian, not you and was rather "tongue in cheek".
> > 
> > Fyi, I can't be arsed to be talked to like that.
> > 
> > > Whether the patch is ready for reviews and whatnot is your call to
> > > make as the author.
> > 
> > This is basically why that patch never staid in -next. Dave said this
> > patch is meaningless without his other patchs and I had no reason to
> > doubt that claim nor currently the cycles to benchmark and disprove it.
> 
> It was a big benefit to bcachefs performance, and I've had it in my tree
> for quite some time. Was there any other holdup?

Plenty.

- A lack of recent validation against ext4, btrfs and other
filesystems.
- the loss of lockdep coverage by moving to bit locks
- it breaks CONFIG_PREEMPT_RT=y because we nest other spinlocks
  inside the inode_hash_lock and we can't do that if we convert the
  inode hash to bit locks because RT makes spinlocks sleeping locks.
- There's been additions for lockless RCU inode hash lookups from
  AFS and ext4 in weird, uncommon corner cases and I have no idea
  how to validate they still work correctly with hash-bl. I suspect
  they should just go away with hash-bl, but....

There's more, but these are the big ones.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

