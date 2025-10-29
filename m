Return-Path: <linux-fsdevel+bounces-66401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4630C1DCF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7274434D23E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAE02FFDF5;
	Wed, 29 Oct 2025 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLQMaBua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1E1C2BD;
	Wed, 29 Oct 2025 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781955; cv=none; b=JJ7JNozjP/PD1QIsmAF+uvacyPxu7aClPY/ahM7w5YjPh0ps9k34SdvI6SjZU3xik+0wVgOB8Xk8jnKaEWTV6XXMSPmHoldJRXyZ19+b7z9OqO2I8EPZzpju4un3sS7giowzvGc7a3XhKSTOTXRA+oKvdIh7ssoajdyDQh4W80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781955; c=relaxed/simple;
	bh=V2XrcyvN6/8XRYF1YiXjH0P5KLrXEXLSKJ61uFr7rIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwDvlUvU3hG16DpRp5xd6446WvQYMv7MpWGJ56+zIvEZ5wWoW5pikTX78plnk/zsN0yNJ6bFjW3Nr21NgaY/q7qtMhoPXzZEo6CimOqSyJ3t3hiKkQy3m74VKw9q/tLBeg6ImVhRhvUVIsXYvaFbDYzsP3V+oGYyImoSLuCZfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLQMaBua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E794BC4CEF7;
	Wed, 29 Oct 2025 23:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761781955;
	bh=V2XrcyvN6/8XRYF1YiXjH0P5KLrXEXLSKJ61uFr7rIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLQMaBuaQA/xHXPdgS+DZGAbO/jlykqLUBRrChTKyTGsqH6u5CuHJTRU5qMGa6YsU
	 bD9WqfAibi9RyDLNS0QLJ7NGM5cnFyc1JqDXHElxw7hvkkwDGaz2vDtoZM2aAjfY/C
	 cxTGrx8Xc36Ry5F7mwBkSQRvt22TVAaFZgQR1XReB9G6x5Usl6FFTXoomqWw3MGcPt
	 604pIrsJ9DX8X+YF6rEuo65PnuWeLB3vic1pOc7tddh580o00dmned4ygudj0KlxwG
	 r0DsSvrBmn+C3j0Q/RiYz6hNZk7F5WtvRSqdg6xa9EUzf+sKf0PozBCAV7fUQ+PQPf
	 3moo1ELrl18FQ==
Date: Wed, 29 Oct 2025 16:52:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCHSET v6] fstests: support ext4 fuse testing
Message-ID: <20251029235234.GZ6178@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
 <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <aQHf3UGaURFzC17U@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQHf3UGaURFzC17U@infradead.org>

On Wed, Oct 29, 2025 at 02:35:25AM -0700, Christoph Hellwig wrote:
> I find the series a bit hard to follow, because it mixes generic
> with fs specific with test specific patches totally randomly.  Can
> you get a bit of an order into it?  And maybe just send a series
> with the conceptual core changes first outside the giant patch bombs?
> Or if parts are useful outside the fuse ext4 context just send them
> out in a self-contained series?  Bonus points for a bit of a highlevel
> summary why these changes are needed in the cover letter.

Well TBH there's a lot of accumulated stuff including some treewide
cleanups in my fstests branch that needs to go upstream before the
fuse2fs changes.  I've been waiting the entire year to see if
check-parallel will get finished... and I'm not going to wait anymore.
That's why I haven't tidied up this patchset at all.

The TLDR version is that FSTYP=fuse.ext4 is how you select the fuse
server, and you ought to have mkfs.fuse.ext4/fsck.fuse.ext4 point to the
appropriate e2fsprogs programs; a [fuse.ext4] section in mke2fs.conf;
and fuse4fs installed as /sbin/mount.fuse.ext4 or /sbin/ext4 depending
on how your libfuse is configured.

Then this series is basically making sure that FSTYP=fuse.ext* works,
and turning off feature tests for things that aren't supported by
fuse2fs.

--D

