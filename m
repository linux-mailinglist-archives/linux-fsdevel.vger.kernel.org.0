Return-Path: <linux-fsdevel+bounces-152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA747C6422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 06:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7627E2827E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 04:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0177563B3;
	Thu, 12 Oct 2023 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR6FB3Md"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47552B759
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 04:37:05 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02931B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 21:37:04 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7eef0b931so7661797b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 21:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697085423; x=1697690223; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5OuTYbjlFj2ZnZUysa+ox563mmr19kTFx3cd83SMJA=;
        b=bR6FB3MdhayRl1/0ey0RupRbvooUZ6o0GOpgayypmdBkz2ZWLNeyEKy9Ikc7S4g90f
         c/4HA0csVgbaMed+EqrpmKtvIRSaABoLmtwIV3xTpeLwVkOHFH8wORf0hMJAgjBs4INO
         rVNCjOvxSsD4ucS2boBRfal/2fG2fMh3FVv+T48fb0XeOjzZOhq+dGiw7n4i+MS5FmrK
         nlf8sQGQTfj0r+1+twNV6DgqduLVNlIVFMLu7iuDJjMAmxljQmroI/wVFJq4ttMV05i1
         khU9wkDcoAabzEwC0ZI0DwUy4pJx8mqJfGwmzK9RcxiZyyzP+Ce+EXFGvU+GPw6K8vMr
         lLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697085423; x=1697690223;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5OuTYbjlFj2ZnZUysa+ox563mmr19kTFx3cd83SMJA=;
        b=NvQWpdANxQ1wT/HpuR+9Lq/J9umFJqNiFDyjVHqtW2kLXUjHSpTu/yMHFfBOoKlDW2
         HoF817OZWbCYrNd9/n3g0DSdEpRAPZBaf0hPf3jrJoqA5v25Xl6jvl+5VLCSxEEHSmUY
         hz9qo3s1+Vv7brfHfHS4RS+iS0OfQ7dk2ALTgq7kjyyepAlyAPWh6yc/FAdtR/+i0N1x
         fMGBJ5r/Y0KivvUP/zYXGaED+tNLzWGOSfrG3e8dwFxWRKWe6n9B0Y6dPtU9rEXYuPbi
         ZCLfJ97n1NalNdmeTeo87neKVJn/yAUKwE7SMZfzLemtsn0eEuxHKrGSB49T955vzD9g
         o5Vg==
X-Gm-Message-State: AOJu0YxyWBOI0JMX+IdVVk/oQ8PiNYIaA5w/zWhBQk6c/i5l2GbY64zR
	t786c3SVKweOT98zRmXMxgQx8w==
X-Google-Smtp-Source: AGHT+IETdOSgEufuiDP0695WsR1MnpV5RMnezXFLEWIo7fsk77X2Wmp8S9Nzl8vTK4HM2wSRsqLU9A==
X-Received: by 2002:a81:c307:0:b0:594:e148:3c42 with SMTP id r7-20020a81c307000000b00594e1483c42mr20822490ywk.52.1697085422882;
        Wed, 11 Oct 2023 21:37:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w136-20020a0dd48e000000b0059b547b167esm5668442ywd.98.2023.10.11.21.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 21:37:02 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:36:59 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Dave Chinner <david@fromorbit.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Tim Chen <tim.c.chen@intel.com>, Dave Chinner <dchinner@redhat.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, 
    Christian Brauner <brauner@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
    Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Dennis Zhou <dennisszhou@gmail.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
In-Reply-To: <ZSNGMvICWWaKAaJL@dread.disaster.area>
Message-ID: <ddc21eb0-8fe9-c5c3-82c5-f8ac3e4a5a10@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com> <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com> <ZR3wzVJ019gH0DvS@dread.disaster.area> <2451f678-38b3-46c7-82fe-8eaf4d50a3a6@google.com> <ZSNGMvICWWaKAaJL@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023, Dave Chinner wrote:
> On Thu, Oct 05, 2023 at 10:35:33PM -0700, Hugh Dickins wrote:
> > On Thu, 5 Oct 2023, Dave Chinner wrote:
> > > 
> > > Hmmmm. IIUC, this only works for addition that approaches the limit
> > > from below?
> > 
> > That's certainly how I was thinking about it, and what I need for tmpfs.
> > Precisely what its limitations (haha) are, I'll have to take care to
> > spell out.
> > 
> > (IIRC - it's a while since I wrote it - it can be used for subtraction,
> > but goes the very slow way when it could go the fast way - uncompared
> > percpu_counter_sub() much better for that.  You might be proposing that
> > a tweak could adjust it to going the fast way when coming down from the
> > "limit", but going the slow way as it approaches 0 - that would be neat,
> > but I've not yet looked into whether it's feasily done.)

Easily done once I'd looked at it from the right angle.

> > 
> > > 
> > > So if we are approaching the limit from above (i.e. add of a
> > > negative amount, limit is zero) then this code doesn't work the same
> > > as the open-coded compare+add operation would?
> > 
> > To it and to me, a limit of 0 means nothing positive can be added
> > (and it immediately returns false for that case); and adding anything
> > negative would be an error since the positive would not have been allowed.
> > 
> > Would a negative limit have any use?

There was no reason to exclude it, once I was thinking clearly
about the comparisons.

> 
> I don't have any use for it, but the XFS case is decrementing free
> space to determine if ENOSPC has been hit. It's the opposite
> implemention to shmem, which increments used space to determine if
> ENOSPC is hit.

Right.

> 
> > It's definitely not allowing all the possibilities that you could arrange
> > with a separate compare and add; whether it's ruling out some useful
> > possibilities to which it can easily be generalized, I'm not sure.
> > 
> > Well worth a look - but it'll be easier for me to break it than get
> > it right, so I might just stick to adding some comments.
> > 
> > I might find that actually I prefer your way round: getting slower
> > as approaching 0, without any need for specifying a limit??  That the
> > tmpfs case pushed it in this direction, when it's better reversed?  Or
> > that might be an embarrassing delusion which I'll regret having mentioned.
> 
> I think there's cases for both approaching and upper limit from
> before and a lower limit from above. Both are the same "compare and
> add" algorithm, just with minor logic differences...

Good, thanks, you've saved me: I was getting a bit fundamentalist there,
thinking to offer one simplest primitive from which anything could be
built.  But when it came down to it, I had no enthusiam for rewriting
tmpfs's used_blocks as free_blocks, just to avoid that limit argument.

> 
> > > Hence I think this looks like a "add if result is less than"
> > > operation, which is distinct from then "add if result is greater
> > > than" operation that we use this same pattern for in XFS and ext4.
> > > Perhaps a better name is in order?
> > 
> > The name still seems good to me, but a comment above it on its
> > assumptions/limitations well worth adding.
> > 
> > I didn't find a percpu_counter_compare() in ext4, and haven't got
> 
> Go search for EXT4_FREECLUSTERS_WATERMARK....

Ah, not a percpu_counter_compare() user, but doing its own thing.

> 
> > far yet with understanding the XFS ones: tomorrow...
> 
> XFS detects being near ENOSPC to change the batch update size so
> taht when near ENOSPC the percpu counter always aggregates to the
> global sum on every modification. i.e. it becomes more accurate (but
> slower) near the ENOSPC threshold. Then if the result of the
> subtraction ends up being less than zero, it takes a lock (i.e. goes
> even slower!), undoes the subtraction that took it below zero, and
> determines if it can dip into the reserve pool or ENOSPC should be
> reported.
> 
> Some of that could be optimised, but we need that external "lock and
> undo" mechanism to manage the reserve pool space atomically at
> ENOSPC...

Thanks for going above and beyond with the description; but I'll be
honest and admit that I only looked quickly, and did not reach any
conclusion as to whether such usage could or should be converted
to percpu_counter_limited_add() - which would never take any XFS
locks, of course, so might just end up doubling the slow work.

But absolutely I agree with you, and thank you for pointing out,
how stupidly useless percpu_counter_limited_add() was for decrementing -
it was nothing more than a slow way of doing percpu_counter_sub().

I'm about to send in a 9/8, extending it to be more useful: thanks.

Hugh

