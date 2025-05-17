Return-Path: <linux-fsdevel+bounces-49315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D1BABA6F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 02:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CEE173F92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 00:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB166AA7;
	Sat, 17 May 2025 00:09:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C74208D0;
	Sat, 17 May 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440564; cv=none; b=AQIkjCJ2irQQqyY94sxAoFBtbRIm353vpfYOIR95PXwffRC7zPMZf4Z2VSUlni3d8Nakk8QKG05Z0BGUEcYA8iQ4rVktZ0SjrFfwSADYI/AAvMF5erzTKeFVExZBqf7WQ4y3pQ3uw6HzGYkCNuPAl4/FwvVJh0+U82KpYNLXiOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440564; c=relaxed/simple;
	bh=NMkGPhvMdLtnOgTXfdv7adUetVbKscL6KMSwnb6oMC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBpBj5TRSS1rgm3843WoIkpSON7jv/eG7eladaHFh4tt4jgBZgrvZiRdNXrNEp2Em1TRwNn5tNbc7a/BwuRs6mR15u7kBc2B4W5VNwAmGcsPXcOnZbSCjVH1wU+ILcWuS3CynhQftzm/vdm3LliAwL/XRjElq8gZfPZWE1EEc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zzknj5Lf4z4f3jq5;
	Sat, 17 May 2025 08:08:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 69AC41A0359;
	Sat, 17 May 2025 08:09:17 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+r0ydogwmIMg--.12035S3;
	Sat, 17 May 2025 08:09:17 +0800 (CST)
Message-ID: <d08e698b-f217-4065-9e7c-47f647ffeea3@huaweicloud.com>
Date: Sat, 17 May 2025 08:09:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Rename the parameter of mnt_get_write_access()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com
References: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
 <vtfnncganindq4q7t4icfaujkgejlbd7repvurpjx6nwf6i7zp@hr44m22ij4qf>
 <b3d6db6f-61d8-498a-b90c-0716a64f7528@huaweicloud.com>
 <20250516235739.GV2023217@ZenIV>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20250516235739.GV2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1+r0ydogwmIMg--.12035S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4fZF1kXry5tr15tFyfXrb_yoW8Wr4UpF
	W5uFy8Kwn7J34fCFy2ya1xAryYkr4fWr1aqw15Kr1j9r909ryfKa1FqFsa9F18JrZrAF12
	93W3tr9xWr4Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/5/17 7:57, Al Viro 写道:
> On Sat, May 17, 2025 at 07:54:55AM +0800, Zizhi Wo wrote:
>>
>>
>> 在 2025/5/16 18:31, Jan Kara 写道:
>>> On Fri 16-05-25 11:21:47, Zizhi Wo wrote:
>>>> From: Zizhi Wo <wozizhi@huawei.com>
>>>>
>>>> Rename the parameter in mnt_get_write_access() from "m" to "mnt" for
>>>> consistency between declaration and implementation.
>>>>
>>>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>>>
>>> I'm sorry but this is just a pointless churn. I agree the declaration and
>>> implementation should better be consistent (although in this particular
>>> case it isn't too worrying) but it's much easier (and with much lower
>>> chance to cause conflicts) to just fixup the declaration.
>>>
>>> 								Honza
>>
>> Yes, I had considered simply fixing the declaration earlier. However, in
>> the include/linux/mount.h file, similar functions like
>> "mnt_put_write_access" use "mnt" as the parameter name rather than "m",
>> just like "mnt_get_write_access". So I chose to modify the function
>> implementation directly, although this resulted in a larger amount of
>> changes. So as you can see, for simplicity, I will directly update the
>> parameter name in the function declaration in the second version.
> 
> FWIW, "mnt for vfsmount, m for mount" is an informal convention in that
> area, so I'd say go for it if there had been any change in the function
> in question.  Same as with coding style, really...

Thanks for the additional information. Based on informal conventions, it
seems that this is the only way to modify it... ?

Thanks,
Zizhi Wo


