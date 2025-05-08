Return-Path: <linux-fsdevel+bounces-48458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93020AAF536
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9797AAFB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2E221F1C;
	Thu,  8 May 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtpiOV/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E966F073
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692061; cv=none; b=QrdduC2Yv8F+P1V+fE8qsu9Wpb66wYYukDVbW9CNSsSJuUxZhEwwB7O9X/Ny8WnlDnN29y+1WzTVJ126sR4aecENEwwdN/w114SD1z+qccuCtbobucQ9h7q5fIEUp24vQUkInipLC9KGPqTOdDC7mNVl1e2N9Z4dHMvHixqYnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692061; c=relaxed/simple;
	bh=AUsNBvqE0HbYXGTJ2WDhpfpO9QGEzenpsghdER8zNx0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IKH0QsZnOsvqa0ADYeiDwE9y211NWrZ8Ctx/QYADOVmGlXKEwYYAzi70guj5vEiU0pNiIM3m0eGBTCt6QnUsF0cliUyTLE7tUTcMQGPmoxqvZYXW49+1z87SEiSgmM+bpkMVJn5oWwGO+iTrsv3iKNkqEuFSNk7AMLXExMW/s6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtpiOV/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AE2C4CEEB;
	Thu,  8 May 2025 08:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746692060;
	bh=AUsNBvqE0HbYXGTJ2WDhpfpO9QGEzenpsghdER8zNx0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EtpiOV/fyk1ZoEAIhopBuBS8SDHdUtuUUZJtBVUT5Qz5uoswLbuD15vDzBhODHy+9
	 ET6Hj62ObUmO0/M3eFGRY5B2AVXB8UDQ4FbvSok3Kc9a3Av3j0sGuKbxKWypWcQIQo
	 ca9HTIAOBZZcgQ/p4PuUR9wXOvhIZC9BafCtnKEuZA1Fp5DUMKv8S3Jx5surqvgblN
	 YvciQZs6zesqrkChqJdZcMEyK/beXmuicoRzDSg7MFSugJJWzTRZdfJ2LZAYgDY6Nf
	 MpucAFyPrQqfRsGo9A6BbxpvJ0NLg4ys0yc3yi0mezgdl6l6irvQn7j6KeDUDicsgy
	 kMWUSyUZ/RwSg==
Message-ID: <a856fb64-f55c-4ffa-a457-fdbb094a2797@kernel.org>
Date: Thu, 8 May 2025 16:14:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH V3 6/7] f2fs: introduce fs_context_operation structure
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-7-sandeen@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250423170926.76007-7-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 01:08, Eric Sandeen wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> The handle_mount_opt() helper is used to parse mount parameters,
> and so we can rename this function to f2fs_parse_param() and set
> it as .param_param in fs_context_operations.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> [sandeen: forward port]
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

