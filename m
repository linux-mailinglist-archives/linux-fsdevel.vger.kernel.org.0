Return-Path: <linux-fsdevel+bounces-69069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E4AC6DD3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89C2D354C23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6034402A;
	Wed, 19 Nov 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0bd6/k9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4A342519
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546037; cv=none; b=gePHumdP+tm/RyYQQdPoanLZt3eAAzEEb0Zq+19bgE8+64KLvbF6EJmvq9eBfDREDE93d9WHklWkVPoRI6A0wHRwfshJwFsAm879tx+XVe5phKjvaR+UxaVWpfgVIXKoMpSgm6gsNJ/BMSwCz0mOgj/bSPJvtQyUkUbEQiGRs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546037; c=relaxed/simple;
	bh=fSK1LA+0DwY89oN0c1eaY5YqoDND6/1twjcBEsiK8Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBywe6wOulWcbqgT6VgUm3KDw445vO+7v8ma/pLnAw27roitErHOqb+lg6q5ztQkSCu10doo38YoSwDGEdWGhbBiCKaxkyVK55LQHZWP0vlxA0KoJk4FFR7kTfz6sdcVFriSw4+WYU0BWr6v5/um48dtZNMHzSbmLGohfb7vQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0bd6/k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E85C116B1;
	Wed, 19 Nov 2025 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546037;
	bh=fSK1LA+0DwY89oN0c1eaY5YqoDND6/1twjcBEsiK8Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0bd6/k9XlkyudN/WcnUj5rMHGcVW8Y7BHzEYIYkhceXkJJJSzgLmzQbQ5PM97tKb
	 0Q9BDj+KFZko1ULFLsvSgZAJStewTMFoiiVj1EpHJ5qdojBCVc6UeGQUdWS2Ve8EVT
	 14Iae29EMaXyEexLqEutc4yvCJzcMhlHadkAHsADI22Z48PJUJpRjesLGLIcSbV77/
	 i4HwTfHbe2/Kko6XdrvmQs2CGc2fRopTT/t839DgsCwIapoNp1zMT/5q/0DgJXzq1I
	 U4LwDPDsrWe4eAbuMLiWCuvhWQR1ncX8tOItkOg4K/UN2KZl3MkJFud1D/08vT/Qy1
	 80b5rwQdJbZZg==
Date: Wed, 19 Nov 2025 10:53:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Message-ID: <20251119-proben-kennwort-75488a3b68f3@brauner>
References: <20251118070941.2368011-1-hch@lst.de>
 <20251119-kampagne-baumhaus-275e14d62e2f@brauner>
 <20251119090100.GB24598@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119090100.GB24598@lst.de>

On Wed, Nov 19, 2025 at 10:01:00AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 09:42:53AM +0100, Christian Brauner wrote:
> > On Tue, 18 Nov 2025 08:09:41 +0100, Christoph Hellwig wrote:
> > > No modular users, nor should there be any for a dispatcher like this.
> > > 
> > > 
> 
> I was going to send a patch doing all the exports in file_attr.c in one
> go.  I can do that incrementally, but I think it would be a tad
> cleaner.

Sure, send it it one patch. I can update.

