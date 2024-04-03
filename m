Return-Path: <linux-fsdevel+bounces-16025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6C896FAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F47B25EB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E2146A8E;
	Wed,  3 Apr 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="V05JxkJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E8146A75
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149181; cv=none; b=lRVhZIh8YarFFPFUwJi4dJ8kOLHc9zMxca+buF3JHu8wXQAI+5BotNMvv6t/myyP+mmXKa6WI2Ea/J+LFOHzfw6Cbjd6Ud2Y9St3JPeqE4e+tKw6ymkYfscjNAhGu97d1Ub9SFkIfWHYJPTz6cGSKjGJKBnvadcBOs2MOpcGhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149181; c=relaxed/simple;
	bh=HUm4rX7f5vx16jEu8Sf5T2cz4l5Z+ApVMO6v3mlJDPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo/cLHFkLEzLp4ZTpKweI0twTvwjIIb/Ex1/AYyfXcW+AyA7AFWLCr2ELHvQTRkjiE0GeFrTWqfhi3BYO7Tsex7H9LcKYIvRnMyG0eB2D3EbznXJIkkk1C+hhzjqfrRCMfuu3mwHMiyMVmBtnOLnAO8wSU2v/0pGq6GIMrAAN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=V05JxkJq; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id rsdHrxQU3l9dRs0DEroRaG; Wed, 03 Apr 2024 12:59:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id s0DDrJkJBuv6Xs0DDrmsCi; Wed, 03 Apr 2024 12:59:31 +0000
X-Authority-Analysis: v=2.4 cv=YbZ25BRf c=1 sm=1 tr=0 ts=660d52b3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4VnFru8p6tJF5H7f7NqpSA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10 a=hSkVLCK3AAAA:8
 a=dZbOZ2KzAAAA:8 a=NCOkLyd_rlf-iUkjTgcA:9 a=QEXdDO2ut3YA:10
 a=cQPPKAXgyycSBL8etih5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fviJob8AHM37gPjhK3h7HrJK72m/4Gn7wrbDrlUSskE=; b=V05JxkJqP76wdpE6Bj5q0AVFtl
	8zYkkK7JocWgI6tZffH/UbcDyOgwgoxTV4GAuzD7Ur49Xvwe71SdnCdyPvNlh42vgUCiWiKQdkjlo
	n5FjQuWcxkDwDk0vHjpjKjvIHhxgojXOwmHkGvsIEH5BnaYeN2syAz5/GAkfj0p5MKfcekEegWG4X
	AmnjvtjLAlaAvrqWfx7FSbEkN6gkXKpQt/C9mZf7OP9dRtCsDnfs8zapScgg357O11jMrfgfIyGFk
	l0CUrGd6dWbdbcMTR4V0zB50erBv73/SbuoNbRK84XhCtIS5u8x/pUqHiUbuWYcVHewnC8jSHhCL7
	mRkevEyw==;
Received: from [187.184.159.122] (port=11187 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rs0DC-002qxv-17;
	Wed, 03 Apr 2024 07:59:30 -0500
Message-ID: <88f4493a-2787-4c25-bd0a-80731a603faa@embeddedor.com>
Date: Wed, 3 Apr 2024 06:59:24 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] fs: fix oob in do_handle_open
To: Jeff Layton <jlayton@kernel.org>, Edward Adam Davis <eadavis@qq.com>,
 syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
Cc: amir73il@gmail.com, brauner@kernel.org, chuck.lever@oracle.com,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 viro@zeniv.linux.org.uk, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <000000000000f075b9061520cbbe@google.com>
 <tencent_A7845DD769577306D813742365E976E3A205@qq.com>
 <72d7604e38ee9a37bcb33a6a537758e4412488ee.camel@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <72d7604e38ee9a37bcb33a6a537758e4412488ee.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.122
X-Source-L: No
X-Exim-ID: 1rs0DC-002qxv-17
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [187.184.159.122]:11187
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFldZXxxeQrS/skokxirUGMi0T5D+g5QdlmBnA54ZnfI5cMjx1BIj6rl5+JvUjCX9TzRvJFxB3KjhHA3PSv+6WOfLdakXH6HG54pF6x9GdMK4JU1mK5I
 vD4AwRUPSSJq14nrc4JQrd9CKaI8ffSRYHZhbWobnO7rYuyDwsxa6wfVD1sgw+EdQ4zJ7w5GARqRIxBTYvMwN+5cAvO75ilWWbzW5KoIkYxn4gL9QWXy2RvX



On 03/04/24 02:48, Jeff Layton wrote:
> On Wed, 2024-04-03 at 14:54 +0800, Edward Adam Davis wrote:
>> [Syzbot reported]
>> BUG: KASAN: slab-out-of-bounds in instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
>> BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
>> Write of size 48 at addr ffff88802b8cbc88 by task syz-executor333/5090
>>
>> CPU: 0 PID: 5090 Comm: syz-executor333 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:88 [inline]
>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>>   print_address_description mm/kasan/report.c:377 [inline]
>>   print_report+0x169/0x550 mm/kasan/report.c:488
>>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>>   instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
>>   _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
>>   copy_from_user include/linux/uaccess.h:183 [inline]
>>   handle_to_path fs/fhandle.c:203 [inline]
>>   do_handle_open+0x204/0x660 fs/fhandle.c:226
>>   do_syscall_64+0xfb/0x240
>>   entry_SYSCALL_64_after_hwframe+0x72/0x7a
>> [Fix]
>> When copying data to f_handle, the length of the copied data should not include
>> the length of "struct file_handle".
>>
>> Reported-by: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>>   fs/fhandle.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fhandle.c b/fs/fhandle.c
>> index 53ed54711cd2..8a7f86c2139a 100644
>> --- a/fs/fhandle.c
>> +++ b/fs/fhandle.c
>> @@ -202,7 +202,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>>   	*handle = f_handle;
>>   	if (copy_from_user(&handle->f_handle,
>>   			   &ufh->f_handle,
>> -			   struct_size(ufh, f_handle, f_handle.handle_bytes))) {
>> +			   f_handle.handle_bytes)) {
>>   		retval = -EFAULT;
>>   		goto out_handle;
>>   	}
> 
> cc'ing Gustavo, since it looks like his patch in -next is what broke
> this.
> 

Oh, sorry about that folks. That looks pretty much like a copy/paste error.

The fix is correct.

Thanks, Edward!
--
Gustavo


