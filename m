Return-Path: <linux-fsdevel+bounces-39668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A561DA16C43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 13:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536AD1888E1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2AB1DFD87;
	Mon, 20 Jan 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAeAIcb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFC1DFFC;
	Mon, 20 Jan 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375703; cv=none; b=Xw1nfntaAzYZJ3kQi1bORw1ltl7SJWqr95So/qPzhsK2epw92LFM/kahf6sJYDtnrjawgeAPgkTEQ5kplk+ly+JD869Zc4QGcXRIxmRnIgN4HmsowplTkqyndAF1QTn8Qu6tj35Vlx+qzaMvYmC6fcYnmDHm68+PeHzqjtt1WNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375703; c=relaxed/simple;
	bh=/q41HM/ppmwTegHsfoNFHy0WGciJqIL+TGk8yUos0wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7L03vNoMJK2qHaAuaE83W50LzUsigDkP53u14gmSLssC73jZgzzCdCOaFSg8qOxgeDYioLI1QlwNXUSAcTB9mGky/SWvSzmAe/r8nV/iotJkGNRjcH1a5FjFphV6l6eXhuH5G2X4I2FpXgw05231Anh3Jki8Yy9wi+xmgyNLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAeAIcb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57564C4CEDD;
	Mon, 20 Jan 2025 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737375702;
	bh=/q41HM/ppmwTegHsfoNFHy0WGciJqIL+TGk8yUos0wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAeAIcb6NZ0GYH1NjR8Rx+o9A48qyfYNNIaT6ReBSa0Az2p/qABJ3kPUKm8boEewX
	 Bvkit1anSwBGPno87qvHd0sZhgq7Fy064vQuJozBooQzUDkGHnrk4alcuxFVLQ1X65
	 ZY/jAVqwodK9vStIAhRvGslMgtHGzWFlpgtcXlOGX3D77G7MVGZG4vKKkE5ZoiB0i4
	 07GGEz7pysVruYmcv+wyCz8GGW+hWfKhSDkdxO6DyomnEknoyGDMUcuJ98e9IYLf9/
	 2w+FXFyB7gTghD5X0boFZdsoHKjBCkDNfTyRukq9h8bXclnYk2x3596rUpguXccdzE
	 DZnPGGV3hTyow==
Date: Mon, 20 Jan 2025 13:21:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20250120-erahnen-sticken-b925f5490f46@brauner>
References: <20250118-vfs-mount-bc855e2c7463@brauner>
 <Z42UkSXx0MS9qZ9w@lappy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z42UkSXx0MS9qZ9w@lappy>

On Sun, Jan 19, 2025 at 07:10:57PM -0500, Sasha Levin wrote:
> On Sat, Jan 18, 2025 at 02:06:58PM +0100, Christian Brauner wrote:
> >      samples: add a mountinfo program to demonstrate statmount()/listmount()
> 
> Hi Jeff, Christian,
> 
> LKFT has caught a build error with the above commit:
> 
> /builds/linux/samples/vfs/mountinfo.c:235:18: error: 'SYS_pidfd_open' undeclared (first use in this function); did you mean 'SYS_mq_open'?
>   pidfd = syscall(SYS_pidfd_open, pid, 0);
>                   ^~~~~~~~~~~~~~
>                   SYS_mq_open
> 
> The full log is here: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-511-g109a8e0fa9d6/testrun/26809210/suite/build/test/gcc-8-allyesconfig/log

Thanks for the report. This is a build failure in userspace sample code.
I have pushed a fix and generated a new tag which I will send out
shortly.

Christian

