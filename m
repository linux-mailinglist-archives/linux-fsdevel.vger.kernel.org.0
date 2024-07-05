Return-Path: <linux-fsdevel+bounces-23207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B6928A97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1853E287E35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464B16A94A;
	Fri,  5 Jul 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="DLXx8XjT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B214B07E;
	Fri,  5 Jul 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189166; cv=none; b=R0dL7KpxLxZ0eoEaivO7t+nlaIMRiIRx/e3myY45Z/IiN5SBqmRIc3g32AmFFWXflk4+mpI43n5YC+pkTenj4vbPgtwyBgX3MhUwMJ4HLuk6vIZngMl027B6k6Yu4kauVjjbFzt6o3byt8HHY/hKr3QvD4VbU/x0t/cOdBUI8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189166; c=relaxed/simple;
	bh=9i3bwHgIdlTydSApcbRnBQwAcvIYW5YuftO1PTzhyRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL266L3YQ0rTc2xO03cVQE/MYqsuBrRn7EkQOqnOMTF98doN8GDiEVFGnhMLVrVY4W/4FCWJDFT5/iBA047mAg7MmTlCWpv+7DpkoFCa1Gt01uCF8GZWtgUZIV5BblkPVB/vL81+Uy9nDWYXj/evD0T4+6ZTj3pBGMnAsfyjSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=DLXx8XjT; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WFwcg1fX1z9tGB;
	Fri,  5 Jul 2024 16:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720189155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ebu8sK6BukO3lLURMplNxavYrXjjHfqDLjXeOhdJfo8=;
	b=DLXx8XjT6eR5GyEh/sIiJ/bGQZYBG9JVM2U9YTBDT4qkrAeR3bSKl960dXQoBGuK0b4HAq
	Ax6NkOZqbR9n3HLTsvul3xLXvyfTAW3JhHXRRF6UuJyeGVWW8MAfZa4Van79qm95jZTDBf
	XZIoc+kium4ipfHa5pdnpz0fuJwIwbJ4rWD9v4jctPoRRnP13RkrAaaCRnAEzF/UBybdU6
	nNPMpF7ZsPGD4xc+2NdB9CugFZq44SN8rJzKco0FA8v9SoV5PkJesC3eg1Dy+D5rinO4gb
	zFfXe0CZcBblAfS7hXp9s0nvOzgzqnaIiuEUf0u1zj6QbADBDXgwgAMEUFRaNQ==
Date: Fri, 5 Jul 2024 14:19:11 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Dave Chinner <david@fromorbit.com>, willy@infradead.org,
	chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
	akpm@linux-foundation.org, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	p.raghav@samsung.com, mcgrof@kernel.org, gost.dev@samsung.com,
	cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240705141911.zamclkk7iajcvwik@quentin>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <20240704112320.82104-7-kernel@pankajraghav.com>
 <2c09ebbd-1704-46e3-a453-b4cd07940325@suse.de>
 <ZoceivBuLIcylaxk@dread.disaster.area>
 <da1d2eea-b7b1-467c-84e0-623d4ec3af55@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1d2eea-b7b1-467c-84e0-623d4ec3af55@suse.de>

> > > 
> > > There are other users of ZERO_PAGE, most notably in fs/direct-io.c and
> > > block/blk-lib.c. Any chance to make this available to them?
> > 
> > Please, no.
> > 
> > We need to stop feature creeping this patchset and bring it to a
> > close. If changing code entirely unrelated to this patchset is
> > desired, please do it as a separate independent set of patches.
> > 
> Agree; it was a suggestion only.

I was going to say the same thing that Dave said as well as we are 
almost there with this series :)

But I will add your suggestion in my TODO. It would be good to have some
common infra to avoid allocating larger zero pages all over the place.

> 
> Pankaj, you can add my:
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Thanks Hannes.

