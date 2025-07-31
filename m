Return-Path: <linux-fsdevel+bounces-56376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E7B16EC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C86A5A4707
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00A29DB61;
	Thu, 31 Jul 2025 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMXT0L9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0EDEAF6;
	Thu, 31 Jul 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954666; cv=none; b=Um5POgLdAQoTbP11A18FNEK3Mv2dx9KRMYYklVpvAwEsKxq6DP9bRY//u8TmvQ2erGWZe/9ySOXdTb6kiVQ612p1P/ROHuT+U3cGI+ElebO0OpmRqvNJ76QsyVLDUnx+GsJafsOwhlq6DuznsYyAl0ZeFKmezOKGuQP7WUMRmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954666; c=relaxed/simple;
	bh=UEAHaLbx2JH3HqX0wj3MzIoRJMTv0UqjZcrtsLxeu4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5Q/jFwcyhsKGUQpU5qO9ziWFf5GU43wFI2k0sdgqoaNBv6QmlCoOeKt6ie1zYs5XN2S1HOUGk2CVjtUAWTrQg1FTApxD+tYdu/CFeRSMcd03ZdsBZAMo08wii2GrJXM+2m6Pt/CSlkT/O4UcmpGMEm1U12yByJo3t+mT0JgoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMXT0L9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADCC4CEEF;
	Thu, 31 Jul 2025 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753954666;
	bh=UEAHaLbx2JH3HqX0wj3MzIoRJMTv0UqjZcrtsLxeu4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMXT0L9GGPAteSWjXIObFJknKlw7+hJcLUq2+hsUy4mlHPjzNChRP5Bzw29uXlFm6
	 gRgxYFXd0ZzrhLeWhNgDkQjpvbHOvX8o9kyj0tA6NZ22kkCqQNxsFWRbf8u535w45D
	 RIdGIjSDqcUg4Nqt4jlmlN+7tf1SnVVlnps5blFtqR47lCltKndgHQesaRxsSNFFSH
	 4U6zTiBZabVOK3zdHBTSM04Mxv70QyljrQt88sXexopjSFR+GQOFUifQK5X3wd6TrU
	 FSmSBLYdx+IfjnXX2YCboWg5DXlFKcTuHacEnnCwHyTrzFDVoPXOd1YNvRQv3xycGi
	 6dXqUW4ExBdFA==
Date: Thu, 31 Jul 2025 11:37:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 02/14 for v6.17] vfs coredump
Message-ID: <20250731-podest-lohnarbeit-dcd3ae5d8d74@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
 <20250725-vfs-coredump-6c7c0c4edd03@brauner>
 <CAHk-=whYAT=9kUrGRCW=kWkF7aPdvcAYUnUj3f-baMy1+DsoOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whYAT=9kUrGRCW=kWkF7aPdvcAYUnUj3f-baMy1+DsoOQ@mail.gmail.com>

On Mon, Jul 28, 2025 at 11:57:58AM -0700, Linus Torvalds wrote:
> On Fri, 25 Jul 2025 at 04:27, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This will have a merge conflict with mainline that can be resolved as follows:
> 
> Bah. Mine looks very different, but the end result should be the same.
> I just made that final 'read()' match the same failure pattern as the
> other parts of the test.
> 
> Holler if I screwed up.

Thank you. This all looks good to me.

