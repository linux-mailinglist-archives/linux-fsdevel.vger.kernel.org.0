Return-Path: <linux-fsdevel+bounces-7505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759CF826129
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 19:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FDA282B87
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 18:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96065E579;
	Sat,  6 Jan 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GAInNRGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC7C8E1;
	Sat,  6 Jan 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sptV1oJo8YsETSI/kLnNx0cSNqyArliacwGxem/egUE=; b=GAInNRGziiw3hd3KnUuXGWgizq
	5mZ1Sf3I2ZnndpIGq472L/tbDbFIL7MU2O3jfT4FvBTSnLpFwiC+Ib7HQDVEvoEUjQPQXXb2L57sv
	Cf6oWxxYRsWqGF61gEQSbxaqrQefR2gdFM89ARZ8OI3+B/X7THqim+NgphcM7+q3F2c2DqqpfSz3B
	bzmuSQlSiE1t4k7/j66IxmojuJ/KEbzHSQD7VTMKZytBCvkYJBwgdtXmPQ41bsYGYl5T6KZchxRXT
	cZBvN/91UL21xaACi+05I/6Q22BQYQ3OUP85AnqMRboo7HaCYmwSqb+InwNqKmYi+lRuxp6nS/jus
	OsOcQvCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rMBs9-003irH-Kh; Sat, 06 Jan 2024 18:58:17 +0000
Date: Sat, 6 Jan 2024 18:58:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: helpdesk@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>, stable@kernel.org
Subject: Re: rename ext4 corrupting kernels on kernel.org?
Message-ID: <ZZmiyTedKJJVuMot@casper.infradead.org>
References: <CACVxJT9Qn4+cjbEQd=ske+Ch6TG+meY0F8RuhLSVH3+bY7Gg_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVxJT9Qn4+cjbEQd=ske+Ch6TG+meY0F8RuhLSVH3+bY7Gg_g@mail.gmail.com>

On Sat, Jan 06, 2024 at 08:54:35PM +0300, Alexey Dobriyan wrote:
> I remember 2.4.11 was fs corrupting and official tarballs were renamed:
> https://mirrors.edge.kernel.org/pub/linux/kernel/v2.4/linux-2.4.11-dontuse.tar.bz2
> 
> I'm not ext4 guy but which versions were affected recently?
> 
> This comment mentions "6.1.64 and 6.1.65": https://lwn.net/Articles/954321/

That would seem like an overreaction.  You've got to do some pretty rare
actions to corrupt your filesystem (iirc it was O_SYNC, O_DIRECT writes
that extend the file?)


