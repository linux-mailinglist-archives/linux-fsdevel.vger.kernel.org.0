Return-Path: <linux-fsdevel+bounces-16147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DA899368
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 04:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4EAB23809
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 02:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E622517753;
	Fri,  5 Apr 2024 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlwXxEFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867012E71;
	Fri,  5 Apr 2024 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285577; cv=none; b=WUuqEvmdAMOmyBYs6RP0urF1mza6Y0CaRl1HizUzq6xJEKEUZzJuMi3Y4vKpgHgYwSjZa42/vw1pRJaWbmbUtCNHUJGm6HNr1a+5hrYA3l3AvJi3gts5MsJfgBESxx0Jk+XFnh9G985qw/M7Tu5JO3bg6tpSU8KYPIHLinZu9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285577; c=relaxed/simple;
	bh=ohWSzMGFm3b4flQnMRyMhCS5VqdCXNjD6WIBamQrdNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqbm9BFxmFXNsUCD3lNwM3IDkqF79en8tkK4Ndd2jhULxeBxC56/6OIq9ymwB89b95vs7AxGYN5PHteFPmG+hNJmCiiRBxQ4rCxCAEULrVFPbJA9ju1Sd8yF1qyGbVbhNRJujSd8w+1jItM0PSbA8C00KH4a6UIaIxHyw6lN14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlwXxEFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71207C433F1;
	Fri,  5 Apr 2024 02:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712285576;
	bh=ohWSzMGFm3b4flQnMRyMhCS5VqdCXNjD6WIBamQrdNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlwXxEFxivLPDMmvVaPMfwQvC17Q9IfoT+B8cIsBnX7X8JswX7rtE3nE5ulIXUX+C
	 eXYlQw1OWUjMe9p+uPn5u1vsjOdxaGAnMPYxutFiVUODpVdwt1wUqfqVcQTpZcwWMb
	 wbV63f9Se12wApfnWsnbZL7WCFP36yuXv9Aa3KmW6G3Exg9eEAHgnTIoqPYdPCexsu
	 RDwApiISiEHVcyypeJ3SQ3bfhbQjW47vtzgwgW5daeE8xzFczlWByDKYFK9TuziRMu
	 koC3Bk/BFcw9P/x+GLcDnbXP1mdVTZlPhznsJmRPaURxaHP8SdczFPaYNotzrzDq62
	 dwBdrfA2i49sg==
Date: Thu, 4 Apr 2024 22:52:54 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 09/13] fsverity: box up the write_merkle_tree_block
 parameters too
Message-ID: <20240405025254.GG1958@quark.localdomain>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868014.1987804.14065724867005749327.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868014.1987804.14065724867005749327.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:35:01PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Box up the tree write request parameters into a structure so that we can
> add more in the next few patches.

This patch actually already adds the struct fields for new parameters.  They
should go in later patches.

- Eric

