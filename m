Return-Path: <linux-fsdevel+bounces-45192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A023A74671
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EB31B6124E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E682139A2;
	Fri, 28 Mar 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx1Ky7NC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D11DE2D4
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154828; cv=none; b=J3Jo7790iWrHOAGbRxVuNDZ6lbw4M8EwCPG/fdEg14TbTmCuXFvSxxVPtWge5Btj+L7djNSIki3eL/i2nc/EvAIVpJY9yPApf4yfr6GkOSZUQk5M6zQTymYHNjtjMFCfEYjft5e3UeWliVrK3qL4WmDs/G2aPJ4ibsdbiClaQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154828; c=relaxed/simple;
	bh=yWCUomho9im7wS5H7ids0K8C+FLQzAtxZPDPwYYH+Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILjA39vmym4MfHBFPbKkkHIOh0UJHDKhkIaBAoAXS4w8WzxrvqxurvsiRYuDp1Iu1l3mwWLRZR+ZwQpCUgmYtPhO86ii9W97HQYwnm46l+cmBwFJgAjTrSljAglEG8+PMVBmf571STy67Qw/2od4jtlDCgylfCmOjE3NIMCYuuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx1Ky7NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548DFC4CEE4;
	Fri, 28 Mar 2025 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743154827;
	bh=yWCUomho9im7wS5H7ids0K8C+FLQzAtxZPDPwYYH+Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tx1Ky7NCc+ZSdXP5xoFe4J2esGkbTb+Om5i/pxV/bbp6j0R8EXLO2JRPuiG3jT+7M
	 sDzA1jEOJdiRfEM6693IHDRX4NxnX7nz71oOyrrjkGNAtCi8Z53YSotNq+G3jlfdXs
	 0br07AvQXoJxe2kKmUTk/RvDjQ/qs94gZ2s09H1eUIIguigPFY47/30elz5ECzq9D7
	 TeDXbQLUp+gLLUsXWUxTzsEd0H+XhKJWbh3N4dBi+pykEHzp+8ZD2A5IxtYaRyzMXh
	 935iM8uGkJXkc3IWDJnGxV4upjPxCvHzyyg/zERAJi2fV3a9i7BZE/amIJRxyJw3Vp
	 bXi55qMiAv8iQ==
Date: Fri, 28 Mar 2025 10:40:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 00/11] Remove aops->writepage
Message-ID: <20250328-farbschichten-begossen-0190490de275@brauner>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>

On Fri, Mar 07, 2025 at 01:54:00PM +0000, Matthew Wilcox wrote:
> I was preparing for LSFMM and noticed that actually we're almost done
> with the writepage conversion.  This patchset finishes it off.
> Something changed in my test environment and now it crashes before
> even starting a run, so this is only build tested.
> 
> The first five patches (f2fs and vboxsf) are uninteresting.  I'll try
> and get those into linux-next for the imminent merge window.  I think
> the migrate and writeback patches are good, but maybe I've missed
> something.  Then we come to i915 needing to tell shmem to do writeout,
> so I added a module-accessible function to do that.  I also removed
> the setting/clearing of reclaim, which would be easy to bring back if
> it's really needed.  Patch 10 is probably the exciting one where
> pageout() calls swap or shmem directly.  And then patch 11 really just
> removes the op itself and the documentation for it.  I may have
> over-trimmed here, but some of the documentation was so out of date it
> was hard to tell what was worth preserving.
> 
> Anyway, let's see what the bots make of this.  This is against
> next-20250307.

Once you're ready it would be nice if you could resend this based on
mainline (can be today) and then I'll pick it up.

Christian

