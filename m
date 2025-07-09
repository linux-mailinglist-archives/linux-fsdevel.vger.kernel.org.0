Return-Path: <linux-fsdevel+bounces-54358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 185CFAFEB5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 16:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91125188F125
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D3C2E5419;
	Wed,  9 Jul 2025 14:02:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2628DB56;
	Wed,  9 Jul 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069759; cv=none; b=KriPufekq9PwfK1PhbOYTC7VeqsVjaVF2dwHaqhCcSsNka/JbaB2Kjy68gueut/mCCdobw56qKiexLoWrDshRdrCdxKNg8cNGFXfBSzBy3IYk6927NdELtT+Jre8KDCfVTvxPUeGigwmCaULQ7akj8U8Y0FCnaflK4h3VHbQ8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069759; c=relaxed/simple;
	bh=I5/PoNuLfVO9juQBCnDCklUrfDrK/8QWDvmSEc5YnEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNZkWUtomi29hhZ5x3XgIXivx+BNqi0rvjhxaoiSQsxzqzOFtvKAKWqINnVK2adpWuTbBR42A07QNueZIptC9pFWNdua72js3QAUTgG44yANkTSh6VndjnbsNKTLUe/swKnFVDhOl/Vtxn/CxlMGloXYtRdmJtlKFUqaArMDb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 569E2DPk060732;
	Wed, 9 Jul 2025 23:02:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 569E2DaA060729
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Jul 2025 23:02:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
Date: Wed, 9 Jul 2025 23:02:10 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
 <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/08 4:03, Viacheslav Dubeyko wrote:
>>> @@ -172,7 +172,11 @@ static int hfsplus_create_attributes_file(struct
> super_block *sb)
>>>   		return PTR_ERR(attr_file);
>>>   	}
>>>  
>>> -	BUG_ON(i_size_read(attr_file) != 0);
> 
> But I still worry about i_size_read(attr_file). How this size could be not zero
> during hfsplus_create_attributes_file() call?

Because the filesystem image is intentionally crafted.

syzkaller mounts this image which already contains inode for xattr file
but vhdr->attr_file.total_blocks at
https://elixir.bootlin.com/linux/v6.16-rc5/source/fs/hfsplus/super.c#L485
is 0. This inconsistency is not detected during mount operation, and
sbi->attr_tree_state remains HFSPLUS_EMPTY_ATTR_TREE, and
this inconsistency is detected when setxattr operation is called.

The correct fix might be to implement stricter consistency check during
mount operation, but even userspace fsck.hfsplus is not doing such check.


