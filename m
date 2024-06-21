Return-Path: <linux-fsdevel+bounces-22089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DB29120E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 11:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DC21C22349
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B14416F0DF;
	Fri, 21 Jun 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW3p2t75"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AFC16E887;
	Fri, 21 Jun 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962833; cv=none; b=qfbEMAxz6u2l/4Ddgo/W7UcOZBz6C87I4Je69kLcC3fTMVENMVz5Oe7CFD7I62c+ZXYwzVqSMyTp7x7I6OLvXZtWhZNll3zVTHcNGx1kpYFrMKVlYbsr/5AawqU60xzui1dHs7OX4/BG8Pb1OYiD2rjeg8ObcEIyWlwsvTWAeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962833; c=relaxed/simple;
	bh=Qv1QJXWLnnCXj1AxvfbHE+yc80zIma1oP61T1IGJLTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAlyntXeJGRw231ckuyb9QIo7HhMTNZP3evn+pwsALGLpdok2bqfrTAVyB6Yghj6WDaElNW0D5GuYLHKkOqly9us5x1MrqohWyb1wZHToHYRQTIKmlne4kSKHzNi/J/MCkiCH05MoCdHdq5MB9n7h+wWRNwvGFQdJmPkhc4u/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW3p2t75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4979AC2BBFC;
	Fri, 21 Jun 2024 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718962833;
	bh=Qv1QJXWLnnCXj1AxvfbHE+yc80zIma1oP61T1IGJLTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iW3p2t75J17zkyniXE2vRmDWezrjpmq8DI15IRBdbV4RaboIrHTxnnGpPleijVOWY
	 bPI9tX2vkyp0tl4OFv61s4CiPG2+cmb56FvzhcK82i3HASgmTxElmbe2rYUP71s4K7
	 qEjMlmY21fs7s86tmKmamoynw+73dEsk3XIThVsXNwhCXZTetVrS03suFxOy1Xffei
	 Z6MtjMUAGAv7/y7k4Sbd+GoNaXDT2bj9mWQ2V+YdVOx2xo+OhqupO7eF5uyx88hsYK
	 MgOKIDdYXMaJ5ZCY3dtwoKjb03QJROp5IBIo4abDJH9410b/QEhrHaLhiiexatGo5k
	 y/ivZXcY6jqmA==
Date: Fri, 21 Jun 2024 11:40:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [vfs]  632586fb1b:
 WARNING:at_mm/slub.c:#cache_from_obj
Message-ID: <20240621-stamm-bauabschnitt-692ac8eb7c27@brauner>
References: <202406211634.7ef4671b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202406211634.7ef4671b-lkp@intel.com>

On Fri, Jun 21, 2024 at 05:24:13PM GMT, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_mm/slub.c:#cache_from_obj" on:
> 
> commit: 632586fb1b5da157f060730549ad45ba9f5e0371 ("vfs: shave a branch in getname_flags")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Thanks for the report. This is an entertaining typo:

diff --git a/fs/namei.c b/fs/namei.c
index 7bb0419a083d..3d3674c21d3c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -193,7 +193,7 @@ getname_flags(const char __user *filename, int flags)
                }
                /* The empty path is special. */
                if (unlikely(!len) && !(flags & LOOKUP_EMPTY)) {
-                       __putname(result);
+                       __putname(kname);
                        kfree(result);
                        return ERR_PTR(-ENOENT);
                }

Folding this into the patch.

