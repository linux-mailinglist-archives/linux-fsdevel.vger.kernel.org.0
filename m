Return-Path: <linux-fsdevel+bounces-11451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284EC853DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D743E28FDFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56B062144;
	Tue, 13 Feb 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="EDLT+gC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BBC61686;
	Tue, 13 Feb 2024 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861256; cv=none; b=pLjgR7222qzz2KsHPryQoydK58MawEQ8bCU0n/qj2z5nmrxdBZ3lEbRbiKHsCmT/uWCrM8qLSFncNZyGxnF5p7a55kFzvkTbH2zSV6Ee4PtOsQHTa9g9c9smcgeF2dytMV/4jZZFTtlRErjYtpxYjhlux1Qov70mQLsLxkoRD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861256; c=relaxed/simple;
	bh=GUppTSmfam1ys5f9EqDy7hf9qiQZRXA2gouOv4/Syq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aom/QT60/+xXlbYkYs0q0g25cOfhpOAtK+3SojC4otWfoHIPJvAoXzbOgtwf2XDtDUvl+8pahfvSjs+sHUFohmvvkY4DYe686Hi1lOVMbF9i/zU1dyf2/EztcNwBnrh34dYBO6lCI2jG+Pu+NKayJl9sttiAfBma1KyS5GG+KdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=EDLT+gC7; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TZFTZ607Vz9sQ6;
	Tue, 13 Feb 2024 22:54:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707861250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fLfN/RqiUV819JYDvf/UizxUNqpKwyIkdbN6p8bRWMU=;
	b=EDLT+gC7WlxNwFr2JeadPIMZdtKWjHPhxclVF3cNviBrsb8N7ok4CPPaF7j0bQx2PW2uCv
	bRlPykPX/3AneYpyIaOwC2kEYCOs6sW4Q9IxyvwD2QwULgu7+8X8gCphJJWU5oLqsD+TiA
	p8IabZ/wf7vc6f4s7J3MJiDiEf+4waNFhDZbRCUVRuheYZb44EHyJbnqALMjtck8jLMYjQ
	koODrBNcl8cwpiyRuJ5fsK6WZIB4OeFfSLSTl7lj5QA3HopJLN0n1f0t48OO5M/8CsNDqP
	XvDT56leprxz7x+1eEvuwPNQRHNOXYucpYfl1TEmZgo+H4VO+ItvHN5eey2Ydw==
Date: Tue, 13 Feb 2024 22:54:07 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 13/14] xfs: add an experimental CONFIG_XFS_LBS option
Message-ID: <gsxwuko2bmajg7wshcxx26p5afmzi6hpvc5u6oecp5slnybdr6@fdky2ksbpvki>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-14-kernel@pankajraghav.com>
 <Zcvc20gqm6U6xaD0@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcvc20gqm6U6xaD0@dread.disaster.area>

On Wed, Feb 14, 2024 at 08:19:23AM +1100, Dave Chinner wrote:
> On Tue, Feb 13, 2024 at 10:37:12AM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Add an experimental CONFIG_XFS_LBS option to enable LBS support in XFS.
> > Retain the ASSERT for PAGE_SHIFT if CONFIG_XFS_LBS is not enabled.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> NAK.
> 
> There it no reason for this existing - the same code is run
> regardless of the state of this config variable just with a
> difference in min folio order. All it does is increase the test
> matrix arbitrarily - now we have two kernel configs we have to test
> and there's no good reason for doing that.

I did not have this CONFIG in the first round but I thought it might
help retain the existing behaviour until we deem the feature stable.

But I get your point. So we remove this CONFIG and just have an
experimental warning during mount when people are using the LBS support?

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

