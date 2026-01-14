Return-Path: <linux-fsdevel+bounces-73730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C57D1F6B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80A203005323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B372DC320;
	Wed, 14 Jan 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lq358vOq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4952DC359
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400938; cv=none; b=tc0g6efa80QtTObxdi4xmuyPE++SsT9Wgh+wnHqUVZ0NKyTVZhWlZBQ8Nd7dM4vsKvWD9yLD/7H88JTTn7K9S607C7X8TdS5tH1sIOz8Pg9LFrpSWFpgUVA1/iIIha9wdBOSid5It9dw4FOAWQrJ3z+2sOk8kmUNLhxRR05yVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400938; c=relaxed/simple;
	bh=UojViaU56pXUxWouNvjF1vVrui2idCwIBHYqDGuqvf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSHyRse8TYriyFttDL8RSAxCbkAuGdYAcRyIGwpyxhoPlMuy4Ol/EV2JTDHcJYK+09FbSHQoGckL9Jc7kl+EXEftIVvh5Tr7vsPLZduEXhjmlmP1mZ/oNMfu7RSCJy7y+20BNpu1mZInUTqTzY0SMPS8vRejn2F1dTy8lzfbvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lq358vOq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MDq7CnLwcVfHk/Yxuues6u7FOlIZmPjkJM3N9g6aVQw=; b=lq358vOqh9ZIA0cr9603vjg572
	cFUKi9fun0XBLnC5oQll+iEFnk/nla13/637NiGoVhV35lUHK5sVVSMyQOMrnpOUSNLlBD99s2DJv
	fRXblW1HaesVIaOVRQNchu0j4R6F5ZbiNt82N6Xz67cbzqyAs40Pdq6/EgnWlDyVi2KAkqbUju+Rw
	BQzygleAw/VBXaYVa4Svm448mCStQrmoSa/9DZM3ulToYHRYiH3LhnhKMGfUs4spJiIIcLCwSGf34
	bH0IkcPDuvTLhkuM2Xbd7PceqC14+9gS9gndcqI/KfmjiYAPcfKevgEIZ2ImZ3Jnmqh43xQKaqd4s
	SatiUeXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vg1t7-0000000HZij-2qV1;
	Wed, 14 Jan 2026 14:30:21 +0000
Date: Wed, 14 Jan 2026 14:30:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linux-fsdevel@vger.kernel.org
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
Message-ID: <20260114143021.GU3634291@ZenIV>
References: <20260113194936.GQ3634291@ZenIV>
 <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 14, 2026 at 09:35:48AM +0100, Andrea Cervesato wrote:
> Hi!
> 
> On Tue Jan 13, 2026 at 8:49 PM CET, Al Viro wrote:
> > 	There are different causes of ENAMETOOLONG.  It might come from
> > filesystem rejecting an excessively long pathname component, but there's
> > also "pathname is longer than PATH_MAX bytes, including terminating NUL"
> > and that doesn't get checked anywhere.
> >
> > 	Ran into that when a braino in kernel patch broke that logics
> > (ending up with cutoff too low) and that didn't get caught by LTP run.
> >
> > 	Patch below adds the checks to one of the tests that do deal
> > with the other source of ENAMETOOLONG; it almost certainly not the
> > right use of infrastructure, though.
> 
> The description is not well formatted, spaces at the beginning of the
> phrases should be removed.
> 
> Also, we can make it slightly more clear, by saying that error can be
> caused by a path name that is bigger than NAME_MAX, if relative, or
> bigger than PATH_MAX, if absolute (when we use '/').

Huh?  Absolute pathname is the one that _starts_ with '/'; e.g. "../include"
is relative, not absolute, despite having a '/' in it.

> In this test we only verifies if relative paths are longer than
> NAME_MAX (we give 273 bytes instead of 255 max), but we don't test if
> path name is bigger than PATH_MAX.
> 
> We should correctly distinguish these two cases inside the test with
> proper names as well. Check below..

> https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#guarded-buffers-introduction
> 
> Many old tests are not using these buffers, but it's better to
> introduce them when a test is refactored or fixed, like in this case.
> 
> You need to define:
> 
> static char *long_rel_path;
> static char *long_abs_path;
> 
> ...
> 
> static void setup(void) {
> 	..
> 	// initialize long_rel_path content
> 	// initialize long_abs_path content
> }
> 
> static struct tst_test test = {
> 	..
> 	.bufs = (struct tst_buffer []) {
> 		{&long_rel_path, .size = NAME_MAX + 10},
> 		{&long_abs_path, .size = PATH_MAX + 10},
> 		{}
> 	}
> };

> > -	TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
> > +	if (tcases[i].exp_errno)
> > +		TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
> > +	else
> > +		TST_EXP_PASS(chdir(tcases[i].dir), "chdir()");
> 
> In this test we only verify errors, so TST_EXP_PASS is not needed.

Er...  Intent was to verify two things: that anything longer than PATH_MAX triggers
ENAMETOOLONG, but anything up to PATH_MAX does not.  Having a pathname of exactly
4095 '/' (or interleaved . and / in the same amount, etc.) be rejected with ENAMETOOLONG
is just as much of a failure as not triggering ENAMETOOLONG on anything longer...

FWIW, I considered something like
	mkdir("subdirectory", 0700);
concatenating enough copies of "subdirectory/../" to get just under PATH_MAX and appending
"././././././././" to the end, so that truncation to PATH_MAX and to PATH_MAX-1 would
both be otherwise valid paths; decided that it's better to keep it simpler - a pile of
slashes is easier to produce and would resolve to a valid directory if not for the
total length restrictions.

