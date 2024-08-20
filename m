Return-Path: <linux-fsdevel+bounces-26352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87028958155
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 10:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B181F250D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5B18A928;
	Tue, 20 Aug 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY/oDBbQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824018E35E;
	Tue, 20 Aug 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143750; cv=none; b=LXQbfLTSKaDRVELx5pmO0NYpKj0ywlRCWd583DdfEkdQg4/gJrvyDHQJU9v7E2mKWnsa9TlXyAGwsRH5IKzDQ/869NZ4nP1FnUBpYnvO6hytQryaDpEuvXq+sc213alSER0JbNeCiHlv7tBO1WQbctEnuzlF73MLHzeNKCtYCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143750; c=relaxed/simple;
	bh=7td8UTWUtBpxNrwYc/4TUxUZPXt3/6PTBBOx63f0MWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZq+/dvbZER/rQ8efGALyWTr+sxbTZ7iXeTkWM2ib8hp39VKsaxo4crFKDJR7F3Vpjw9BLV1qZyq95nwUqDMVNqhoJAI3tJO0P0jtpkJxkssjdtUvLSyemQEWbZMNVzDPWaH+lJ50vQEp+aw6v9mSaR5c1t/shCYjaIi71MvqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY/oDBbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3708C4AF0B;
	Tue, 20 Aug 2024 08:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143750;
	bh=7td8UTWUtBpxNrwYc/4TUxUZPXt3/6PTBBOx63f0MWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RY/oDBbQkI1nyS16xOF1/lch8QijVo45PI0UZf1XHjmLEuleZ/XXJhjSSdM7cL9g/
	 7ZK5KtIALn3zvZbfQzwFeWOmOu+/IIQBnw4j3FS5hGHCLFWc5C8vQX30ja9P84Z5J+
	 eMLAWjejYTjKUmFgwTRwKhCN7Be4RRaNaryUIvsVLwLd3QWXEvZ+bEnDCwnID3NUsf
	 u1Ul0HhelvAALFwc7FtfV3TUHneMdkqOU4ozZnlwhChgxwFgstYUTzPqrtuKBTDdZe
	 l7Rr0EU3ho+gwOilTpHB8LV1VTPG57jbsHRGHSae571icj/FsYHhBsVelo8SsYlGPs
	 B5aAK27+Vkyhw==
Message-ID: <122f238d-c375-43a4-b3ee-611c50b478ed@kernel.org>
Date: Tue, 20 Aug 2024 17:49:08 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] zonefs: add support for FS_IOC_GETFSSYSFSPATH
To: Liao Chen <liaochen4@huawei.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, naohiro.aota@wdc.com, jth@kernel.org
References: <20240820022029.8261-1-liaochen4@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240820022029.8261-1-liaochen4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 11:20, Liao Chen wrote:
> FS_IOC_GETFSSYSFSPATH ioctl expects sysfs sub-path of a filesystem, the
> format can be "$FSTYP/$SYSFS_IDENTIFIER" under /sys/fs, it can helps to
> standardizes exporting sysfs datas across filesystems.
> 
> This patch wires up FS_IOC_GETFSSYSFSPATH for zonefs, it will output
> "zonefs/<dev>".
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Applied to for-6.12. Thanks !

-- 
Damien Le Moal
Western Digital Research


