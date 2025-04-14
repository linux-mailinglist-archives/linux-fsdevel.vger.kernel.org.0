Return-Path: <linux-fsdevel+bounces-46362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF408A87E86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93643B427B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 11:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687DB290BC0;
	Mon, 14 Apr 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uuqOhQnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5B269882
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628988; cv=none; b=QwlrHHMGEoPQEypPZNv7OnxaIC/M8fZYc868k0e841ckARnne/ciTG8THJAgh+wiU9iejjOyEGW/IAeDBzwBLpnZzgUoT5rRe89kfSasYWfBUZORZhqq56CHi0owGw/MvtG1NjGrVTWzumBNmBFmFOfVU14wGkt3J6uOWT0P3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628988; c=relaxed/simple;
	bh=q08922A4yKgEH82yvFth/K+0rlyEy0HZrUqvhFgN6pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoteuirvrmQYOurQ+eRry7Xv+c4d3TW4+UxlsLSAl67Uusnkyo5wF3IIjQR8b1o1LcLOocDPI7ZWdY6Zkc8sAJVcmc2cO1rVnu8SzJ6PMP6m/Nvk8CcRfFeGxbpMyQnjlYUBPEdSIKbICZeWiZ/u8BpxOkXG73l032TnV5Uceu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uuqOhQnz; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Apr 2025 07:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744628983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ3mkGGw8Px2MJlSAKgdSW9a06mMz6yRygMq5HG+vX8=;
	b=uuqOhQnzDrweD6ONhFmlYBc8f2GebBEemmxwH6/rVmtv4I7ZHJaxuX05Yr8EQfK8wzogbG
	8Tm9hF2Mop+rQfoWsoDwPZZ1f71Bj6lY59IMNQ8CptTB07b8DDQykSdBmZZ1zhUNOLTnMr
	EjmY0Y+4nIOa5VhSjOQar4BGwI7+K5c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] README: add supported fs list
Message-ID: <rh6l7ugjga6xj22wipaxrpveyxthpgngntdhp3czgatccdkz7w@sqbph4huj7fr>
References: <20250328164609.188062-1-zlang@kernel.org>
 <u2pigq4tq5aj5qvjrf3idna7hfdl6b4ciko5jvorkyorg25dck@4ti6fjx55hda>
 <20250414055857.w2zvapp3mjintgar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414055857.w2zvapp3mjintgar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 14, 2025 at 01:58:57PM +0800, Zorro Lang wrote:
> On Sun, Apr 13, 2025 at 05:56:08PM -0400, Kent Overstreet wrote:
> > I heavily use xfstests and look at the test results every day - I
> > believe that would indicate L3.
> 
> Glad to receive the response from bcachefs :) L3 means there're enough fs specific
> test cases in tests/$FSTYP besides generic cases, e.g. tests/overlay, or f2fs (although
> it only has a few currently, but it's increasing).

Active support for existing tests, or writing new tests?

To be blunt, fstests is not a great environment for writing tests, the
'golden master' model of pass/failure means debugging test failures is
archaic.

But those tests do get run and used, with active support.

> > bcachefs specific tests are not generally in fstests beacuse there's
> > lots of things that ktest can do that fstests can't, and I find it a bit
> > more modern (i.e. tests that names, not numbers)
> 
> ktest? linux/tools/testing/ktest/ ? I'm glad to learn about more test suites,
> I run fstests and LTP and some others too, fstests can't cover everything :)
> Hmm... about the names... fstests supports to append a name to the ID number,
> but the developers (looks like) prefer using number only all the time, then
> it become a "tradition" now.

No, not that. Does anyone even use that thing?

https://evilpiepirate.org/git/ktest.git/

It's a full CI - https://evilpiepirate.org/~testdashboard/ci

> 
> > 
> > Not all tests are passing (and won't be for awhile), but the remaining
> > stuff is non critical (i.e. fsync() error behaviour when the filesystem
> > has been shutdown, or certain device removal tests where the behaviour
> > could probably use some discussion.
> > 
> > But if you find e.g. a configuration that produces a generic/388 pop,
> > that would go to the top of the pile.
> > 
> > (I do have a few patches to the tests for bcachefs in my tree that I
> > really ought to get upstream).
> 
> Sure, warm welcome your patches. And don't worry, you can send patch to
> update the level part anytime when you think fstests supports becachefs
> more :)
> 
> Thanks,
> Zorro
> 
> > 
> 

