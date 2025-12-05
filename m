Return-Path: <linux-fsdevel+bounces-70803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831CCA71DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 11:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4835B34DA196
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9272C3148C1;
	Fri,  5 Dec 2025 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaGvfZBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05E30276D;
	Fri,  5 Dec 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764924748; cv=none; b=aey6T7MJaGehW65cks8DkdaG02UJpWqE+yyZrwh2+Er9kG1nGdluVobdQicgDUOi5gYTqwUe1faZkEsBSZmz0oMh6unEvStNhGYsPpg6B1cKAJ/8mo1/PYVBt9q0ZDOlEbojm/zWBquKHQnXsECPBwIHL7o43aqZ75nGbC/Nj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764924748; c=relaxed/simple;
	bh=umqA5uDaVfvBv+PTFIRSvLcxYEIDst8dXILws/I4Ilk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0wLqgpQOYRcFntTdPemcjV0DdBivTCNeMttY6iiVfdQmHVbsns1TUsTMMX/ExB015ue3HUIlv+HtX8YRuC6agJ4fn5yWWRM5eNBuqf3uHViEJ4mihwq57zavA+3gsTFvfFML/SCVRCnc7HdiTta0UXAX1pDctowz02p6Dh64iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaGvfZBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A983C4CEF1;
	Fri,  5 Dec 2025 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764924746;
	bh=umqA5uDaVfvBv+PTFIRSvLcxYEIDst8dXILws/I4Ilk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaGvfZBbC0p4cj6HIis/VLd3EHGl5TXf0j7TUVmf8Ra3PqooEGNzz9uzMxATg0CYy
	 JLhdpLx8gaLnMaZ7teTzWVWNP9oAwDTHcZqRm0nguKKGaiYAngthOTKQO/TzpNs0nV
	 98T2Pv0EUwRkVTH5mNqNn8YsvgcsXFw2uo5wFtjUZqsnfsWiGn77uJEMvObu1Swgj5
	 znfcHEuBD71rL1zrCsfhrx+/lY7nhd57nJLtFwoXDBM0iLtCd+fPiQxI4iu5uFDf70
	 RyLS+sotB1O6MyPx035QyLO+TwAKPyVZ8e6K1PyWJAoTDeiGm2WSRx91gPxxIj6XSY
	 i4mz+tTghNoAQ==
Date: Fri, 5 Dec 2025 09:52:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: use UAPI types for new struct delegation definition
Message-ID: <20251205-marzipan-entmilitarisieren-3b0c7b882009@brauner>
References: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
 <20251204-haargenau-hauen-6d778614c295@brauner>
 <20251204101551-fac92797-fad2-4104-bd07-a3069d39f1f5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251204101551-fac92797-fad2-4104-bd07-a3069d39f1f5@linutronix.de>

On Thu, Dec 04, 2025 at 10:17:01AM +0100, Thomas Weißschuh wrote:
> On Thu, Dec 04, 2025 at 10:02:05AM +0100, Christian Brauner wrote:
> > On Wed, 03 Dec 2025 14:57:57 +0100, Thomas Weißschuh wrote:
> > > Using libc types and headers from the UAPI headers is problematic as it
> > > introduces a dependency on a full C toolchain.
> > > 
> > > Use the fixed-width integer types provided by the UAPI headers instead.
> > > 
> > > 
> > 
> > Applied to the vfs-6.20.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.20.misc branch should appear in linux-next soon.
> 
> Thanks.
> 
> Given that this is a bugfix is there any chance to get it into v6.19?
> Preferably even -rc1? This is currently breaking the nolibc tests.

Yeah, I guess so.

