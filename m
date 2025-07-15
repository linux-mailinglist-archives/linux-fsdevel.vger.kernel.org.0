Return-Path: <linux-fsdevel+bounces-54904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F35B04D97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 03:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868C47B07B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49A2C08AA;
	Tue, 15 Jul 2025 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPQXRc8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4292A1AA;
	Tue, 15 Jul 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544300; cv=none; b=G91oZL+aDPHCfsBf6fvndgbl1eSLAL0RT+NIctmNYenKrQtT/RNZ3gZT/ISeYX+gFf5neNDkqx8SD0C3uV/SJ4pYJow2ITPPW/IUFsEBBPXN7cZCIH/JZMbB4JNHF+1iXi1HiGDxiTf1v0YroJfIq67FluAVHfu4Qex2v0jOcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544300; c=relaxed/simple;
	bh=TvkPdYPwe28TWT3Cql9wBIGSRg3jZiqx/OKwt4OJ1E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVUlaTxuTuA9Q+wjU7EfOHkS6RUcrcvr0Ae9Fe7Dbfq04EO2uvHhO8pfc2GzUJ140xFK5tLskCmeJUsAcgb6SUN4qQnSL/pnCGeEy/1Ef2TvfMkepLeHeko7MM9N+QkFU1bHlpqoBnFgh0GrYvkJE0CvyTdyuGNVEq/xXlCzm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPQXRc8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A0EC4CEED;
	Tue, 15 Jul 2025 01:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752544300;
	bh=TvkPdYPwe28TWT3Cql9wBIGSRg3jZiqx/OKwt4OJ1E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPQXRc8t10IJynDtzrPNbu0DPGjP5rDdiOcH8v5YM1lhTCkk8twdKbS0kfGdrd7vV
	 i9l2dzHZrNHNHo+PZh2Y4H5Wwx/jYxdkTtqknOjtpuoR1F+ZOVXE0jL6Mb6KU1JsW4
	 5sRJQ71DeYzib3xgZcRbRObsE7n32hLPaMm4DyX/WgPHpkouOOFYUM0VL56eK9THiB
	 EWKxmlwPWTBbqUjGcVSmUBMja/uU54i41TFgbApWI/Acpdp+dKWQrS3383mW6ygGCX
	 U8DpHzL71Kqu5wS3wKRSzYMfBu1/CTgAVnTYgWyaVGrEOl8MEP2D6/LS4Oy+Wu8Uzi
	 Roa4kqJkf9miQ==
Date: Tue, 15 Jul 2025 01:51:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] mshv_eventfd: convert to CLASS(fd)
Message-ID: <aHW0KrQSZ4TGHs2l@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250712165244.GA1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712165244.GA1880847@ZenIV>

On Sat, Jul 12, 2025 at 05:52:44PM +0100, Al Viro wrote:
> [in viro/vfs.git #work.fd; if nobody objects, into #for-next it goes...]
> 
> similar to 66635b077624 ("assorted variants of irqfd setup: convert
> to CLASS(fd)") a year ago...
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks for the patch, Al.

Acked-by: Wei Liu <wei.liu@kernel.org>

