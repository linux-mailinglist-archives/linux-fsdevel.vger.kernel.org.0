Return-Path: <linux-fsdevel+bounces-56838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701ADB1C629
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 14:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964B97216D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A123628B4EF;
	Wed,  6 Aug 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="QMucSp9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5F26A1C9;
	Wed,  6 Aug 2025 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484230; cv=none; b=Tc+4lq+uEHx9POyiw1RVqXrY1DoE0FaacL9N6qBHDNSnL8UlsGxS0fgtUNhGU0Wzh0A9YSEcqWBNLeeoRSSI1RqXmVGa2Kwu+s07sq4wf03iT9bBXcYOxwZM7F37qrLvmI2O8opngY+rrwFgATbv5Jz+zvjb56hHS3yDRMJpKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484230; c=relaxed/simple;
	bh=8n3taMBmOxYj96LCxoNQDUV4w13/wrkzPY2ufMu9uaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVocpACTgufQTB+mCqiPeHP3Ow/XEhp28XpFnvZ66vzhHzjLf0PbLiX4D3m9vlXDA0D3cjCUh7BzGOpwPsV/hVg9lbbXBFLSVqwZZ9MAOwi4UfrxRqq2Y/peyuySVb57wPkXdQlcrsxUjLpDI3KbTG8uxMLuiTZke98ssEbBlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=QMucSp9y; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxqjC35nkz9tGN;
	Wed,  6 Aug 2025 14:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754484223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZophTKdo4O3A36vGcC5G0lV5mUY9trAmIEPn+lZrbVg=;
	b=QMucSp9yjzTRGS3JNNwUENMKvP5/sRhXP+HKsADS77xEB0DQ47TT+6Nm3BywgS+3ZTWgE8
	FDVYRrg6d651lQ3fvj/bKEUJaL+NNjcReQYrtHwEKkrCZMgTLevtAxm92vk66VagiGM2Bv
	VchgcKSTtEYhg17rYrQuY5vEjVZoc7cqxesoLvL2LqtvH1bdkXk3BUqp+NBFJE0OPAhGjo
	+UP/o6D799+eZyGQQQkRu8KFKW8ZjZ+4Tx7tj2cJC1n/bjv+OJdRL1eQqLVGrgSmUE8L1N
	0GaHRhouyJPzw12uHKykUG9ZpLjcTfNs+FEk/sIuuTKW3qClFdaVOLgvhZt+1A==
Date: Wed, 6 Aug 2025 14:43:32 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
Message-ID: <lyfgmdjehtfjb2gmj5ciao6l5lmkvlfe54wtlnlhjjf7ge65sa@2dyo3tb6ka4i>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
 <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
 <bmngjssdvffqvnfcoledenlxefdqesvfv7l6os5lfpurmczfw5@mn7jouglo72s>
 <e67479f5-e8ed-43a7-8793-c6bff04ff1f4@redhat.com>
 <iputzuntgitahlu3qu2sg5zbzido43ncykcefqawjpkbnvodtn@22gzzl5t77ct>
 <9a657c84-99fe-41ba-88ca-097acab4b96b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a657c84-99fe-41ba-88ca-097acab4b96b@redhat.com>

On Wed, Aug 06, 2025 at 02:36:51PM +0200, David Hildenbrand wrote:
> On 06.08.25 14:28, Pankaj Raghav (Samsung) wrote:
> > On Wed, Aug 06, 2025 at 02:24:28PM +0200, David Hildenbrand wrote:
> > > On 06.08.25 14:18, Pankaj Raghav (Samsung) wrote:
> > > > > We could go one step further and special case in mm_get_huge_zero_folio() +
> > > > > mm_put_huge_zero_folio() on CONFIG_STATIC_HUGE_ZERO_FOLIO.
> > > > > 
> > > > 
> > > > Hmm, but we could have also failed to allocate even though the option
> > > > was enabled.
> > > 
> > > Then we return huge_zero_folio, which is NULL?
> > > 
> > > Or what are you concerned about?
> > 
> > But don't we want to keep the "dynamic" allocation part be present even
> > though we failed to allocate it statically in the shrinker_init?
> > 
> > Mainly so that the existing users of mm_get_huge_zero_folio() are not affected by
> > these changes.
> 
> I would just keep it simple and say that if we fail the early allocation
> (which will be extremely unlikely that early during boot!), just don't ever
> try to reallocate, even not when we could through mm_get_huge_zero_folio().
> 
> That sounds as simple as it gets. Again, failing to allocate that early and
> then succeeding to allocate later is a fairly unlikely scenario.

Ok. I will also document this as a comment just so that people are aware of
this behaviour.

Thanks a lot David for the comments and feedback!

-- 
Pankaj Raghav

