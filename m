Return-Path: <linux-fsdevel+bounces-34556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 899A49C63E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472E6283D66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9A121A4B7;
	Tue, 12 Nov 2024 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNJSZxm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E61200C96;
	Tue, 12 Nov 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731448699; cv=none; b=GF8LOPM2ezNmOHFWHO9+PCnQubfiAi1pU7Rs6VXsZIp8c/W5JHPpkNaYGt13V6gtR95ohQ7iNFHSI8MYxShGunBa94OpC4XOWwLVIEUPjTMDZ1CFoouKNSHHetWcP7almtJ3t3Un0FdTAE6jAyFC9RGzMoaWSoBO2qtrLcdoh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731448699; c=relaxed/simple;
	bh=N4mkR2zBBSmHdT6f4fdhVCH/CsMm4CZ2hzcH+plynlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojI1ytuuubsTLkrG106AFu/nlZHQ0qV+jwZrp0Tqm1ecWlQu4pgES3jyynhDO3WdtUISANI9+2dVzPPu8p3J6357OqT0840elSdn6mxOAl0X+ZGZSFU3pbUE1MYA1W0WDAHMbBF3+Yyd41jJ+ETCVq0bDgSyhgizsMMp7j5YEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNJSZxm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32AEC4CECD;
	Tue, 12 Nov 2024 21:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731448698;
	bh=N4mkR2zBBSmHdT6f4fdhVCH/CsMm4CZ2hzcH+plynlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNJSZxm6LAubrVG/XoRm+WvaF+rY343wxxf5I+gjvrnzihEWEPAo1d9ixCXVc9nx3
	 E3Fu+fJxBRZC0UWm5qTbB7qeDar7uwNIOAVPurTCWKkkIo3NsWZDmQuqhFMtQIQxu0
	 7z1wnQOjIpXVTd5cljM/MVJWOM9LJMw60bEphjShAMv/lpA4bdFuNWLCk972zB851b
	 6OUPORUzmPHmyXxK+ZJM1sz+4Jf8O7LLx8TYCAV3wBIsO2dtNc0CFXK8MNPncZ5wD2
	 P3D5shRFkuQ3yo48QwsNRVJjW0GJME9vy+jH1NHP42gIjw1n+8x0MITM2FYBmt2XQ4
	 ll7BRwJfwSaHA==
From: cel@kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] nfsd: get rid of include ../internal.h
Date: Tue, 12 Nov 2024 16:58:10 -0500
Message-ID: <173144863588.162655.6981261964613528856.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112213524.GB3387508@ZenIV>
References: <20241112213524.GB3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=655; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=L+9BkY1dGWIhdXeZYfcBMLKg98+nAC9ykyp6ydcbSks=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnM89xsUq5ywG7UyCfyUpYdQSTbW5i9xW2oJan0 +fh5nXFtWyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZzPPcQAKCRAzarMzb2Z/ l8AAD/0RmBroxq60Xsgl3vIEgzmHvaPuD2fsDUJiiJDMbjFlpFHpl66c+yZq0xd0ACFlKsfvmPo bqdoNmFbeT3MYC8zDT15xqolUCiPDPUaGAeogEg+zAVVDAwd7b4MLQM4yByfjlcEXF5mAxajzAP Ync+0FHIbA4QtJc4FzTXbwzJrAOVlYS34RFPfaNzohlxC3ba7NQQbk7T5pVvvhAIFif+CDFmmGH 0AVKkHseWElmlOsirQk9vuBocNmLmTq2g1OJZA4y23xPC76XwymSSY/ASlHV3/pgnmnkDsdxo+8 sorHM06dac8ulxaaUhg735wpwrS2QjYldRO7nhwE/ku38phvh/2pZHrQ4tpCgLP3Ab3XxSTSpIV t/B2rcv8RNLgRqfQJUcWH5VEInLFqGr2cYxLU/e9Sx61dllKZTDAHoGsd9rcw7vRNxNFcAZ8oOE tWqe20alkSC0TjQQYOghFNWTOpmpqy8ZRKhXOV/FXYnqY6E5nBkVU9pFXxxXjU807W6bVUB/H9e SiU+QpSDwJvvK51+EPFpuBKwMfxQF0jja7AvXo+YVLvfbb78leMho7erDsgnKCZ09/gt112ehNT KTaxIv/gfWG6N+Lqv4vWsOznKvEY5V/LkaK3+8ABvGQExfgilsWg2hFjZQPHlDkXyrTI2L29vJQ 8g44pWX
 XgWqocRg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 12 Nov 2024 21:35:24 +0000, Al Viro wrote:                                              
> added back in 2015 for the sake of vfs_clone_file_range(),
> which is in linux/fs.h these days
> 
>                                                                         

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] nfsd: get rid of include ../internal.h
      commit: 92fbf04c399bbc17047af893c7537c8bd6a00b20                                                                      

--                                                                              
Chuck Lever


