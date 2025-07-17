Return-Path: <linux-fsdevel+bounces-55237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419CDB08AFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 12:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3281C1752F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC329A326;
	Thu, 17 Jul 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="IhJUYENm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59642046B3;
	Thu, 17 Jul 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749036; cv=none; b=JiNzT0x906dS6/euRqR54WTnVxxNLxL6wtI6K5CoNtsRLmHN7+AHg2vkOoycE33+OiKHskBQt5beiQqajVi2+ttjKxVSqIPHKqbc25FI/SP6jJY7hOshwnthew3WqPph+YOs+xQdvdZRJakycNZBmmQVZJliEuZ4RHZde07BkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749036; c=relaxed/simple;
	bh=HC9R4zYk3BPZBipB3KfLaf2TbWkZjH7VUczvHOGeXVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7Atiz33zL5O5dsxYseK/tMw7EIaYaqadn/lK9hkXFx2eM/TR6rcGpQhUdsBvhm/qP7t1tsnY5dA9ZaGqrO/XUPekiU1GZnoLW1goi45ICujryOE0gs97gERIrj/ZHQU56PQNuN3XRsf5IBoVjdgZbZ9yNTfZWBBVKJC9jotaDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=IhJUYENm; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bjV07091Yz9sWQ;
	Thu, 17 Jul 2025 12:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752749031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xHfcT+a9EpXlxQ4yABCPQ6TAiqJotc4d3YX9oBajeRo=;
	b=IhJUYENmGgsHvgZMQ/r9GV+csrVUBCPDx6gnPnm4YjemBiGqjvUpf/+K2oEPeK/9Qk0ju1
	sFpVs6diFbSXh3fPuHSOankyWFSnLQRGOoBoR/yHGTOnQfV1QxtpG8u0lebdxKGLPyr0fu
	gJc1RQYsGms6/CEy2YC6BtJ59wW9wyvka3MizTmR+QHsQQYGYM4izeuW/SzzzyNGgjceve
	BefQ89b9Ks70+jw2B4WfNZECeWKyqyztgOTiN5rYRfpXBc0Uaa7DbLAgz3/PPktjOejoui
	KZ+usenk1miQtYFf/v/5B8eiRgCi3CcO/rymKwcw1+oPxFAp+z0dGuWT78+lxQ==
Date: Thu, 17 Jul 2025 12:43:41 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
Message-ID: <7zx7y5nhtgxhgc2jzs7prfb2yxxaullqs4e2mfw4uuz2xsc6t4@hp3d37dmsfea>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <cb177185-ba7e-4084-a832-7f525f5cc6eb@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb177185-ba7e-4084-a832-7f525f5cc6eb@lucifer.local>

Hi Lorenzo,

On Tue, Jul 15, 2025 at 04:34:45PM +0100, Lorenzo Stoakes wrote:
> Pankaj,
> 
> There seems to be quite a lot to work on here, and it seems rather speculative,
> so can we respin as an RFC please?
> 

Thanks for all the review comments.

Yeah, I agree. I will resend it as RFC. I will try the new approach
suggested by David in Patch 3 in the next version.

--
Pankaj



