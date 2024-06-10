Return-Path: <linux-fsdevel+bounces-21313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C59901BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 09:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489DD282FD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969793F8C7;
	Mon, 10 Jun 2024 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="An+Uh043"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6F3BB23;
	Mon, 10 Jun 2024 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004436; cv=none; b=PaYTLvOk+inrwtkgpryEnEe0qE1KuatKcxmdQPZS83CyPEvApBG3mwOSg9F5fRn6ruBAsASnr6LiNxcHmDxB+gE85hVP/CtY+kuz64RGyUGimdhdp3AHfR22XVeJpUSIYZSy1cdqpQ+POVjCELHCUPfvubYKQi1xGui1aS44yxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004436; c=relaxed/simple;
	bh=LVVbjbdC0h1myF0BjJQa4zSFEF6yQpkGEbeWYWDz0i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxIdAtN9mUsr4PROmhVzRLQRpbdCWz5ZC/XwNFqYnSVqRQ/MRqdMVCMuo+H/77quLqTUl41La2dH91UmWcXmMWDGf97u4K6TyA66sT1Eaqi5+mFS8YcIbjKzBA9Hk/HPMrpRmirMenJjxo/7h9ws8MjwNEkpLWeScmWiwjjxiNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=An+Uh043; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VyNfc5MG3z9sZ1;
	Mon, 10 Jun 2024 09:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718004424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iGob73/+SiPz4izhI7kTGZht0v2bPSc+GBGKwV0QDw=;
	b=An+Uh04344BjAG9Mk2nqabnGvtZ/+hXx1GPI0dI1WE8555DgD9yowev7iNOBrjihzcDVwd
	zGpq4FEZeEBpGok+5jATEJk0VeV6GOVwR/biqfE8HlOetnD2uKNbcQQLIrvK/h1vDDIOVx
	k2oIvMSRrHm+VFaMmzXI0sIvSYCL5GI4PgiWUoVsK2ijHTwrByUjV/sbIljXS5Ro6Q6gs9
	vzHkJ3HBKg3av+1TQUo7cMYppmB8lYKDL1P2VshdRS4VxBlsXChLKCl4IVXAgUDOqOMRTr
	QWiW4grDV6XL1fiCvfKX3Cp189+GzybvBLGD6dc0rnZHL8waLJoeUrvS32L0RQ==
Date: Mon, 10 Jun 2024 07:26:57 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: willy@infradead.org, david@fromorbit.com, djwong@kernel.org,
	chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, mcgrof@kernel.org, linux-mm@kvack.org,
	hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 05/11] mm: split a folio in minimum folio order chunks
Message-ID: <20240610072657.erdzkedvbzj3gohu@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-6-kernel@pankajraghav.com>
 <75CCE180-EC90-4BDC-B5D8-0ED1B710BE49@nvidia.com>
 <20240607203026.zj3akxdjeykchnnf@quentin>
 <45567EBA-5856-4BBC-8C02-EAE03A676B94@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45567EBA-5856-4BBC-8C02-EAE03A676B94@nvidia.com>
X-Rspamd-Queue-Id: 4VyNfc5MG3z9sZ1

On Fri, Jun 07, 2024 at 04:51:04PM -0400, Zi Yan wrote:
> On 7 Jun 2024, at 16:30, Pankaj Raghav (Samsung) wrote:
> >>> +		if (!folio->mapping) {
> >>> +			count_vm_event(THP_SPLIT_PAGE_FAILED);
> >>
> >> You should only increase this counter when the input folio is a THP, namely
> >> folio_test_pmd_mappable(folio) is true. For other large folios, we will
> >> need a separate counter. Something like MTHP_STAT_FILE_SPLIT_FAILED.
> >> See enum mthp_stat_item in include/linux/huge_mm.h.
> >>
> > Hmm, but we don't have mTHP support for non-anonymous memory right? In
> > that case it won't be applicable for file backed memory?
> 
> Large folio support in page cache precedes mTHP (large anonymous folio),
> thanks to willy's work. mTHP is more like a subset of large folio.
> There is no specific counters for page cache large folio. If you think
> it is worth tracking folios with orders between 0 and 9 (exclusive),
> you can add counters. Matthew, what is your take on this?

Got it. I think this is out of scope for this series but something we
could consider as a future enhancement?

In any case, we need to decide whether we need to count truncation as a 
VM event or not.

