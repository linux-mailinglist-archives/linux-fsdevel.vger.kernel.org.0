Return-Path: <linux-fsdevel+bounces-31525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E91998216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5371F250B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F7A1A072A;
	Thu, 10 Oct 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu5s6DNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE761922DD;
	Thu, 10 Oct 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552368; cv=none; b=jHuBdd3dXlGxVejIiJ3dsI3ghpWPS0y8GFtHPzWJag1zSjU16YadXZ+hfJd5w8kEvF3eLYrNIj/LEzUD1Q/4u4ZFiZ0UVnzjMLfj8h6diwpW/+fherh71hb+rFl5g41Q9rj2CkQlTPZOAijvZHieB54RhTI1DD5vQLbdSQdP7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552368; c=relaxed/simple;
	bh=MUNnJAfZBwiGRUv3CoIf4POyn7nVfA36YbnFb7U/+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdXtUr+9i/EkVIuNbxLO5n5S92xxPXm8zo+5do9dKTgnHHnnDiemzh8M3aJnTz0nzAz/OgSAiefim0p+hMQsgIhHktUxzbLHEhVTi4ZEuP76GXMlH773L5CcvGadeSmedf47nnk8L2TS3bJ8E3zcPvn8DR4cY1sMrEnzxPl49bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu5s6DNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD39DC4CEC5;
	Thu, 10 Oct 2024 09:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728552368;
	bh=MUNnJAfZBwiGRUv3CoIf4POyn7nVfA36YbnFb7U/+4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fu5s6DNf+1ARrhLwLE/vGfJoYMJjs1sM3qq/UNwrvFkVIeIrvyYTEbLzDjCLl4uGm
	 uFptnniGCFFZuYT5JMqB/nmgOCpqNwbXFtmLTrEvQmKoIjieZuqWTAHJPch2pODdFE
	 Lvd5xB74Y4eFe1eHpiUBif5iGCGmOJL2DP60QEAOXRZy1TQll5DZ6XSeABb5/EK16o
	 gplsihkjLuTSldp6xWy/bAARRZnoqA4TdfQWNHiJcrlzlkA2UT7IaGit5o6wKabZKx
	 nOM+etq+FDjaptgPVcab46mrm5kGqSf/z+LeuQtR99qiq0YBiPgwo3Crnhyo4jXAaz
	 f4F4g2cn08UYg==
Date: Thu, 10 Oct 2024 11:26:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241010-nahtlos-erproben-27bf691dcc06@brauner>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <87msjd9j7n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msjd9j7n.fsf@trenco.lwn.net>

> > +	/*
> > +	 * If userspace and the kernel have the same struct size it can just
> > +	 * be copied. If userspace provides an older struct, only the bits that
> > +	 * userspace knows about will be copied. If userspace provides a new
> > +	 * struct, only the bits that the kernel knows about will be copied and
> > +	 * the size value will be set to the size the kernel knows about.
> > +	 */
> > +	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> > +		return -EFAULT;
> 
> Which "size value" are you referring to here; I can't see it.

Luca did just copy my comment from another interface which has a
separate size parameter. This should indeed be fixed.

