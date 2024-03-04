Return-Path: <linux-fsdevel+bounces-13487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9D870607
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A72287AD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F374481A5;
	Mon,  4 Mar 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="nCigb0N+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348F47A6A;
	Mon,  4 Mar 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566721; cv=none; b=WJQTydNlpKA/nHlz31ABJHLnVuKbmbbjwioUb+xilvYQdie9pYBDZVQ8cPZ3S80GbpDBz29B56IJKSZtUzk2Y/KZlE0jL6Mj2tPKuymkRJZxU1RTLoMBpXWmyTtrFqqZqbCurWzXwXRetawaCFBkQk7v9q8JN91rmpyF/X4e8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566721; c=relaxed/simple;
	bh=TrOySHR04QLD5g+v5qamK3nqWEg+PYHQLIH2Ny/A5bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5IQZi1PTc+HYJw3f9CbTfnebR98E7Di42mTHc4D15UF4tMR3RgenNHesZv22Tt4jx++bm2WfTHjkX6V5KkjoB/Z6BoTc9i07Q5P5W5ECrnLuIFQPgi8UHnTNA3MeAhf2uuNdyk+Iq0wjStMtC253NhxpbYefZHxMVrdyd+OVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=nCigb0N+; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TpNC02CXpz9t2x;
	Mon,  4 Mar 2024 16:38:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709566716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCUZrMhv+Ip6AlhQv9o/ZyuuqgJYxTQNgNIIwuFAJhg=;
	b=nCigb0N+NOC/Z7x7NK4bJ7M9+yqmc8/b9bw3lzKhp0Hwd9ojAausgLTzVrc1WS0moifMpl
	5Dyx7gEheOypByjZutu8yfpfcMISQamT9Fr+aLVBl4A/v3ye/jUtGJla2D5HT68lqkx/yA
	y9rCCQXBZe4IbOeNFWnHwBtrDLfGDqAW/zjonKERsI/7jMqAHmoxd9AQ8mW46gHr4j/pOE
	xlMj5xGeBQ5bHBk7MgyfcadTXw9pNn5mb61xaMpNl87L/6uPrfIS5WbJaDSMbihfkmW9bD
	95zSya837PM4+vyODLRrA8Coka9IfQLAqxh1txUNOl8nSkIDS5yamMvj7NXUmQ==
Date: Mon, 4 Mar 2024 16:38:31 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, djwong@kernel.org, mcgrof@kernel.org, linux-mm@kvack.org, 
	hare@suse.de, david@fromorbit.com, akpm@linux-foundation.org, 
	gost.dev@samsung.com, linux-kernel@vger.kernel.org, chandan.babu@oracle.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 03/13] filemap: align the index to mapping_min_order
 in the page cache
Message-ID: <mu5ajujhqqlriqow5nehawhtr2ywqi67xjisgcxd5p2lacmsrp@jurev3lqvopc>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
 <20240301164444.3799288-4-kernel@pankajraghav.com>
 <ZeIr_2fiEpWLgmsv@casper.infradead.org>
 <c5rw63nyg2tdkgeuvriu74jjv2vszy2luorhmv3gb4uz2z4msz@2ktshazjwc2n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5rw63nyg2tdkgeuvriu74jjv2vszy2luorhmv3gb4uz2z4msz@2ktshazjwc2n>
X-Rspamd-Queue-Id: 4TpNC02CXpz9t2x

On Fri, Mar 01, 2024 at 03:04:33PM -0500, Kent Overstreet wrote:
> On Fri, Mar 01, 2024 at 07:26:55PM +0000, Matthew Wilcox wrote:
> > On Fri, Mar 01, 2024 at 05:44:34PM +0100, Pankaj Raghav (Samsung) wrote:
> > > +#define DEFINE_READAHEAD_ALIGNED(ractl, f, r, m, i)			\
> > > +	struct readahead_control ractl = {				\
> > > +		.file = f,						\
> > > +		.mapping = m,						\
> > > +		.ra = r,						\
> > > +		._index = mapping_align_start_index(m, i),		\
> > > +	}
> > 
> > My point was that you didn't need to do any of this.
> > 
> > Look, I've tried to give constructive review, but I feel like I'm going
> > to have to be blunt.  There is no evidence of design or understanding
> > in these patches or their commit messages.  You don't have a coherent
> > message about "These things have to be aligned; these things can be at
> > arbitrary alignment".  If you have thought about it, it doesn't show.
> 
> Don't you think you might be going off a bit much? I looked over these
> patches after we talked privately, and they looked pretty sensible to
> me...
> 
> Yes, we _always_ want more thorough commit messages that properly
> explain the motivations for changes, but in my experience that's the
> thing that takes the longest to learn how to do well as an engineer...
> ease up abit.
> 
> > So, let's start off: Is the index in ractl aligned or not, and why do
> > you believe that's the right approach?  And review each of the patches
> > in this series with the answer to that question in mind because you are
> > currently inconsistent.
> 
> ^ this is a real point though, DEFINE_READAHEAD_ALIGNED() feels off to
> me.

Thanks Kent. I am going over the patches again and changing it based on
the feedback.

