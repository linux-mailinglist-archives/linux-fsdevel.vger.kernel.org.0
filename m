Return-Path: <linux-fsdevel+bounces-47007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B699A97B05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 01:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8944176895
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 23:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028E2144C4;
	Tue, 22 Apr 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="scvsfLwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6151F790F;
	Tue, 22 Apr 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745364594; cv=none; b=mNIInLMDWfC7YTYmWP2RfpIgaaNwLowB031Cwrx7jiLAS63py1NB8OEMGKL9Li8KvEImOc4d2PoCNapU4UKXz8b2mma9uoY2nNUCPSaFDOz5vn+IXp6BWsEX0ponMltKBZNqUtlu862TwtX0G3Z+rNBWUSaSFKIbcgYUSSsZ0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745364594; c=relaxed/simple;
	bh=tHndFDrcFd9kMEmQ7a57XQ1NzeaY52OykaSsg/Pf/9w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SdAiCIElBLFXPuYQVUmkURAPE77wFNOncbkJvLcz1vsVvmjQwFP77b7GfzIEsDRzRuYlBgVgOi1u6HkPI/u4goPv7V65Hkm6JVVoSlskppqMGLblVrOo/JDAr/nbRPp2sHpYlawmUlsUftUrTXRrUxdR/3sIIEulFGgpytZ/uX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=scvsfLwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E03EC4CEE9;
	Tue, 22 Apr 2025 23:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1745364593;
	bh=tHndFDrcFd9kMEmQ7a57XQ1NzeaY52OykaSsg/Pf/9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=scvsfLwnRHsBz0Kz2b9irieRzIMprh10laqJ9X/PG1vjeW3eq2BF8SbpdQVgS2ms/
	 h7v7jM6QLjdwR5cXDrepB5IRb7R4R5OkkXq8QBDuWPWFP5jcICYl04lHyNLHu5RcMG
	 6SOHr+gqhly2aBmew7Xd18Prd0d333nbIevX+hR4=
Date: Tue, 22 Apr 2025 16:29:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: xu xin <xu.xin.sc@gmail.com>
Cc: xu.xin16@zte.com.cn, david@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, wang.yaxin@zte.com.cn,
 yang.yang29@zte.com.cn
Subject: Re: [PATCH RESEND 1/6] memcontrol: rename mem_cgroup_scan_tasks()
Message-Id: <20250422162952.19be32aa8cead5854a7699a8@linux-foundation.org>
In-Reply-To: <20250422111919.3231273-1-xu.xin16@zte.com.cn>
References: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
	<20250422111919.3231273-1-xu.xin16@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 11:19:19 +0000 xu xin <xu.xin.sc@gmail.com> wrote:

> From: xu xin <xu.xin.sc@gmail.com>
> To: xu.xin16@zte.com.cn
> Cc: akpm@linux-foundation.org, david@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, wang.yaxin@zte.com.cn, yang.yang29@zte.com.cn
> Subject: [PATCH RESEND 1/6] memcontrol: rename mem_cgroup_scan_tasks()
> Date: Tue, 22 Apr 2025 11:19:19 +0000
> 
> ...
>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>

It's clear what was meant, but please include the explicit

	From: xu xin <xu.xin16@zte.com.cn>

within each changelog, rather than only in the [0/N].

Patchset looks nice to me, thanks.  I'll await reviewer feedback before
proceeding.


