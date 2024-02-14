Return-Path: <linux-fsdevel+bounces-11553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7555854A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50942B21A0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5DE54BC4;
	Wed, 14 Feb 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="V99bcL2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEAA1A58B;
	Wed, 14 Feb 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917557; cv=none; b=EE9plZGEkkD5pxqQG6d2GnrfsARSgB3YHlza3JlhAPNuHqY9uHimFRvvlrAfNp+XTGU7Gdg9yDJkNUc6l437eDawwN5rqXihW4Ep5Gu5D1ch1hhFjJlCzFZjYb4kzJU9v9b3eyX6SRdiLXfmsRJeU25iBZMszBAHIEdD/Z7LYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917557; c=relaxed/simple;
	bh=hrcLabH8+U7ElLZ0gLy45aEV44/wRhwcyzbQZu9MBRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeoSJg5trscbtKH77dy91E5lVx1HqX6DmAeWnzN766ACJezBmfmkxVuPB7YERiUDvj7hMilDFZoMaDBuDEpUYcJmBpi4ZsKkWa231K20QL68q2iyInpXxMw4xrvudMsAYaEywCjjU0HkFKnG7Y6/Ntpot3e6z745ZGuKyF62nyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=V99bcL2n; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TZfJB4HhLz9scX;
	Wed, 14 Feb 2024 14:32:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707917546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHn8rk5ik3XE6uaEukHPeObORKT6c7Ek1ETigF2s+IU=;
	b=V99bcL2ni7adjAhC8IHUqrzSr0JqPbj69nW6nPE07i/Pk+2dzFdy90eD4lKa6JNoiVu84o
	27Pif9AbwYdbHqemp+GWNUfYl2vJavGsCid4TOKCFJB6pdHktGhQJG4qMok9p/Xugo1YA4
	bxnNUvmIhE2XrOrurCJqk334p8ECqROiKRK3+wb3NwTInsz9Wc3S7XwTa2x2lYRzSylhzz
	X6avpqZSMI388JMNFakWJTCQ4ugZJJtCF6Fjx/QtjJUiM+4t7bgfpJGVdI+lLtOIegIRTk
	jGM+vw1ua9h3mOSpefZo1o4WrmcXeoP7uoB6jQ9usUm5T+hJGy1TwoN+H3DQyw==
Date: Wed, 14 Feb 2024 14:32:20 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 04/14] readahead: set file_ra_state->ra_pages to be at
 least mapping_min_order
Message-ID: <c7fkrrjybapcf3h5sks3skb2ynv7hw4qpplw4kaimjkfas2nls@v522lehxqxqm>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-5-kernel@pankajraghav.com>
 <ZcvosYG9F0ImM9OS@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcvosYG9F0ImM9OS@dread.disaster.area>
X-Rspamd-Queue-Id: 4TZfJB4HhLz9scX

On Wed, Feb 14, 2024 at 09:09:53AM +1100, Dave Chinner wrote:
> On Tue, Feb 13, 2024 at 10:37:03AM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Set the file_ra_state->ra_pages in file_ra_state_init() to be at least
> > mapping_min_order of pages if the bdi->ra_pages is less than that.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  mm/readahead.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 2648ec4f0494..4fa7d0e65706 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -138,7 +138,12 @@
> >  void
> >  file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
> >  {
> > +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> > +	unsigned int max_pages = inode_to_bdi(mapping->host)->io_pages;
> > +
> >  	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> > +	if (ra->ra_pages < min_nrpages && min_nrpages < max_pages)
> > +		ra->ra_pages = min_nrpages;
> 
> Why do we want to clamp readahead in this case to io_pages?
> 
> We're still going to be allocating a min_order folio in the page
> cache, but it is far more efficient to initialise the entire folio
> all in a single readahead pass than it is to only partially fill it
> with data here and then have to issue and wait for more IO to bring
> the folio fully up to date before we can read out data out of it,
> right?

We are not clamping it to io_pages. ra_pages is set to min_nrpages if
bdi->ra_pages is less than the min_nrpages. The io_pages parameter is
used as a sanity check so that min_nrpages does not go beyond it.

So maybe, this is not the right place to check if we can at least send
min_nrpages to the backing device but instead do it during mount?

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

