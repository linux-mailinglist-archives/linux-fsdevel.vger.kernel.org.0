Return-Path: <linux-fsdevel+bounces-49661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9993AC0679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582324A69EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4B261398;
	Thu, 22 May 2025 08:02:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544A25E476;
	Thu, 22 May 2025 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900968; cv=none; b=I0++evu3pwfh6lJADnMdzhKCNA5C4/j9hz++jc5XAfyNjTmuNvcQpxSjEKQIthzBdrJml4rADRdG0fs97WBQmGnJ6dYcAfjP/IAKqav6NmqtG3wWFHyRs2U6BPAf2gghA9SD9inpWbGAFiUJd0E22LnEf6mzlKLFGdMlQYLXACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900968; c=relaxed/simple;
	bh=oA0vm5pDkCgw+4gBq+C//APdjwOF+bXuymjsHbQI/Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCiTj1KsT5KAv5GQ8r5rppHd2weYbaz3dIDUx6NdZWbH2bNE+7Xkdy83wWlcrO4AambKw8cZRxnP+W+AtkpUoslKGxjMy0Hcaz14l3id+XR6Vz3Bz1SwSsOfMe2U1678zlXCeuthsjLdsL7qlkXTL+ED3NM6M1KqggHmpLFvo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b313W4FN8z4f3lCf;
	Thu, 22 May 2025 16:02:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2AF2A1A17CB;
	Thu, 22 May 2025 16:02:42 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP1 (Coremail) with SMTP id cCh0CgCH7Hwg2i5o5m3JMw--.13902S3;
	Thu, 22 May 2025 16:02:42 +0800 (CST)
Message-ID: <8822d84d-eedc-4b3b-a6c0-4ccef4c0cecc@huaweicloud.com>
Date: Thu, 22 May 2025 16:02:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Rename the parameter of mnt_get_write_access()
To: Amir Goldstein <amir73il@gmail.com>, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com
References: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
 <f6a9c6ef-1fd8-41d2-8f6a-396b6b191f97@huaweicloud.com>
 <CAOQ4uxiT=v9JKS39ii-em0XFNkWyskW_Ed3kxS5PE5Q2Rs+NMQ@mail.gmail.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <CAOQ4uxiT=v9JKS39ii-em0XFNkWyskW_Ed3kxS5PE5Q2Rs+NMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCH7Hwg2i5o5m3JMw--.13902S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4DKrykJF1fAryxGrWkXrb_yoW8Cw1rpF
	WFk3ZYkw4rJa1fAr1Iva12qFyYyryrXrW7JF15Gw1rAr98CryfKw10gF4Ygr18Wrs7uw4I
	vF42qryDC3Z8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/5/22 15:41, Amir Goldstein 写道:
> On Thu, May 22, 2025 at 3:02 AM Zizhi Wo <wozizhi@huaweicloud.com> wrote:
>>
>> Hello!
>>
>> There are currently two possible approaches to this patch.
>> The first is to directly change the declaration, which would be
>> straightforward and involve minimal modifications.
>>
>> However, per Al Viro's suggestion — that "mnt for vfsmount, m for mount"
>> is an informal convention. This is in line with what the current
>> patch does, although I understand Jan Kara might feel that the scope of
>> the changes is a bit large.
>>
>> I would appreciate any suggestions or guidance on how to proceed. So
>> friendly ping...
> 
> Hi Zizhi,
> 
> I guess you are not familiar with kernel lingo so I will translate:
> "...so I'd say go for it if there had been any change in the function
> in question.  Same as with coding style, really...
> 
> It means that your change is correct, but maintainers are
> not interested in taking "style only" changes because it
> creates undesired git history noise called "churn".

Thank you for your patient explanation! I'm indeed a newcomer to the
Linux kernel. Now I understand what everyone means.

> 
> Should anyone be going to make logic changes in
> mnt_get_write_access() in the future, the style change
> can be applied along in the same patch.
> 
> One observation I have is -
> If this was the only case that deviates from the standard
> the change might have been justified.
>>From a quick grep, I see that the reality in the code is very far
> from this standard.

Yes, I noticed that as well. However, for consistency with the later use
of mnt_put_write_access(), I chose to go with the modification in this
patch...

Thanks,
Zizhi Wo

> 
> FWIW, wholeheartedly I agree that the ambiguity of the type of
> an 'mnt' arg is annoying, but IMO 'm' is not making that very clear.
> To me, 'mount' arg is very clear when it appears in the code

> 
> Thanks,
> Amir.
> 


