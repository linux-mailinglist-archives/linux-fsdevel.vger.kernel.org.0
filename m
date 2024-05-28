Return-Path: <linux-fsdevel+bounces-20328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7908D17F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D851F25D01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E6161310;
	Tue, 28 May 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbhy/wnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DCDF6B;
	Tue, 28 May 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890447; cv=none; b=AJKWF9aJesbPYyF2a4nlgS9ngOYuGPRLrMSTLuim/dx9dTxDKhOJEbNbS9bLrGxBwk/4DspuM48Xv4Zqy3eF7nNQx23s+Rtg8Veoj3fdpH22G5RGR7FYX428rygpmumtIRjZuyKU8AnG8aPNgbPo6BkHybwzMj5Rl+f1RGBsLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890447; c=relaxed/simple;
	bh=CInOkgJyB8kDq39UtAQfDvd/HXuF8nIS2l/KfM8QXoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADSya53u1iIiq928XAPuxCbcGXopK5i6lv7DGTi+CTo/zwK+UmWjg+HDp+XlAXOTRuQoz8vbT78gMABe5rcN9ifVrf/n9i0V+NuHSTdhxGwt7ZcfSa0yLdhNfwfWHKv8AUTJkJE/mstl+TARo+4awGP5oydmZ7P6TGgKJP/yy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbhy/wnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F22BC3277B;
	Tue, 28 May 2024 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716890446;
	bh=CInOkgJyB8kDq39UtAQfDvd/HXuF8nIS2l/KfM8QXoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cbhy/wnU7b2WvMpU4rk/NU2K1d0Nb7zY25T6iILapAP78k6pFmPbzvKfxYwrJMBzJ
	 OZCvWIXT+Ta/wFoeYS2eKdfGx+X2xjqxkwGIaUiqesIx4lAsRR7ByTZiJwPsjYxu2O
	 iWCcBC4D1DvvyVJaFaPVRbDnn+4FV9y7jEVbN19SsCIwe7OjC7FKEt878TqFwU/Jl7
	 4n2xlb8D4N3A3MewEIcuOYeSx/t1FFhPm/eswShfRLqLA3tSCMIynX/N8f+hIuUbAx
	 JlL3is3fAXkhpJA1D4yEIjB6GfvlRuwelOAwXlx4CARZD67tFOM28WupbeX16AHncm
	 YmqqivZMLrzTw==
Date: Tue, 28 May 2024 12:00:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/adfs: add MODULE_DESCRIPTION
Message-ID: <20240528-gehemmt-umziehen-510568bb05ac@brauner>
References: <20240523-md-adfs-v1-1-364268e38370@quicinc.com>
 <20240524-zumal-butterbrot-015b2a21efd5@brauner>
 <20240527164022.GE2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527164022.GE2118490@ZenIV>

On Mon, May 27, 2024 at 05:40:22PM +0100, Al Viro wrote:
> On Fri, May 24, 2024 at 03:13:04PM +0200, Christian Brauner wrote:
> > On Thu, 23 May 2024 06:58:01 -0700, Jeff Johnson wrote:
> > > Fix the 'make W=1' issue:
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/adfs/adfs.o
> > > 
> > > 
> > 
> > Sure, why not.
> 
> Might make sense to move those into a separate branch, IMO (and feel
> free to slap ACKed-by: Al Viro <viro@zeniv.linux.org.uk> on those -
> AFAICS all of them look reasonable).

Thanks! Added Acks to all of them and about to push it to
#vfs.module.description.

