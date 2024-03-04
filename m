Return-Path: <linux-fsdevel+bounces-13486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4D87060B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2DB2BE86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78465B5B8;
	Mon,  4 Mar 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="XZ213hoq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AB5A78D;
	Mon,  4 Mar 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566608; cv=none; b=iTTKjiOF6LV2U//ADmS1sd9nsPixaxTlQCyU+/D47WppTVUd+41QcZmgI0X9WK89YpJxQ2bEcmoCFiS1Ro4RtATq3mZ+AfdTI4PvzZ0v/XO8ai1wzENK+bTPcR35DCIb0TETicy3euiNQjMKOYtD0b9n2iVQC/oEs0NSbyTvCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566608; c=relaxed/simple;
	bh=27ZEQY1OYJTwJ8N3KSiYrgwBNlU92bOu1XfV8mj6bjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHINNEVD3A1ERsxFmtsc//vvMBCwTWAAqYOte6xDBSP+xSn7+uU731yRUkp0utNEwxs63k+G+dbZ2asCFsGB11jCB1d/7hpOXlWCLDJrH1G1R5nzP39ujMUocEHlP6qE0ez2MIfE84ZHBZtMQY9X7q8yIzNRZ9Do/zLYXChxnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=XZ213hoq; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TpN8p4q7Hz9tYJ;
	Mon,  4 Mar 2024 16:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709566602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOKwtz1OnhAxtbDBuKtXT/Xq4RMrHi4ST4yvlFkJb6g=;
	b=XZ213hoq4xNhbJ19fxAiIm/ZtWfY3ZX1T/O9/2/Ay1pSrdChz8dUXG/AtOfjGdeat5jUtM
	Do7WVRj1j03L4mGyucjrLhQw+ECx47fs23dV1ZEkD+hquLfaRdbcnzX8NH7YsFnivM9e99
	QOFFPeuEGMvpzKunQZ+J8fTwnxPu41I3Zdi8oPf4Rw7+gPdEPrIW0DBLgAi8zAVIpCuA6m
	cCk8r1R3THOPf8RMrYg4/h/lz7Fzk8jkjjABH+jvkIiOJV9sgxYCaFZzoS7HOTjmb0Htf4
	gP/oRdR9nNXp7xHWfxLr2shVCvljt0tkeOZtFepA866Vd+HiqV8AU1oZZ/BUIQ==
Date: Mon, 4 Mar 2024 16:36:34 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	djwong@kernel.org, mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de, 
	david@fromorbit.com, akpm@linux-foundation.org, gost.dev@samsung.com, 
	linux-kernel@vger.kernel.org, chandan.babu@oracle.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 03/13] filemap: align the index to mapping_min_order
 in the page cache
Message-ID: <ofna2ao4w5aywviupntdz6m5xos6qb5btdxxixkyosfw45exwp@iuuexfq62qhr>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
 <20240301164444.3799288-4-kernel@pankajraghav.com>
 <ZeIr_2fiEpWLgmsv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeIr_2fiEpWLgmsv@casper.infradead.org>

On Fri, Mar 01, 2024 at 07:26:55PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 01, 2024 at 05:44:34PM +0100, Pankaj Raghav (Samsung) wrote:
> > +#define DEFINE_READAHEAD_ALIGNED(ractl, f, r, m, i)			\
> > +	struct readahead_control ractl = {				\
> > +		.file = f,						\
> > +		.mapping = m,						\
> > +		.ra = r,						\
> > +		._index = mapping_align_start_index(m, i),		\
> > +	}
> 
> My point was that you didn't need to do any of this.
> 
Got it. I probably didn't understand your old comment properly.

> Look, I've tried to give constructive review, but I feel like I'm going
> to have to be blunt.  There is no evidence of design or understanding
> in these patches or their commit messages.  You don't have a coherent
> message about "These things have to be aligned; these things can be at
> arbitrary alignment".  If you have thought about it, it doesn't show.
> 
> Maybe you just need to go back over the patches and read them as a series,
> but it feels like "Oh, there's a hole here, patch it; another hole here,
> patch it" without thinking about what's going on and why.
> 
> I want to help, but it feels like it'd be easier to do all the work myself
> at this point, and that's not good for me, and it's not good for you.
> 
> So, let's start off: Is the index in ractl aligned or not, and why do
> you believe that's the right approach?  And review each of the patches
> in this series with the answer to that question in mind because you are
> currently inconsistent.

Thanks for the feedback, and I get your comment about inconsistentency,
especially in the part where we align the index probably in places where
it doesn't even matter. As someone who is a bit new to the inner
workings of the page cache, I was a bit unsure about choosing the right
abstracation to enforce alignment.

I am going through all the patches now based on your feedback and
changing the commit messages to clarify the intent.

--
Pankaj

