Return-Path: <linux-fsdevel+bounces-20295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455178D12F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 05:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEE31F22F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 03:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF117BD8;
	Tue, 28 May 2024 03:45:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7186417E8E4;
	Tue, 28 May 2024 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867950; cv=none; b=K3L0sKEMpRBdCQhFKHhjwE7V4t3mlXJPzO+0UsFcyN6YfvYmP/EGXsWmFDHXdlb2NuStt0yU9YnGnmwwGLIoNcHHK718cMaWK6fXGB/bHvltsKInp5G6qRCSKZLagFk5dWNiv7YIkES86v2n38QXq0zTk2M8sdEUDuvAtffRHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867950; c=relaxed/simple;
	bh=8Wbp2Csk20jRbXt47bxwNrTOIr9WdTkbi2J4gtJqvXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EOwNrpOAt3MWhfwaELGqL1jYY7XzzXk4XpNhcmt4XMPWHTcMMabTD2K1BIDxkEznGKiZwhkcStu7EZON/Kg8GHEJ7oFuko9lc89S66t4NPwqegE0QD6/2kZ4vKGq5viKBHYsEpwtW3hoSCZKWgVy7E7mLLHkqawJXRhWJ/rcsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 186DC205DB9A;
	Tue, 28 May 2024 12:39:29 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-3) with ESMTPS id 44S3dRkS081341
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 12:39:28 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-3) with ESMTPS id 44S3dRBl828125
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 12:39:27 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 44S3dRPC828124;
	Tue, 28 May 2024 12:39:27 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] fs: fat: add missing MODULE_DESCRIPTION() macros
In-Reply-To: <20240527-md-fs-fat-v1-1-b6ba7cfcb8aa@quicinc.com> (Jeff
	Johnson's message of "Mon, 27 May 2024 11:00:40 -0700")
References: <20240527-md-fs-fat-v1-1-b6ba7cfcb8aa@quicinc.com>
Date: Tue, 28 May 2024 12:39:27 +0900
Message-ID: <87v82yzjtc.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> Fix the 'make W=1' warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat_test.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/fat_test.c | 1 +
>  fs/fat/inode.c    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
> index 2dab4ca1d0d8..1f0062659067 100644
> --- a/fs/fat/fat_test.c
> +++ b/fs/fat/fat_test.c
> @@ -193,4 +193,5 @@ static struct kunit_suite fat_test_suite = {
>  
>  kunit_test_suites(&fat_test_suite);
>  
> +MODULE_DESCRIPTION("KUnit tests for FAT filesystems");
>  MODULE_LICENSE("GPL v2");
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index d9e6fbb6f246..3027d275dbf1 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1978,4 +1978,5 @@ static void __exit exit_fat_fs(void)
>  module_init(init_fat_fs)
>  module_exit(exit_fat_fs)
>  
> +MODULE_DESCRIPTION("Core FAT filesystem support");
>  MODULE_LICENSE("GPL");
>
> ---
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> change-id: 20240527-md-fs-fat-bea9424c9303
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

