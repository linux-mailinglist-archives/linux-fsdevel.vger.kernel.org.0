Return-Path: <linux-fsdevel+bounces-31312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7DA994653
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD5E28842A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407201CDA26;
	Tue,  8 Oct 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5vZOkh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B418C90B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386122; cv=none; b=KQT2g9QaLvoFQu56lr/PvLLpftUcteAMkmErpHUeH/aEIvGATWYdmHaDf29FQlqmZpILKrMmMXWFdUg3tCWpeC/PAusAwwnKHjWYh/mfOR1aD2bLybllYH6s5rB6RqQCOS69ZoogCVl8YvWDbsA9ZCS7Zoab5M+2wPWwfTWe44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386122; c=relaxed/simple;
	bh=1CSudkbos9ZtX0WrBsvPhsHxZwJ2Bifh+5CcXmzP4hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lN/b2peptVnDxlzqWOAQTygDctFzrUOgzuhQ07aYJ9V2Gg0UVrwpVN1+0XFirOs/jQeif+EGfQ7uPJdpcCSSH8PoXntX4L6bCUOUfnoVy40FLfGA/cKt9nwDNSZrV/XUClFf0Bh1GxhWhJInVST3RhOU27uCj8weVmZNy0ZDt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5vZOkh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AA3C4CEC7;
	Tue,  8 Oct 2024 11:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728386122;
	bh=1CSudkbos9ZtX0WrBsvPhsHxZwJ2Bifh+5CcXmzP4hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5vZOkh0HjHW5oes/ty9R/vnWJxSztOxzBdSVMwY4nfvVirGUV7sM5EY3EfLnu/wE
	 7RFGSC4xQ9/Bta+dFdH9ZQkUk/8PPDE6gd/5BUKGs66sesUBZJ27TOqK9KsCroTUAd
	 1hYvlxgfobBgRsTJm/kybijSqTWokoX4+Yk5XjLkwUjqi+s3a/+2aqwHGlsxU2Qu/L
	 R7w4vOO58ute3XYJP2YC6VRN8Z2bmn/mIvjlcnUAHB7VwsA4jGeNjgDoKpM5xOONcN
	 GvYsITkVOazVCbfCA63s7PIAxIyRVDgEiyO5SASeWjBww4s+Q3gNxEjxFMqyyb0wko
	 WFKtiyME56rqQ==
Date: Tue, 8 Oct 2024 13:15:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHES] fdtable series v3
Message-ID: <20241008-baufinanzierung-lakai-00b02ba0ac19@brauner>
References: <20240822002012.GM504335@ZenIV>
 <20241007173912.GR4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007173912.GR4017910@ZenIV>

On Mon, Oct 07, 2024 at 06:39:12PM GMT, Al Viro wrote:
> Changes since v2:
> 	Rebased to 6.12-rc2, now that close_range() fix got into
> mainline.  No more than that so far (there will be followup
> cleanups, but for now I just want it posted and in -next).
> 
> Changes since v1:
>  	close_range() fix added in the beginning of the series,
> dup_fd() calling convention change folded into it (as requested
> by Linus), the rest rebased on top of that.
>  	sane_fdtable_size() change is dropped, as it's obsoleted
> by close_range() fix.  Several patches added at the end of
> series.
> 
> 	Same branch -
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.fdtable
> individual patches in followups.
> 
> Christian, I can move that to vfs/vfs.git if that's more convenient
> for you - we are about to step on each other's toes with that and

That's fine with me but note, there were no conflicts at all when I
pulled this whole series into vfs.file on top of my stuff. If you don't
mind I can just keep it there.

