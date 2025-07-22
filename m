Return-Path: <linux-fsdevel+bounces-55632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68BB0CED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 02:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895CE189C157
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8A13A3ED;
	Tue, 22 Jul 2025 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ms8b75j+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E42548EE;
	Tue, 22 Jul 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145052; cv=none; b=Pd2g8H9y02/X4c/zdvIkLzw840MG2NutDj6tbBhgM9//V1c9EErg/x9IWhVkgqjsJI+U2LA5SibXd3hmuKDKrmdbPVbOFj6u2HJQgPh2jG2u8Tj4UvHUnIkRawqjcEAS94cekmNvW/75fcxVm2g5wWI5ePFcpgjQ47g65PIElmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145052; c=relaxed/simple;
	bh=Y1iZgiOzwKTp90jxUc90E2mBt/a0rdRCwCTMB/1BlLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfsJjZaPrlTAc6ebGiquqdUxI4UyQabSnTCVLjPu2hHnnuAfKG8d1lZRLtArrdgNgeyaWTAQmQoh5Aw2g7WEbcJz14EX9QnWvQB0eKKEfQfrxJ+lTUidIz0DD+berx8vNr5v3Nl8T8E+iZsgGYU/a7zEqAAPKBG6mMU6meVbbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ms8b75j+; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753145040; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gZkB6oAI3ayRod1op0xsOxq89vDBkQO5DG9RVIOAOG4=;
	b=Ms8b75j+vPqnwiiioBv3eZy/JLSOT220rZ1ES65tJvkLtq6cABNfOavY7adARyl/dsyX0nb40bWd1RGwsszfk5JfLjcpHyeipDjtH4aj930g72oMz+oBUPYBn64MmoRcSCbGdETOk/WYItJ0fOKR+vdAik6VRtZsw8liZeMBGCU=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjTR0ng_1753145038 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 08:43:59 +0800
Message-ID: <293202c8-68e0-45fd-aed8-5ec9aac39872@linux.alibaba.com>
Date: Tue, 22 Jul 2025 08:43:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 21 (fs/erofs/*.c)
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Bo Liu <liubo03@inspur.com>
References: <20250721174126.75106f39@canb.auug.org.au>
 <b555f01c-4e9e-4b42-aa5a-2d35ef9c1c50@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b555f01c-4e9e-4b42-aa5a-2d35ef9c1c50@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Randy,

On 2025/7/22 05:31, Randy Dunlap wrote:
> 
> 
> On 7/21/25 12:41 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20250718:
>>
> 
> on i386 (i.e., 32-bit):
> 
> In file included from ../include/linux/bits.h:5,
>                   from ../include/linux/string_helpers.h:5,
>                   from ../include/linux/seq_file.h:7,
>                   from ../fs/erofs/super.c:8:
> ../fs/erofs/internal.h: In function 'erofs_inode_in_metabox':
> ../include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
>      7 | #define BIT(nr)                 (UL(1) << (nr))
>        |                                        ^~
> ../fs/erofs/internal.h:305:38: note: in expansion of macro 'BIT'
>    305 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
>        |                                      ^~~
> 

Thanks for the report.

I checked this just now. This warning is due to another
helper erofs_inode_in_metabox().

I've fixed it up and just push it out but not sure if
it will catch up with the today's next (20250722).

Thanks,
Gao Xiang

