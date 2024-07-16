Return-Path: <linux-fsdevel+bounces-23781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4098E932FCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 20:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0410282939
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 18:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7971A01C1;
	Tue, 16 Jul 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EymzFKC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4C19B587;
	Tue, 16 Jul 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153605; cv=none; b=LTJW5Pp0ek5NIguaLm58dQnmryb538LbAiGnXluvXkd4ZfTzo30y3Ku6ohpA9F+K55xRcCxgHHt5zwPJH2dcOOx6IIhf7DBPxsCAM/DEZEcHE3Y08/XmBDywQX3Nvw3SSM/ZrBlDJ6e0rfZ4l0DGC9foAiinJMVqdyiePDvGlbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153605; c=relaxed/simple;
	bh=DZhcXLiUis/iLbLerEgeoOThaEhIx0IPchRNnZGuJig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M17RFUxIW7GRmits23shE9uv1P1M0Io18WcgwnlECNOpOcuXYtZewoqciROsR6GKiEEM98rKMhfcI+aP9fnzPaarBnvTKBCzY61ExugqiUZnmbTWvaz9Am/wqpT+rUjOHeX1VzLLcq9qSmQmX8U3GnvuRh2p4qhc6qMOp7vRF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EymzFKC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D591FC4AF0D;
	Tue, 16 Jul 2024 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721153604;
	bh=DZhcXLiUis/iLbLerEgeoOThaEhIx0IPchRNnZGuJig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EymzFKC74OJvZOlQhc1CY3OBG7OvBimicVTPs8ebqIQGUWU8LrIcw14VbjVsGJE9E
	 qdb8uCgbsTdpfCvjE/ArvYi/o16EwBTA6NTeZv2AjMqDkqGTxIKxM6Fip2vuBvSTNB
	 ut0V6keKqfPZz4Ry+NPcMLWnRh+OmG/KDUrzB09r2+n2Vpi4f+LgwrE7Vo2JYvXCWX
	 ezJZSiO7lqdQHf7/c3ZzECjtO26lKaoTjx/oSxWK1jh/hiCFixjRErNLwUinoKV4VX
	 9qkT1kLnzfF5qTTfjCJYGZ2q24ZNC0ziVO/dprOexV8CUF9nutXWB9Vael+rr6JvCl
	 0XIM7YsqEKaMA==
Date: Tue, 16 Jul 2024 11:13:24 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
Message-ID: <202407161108.48DCFCD7B7@keescook>
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com>
 <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>

On Tue, Jul 16, 2024 at 04:16:56PM +0200, Joel Granados wrote:
> * Preparation patches for sysctl constification
> 
>     Constifying ctl_table structs prevents the modification of proc_handler
>     function pointers as they would reside in .rodata. The ctl_table arguments
>     in sysctl utility functions are const qualified in preparation for a future
>     treewide proc_handler argument constification commit.

And to add some additional context and expectation setting, the mechanical
treewide constification pull request is planned to be sent during this
merge window once the sysctl and net trees land. Thomas Weiﬂschuh has
it at the ready. :)

-- 
Kees Cook

