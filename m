Return-Path: <linux-fsdevel+bounces-70044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6EC8F377
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690BD3BBAE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C833345D;
	Thu, 27 Nov 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS8kzNke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7B27E074;
	Thu, 27 Nov 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256177; cv=none; b=AVQUtqFKR/CFXIad6kB2xH2IDJC+1gBkb4dyH/wUbCQnnwkgxMZOZmkv/gNyXK/sRLIoyJLuwN2QSm0LyyBE3brxJKWriA2fLjj6QGlVx62xZEcnP08vVuMRJ+s0goEM94SNWncYQEYiF4kqbcWl8CxF12hoHVL71qormtcrUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256177; c=relaxed/simple;
	bh=g5AWCMlXDlcP7MTfdPRnsS2Zca959sEYu/2s2Rlf4xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhQNvY/qytpcu16Bx+6TJwqsFZhOJ1EbOuLwc4D2U4vT7tik7ZI4R9dewL8wOff+/8Qx1O51ib6tnPzCe0CMnnpZrTC+RU7y6dAaPDwB0FCvzgHP/3ys12dc6SNbDbHXn+XkZAEf3wtzilJj8RFn6NdFlba+4p07WnAegDyrQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS8kzNke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55759C4CEF8;
	Thu, 27 Nov 2025 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764256176;
	bh=g5AWCMlXDlcP7MTfdPRnsS2Zca959sEYu/2s2Rlf4xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SS8kzNkeqTAgtlDAphnQxYtF8324wYIhp9sTbr6iana3+8Prb+0x+p4powHE07AJp
	 QhDFQMOqlLwhsFewFfLwkMkus2tJvF9TwetcJkr8KVWK4V+n1tu6/kzRQ0Oaq4gtDf
	 6cOsAbeOvt3eRhzclhsMdxjp9fuxNmXy8habZjlMV0L10y8jgg0Zbke+ehwa2cMbCm
	 krq+bQDl1fmAYlRijwrIOSh6bka5RSg0+qZ+qBz6NYpg9db4aE2fNEUTtfzkkba5rf
	 OIVxicH87RC5gNQYO6FS0sHWykB4cxeTLZOSXga+dlp502dpMgETv2+/+nncFwI+gV
	 cAVv/K6wCebzQ==
Date: Thu, 27 Nov 2025 16:09:32 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/22] docs: remove obsolete links in the xfs online
 repair documentation
Message-ID: <wvyokb34zh4ycahfeyyfelxjaefbwwge6og4vpumpnvedcnul6@2zp36drhiujw>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
 <176230365709.1647136.9384258714241175193.stgit@frogsfrogsfrogs>
 <usg3AiloVtoUi4MfDUFv4ISZlhgL9NQorACfzwYsF4F01o3wWKNHOZ1NC2wUoPWZjx9xkr6c71IEMHbh0M-_Fw==@protonmail.internalid>
 <aSaheJ-eYvqi3-Um@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSaheJ-eYvqi3-Um@infradead.org>

On Tue, Nov 25, 2025 at 10:43:04PM -0800, Christoph Hellwig wrote:
> On Tue, Nov 04, 2025 at 04:48:40PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Online repair is now merged in upstream, no need to point to patchset
> > links anymore.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can we get this queued up for 6.19?  Sending it standalone might be
> best, although given that Carlos is on Cc maybe he can directly
> pick it up?
> 

Done, will send an update soon.

