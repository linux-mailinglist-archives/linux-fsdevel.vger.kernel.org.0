Return-Path: <linux-fsdevel+bounces-11590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA3855077
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4103A1F2AB11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F983A1A;
	Wed, 14 Feb 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bS0LZlXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C725F865;
	Wed, 14 Feb 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932301; cv=none; b=IeCwLGQlPuGJR3vcgA1xRmjEp1V/TfIXHV8YLgSLxQeGJB+hhUQzapvW2UUvJrGHiJFm2cW2VFVgxY1TVbH466Izq4jiji6NkS+6Z6TzyNK9jCGlN2GccRCknetZ/kW7NHdeWNddWgJHgGST7eYVxcKL17uekoFDNzMCUyljUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932301; c=relaxed/simple;
	bh=s6HeBJyfIPnyqjs4144G8v3FowXnX150xUdsdubyEh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdtknJFFN8AJUDL2rW+ftSMUZCmVq8hNVPy/+u/81Jg0buqsnZyPINeKeybbxURzXGcThvxaBW3wSKie4Oy6V2aQqUw5kCVGz1Nr+HkP8PYOHoClWXv7cKg2XGYelxOHL3VrJXE25SezCZ/X1owYD+oCqvFatDltusjfIIB3Lu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bS0LZlXP; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TZllr01Ppz9sqP;
	Wed, 14 Feb 2024 18:38:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707932296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sENgyQIfMJrprwSCQD6BnlwUXKHmIs45mARoOV6LcHI=;
	b=bS0LZlXPS54FRT/AI0C8xeZlvGsjQeTurUngmAUx3VgaKmOdICNJAzvuS8Hcz5Cbe3a3Zq
	fc98QmzKnvfPDogUpKx9Sz6mLV6arx/Lhmn7gyGj1lXtOqZcMq6lfaJzsYcGsKVGhW5IUM
	tM2z80U3jR/Pf/6V+89v1Zz70v/xO2+kOIat8NJKTuprLGP+X/HOHUP9HNxSasAeaox2vX
	XjV/oYg74OeZRfnJAvlGVTX1A+Y486vAS19kFNvYUmwzjaFuPU9UWP4gzbt9Py9hVH3IFa
	9og1z8puLb9xNQnyaxBmt9KDJoUuqd0P+RBHP8+c2U0ITezBkYFOeFmXfj+uWA==
Date: Wed, 14 Feb 2024 18:38:11 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>, 
	linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, 
	Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>, 
	"\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	=?utf-8?Q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>, 
	Mcgrof Chamberlain <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Split a folio to any lower order folios
Message-ID: <fggmw4jfozww47c3pbpbad7v5ew3jvvgiqg7ccloz6xl5xd4dy@2nxr5lhhzbcb>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <FC18B703-54B3-4BC4-B298-5057E8F26A70@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC18B703-54B3-4BC4-B298-5057E8F26A70@nvidia.com>

On Wed, Feb 14, 2024 at 12:18:14PM -0500, Zi Yan wrote:
> Hi Pankaj,
> 
> On 13 Feb 2024, at 16:55, Zi Yan wrote:
> 
> > From: Zi Yan <ziy@nvidia.com>
> >
> > Hi all,
> >
> > File folio supports any order and multi-size THP is upstreamed[1], so both
> > file and anonymous folios can be >0 order. Currently, split_huge_page()
> > only splits a huge page to order-0 pages, but splitting to orders higher than
> > 0 is going to better utilize large folios. In addition, Large Block
> > Sizes in XFS support would benefit from it[2]. This patchset adds support for
> 
> Just talked to Matthew about his order-1 pagecache folio, I am planning to
> grab that into this one, so that I can remove the restriction in my patches
> and you guys do not need to do that in your patchset. Let me know if it works
> for you.
> 

Cool! Sounds good to me. I generally base my baseline based on -rcs. So
I might include it while sending for reviews until 6.8. I will remove
that patch once this gets in for the 6.9 merge window.

Thanks.
--
Pankaj

