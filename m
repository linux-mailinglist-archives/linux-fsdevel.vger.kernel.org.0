Return-Path: <linux-fsdevel+bounces-32113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE6F9A0AFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 15:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEA1281DF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70C208D99;
	Wed, 16 Oct 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="huMirWV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C35208967
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083982; cv=none; b=RjPBEgOgD1scXEZiNaCfZO5f8QiEWhr0RWYQ5QsEy75J/hnNTNWxTtJWLt9v8pQhzFv+J+XuTH1Qf861TEl5P2ukMVDEJOkBFW/TKWsbU2AHs44NGRfujb+oNejI6BGNY7p4rUI5bsAWqvGadl6+l8SRLRx5UQYNARiqZY9PVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083982; c=relaxed/simple;
	bh=oN5bRtKHfJ2Z49aHnr6hdA9QvN+hIfD2CN6uwWim2bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQORdXWi1eMsI4LepS8bLPq7HNSEGBEQLQI+jape+g6tJ5IOkwx0kCne+50e4JHyd+LxxnvlRw0aWuYbNAGBaMUltJZgtWvjNM48C8fqy3vkqZT3brutp+Te1C7tAPssPVReCgVrEuZaSPoWkxoEmfwg+9DtSGE9Rybem7d6sWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=huMirWV9; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XTB6w6qgFz9sRx;
	Wed, 16 Oct 2024 15:06:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729083977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JCi90PWGZerW7sJN/H2MblCN/ThnlTZy4Lel3S1pN6s=;
	b=huMirWV9AVz/JD6v7UbrVon5zhbh8lKKFaIu3W20e91cQx0rWWjrILRFyY+Yxy/2vP6+zU
	gnwSo/uv5jSSuZwbBP9rzGbh4Ea4LqMk84x6vAFRcztfoxlTcHN/ZvaNmtqPgK/t10/6Nc
	hrbVDaZd5Hb1HO+0TGverW2iVUTHvRzMGv0NEf5TUXEiHiF1D/9d78IBG9RMlEm0Cq6Y91
	RJc11YmGKp4fePwfiLF1UKeiDwVm0ZU6rS4ngLe91G06ZIRSXwDwdzNvPiHT2WAv+UCOjU
	eZBlqWOe6KCQjSr+JliKMvQ8Z2XVAxSh8kFUWAh8zvsDCHLX/s7VrAxcJ705Ig==
Date: Wed, 16 Oct 2024 18:36:04 +0530
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: Re: Re: [PATCH v14] mm: don't set readahead flag on a folio when
 lookahead_size > nr_to_read
Message-ID: <sokq3z55j3xwxjktvsnssxcldnmzbqax5wp4wcturof4f3jqp4@izfk6jzzifjh>
References: <20241015164106.465253-1-kernel@pankajraghav.com>
 <Zw6nVz-Y6l-4bDbt@casper.infradead.org>
 <cwugg63urgcknylwum4lfcxyemx3epcejfchrpfwcii5pvsp3k@2f5d5kjw7tlq>
 <Zw-qOAOM2je3EHb1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw-qOAOM2je3EHb1@casper.infradead.org>

On Wed, Oct 16, 2024 at 12:57:44PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 16, 2024 at 03:35:27PM +0530, Pankaj Raghav (Samsung) wrote:
> > > > - The current calculation for `mark` with mapping_min_order > 0 gives
> > > >   incorrect results when lookahead_size > nr_to_read due to rounding
> > > >   up operation.
> > > > 
> > > > Explicitly initialize `mark` to be ULONG_MAX and only calculate it
> > > > when lookahead_size is within the readahead window.
> > > 
> > > You haven't really spelled out the consequences of this properly.
> > > Perhaps a worked example would help.
> > 
> > Got it. I saw this while running generic/476 on XFS with 64k block size.
> > 
> > Let's assume the following values:
> > index = 128
> > nr_to_read = 16
> > lookahead_size = 28
> > mapping_min_order = 4 (16 pages)
> > 
> > The lookahead_size is actually lying outside the current readahead
> > window. The calculation without this patch will result in incorrect mark
> > as follows:
> > 
> > ra_folio_index = round_up(128 + 16 - 28, 16) = 128;
> > mark = 128 - 128 = 0;
> > 
> > So we will be marking the folio on 0th index with RA flag, even though

Oops. I shouldn't have said 0th index. I meant at offset 0 from the
index.

> > we shouldn't have. Does that make sense?
> 
> But we don't go back and find the folio for index 0.  We only consider
> the folios we're actually reading for marking.  So if 'mark' lies
> outside the readahead window, we simply won't mark any of them.  So I

`mark` is the offset from index. So we compare `mark` with the 
iterator `i`, which starts at 0. So we will set the RA flag on index
128 in this example, which is not correct.

if (i == mark)
	folio_set_readahead(folio);

With this patch, mark will be ULONG_MAX and not 0.

> don't think your patch changes anything.  Or did I miss something?

Does that make sense?


