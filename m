Return-Path: <linux-fsdevel+bounces-73784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B284D2053D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE1E9300752F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B683191C4;
	Wed, 14 Jan 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eau7VtTu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EA3A4F28;
	Wed, 14 Jan 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409451; cv=none; b=jCSnAmfW4+3OQGiNk99VsoxeynqdclA6wi+auIKlysMXVW7ILf9DBN1PcxHTdJx9PKXkbD73V14j62JyavSA+wNisOtBoPdoi9M/Ujsc/nOL6xUhteV7VctQJNJPmsO8qWK+P9JErRXrKuNH8HYcDaWktm8Gae9jYEESYO3SMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409451; c=relaxed/simple;
	bh=xf0auUcJs1yu+qsFMxdb3IBittaWs/QnfWdfBzX31ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq9Uaarel4N71M+4tu3EEvesywmeGblxAtnutSMWY7V+xsuGZcw4KBIiW0AfWCIpoluXImI2Vzag2KISgo7m+iIhDkT2oi1kH0Z2U9u01fqIlzFKEq5B9npfAJZLOL2dlmrctUZqA1ny+cotYRC8tZ0S8nWI5eoPVpTJZjbR53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eau7VtTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54283C4CEF7;
	Wed, 14 Jan 2026 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768409451;
	bh=xf0auUcJs1yu+qsFMxdb3IBittaWs/QnfWdfBzX31ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eau7VtTu7sjhHIVjujN6z9JNke+WR7TKtW29JlWF4f8eDitCPbSY/CrxnfK8fgFCR
	 YJMswUPxh8OQ+IMj9UzyJ6HZQ9wi7mLF3dCrBwOZPivXoOPfD2IsZ348l2TyzdI17g
	 YX89iDhPviSayfFoSqhWadxpQx/MdIEo9hGoMtsIA3BX9d2HBgbbejxSZCQvmqZXlM
	 z5oLaeLdzx4ByegR2C+6agydK2ajYP+JrLKKZn447xbsE0zhsW7jJY2Cg/CjUPRNqh
	 xvRpfWg/k0UdQE2rDOa7H8NwzrMnKYONI3kxbwi8rcTfhPOFxo29FjYGPRZIOu3/2j
	 zhZS9yDmOdV9w==
Date: Wed, 14 Jan 2026 08:50:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 13/22] xfs: introduce XFS_FSVERITY_REGION_START
 constant
Message-ID: <20260114165050.GQ15583@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <qwtd222f5dtszwvacl5ywnommg2xftdtunco2eq4sni4pyyps7@ritrh57jm2eg>
 <20260112224631.GO15551@frogsfrogsfrogs>
 <5ax7476dl472kpg3djnlojoxo2k4pmfbzwzsw4mo4jnaoqumeh@t3l4aesjfhwz>
 <20260113180655.GY15551@frogsfrogsfrogs>
 <20260114064735.GD10876@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114064735.GD10876@lst.de>

On Wed, Jan 14, 2026 at 07:47:35AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 13, 2026 at 10:06:55AM -0800, Darrick J. Wong wrote:
> > > hmm right, check in begin_enable() will be probably enough
> > 
> > I think that would probably be more of a mount-time prohibition?
> > 
> > Which would be worse -- any fsverity filesystem refuses to mount on
> > 32-bit; or it mounts but none of the fsverity files are readable?
> > 
> > Alternately I guess for 32-bit you could cheat in ->iomap_begin
> > by loading the fsverity artifacts into the pagecache at 1<<39 instead of
> > 1<<53, provided the file is smaller than 1<<39 bytes.  Writing the
> > fsverity metadata would perform the reverse translation.
> > 
> > (Or again we just don't allow mounting of fsverity on 32-bit kernels.)
> 
> What are the other file systems doing here?  Unless we have a good
> reason to differ we should just follow the precedence.

I ext4/f2fs place the fsverity metadata at roundup(i_size, 64k) and who
knows what happens if any of them ever enable large folios or have a
gigantic base page size (looking at you, arch/hexagon/).

btrfs seems to persist the merkle tree elsewhere but it loads it into
the pagecache at the same rounded-up address.

--D

