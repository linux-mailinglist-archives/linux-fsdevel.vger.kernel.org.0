Return-Path: <linux-fsdevel+bounces-70443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87CC9AEAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 10:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8F3D4E45DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FBD3101BF;
	Tue,  2 Dec 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of7ADg3K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17230CDAF;
	Tue,  2 Dec 2025 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668546; cv=none; b=ecwHo+LMufJde0m1DVmtK69zahYoWNz7RX/ku0pNPHmon94RqBMJBkdzuG07tXNa4jnj2t7MJxumnngRS1u3qMHwzh8VN0FirNtl/qcJBxXWEiLUQWHolkFgxaA27EPzl9pU4nJSieVoCWjXR9PQEWu/UKwzI2Xj+lm8Luu0S1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668546; c=relaxed/simple;
	bh=8WYSz7ybPtoFJBQTSEr1myjqDtGX3CnayArB4WVLUQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUh4s/Ydf4g6n5FIbnMy+1cf+cKN/CH5vls76sfXN4lKIurkQRyiG6FssmAm7yxAkqfrXVn+hNvgiRvG/fRJIG+yS5Ixtpa7TIa1rC0GsfVQsWQxzEUPYMOHlxtcdIswlEe5DVMaRKMAwcLFnlGgpBTgOAY48HZE4afpgGSq7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of7ADg3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FE5C116D0;
	Tue,  2 Dec 2025 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764668546;
	bh=8WYSz7ybPtoFJBQTSEr1myjqDtGX3CnayArB4WVLUQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=of7ADg3KWuZM83UkquqDvPJBTBtDMUKxtfpx+s7eh5Af14NGUIbeulCRqUEbY3SnG
	 dKzwnpM2P9GM6rlKX967uANr+Qh4l+HNFQoFg7cud85QOW+Uw82DGll5PAgPB93J4h
	 CJWnIneS8oeS68X3xr/auQ2QQcuwWVFdAZKHg87qDwkjwvSYLTybMlzQQGLBH14CrU
	 vtQ+iThoS+PIrhy1JU/eQxiHEHAbkFNgjawH5a50LFc7DZUiBTKgx3jBWxKHvFCic2
	 WKm9Mv1ZDLA4WEMjF5fgceccYpfU7nJGcME3DCDHK8VC2bwkmsWUIArD2xQxh65Nyx
	 PVt2dtH11oPKw==
Date: Tue, 2 Dec 2025 10:42:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 17/17 for v6.19] vfs fd prepare minimal
Message-ID: <20251202-dossier-gecheckt-175f0aaa9c33@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
 <20251128-vfs-fd-prepare-minimal-v619-41df48e056e7@brauner>
 <CAHk-=wgir86nTfX8SG05QhTtV-Vghkk-q6RMeiBUb80hSF2+Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgir86nTfX8SG05QhTtV-Vghkk-q6RMeiBUb80hSF2+Lg@mail.gmail.com>

On Mon, Dec 01, 2025 at 05:35:39PM -0800, Linus Torvalds wrote:
> On Fri, 28 Nov 2025 at 08:51, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This is an alternative pull request for the FD_{ADD,PREPARE}() work containing
> > only parts of the conversion.
> 
> Ok, I'm nto super happy with how thsi all looks, partly because
> there's been a lot of conflicts.  I don't t hink this was well done,
> with multiple different areas getting cleaned up in the same release.
> 
> I considered leaving some stuff entirely for the next go-around, but
> I've taken it all, although I only took this smaller version of the
> FD_ADD().
> 
> Not because I think anything was particularly bad, but simply because
> I feel it was too much churn for one release. This is all old code
> that didn't need to be changed all at once.
> 
> Please don't do this again. We're not in that kind of a hurry, and
> hurried cleanups aren't great.

I understand. I'm sorry if I rushed this. I was excited about the series
and I thought I'd leave the decision to you. I'll be more conservative
next time.

