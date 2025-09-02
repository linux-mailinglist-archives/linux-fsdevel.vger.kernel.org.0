Return-Path: <linux-fsdevel+bounces-59955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB2FB3F8CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5948E7B08C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E52E8DFD;
	Tue,  2 Sep 2025 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg2gcPLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793826E6E4;
	Tue,  2 Sep 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802175; cv=none; b=M/nPnsPCEE6apBGsEchzso7cxOEL3RUHo9fT60WhXz1+It7HrpwqunLRvfAoiTsXwQo1SXTdo1PlpsIVFOo1ZqjSky65dWKo9lDu2NywGh9oLS3vU76h7dq6a2y/pQfVQ0cHXeX41RqbVLcZJtVoWjsdNWlTuo0O0RAeoPfRoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802175; c=relaxed/simple;
	bh=AiJwx+ovZSz55eeB+XnEvYBdwHpVIKh702G79SMjs1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR9uZ8aS7BwOCfWXSGDpiM3U5p59vYXhzuwTrn4UJ8H08TGDvJunt35thRPNwe5lEwPLSdgvCFc1EtSQkLI8+vvG+DX/NL6PcAmZFyzGHYPvhcCJUPTae/lArTHTFL2JvRwSdI/gGAptRwtX1zeqQZRlGOSlS2G0iCQRezTK0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg2gcPLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C165C4CEED;
	Tue,  2 Sep 2025 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802174;
	bh=AiJwx+ovZSz55eeB+XnEvYBdwHpVIKh702G79SMjs1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mg2gcPLFkb+/wwozAzY77vsD4+hFtwC3OMBVSbhol0RfmzlQJaeAJX0cOYcdDICo9
	 XtTvk+8u5hMB+WB1BEz5ANBvx4aJcVZ61vuOecOYiXP239fUZp+BewMEyCmp68VMqX
	 VGOkvLYjPZSnSufMaYrRjEfB2dIRmatOBTKXGCaqErjZuknzHLLBuPZZ2ZmdVnOe60
	 zN251sC1R7pI2HxTNYy1155jq3DYyeQkH0R2CxXIZWjD9tbaBr6IOnFXbGnRxAplfc
	 NPYXzsJ0f78+nkvxkm8R23x34Lki3UKvE1Hp5ukk1SAqIOHvnOmq8vUfVfiJktqm0/
	 f5P1bfkduMl3A==
Date: Tue, 2 Sep 2025 10:36:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Xing Guo <higuoxing@gmail.com>, amir73il@gmail.com, 
	jhubbard@nvidia.com, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	miklos@szeredi.hu, shuah@kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] selftests/fs/mount-notify: Fix compilation failure.
Message-ID: <20250902-abhalten-besehen-ab6959fc4ebb@brauner>
References: <CAOQ4uxjJHscMEcAahVpbUDcDet7D8xa=X2rLr33femZsCy6t0A@mail.gmail.com>
 <20250813075523.102069-1-higuoxing@gmail.com>
 <e4aftint6uauii7p5dvnfd2byllwvzu5hjfxwpa3la3pigmae7@ahw76agoljhh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4aftint6uauii7p5dvnfd2byllwvzu5hjfxwpa3la3pigmae7@ahw76agoljhh>

On Mon, Sep 01, 2025 at 07:17:07PM +0200, Jan Kara wrote:
> On Wed 13-08-25 15:55:23, Xing Guo wrote:
> > Commit c6d9775c2066 ("selftests/fs/mount-notify: build with tools include
> > dir") introduces the struct __kernel_fsid_t to decouple dependency with
> > headers_install.  The commit forgets to define a macro for __kernel_fsid_t
> > and it will cause type re-definition issue.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202508110628.65069d92-lkp@intel.com
> > Signed-off-by: Xing Guo <higuoxing@gmail.com>
> > Acked-by: Amir Goldstein <amir73il@gmail.com>
> 
> Christian, quick search didn't find this patch in your tree. Any reason you
> didn't pick it up?

Weird. Thanks for the reminder, Jan! Picked into vfs.fixes now!

