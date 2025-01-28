Return-Path: <linux-fsdevel+bounces-40265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C213A21538
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 00:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02336167540
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F91E9B3E;
	Tue, 28 Jan 2025 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsb8VLiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29E198E84
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738107526; cv=none; b=ZFSDiSaUY3/haubjtw4K8NoNAEFXotPAmFlsa8BLNnBqd2BuTZ0C4/eopwZRa85rwS3kKTlrlDY6Q8n+yii/Bzx2MlqV7kLiNNCHakWXl2HZ1fCyyrdk2atwU0kf/zNaDDgXU41FWUmZ5E0EqECGBktprvtAqV/Er5ADmAIJ/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738107526; c=relaxed/simple;
	bh=jXP37kcWnbWY/6Oix83iAuu5NLaIanGNzL0/0LZBzVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYpE89Cg5NBBDXtg7iqj+nQGIr4ZZIXuuexo4jGI2xXrx21QEfgZOeovhZvNFAE7gq0vt/PBNsRy/BlBUzw0/Ex8Y6/0Ohx3/DScJIPHolW864GonGDai6gWH04GrEY1ZHElvB/f5o8U3QcbItlsjGAqPkIKK5bTmiRHLwAZFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsb8VLiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D716EC4CEDF;
	Tue, 28 Jan 2025 23:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738107524;
	bh=jXP37kcWnbWY/6Oix83iAuu5NLaIanGNzL0/0LZBzVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zsb8VLiGJKxwoywzFbAS7PC9UyMGe6+b/3qdOCkCPEmJMIZug9lO4pWof42Eyy/4r
	 MOwKutoi+M6rNUpA0mZqKj8fYCb03q5sHVU6o3HiAxoGSfw69UAuo23xMR2TVtHiUw
	 +bvUlLHjrfYRAdJv1U0XzoeocwB4KpYBE8B++8K/JZsIhf5OjPSPJFg9lEZwTWI7RH
	 OH+bibMl8/oDon63Kj+57pVf9i+qFNX51VUpwDzBLcVTjIGBy7kwVfAMesDcoOg5FJ
	 1aJWrx4bJ7egl7gyqmMFbHQ0+8GiQpW55Kc0CSB1Cz3PoDL1mkG512PMx1U41WweQs
	 28DN0+GVxzpTg==
Date: Tue, 28 Jan 2025 13:38:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	David Reaver <me@davidreaver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
Message-ID: <Z5lqguLX-XeoktBa@slm.duckdns.org>
References: <20250121153646.37895-1-me@davidreaver.com>
 <Z5h0Xf-6s_7AH8tf@infradead.org>
 <20250128102744.1b94a789@gandalf.local.home>
 <CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
 <20250128174257.1e20c80f@gandalf.local.home>
 <Z5lfg4jjRJ2H0WTm@slm.duckdns.org>
 <20250128182957.55153dfc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128182957.55153dfc@gandalf.local.home>

On Tue, Jan 28, 2025 at 06:29:57PM -0500, Steven Rostedt wrote:
> What I did for eventfs, and what I believe kernfs does, is to create a
> small descriptor to represent the control data and reference them like what
> you would have on disk. That is, the control elements (like an trace event
> descriptor) is really what is on "disk". When someone does an "ls" to the
> pseudo file system, there needs to be a way for the VFS layer to query the
> control structures like how a normal file system would query that data
> stored on disk, and then let the VFS layer create the dentry and inodes
> when referenced, and more importantly, free them when they are no longer
> referenced and there's memory pressure.

Yeap, that's exactly what kernfs does.

Thanks.

-- 
tejun

