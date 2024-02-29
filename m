Return-Path: <linux-fsdevel+bounces-13186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5D86C81E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 12:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3327F1F2595A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B1A7C0B3;
	Thu, 29 Feb 2024 11:35:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85E7AE63;
	Thu, 29 Feb 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206541; cv=none; b=SA+oW2/Xs9r786K6bJ6/aLuBgatqL0UqaEHrcBeVaggS1YKsFiCBufh/rHI2YrAw1LFghOcVHdu+dtrmIuV20SsJM0IR3l9NmAAROKZdNmbtz+AgcgGENmpNBTYeFxdaY1+z7qL1R+20AQzLD9yR+O9RPlT47Nky4LQzfeTb0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206541; c=relaxed/simple;
	bh=l8JNhnbr78XR0At/pJ0cw6TjsbveTynqFyEJUCTM6Xw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tHMfk9Y87HnHwR0fkW/j0xsm4YWwq6hzAP5mEbGM83sygQaJDV+uZI7mTZW2MltfRqI2haV2Ct1L+E+19CSYa8PVxisVvHeCdAt86+KcZ6NMEnosEJvF6PHePV6PGiVibZvApTW/4V51/P56JktOp1wRjlB8RtcIi8T4iUBP9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tlq0K1FJhz4f3jrl;
	Thu, 29 Feb 2024 19:35:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6B0E91A0232;
	Thu, 29 Feb 2024 19:35:34 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgB3lQ4EbOBlh0wOFg--.6135S2;
	Thu, 29 Feb 2024 19:35:34 +0800 (CST)
Subject: Re: ext4_mballoc_test: Internal error: Oops: map_id_range_down
 (kernel/user_namespace.c:318)
To: Christian Brauner <brauner@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 lkft-triage@lists.linaro.org, Jan Kara <jack@suse.cz>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>,
 Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <CA+G9fYvnjDcmVBPwbPwhFDMewPiFj6z69iiPJrjjCP4Z7Q4AbQ@mail.gmail.com>
 <CAEUSe79PhGgg4-3ucMAzSE4fgXqgynAY_t8Xp+yiuZsw4Aj1jg@mail.gmail.com>
 <7e1c18e3-7523-4fe6-affe-d3f143ad79e3@roeck-us.net>
 <20240229-stapfen-eistee-9d946b4a3a9d@brauner>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7c4f502e-0198-b941-39dc-90281564665b@huaweicloud.com>
Date: Thu, 29 Feb 2024 19:35:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240229-stapfen-eistee-9d946b4a3a9d@brauner>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3lQ4EbOBlh0wOFg--.6135S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw48tFyrArWkuw1xXFy7ZFb_yoW5Jr18pF
	WSy3WrWF4ktr1kWasFqr1fZryI9w4UJFyUur97X3Z8Aas09r18Ja98tFyY9rZYvrWxCr4k
	ZF1Utay3WrWDGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/29/2024 6:09 PM, Christian Brauner wrote:
> On Wed, Feb 28, 2024 at 11:33:36AM -0800, Guenter Roeck wrote:
>> On 2/28/24 11:26, Daniel Díaz wrote:
>>> Hello!
>>>
>>> On Wed, 28 Feb 2024 at 12:19, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>> Kunit ext4_mballoc_test tests found following kernel oops on Linux next.
>>>> All ways reproducible on all the architectures and steps to reproduce shared
>>>> in the bottom of this email.
>>>>
>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>
>>
>> [ ... ]
>>
>>> +Guenter. Just the thing we were talking about, at about the same time.
>>>
>>
>> Good that others see the same problem. Thanks a lot for reporting!
> 
> Hm...
> 
> static struct super_block *mbt_ext4_alloc_super_block(void)
> {                                                                                                                                                                                                       struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
>         struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>         struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
> 
>         if (fsb == NULL || sbi == NULL || es == NULL)
>                 goto out;
> 
>         sbi->s_es = es;
>         fsb->sb.s_fs_info = sbi;
>         return &fsb->sb;
> 
> out:
>         kfree(fsb);
>         kfree(sbi);
>         kfree(es);
>         return NULL;
> }
> 
> That VFS level struct super_block that is returned from this function is
> never really initialized afaict? Therefore, sb->s_user_ns == NULL:
> 
> i_uid_write(sb, ...)
> -> NULL = i_user_ns(sb)
>    -> make_kuid(NULL)
>       -> map_id_range_down(NULL)
> 
> Outside of this test this can never be the case. See alloc_super() in
> fs/super.c. So to stop the bleeding this needs something like:
> 
> static struct super_block *mbt_ext4_alloc_super_block(void)
> {
>         struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
>         struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>         struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
> 
>         if (fsb == NULL || sbi == NULL || es == NULL)
>                 goto out;
> 
>         sbi->s_es = es;
>         fsb->sb.s_fs_info = sbi;
> +       fsb.sb.s_user_ns = &init_user_ns;
>         return &fsb->sb;
> 
> out:
>         kfree(fsb);
>         kfree(sbi);
>         kfree(es);
>         return NULL;
> }
> 
Hi Christian,
Thanks for the information. I'm looking at this too and I also found
root cause is sb.s_user_ns is NULL. I'm considering to get a
super_block with VFS level api sget_fc to fix this to avoid similar
problem when new unit tests are added or new member is added to
super_block.
Would like to hear more from you. Thanks!


