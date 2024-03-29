Return-Path: <linux-fsdevel+bounces-15693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255118920C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 16:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91371F26205
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C32D052;
	Fri, 29 Mar 2024 15:45:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B821C0DD0;
	Fri, 29 Mar 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727148; cv=none; b=PKyxCYDUI/eRKEmbGDZ70ASq7qEvxdAP1D5HGvf5vJKcW2YHnPXTWkTCFBETK+6S+GUT6guWCZL7TZlhujH0yf2f7HhEYsdCEut6IQsTjaEX/l0faB67LwmcLfIwxTwaKmq6vhdtSfuW0uGBCjaRm7xwTH+FuWX/SGzpyEA5vwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727148; c=relaxed/simple;
	bh=LqWjA+/6Exik0OsXA9dAI7OvBuQWFxpxADnnIBMeYmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHNzmPWUKhIFM0fNyZ9n3/u191qmtgBs4GsC3x9hEDtELGrj+Ps+6jEFNsqKsoQbtpu8TcLq+EeRqNbvfuk6rADGaCP4AKBsxqS5ZT994w4YeCDMtsGnoP7+D7QAVkLQMGU6x7wEqSopCR7WoHCCG7YiaWjx4FExENoCW0F7rPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4V5kk16DXzz9v7JY;
	Fri, 29 Mar 2024 23:25:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 445091402A5;
	Fri, 29 Mar 2024 23:45:28 +0800 (CST)
Received: from [10.48.128.185] (unknown [10.48.128.185])
	by APP2 (Coremail) with SMTP id GxC2BwAH8yYM4gZmgxYuBQ--.12307S2;
	Fri, 29 Mar 2024 16:45:27 +0100 (CET)
Message-ID: <0cce46c1-3a78-435c-b60e-04c1d790529b@huaweicloud.com>
Date: Fri, 29 Mar 2024 16:45:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ima: evm: Rename *_post_path_mknod() to
 *_path_post_mknod()
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com,
 christian@brauner.io, Roberto Sassu <roberto.sassu@huawei.com>,
 stable@vger.kernel.org
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
 <20240329105609.1566309-2-roberto.sassu@huaweicloud.com>
 <e9181ec0bc07a23fc694d47b4ed49635d1039d89.camel@linux.ibm.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <e9181ec0bc07a23fc694d47b4ed49635d1039d89.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAH8yYM4gZmgxYuBQ--.12307S2
X-Coremail-Antispam: 1UD129KBjvJXoWruF45GF4kCFyDtw1rKFWrGrg_yoW8JrW7pF
	W8t3Z8Crn5tr1xAFnavFW3AFW8AayUXF4YqFn5try5Z34aganY9rWI9a4FgasxKr429a4a
	yF1SqrnIv3yUArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eHDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj5vwDwABsA

On 3/29/2024 4:16 PM, Mimi Zohar wrote:
> On Fri, 2024-03-29 at 11:56 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Rename ima_post_path_mknod() and evm_post_path_mknod() respectively to
>> ima_path_post_mknod() and evm_path_post_mknod(), to facilitate finding
>> users of the path_post_mknod LSM hook.
>>
>> Cc: stable@vger.kernel.org # 6.8.x
> 
> Since commit cd3cec0a02c7 ("ima: Move to LSM infrastructure") was upstreamed in
> this open window.  This change does not need to be packported and should be
> limited to IMA and EVM full fledge LSMs.

Yes, got it wrong.

>> Reported-by: Christian Brauner <christian@brauner.io>
>> Closes:
>> https://lore.kernel.org/linux-kernel/20240328-raushalten-krass-cb040068bde9@brauner/
>> Fixes: 05d1a717ec04 ("ima: add support for creating files using the mknodat
>> syscall")
> 
> "Fixes: 05d1a717ec04" should be removed.

Ok, I agree that it is not a necessary fix for stable kernels. We can 
reconsider it if there is a bug fix depending on it.

Thanks

Roberto

>> Fixes: cd3cec0a02c7 ("ima: Move to LSM infrastructure")
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> 


