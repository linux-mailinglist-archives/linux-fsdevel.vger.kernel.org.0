Return-Path: <linux-fsdevel+bounces-45916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD1A7EF77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 22:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D69A1693EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79122256B;
	Mon,  7 Apr 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVN6vNci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626772153D2;
	Mon,  7 Apr 2025 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744059259; cv=none; b=EiJKMne894RDoby/VptvcD9HhxZ+CSiaY9+enPtfatT0+fRfW4+XNmSOg5k/qMAl208+fhWpx4JrXjaqbl3FiiRFQX0DvljmMqHtOr+fhXvX+HN1tTYjLdOfpmQNfDIyzwZUl276Ahjp081/TAjYer+8Ih7LPKJw2jSh5LeCAoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744059259; c=relaxed/simple;
	bh=HJlNZZRn9M561YMJiY1dk0GguFob33goTjpzmmJxXxA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cfLIwdzAFPb8jzvwVXrQsjvaEdVj4FefY3fGOXYoaNsbr/lucJ9dSGlLwgAyE4wrbH1BcSPElGLrJN2t6NvZwu/VfM6j+ALiuHM+8qrig9CTD+Tp4yjbO2eKT8VUYdDDpO+VZ7tT1mHQ6zWyVOuolGgO5i0/0pe7aocbP5u+Tyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVN6vNci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FEAC4CEDD;
	Mon,  7 Apr 2025 20:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744059258;
	bh=HJlNZZRn9M561YMJiY1dk0GguFob33goTjpzmmJxXxA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=sVN6vNci4531GuMRvZ2AIIe4uR+phJ0GBXZyRI1L7t5yap1QFLxi1+CwA2ZRRGC0z
	 2xg5Ovd39ljph8Sg/u/m/r2ahDryPsQA5WZwxVj1N7iH7wKsg87+ZcFxLa7HKqaZUd
	 EN2FfKskSq2cxlmrff8Y7Ybf3JaZPKPZIkEeZkrUiKnpnIYW4T7L71PuEY6Lc3PqEc
	 kvBUjBCOKybSM5upyrhuGphvtYtlE9+d+mRYuEqhyS3MesY+ok4YE1irIvX0cPaIGB
	 XAgUiwHTRbnmosMawjY4XnKlv4W170zphKaKWNZEN3mo+FgEhwb+PD49lyoGr5Ahwt
	 u1fAJix7afX6A==
Message-ID: <9a6af7c9-bc77-4bcf-8a4c-2aea712ede25@kernel.org>
Date: Mon, 7 Apr 2025 15:54:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: distrobox / podman / toolbox not working anymore with 6.15-rc1
From: Mario Limonciello <superm1@kernel.org>
To: Linux kernel regressions list <regressions@lists.linux.dev>,
 David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 yaneti@declera.com
References: <0cfeab74-9197-4709-8620-78df7875cc9b@kernel.org>
Content-Language: en-US
In-Reply-To: <0cfeab74-9197-4709-8620-78df7875cc9b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/2025 10:48 AM, Mario Limonciello wrote:
> Hello,
> 
> With upgrading to 6.15-rc1, the tools in the subject have stopped 
> working [1].  The following error is encountered when trying to enter a 
> container (reproduced using distrobox)
> 
> crun: chown /dev/pts/0: Operation not permitted: OCI permission denied
> 
> This has been root caused to:
> 
> commit cc0876f817d6d ("vfs: Convert devpts to use the new mount API")
> 
> Reverting this commit locally fixes the issue.
> 
> Link: https://github.com/89luca89/distrobox/issues/1722 [1]
> 
> Thanks,
> 

David shared this on the Github thread:

https://lore.kernel.org/linux-fsdevel/759134.1743596274@warthog.procyon.org.uk/

I can confirm it fixes the issue.

