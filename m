Return-Path: <linux-fsdevel+bounces-65527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9CEC06E36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CB044E912D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FB3322A27;
	Fri, 24 Oct 2025 15:12:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D22580E4;
	Fri, 24 Oct 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318768; cv=none; b=eMFS46+RhfB3sEPw1clmywUWyPIj6ASNiemNGv4WKV2FKOdKorMOY8tng1dn2yOe6KHuYqguKMTsppBOLQbkG725J5RhSjknTu+eQEFFGRrU2NvNo6Yy+9d2dNuzrmqJJ5P1P8MxglRPmoCf/fcylNxY+v+XkLfn1n3z4qGkBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318768; c=relaxed/simple;
	bh=i+ccLUlFUYhj92tCzyrNYXPU2QKCgamjHaO1CQKdmNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg4d/xnyQpQS/h3O8Y4cBKs1Rg16iPQgUCFrsKWquiXPQuEoxiyyGHJOZ0imzWet+tsYNf9pOgSsv8kC6qSwUdbjkOAOKODphpLwYRlEbvKzBMmENscQ1lDXuF9jE+NzimtQLp3nTgSwcOKndbj5vkufBj5CkdUWuZuNOvHkwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50D9D227AAA; Fri, 24 Oct 2025 17:12:38 +0200 (CEST)
Date: Fri, 24 Oct 2025 17:12:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
Message-ID: <20251024151237.GA1491@lst.de>
References: <20251017034611.651385-1-hch@lst.de> <20251017034611.651385-3-hch@lst.de> <fba8631d9159c9bd8df98e4cf33a6ffedecac050.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba8631d9159c9bd8df98e4cf33a6ffedecac050.camel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 24, 2025 at 08:03:34PM +0530, Nirjhar Roy (IBM) wrote:
> So this patch doesn't really explicitly set s_min_writeback_pages to a non-default/overridden value,
> right? That is being done in the next patch, isn't it?

Exactly.


