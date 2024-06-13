Return-Path: <linux-fsdevel+bounces-21639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E2906B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE50281444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58AC1448ED;
	Thu, 13 Jun 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3eE7u9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D91448E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278906; cv=none; b=ucinyX6WkMxUkG5eSSIQHMhBfzo6GXLnRK3L7RsckI1x+tqwbtWpntA8U5sHtkZFgPmT7Amm0nkt01CXYaeUeK5BS/JOKnaQYwALiNwGDwpmAj8fy74XWil4i4r6dZpnCCqoaDW5Ngb/PqGUDx1ZBrst59eY+SVZMuuD/oyiDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278906; c=relaxed/simple;
	bh=fyIJxSYimFwAI+o2TnQSoDMArdIK5TJrBGtQsK1d+NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULBirWd1/H2Mday+wMdE979srlVR1Ro5Qk8O7OlqUxXSkAtxRqPlx1EshlyqI9GYVrsy0A5wl7CgE4GC2zSkscBevHVB5nHfMTVrjPqGqCAe2hIMdXZbEpuvZo7SUNQdrSxWKHao93WhrCqP3OTVdeeq5K/IBi7w2xZugP906jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3eE7u9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354CCC2BBFC;
	Thu, 13 Jun 2024 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718278905;
	bh=fyIJxSYimFwAI+o2TnQSoDMArdIK5TJrBGtQsK1d+NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3eE7u9lNVhxfwmL4f+spXllyfqPq9yfhHm6mxpdvG94+QZEnhxiBzDyhmnU6ZGt+
	 TSle3N9TIo0gjhzAymGM9wDp3PaB2aCtPjNbDVAcxmY7pQ7igRURUfPKJZvuoLnVIu
	 +8FYYxLMKxt2BCaXHNZZc9HYWdWt8EfULep/oCqdy9CrIyxh2nCHTEAzUsP/YBCujK
	 El9Bozz+hpLaYyUtWoSZq9kw4qs5VxnJbwxJU3iAraOk/vqTrleJdEqmH/8oF1ie2J
	 Oknqnw6UbhcXX3/ekPFq7SQORX//P5YA5b0wbRvDYrFRwBqTqpy2y12DcENqPhyOlp
	 nykeJc/YP52TA==
Date: Thu, 13 Jun 2024 13:41:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 4/4] listmount: allow listing in reverse order
Message-ID: <20240613-demut-datieren-28fa5fb6e2b8@brauner>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
 <20240607-vfs-listmount-reverse-v1-4-7877a2bfa5e5@kernel.org>
 <Zmmor8Y1x7opCNU1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zmmor8Y1x7opCNU1@casper.infradead.org>

On Wed, Jun 12, 2024 at 02:54:55PM GMT, Matthew Wilcox wrote:
> On Fri, Jun 07, 2024 at 04:55:37PM +0200, Christian Brauner wrote:
> > util-linux is about to implement listmount() and statmount() support.
> > Karel requested the ability to scan the mount table in backwards order
> > because that's what libmount currently does in order to get the latest
> > mount first. We currently don't support this in listmount(). Add a new
> > LISTMOUNT_RESERVE flag to allow listing mounts in reverse order. For
> 
> s/RESERVE/REVERSE/g

Thanks! Fixed!

