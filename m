Return-Path: <linux-fsdevel+bounces-58385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9C0B2DCCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F941887C10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C102E764C;
	Wed, 20 Aug 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s65pGudP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB8302CA4;
	Wed, 20 Aug 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693554; cv=none; b=iOC6DHACuFRA5ovoi+/lejYfpwdYKsC4HXR5lqRmmmgZQbNwM9SliidDoImQNT1F1IHp8yREULyfFdT4Gk7tBB8ZnG55b0D3jb9ztGFnp7IDM5II+87XKGbLqRcSRhL+6GQxRuPKvec5OBVbybhMRimYXBhziGN+mVL/+m4iQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693554; c=relaxed/simple;
	bh=vRs6O2QQYZ1Qz3nbRAs8QyWrRXLj0KnjhKbnXslYIeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq2OQ7XV+jEFppLjqyf1118ENKAY+XiUX/6SHOkBIlE5dQK7hA2S2VMoEsgIv29xwaqr1GkpHEHhZslHPsZSGVqgoqFaHtALbJA7lp8/ABwBkfyjb1JEo5LYqmNMRffE9MQFbXpcgT3sjrOCWGCFMOxZynRoHTJtVmGjlN+moWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s65pGudP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gCbIzlOhtOecIDyn8V6GPgdB5z0VOBcPUH7fh+l4b+E=; b=s65pGudPm6U7T8BIRWIPozjuvE
	HxqlTG0yAzsPk1nuGhc+aCVZqi+VHkrE/6OZzmjxcKGIL2jgxl+d3aK/2+ZUbUk1uRn6F/hqLOtIs
	ng+jWEgFbSoPWXwwTzUp73wFKqhJgnaEzlvRtRJeOySXiMa28MqXhfqI15xiRDiPQ3mHINxrnO3kU
	t5wSLsmqW+4XvHaznpTTznR8d0IzmNgAWRnWSFRrn4ZZ8DzGYw2bYnTELJhK/MOsVSaVEmXRsskwj
	cmcpa/dUjkUceFFeK7IgOaxkPHfzwE6+EsNMChcqw9RqKv8yqkcG21BxuAC1qj2xdFdWtikM9sdEE
	dk8ALVSg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoi5t-00000006QJC-42JS;
	Wed, 20 Aug 2025 12:39:10 +0000
Date: Wed, 20 Aug 2025 13:39:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pavan Bobba <opensource206@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: warning fix
Message-ID: <aKXB7Ux8_C_IIrkB@casper.infradead.org>
References: <20250820122737.13501-1-opensource206@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820122737.13501-1-opensource206@gmail.com>

On Wed, Aug 20, 2025 at 05:57:37PM +0530, Pavan Bobba wrote:
> This fix is to mitigate below warning while generating documentation

You're the fifth.  You know you can read mailing lists as well as
send to them?  Also, reviews are more useful than new patches.

https://lore.kernel.org/linux-fsdevel/?q=name_contains_dotdot

