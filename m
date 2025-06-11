Return-Path: <linux-fsdevel+bounces-51294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8493DAD5350
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE3F1C22CD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB5E25BEE5;
	Wed, 11 Jun 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1DAcVUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98D22836C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639668; cv=none; b=MeyH2D9Fz/8428iO1oQtL4B7jFGTcnaUrpX+heVkDq/fsKtXLMn+mVEuQjt23Jx9g+4J/JqVAGjAl6MkRhoWHeP63UmzsC1IBikM4u2w6+1YLKj+JM8gFAneiEql6DFaU2j8nh9N5pp644zMY4Bt9rRkC8fd0NaWAO/czcfwbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639668; c=relaxed/simple;
	bh=h7DFrm7Gk5M1PAujKT/s5XuWTtz1zQraTjtDeBiTOAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS0IDOMMV969QFi+Lnc27cTEddSmZ9OZo6x8tBsfRr1KaVmPylt318HWT47eAGn+tl0ANEhYYjkstuuGumsuooBku99E58inqcSRUfOcJzI0S+MplTR0ZutxU1OfNUYpbeMxhDXXklunBRFE2+Ff8757EoRweuNoYR/XNHdKIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1DAcVUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0E4C4CEEE;
	Wed, 11 Jun 2025 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639668;
	bh=h7DFrm7Gk5M1PAujKT/s5XuWTtz1zQraTjtDeBiTOAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1DAcVUAvKNAtYn+23wgWWjbOaDKlPHxdAYJQWghUxS6c4L8PEbYZgFfBaRDk+k0I
	 k0su8vXUnOkN++mtDjxDOV4y9jj1MW1Dzu0rU21sb7axCO5QbqY6QHP/PyRDXZ4oQa
	 EAjF8NhFTVFdRJRI0W3hKPOHa+R/a3dM8lgp6b380WpFIAk4XWdJO75pd9Jcm7aZlO
	 QT6s6efCsZpXaAocUAZjSBGyjLovMvkADSrewEXHf2z8Vg3GZ7wqXV/chvSScwYX6G
	 oPROdXZWrghaj+ubsLRzoG8KpBN824a69ZSmM+PpbmRJtXIh2Yn+Ehgv8kAmMFAugW
	 wAitc1/nSAXfQ==
Date: Wed, 11 Jun 2025 13:01:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 15/26] get rid of mnt_set_mountpoint_beneath()
Message-ID: <20250611-auffressen-gelyncht-248c57feaf04@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-15-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-15-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:37AM +0100, Al Viro wrote:
> mnt_set_mountpoint_beneath() consists of attaching new mount side-by-side
> with the one we want to mount beneath (by mnt_set_mountpoint()), followed
> by mnt_change_mountpoint() shifting the the top mount onto the new one
> (by mnt_change_mountpoint()).
> 
> Both callers of mnt_set_mountpoint_beneath (both in attach_recursive_mnt())
> have the same form - in 'beneath' case we call mnt_set_mountpoint_beneath(),
> otherwise - mnt_set_mountpoint().
> 
> The thing is, expressing that as unconditional mnt_set_mountpoint(),
> followed, in 'beneath' case, by mnt_change_mountpoint() is just as easy.
> And these mnt_change_mountpoint() callers are similar to the ones we
> do when it comes to attaching propagated copies, which will allow more
> cleanups in the next commits.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

