Return-Path: <linux-fsdevel+bounces-12619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E50861B93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 19:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3AD1F24B50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0C142634;
	Fri, 23 Feb 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLcX593i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0912AAE0;
	Fri, 23 Feb 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712857; cv=none; b=Y3v9TkY4/GdRwa6MrOamhVr4jYE5V0ron1mcctIB1B/rMeYambpVyfAEypKT0AG/q+0U5ltuKMITyGWIC1HnN0F6d/DtfG0Tki/Ulr/cf6MsYWKg+ze+pGq0ZpOX19xHzeoo/G4Shp4wIfSIsuH8ZP5X0kEuEk0rM1gggfrYkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712857; c=relaxed/simple;
	bh=QRdiuhTMR16m4fIPAyssErxzQ5LISwQQGfoCj2IS59c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiSnGGonox9Vb1L6QaR1dg8WeU0xTP+MdNJvIFsiMalqJ9Tp4480xDpXVrDRB23V5O+pOLhIGaawx7bVOfMvE1yaZqnoRIze9Ze98yi+F1OEUXVgYbRbTse73yjvy2YTNfdTV2qAPhTF4goUWoa/XeFsbkKm15beHITtyk5OivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLcX593i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D78C433C7;
	Fri, 23 Feb 2024 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708712857;
	bh=QRdiuhTMR16m4fIPAyssErxzQ5LISwQQGfoCj2IS59c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLcX593iwdJgniejHOsCm2TrV+5iXQqtHCQuIjvRyCwbmBjutfCnwd0SPEe+V2Tyf
	 nqlsOpp+uKKfEB3dLy8IhzklgKM8L36WR2+Mn7mMqpsri1fgRRgPcqfxx6eXneF0tZ
	 gN/PjUJC7oK5nOMRmNkq9rfeESbTvj2c5bztmf04mj4ob8ijsqC6OjLS8O6dA/yCGt
	 QfmoYzvG1LSbocfSnR3JtjLupmLIf+OiiXCHN6DFVp25BvDRyje3UVQNMTgiWRFkI7
	 Sx4qqfBqicK+5qtF7DgC2I/USTfYy2Mpx+FYulljDDLT6G5ER548xcvBrdvFNA+0Un
	 sM/abViQzNqjA==
Date: Fri, 23 Feb 2024 10:27:35 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v4 09/25] fsverity: add tracepoints
Message-ID: <20240223182735.GD1112@sol.localdomain>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-10-aalbersh@redhat.com>
 <20240223053156.GE25631@sol.localdomain>
 <copvwl7uhxj7iqlms2tv6shk4ky7lce54jqugg7uiuxgbv34am@3x6pelescjlb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <copvwl7uhxj7iqlms2tv6shk4ky7lce54jqugg7uiuxgbv34am@3x6pelescjlb>

On Fri, Feb 23, 2024 at 02:23:52PM +0100, Andrey Albershteyn wrote:
> On 2024-02-22 21:31:56, Eric Biggers wrote:
> > On Mon, Feb 12, 2024 at 05:58:06PM +0100, Andrey Albershteyn wrote:
> > > fs-verity previously had debug printk but it was removed. This patch
> > > adds trace points to the same places where printk were used (with a
> > > few additional ones).
> > 
> > Are all of these actually useful?  There's a maintenance cost to adding all of
> > these.
> > 
> 
> Well, they were useful for me while testing/working on this
> patchset. Especially combining -e xfs -e fsverity was quite good for
> checking correctness and debugging with xfstests tests. They're
> probably could be handy if something breaks.
> 
> Or you mean if each of them is useful? The ones which I added to
> signature verification probably aren't as useful as other; my
> intention adding them was to also cover these code paths.

Well, I'll have to maintain all of these, including reviewing them, keeping them
working as code gets refactored, and fixing any bugs that exist or may get
introduced later in them.  They also increase the icache footprint of the code.
I'd like to make sure that it will be worthwhile.  The pr_debug messages that I
had put in fs/verity/ originally were slightly useful when writing fs/verity/
originally, but after that I never really used them.  Instead I found they
actually made patching fs/verity/ a bit harder, since I had to make sure to keep
all the pr_debug statements updated as code changed around them.

Maybe I am an outlier and other people really do like having these tracepoints
around.  But I'd like to see a bit more feedback along those lines first.  If we
could keep them to a more minimal set, that would also be helpful.

- Eric

