Return-Path: <linux-fsdevel+bounces-27360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E265D96093C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC101C22554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348ED19FA72;
	Tue, 27 Aug 2024 11:48:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FB155CA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759283; cv=none; b=tnQHVEImeJcgiRWmKBgDEj7rQXtgMxshg/qsjEeHezACOjOcsVg2zl+2GohzACL6PLcDXNHP3jq/+k62PnyfwD/1Mi4clargpM0n6M6l+t47dRdnl6fkKiRY66YLyw+TEkUExws3WuwK2vstpjBYBW3yzceUUFTUfBpkkJvAQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759283; c=relaxed/simple;
	bh=xtuvclMCs8tB2+Ts7aoJIVT198TtlA+CT+9bLh9krpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hGBOWNIF+xZhR6C+FDQvQH+K2UrgXWw4D1PHKrBG43r3you43EZXiMW7/SJf5BtT6G4+SRnuH+Z6iMfB2SvExLViY7DeajRBmtEOZYFUrl3O+bARPJhpeOh2CHSCGgVOuImtuCmrDgRhdIE8vEry7iUepak5VDs/cJ3k2rwVjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtQjH6nG5zfbdw;
	Tue, 27 Aug 2024 19:45:55 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 64A4E140202;
	Tue, 27 Aug 2024 19:47:59 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 19:47:59 +0800
Message-ID: <6c1baa6e-5f71-418f-a7fc-27c798e51498@huawei.com>
Date: Tue, 27 Aug 2024 19:47:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] f2fs: new mount API conversion
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <brauner@kernel.org>,
	<lczerner@redhat.com>, <linux-fsdevel@vger.kernel.org>
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240814023912.3959299-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Does there exist CI test for f2fs? I can only write the mount test for 
f2fs refer to tests/ext4/053. And I have tested this in local.

Thanks,
Hongbo

On 2024/8/14 10:39, Hongbo Li wrote:
> Since many filesystems have done the new mount API conversion,
> we introduce the new mount API conversion in f2fs.
> 
> The series can be applied on top of the current mainline tree
> and the work is based on the patches from Lukas Czerner (has
> done this in ext4[1]). His patch give me a lot of ideas.
> 
> Here is a high level description of the patchset:
> 
> 1. Prepare the f2fs mount parameters required by the new mount
> API and use it for parsing, while still using the old API to
> get mount options string. Split the parameter parsing and
> validation of the parse_options helper into two separate
> helpers.
> 
>    f2fs: Add fs parameter specifications for mount options
>    f2fs: move the option parser into handle_mount_opt
>    f2fs: move option validation into a separate helper
> 
> 2. Remove the use of sb/sbi structure of f2fs from all the
> parsing code, because with the new mount API the parsing is
> going to be done before we even get the super block. In this
> part, we introduce f2fs_fs_context to hold the temporary
> options when parsing. For the simple options check, it has
> to be done during parsing by using f2fs_fs_context structure.
> For the check which needs sb/sbi, we do this during super
> block filling.
> 
>    f2fs: Allow sbi to be NULL in f2fs_printk
>    f2fs: Add f2fs_fs_context to record the mount options
>    f2fs: separate the options parsing and options checking
> 
> 3. Switch the f2fs to use the new mount API for mount and
> remount.
> 
>    f2fs: introduce fs_context_operation structure
>    f2fs: switch to the new mount api
> 
> 4. Cleanup the old unused structures and helpers.
> 
>    f2fs: remove unused structure and functions
> 
> There is still a potential to do some cleanups and perhaps
> refactoring. However that can be done later after the conversion
> to the new mount API which is the main purpose of the patchset.
> 
> [1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/
> 
> Hongbo Li (9):
>    f2fs: Add fs parameter specifications for mount options
>    f2fs: move the option parser into handle_mount_opt
>    f2fs: move option validation into a separate helper
>    f2fs: Allow sbi to be NULL in f2fs_printk
>    f2fs: Add f2fs_fs_context to record the mount options
>    f2fs: separate the options parsing and options checking
>    f2fs: introduce fs_context_operation structure
>    f2fs: switch to the new mount api
>    f2fs: remove unused structure and functions
> 
>   fs/f2fs/super.c | 2211 ++++++++++++++++++++++++++++-------------------
>   1 file changed, 1341 insertions(+), 870 deletions(-)
> 

