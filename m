Return-Path: <linux-fsdevel+bounces-32668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1159ACB62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501E328519F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F11B4F24;
	Wed, 23 Oct 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eodQbZ1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08561AC8AE;
	Wed, 23 Oct 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690696; cv=none; b=m+9T39/imiOqi+uYCHyheOce8DVVabeq7wCXUlgPsmstNIlQ1aJ35qz6SXjzrotT8otHMMCneO4joZKS4p9vGUx+6+jOj75eqffcmb9nc8yqoLOunCj2vOlmqlOfGaeG2r+RyYtZApTB2lGm1OIoIi+Y21uxKHzGEFA/+gZkPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690696; c=relaxed/simple;
	bh=UUwRNANEPvL49Qo42oznXEXEPehnvirn493kgCeLO2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBJSpNCgbcb3hVzv11swFBp10CqIBk6g2+qOVZJwHwAAiFXvUuqfupVACxyKQYsznmp9/7LdCNDK+l7LVJ5M2f9b+Sk/zYaD95+Uh55VGqXoDbxT5PtotXzKzlpELNehNqX2YWyww3DHvxbcNwVT0GL2u1/GvYsfaHwi1o00yyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eodQbZ1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D977DC4CEC6;
	Wed, 23 Oct 2024 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690696;
	bh=UUwRNANEPvL49Qo42oznXEXEPehnvirn493kgCeLO2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eodQbZ1gZTRtc9UxAFqYRey9PZPoCpOwAMc0A0qEUjqSg3rI0VPQmNrnUvd3+1A/L
	 Ji/4BlVNraBSlrxFpFG/w6TVejaB/V1dndil8HxRG61XfMBZYhOL7NVb+tUnM+OAM7
	 8OjQ/XWt0Qe1lHH7BvGohM0NTAR1DpT3hNWOYT3+MzC7zujLnpS5sCzVFTRPQgO2+F
	 lD5GacBYmZXUbBq9UvXTze3Z49dp/VtxLFbOyPEMC6OYGev0Q5wPs6mwmhOVHFK0tu
	 VdVD+CcFiYjrD6AJEVaMc4OnPoZPtQYoRAI4GEKwRtmsS94vGmDqdHGL7eZpH5WgNU
	 iYduJYm6ey8Lg==
Date: Wed, 23 Oct 2024 15:38:11 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Luis Chamberlain <mcgrof@kernel.org>, kernel-janitors@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Re: [PATCH 09/35] sysctl: Reorganize kerneldoc parameter names
Message-ID: <4kvlidx2ucazm3pbrkao4ugvjlhq5kql3vbxjf5i2lrixrh6rz@p3ao5v4667ij>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-10-Julia.Lawall@inria.fr>
 <nnbmui2ix23wjmfvxo2t3zd3tgymk77h765kyoc3pxu6wkhqxx@6qis4yyszkec>
 <e6f7d5e-6f7e-ed6-a54a-2a5fd87b3d7f@inria.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f7d5e-6f7e-ed6-a54a-2a5fd87b3d7f@inria.fr>

On Tue, Oct 22, 2024 at 01:13:25PM -0700, Julia Lawall wrote:
> 
> 
> On Tue, 22 Oct 2024, Joel Granados wrote:
> 
> > On Mon, Sep 30, 2024 at 01:20:55PM +0200, Julia Lawall wrote:
> > > Reorganize kerneldoc parameter names to match the parameter
> > > order in the function header.
> > >
> > > Problems identified using Coccinelle.
> > >
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > >
> > > ---
> > >  kernel/sysctl.c |    1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 79e6cb1d5c48..5c9202cb8f59 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -1305,7 +1305,6 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
> > >   * @write: %TRUE if this is a write to the sysctl file
> > >   * @buffer: the user buffer
> > >   * @lenp: the size of the user buffer
> > > - * @ppos: file position
> > >   * @ppos: the current position in the file
> > >   *
> > >   * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> > >
> > This looks good to me. Is it going to go into main line together with
> > the other 35 or should I take this one through sysctl subsystem?
> 
> Please take it,

Ok. I added to the sysctl-next branch going into the next release.

thx.

Best

-- 

Joel Granados

