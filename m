Return-Path: <linux-fsdevel+bounces-37616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0809F4599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C7616CA10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497E1D5CFE;
	Tue, 17 Dec 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iia/LHYo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08986A29
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422365; cv=none; b=s0YM4cOA0BYFKtpAXnAs/Ux02bdip8Uy4GuJ7wd528aXvW25VY9Asx9WUy2kKPPcmojf4AwRakKaPX+SZSZPxdLYri2LD0IZbrhXoQjqPTBAmkUTH1VVG/C6LxDdV4GLUuzxp94VLfqxCAUrJkqPwUb/HGTTgjgRxBSlH53v7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422365; c=relaxed/simple;
	bh=l0ixlBpfwnrUpyWzHvznw3mlye/aDEeyyEP5BZhg5bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJGEW1p+BAUqucxXp+f04CQseH81FTqUI5b1G+15UmpZ2OIpagTHNhpa+2yKiNSpOIl5RPPKlmi2/++z4IZ8P6bsVbHNFduUBxLk4CglUeEhAdUjz4V262mFcBZMrFWSzWN3EeFBbhjvHnigwYqlk+puQsyMgDrOic5pJdrKNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iia/LHYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65B2C4CED3;
	Tue, 17 Dec 2024 07:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734422364;
	bh=l0ixlBpfwnrUpyWzHvznw3mlye/aDEeyyEP5BZhg5bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iia/LHYoWnQlt6pn4x0hyA5rYJnA1wAq4FPOeUmd29tFOaA/erZwtlzzEkAtMJ7Zi
	 WvteQbKrzfU0gIw1ccvpNryaBvCL8CPWJ7HdIyNkaLOMrX8CUnSYGBOxHnYKqqY05/
	 XqI3KoUQ8ZgYClNbbnGi5CXtkvmI4XQ5e6upbppBFakgH4pfDKriQZhdvc/VO1EFnS
	 cFlDO1G9YaHh03FiB1X4uzTjjXhzw3j9pmVJJIgG0eT/2XAYNJPjx1hG7hgCiR3eoc
	 hOGeGFtn7hVr5DFOOj8s78OVkkAY3eRc+/9DZm/+OYRY/terqUc2VqOi/38MZFmL02
	 a0vfWRbLrR2lw==
Date: Tue, 17 Dec 2024 08:59:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
Subject: Re: [REGRESSION] generic/{467,477} in linux-next
Message-ID: <20241217-ansturm-hallt-2b62fa6739de@brauner>
References: <20241217060432.GA594052@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217060432.GA594052@mit.edu>

On Tue, Dec 17, 2024 at 01:04:32AM -0500, Theodore Ts'o wrote:
> For at least the last two days, I've been noticing xfstest failures
> for generic/467 and generic/477 for all file systems.  It can be
> reproduced by "install-kconfig; kbuild ; kvm-xfstests -c
> ext4/4k,xfs/4k generic/467 generic/477".
> 
> I tried doing a bisection, which fingered commit 3660c5fd9482
> ("exportfs: add permission method").  When I tried reverting this
> commit, and then fixing up a compile failure in fs/pidfs.c by the most
> obvious way, the test stopped failing.
> 
> Christian, could you take a look?   Many thanks!!

On it!

