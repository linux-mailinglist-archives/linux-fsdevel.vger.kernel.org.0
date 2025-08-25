Return-Path: <linux-fsdevel+bounces-58971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496BB338A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8CA1B20D2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988327FD5A;
	Mon, 25 Aug 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8sfNm6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C129BD82;
	Mon, 25 Aug 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110054; cv=none; b=lJ7k/x3dXT/t9uYQltyIvHggiQIbbGNv2uZd2dC74ic49BGmwz3GH34knq6SiESfQIRHr1ASSLbpKlfz0lX9ZY6l52aLTGPkk44uJAoVdYrXTXva2taB1b084Uu0F6Sa+dIRvc4fpapWY2OTsYXs7zF36eTzERacsm/KOY+6gtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110054; c=relaxed/simple;
	bh=yJJQ2u/iKmxy+e3RF/GJg2tOmR67e64wxy33L/BxuSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQfjHUhJoYlofj8llgkh0zso63G3Cxb962/m0PWyMrd9bQtBGI9dL0E4Ct/cUfmNsom2xV7JU0r/oISujcSX6tJlrQrQ3CeaH92wrWfYRV7V/PtCGlBFRLEDt+iHeVaJHVs1K6XwzVW9uAbLPKkJpNBCgkX3DRIUy74KW9J4BWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8sfNm6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3B7C4CEED;
	Mon, 25 Aug 2025 08:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110052;
	bh=yJJQ2u/iKmxy+e3RF/GJg2tOmR67e64wxy33L/BxuSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K8sfNm6PJklGFXEsL0q9K4u/Xycxfzj8GTQKiInKWdvG9CEOrwKFbIO2odJfArrg1
	 h9RY+mPeLo52u8gfcpLN6fWE1478tfZzkeUBQUMg6ijQm/eRo/pobKvk72SC5uFDyd
	 YoUTuJfkzkT1uxJbH2njDhnw0oMjXxWupy7TPRjoZ67W6xzfNKu7v4U+0/vKv30kN8
	 q5Ujo5hxqkYOvoPB5aAay0Lk6pE+j3dtzjCEjg8nrxIQAUnz89rx/YoRXTxi4hHEhw
	 zVrh79DMsWMk7+DKRQY6LrzsqZn6Rwl0U5+URupGx5SBl0y+NAtNKqyqQersxQtD10
	 6jTb82sK2Irzg==
Date: Mon, 25 Aug 2025 10:20:48 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Theodore Tso <tytso@mit.edu>, Greg KH <greg@kroah.com>,
 ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <20250825102048.754ee0a2@foz.lan>
In-Reply-To: <62aea685546cee80b18cfd7e1ea50b1a590d5edd.camel@HansenPartnership.com>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
	<20250821203407.GA1284215@mit.edu>
	<940ac5ad8a6b1daa239d748e8f77479a140b050d.camel@HansenPartnership.com>
	<2025082202-lankiness-talisman-3803@gregkh>
	<20250822122424.GA34412@macsyma.lan>
	<62aea685546cee80b18cfd7e1ea50b1a590d5edd.camel@HansenPartnership.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 22 Aug 2025 16:31:49 +0100
James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:

> Well I did ask for two concrete things, but I can certainly repeat:
> 
> On Fri, 2025-08-22 at 09:09 +0100, James Bottomley wrote:
> >  I think I'd be happy if we sort out two things
> > 
> >    1. That the decision be taken by more than one person rather than
> >       abdicating to last man standing
> >    2. The outcome be documented clearly.

There are some aspects here:

- Who will communicate the decision? 

The way I see, the best would be if this would be done by the subsystem 
maintainers who accepted/acked the feature addition.

- Who will be involved on such discussion?

I'd say the subsystem core maintainers and developers plus the top 
maintainer and eventually TAB. Feature removal may cause troubles 
to distro maintainers, as some may have it enabled as well. So,
better having more people know in advance.

- How this will be documented?

Depending on the reasons why a feature is dropped, e.g. if it
involves personal data, I don't think the entire process can be
transparent, but surely a sanitized summary should be documented.

IMHO, the best way to document it is at the patch dropping such
feature, which will explain why the feature is removed. IMO, the
best would be to have such patch containing SOB from multiple
people:

- core subsystem developers and maintainers;
- Ack or SOB by the top level maintainers, if pertinent.

Thanks,
Mauro

