Return-Path: <linux-fsdevel+bounces-13239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7886D9FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB138286CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B406241A88;
	Fri,  1 Mar 2024 03:20:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC8405CB;
	Fri,  1 Mar 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263209; cv=none; b=A3yThXoWDWZWxiIv7mAliuRwqQ5E7Yo6560GnpvYuhBBunGRIBQ7y2GL2UkXNzZZ3Ns6WovtCnonBoLmHyLAY+DX/o4l/UB4vl8DhYUGogiiPMzPnFQ57H+sOp4UjDGogGabC6jfcVU9F+YyLNYnJUZWnWs/MScJoh+UCOgJlTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263209; c=relaxed/simple;
	bh=Dz0XRmkbchTi9//0KHWboxe68ipFLFpvysUBofhP67c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nJrm4emEuvkiL/tqcuu9r4dBXC6XEtGk4cra8Ppr08DLLL4o1v5j3HZ5JF2kGa3XXBJgzQIwR3QZn/fPBAtz1oGZolX/FNGS6FEq4YHMrkWNNgTD7kMCW1EDY9Fbe7nYOrpyb695GgNH+DfCci1gmVBzHo7L7gkHEoFS5uWsesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmCy33gwNz4f3m7B;
	Fri,  1 Mar 2024 11:19:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DCB351A0B4F;
	Fri,  1 Mar 2024 11:20:02 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgBHmGpeSeFl6DqnFg--.7387S2;
	Fri, 01 Mar 2024 11:20:00 +0800 (CST)
Subject: Re: ext4_mballoc_test: Internal error: Oops: map_id_range_down
 (kernel/user_namespace.c:318)
To: Guenter Roeck <linux@roeck-us.net>, =?UTF-8?Q?Daniel_D=c3=adaz?=
 <daniel.diaz@linaro.org>, Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 lkft-triage@lists.linaro.org, Jan Kara <jack@suse.cz>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>,
 Christian Brauner <brauner@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <CA+G9fYvnjDcmVBPwbPwhFDMewPiFj6z69iiPJrjjCP4Z7Q4AbQ@mail.gmail.com>
 <CAEUSe79PhGgg4-3ucMAzSE4fgXqgynAY_t8Xp+yiuZsw4Aj1jg@mail.gmail.com>
 <7e1c18e3-7523-4fe6-affe-d3f143ad79e3@roeck-us.net>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <be57cb0f-faaf-ba19-ea8e-8c1ed341d2d3@huaweicloud.com>
Date: Fri, 1 Mar 2024 11:19:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7e1c18e3-7523-4fe6-affe-d3f143ad79e3@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHmGpeSeFl6DqnFg--.7387S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyDAF1fKr17XF18CFW8tFb_yoWDCFg_uF
	W3uw1DWr1kJF409anxAFnIkFsxGFZ8XF1rX348J3y3uw1rJryrArn3Cr93Was7uFWxXrsI
	kr1q93Z2qw4UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/29/2024 3:33 AM, Guenter Roeck wrote:
> On 2/28/24 11:26, Daniel Díaz wrote:
>> Hello!
>>
>> On Wed, 28 Feb 2024 at 12:19, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>> Kunit ext4_mballoc_test tests found following kernel oops on Linux next.
>>> All ways reproducible on all the architectures and steps to reproduce shared
>>> in the bottom of this email.
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
> 
> [ ... ]
> 
>> +Guenter. Just the thing we were talking about, at about the same time.
>>
> 
> Good that others see the same problem. Thanks a lot for reporting!
> 
> Guenter
> 
Hi everyone, thanks for the report. I try to fix the reported issues with [1]
which works fine in my vm. Of course, it needs more interview before being
applied. Please let me if it works fine in case anyone have interest to test
it in advance.
Thanks!

Kemeng

[1] https://lore.kernel.org/linux-ext4/20240301120816.22581-1-shikemeng@huaweicloud.com/T/#mfbfb65f0a2b9092eea5d4fea7166c46aaa878215


