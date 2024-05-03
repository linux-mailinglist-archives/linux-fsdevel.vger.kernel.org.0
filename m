Return-Path: <linux-fsdevel+bounces-18561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB48BA51B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 03:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0301AB22385
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 01:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A8E13FF9;
	Fri,  3 May 2024 01:55:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD5E574;
	Fri,  3 May 2024 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714701308; cv=none; b=J0ENyTAvbEwSoJFOXUvwogKDTE9ZWRtH9n4bsfdT+Y9DrVleTf88otu4lq3HnP3Wl8utJFRXpjVBroZnRzDYMuYpGgwm+MwQ5sSFltlMtUO7m1opOYawb+8LNQZTqZfwFJBEwD2fhBtzRx5eWROP4HNWPiqRO1tH2SspHdtablg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714701308; c=relaxed/simple;
	bh=BZ6f+p90P5mJixOYZNlhavrNUMb9G+1YR3hJY3NcPzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k2fpoTOvAbnSPEyyhGxlMbbdRfc6lJL+U1bg2hLP+CBpiI5JOXuJWLlTOEWCQvQvWoAvzJl+EJ3RWae55JfhogUd3LT/3dj/zKD0uoRLJ5GGdlkmKiY9f7jSerBf40WG3vnGi2h/nNIxNzICVpi+ZAjBDp4Ps088jzbW0C1tQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VVv3d0nGkzccq7;
	Fri,  3 May 2024 09:53:49 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id B27291800B8;
	Fri,  3 May 2024 09:54:57 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 09:54:56 +0800
Message-ID: <cd418415-53ba-225a-8998-dfb832b2e7d3@huawei.com>
Date: Fri, 3 May 2024 09:54:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] [ext4?] WARNING in mb_cache_destroy
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, syzbot
	<syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, <nathan@kernel.org>, <ndesaulniers@google.com>,
	<ritesh.list@gmail.com>, <syzkaller-bugs@googlegroups.com>,
	<trix@redhat.com>, <tytso@mit.edu>, yangerkun <yangerkun@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <00000000000072c6ba06174b30b7@google.com>
 <0000000000003bf5be061751ae70@google.com>
 <20240502103341.t53u6ya7ujbzkkxo@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240502103341.t53u6ya7ujbzkkxo@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/5/2 18:33, Jan Kara wrote:
> On Tue 30-04-24 08:04:03, syzbot wrote:
>> syzbot has bisected this issue to:
>>
>> commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3
>> Author: Baokun Li <libaokun1@huawei.com>
>> Date:   Thu Jun 16 02:13:56 2022 +0000
>>
>>      ext4: fix use-after-free in ext4_xattr_set_entry
> So I'm not sure the bisect is correct since the change is looking harmless.
> But it is sufficiently related that there indeed may be some relationship.
> Anyway, the kernel log has:
>
> [   44.932900][ T1063] EXT4-fs warning (device loop0): ext4_evict_inode:297: xattr delete (err -12)
> [   44.943316][ T1063] EXT4-fs (loop0): unmounting filesystem.
> [   44.949531][ T1063] ------------[ cut here ]------------
> [   44.955050][ T1063] WARNING: CPU: 0 PID: 1063 at fs/mbcache.c:409 mb_cache_destroy+0xda/0x110
>
> So ext4_xattr_delete_inode() called when removing inode has failed with
> ENOMEM and later mb_cache_destroy() was eventually complaining about having
> mbcache entry with increased refcount. So likely some error cleanup path is
> forgetting to drop mbcache entry reference somewhere but at this point I
> cannot find where. We'll likely need to play with the reproducer to debug
> that. Baokun, any chance for looking into this?
>
> 								Honza

Hi Honza,

Sorry for the late reply, the first two days were May Day holidays.
Thanks for the heads up, I'll take a look at this soon.

Regards,
Baokun

