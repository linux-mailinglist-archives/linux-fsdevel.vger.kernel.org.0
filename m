Return-Path: <linux-fsdevel+bounces-15518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9161B88FE05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CFD1C26B2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3B7E76F;
	Thu, 28 Mar 2024 11:24:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C07E574;
	Thu, 28 Mar 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625095; cv=none; b=KwuMoV2fgvtuRSennm6okgK17DSH/SDJqjnKjZnLu5+mal8eUEe5Yd7MtlpeUI7M7oLR1XzJh1Z8j1sj22EaJFsHRLig24r1pwnvZlYniN+lCcLWiJOzRY7m+ruXOY9JBI65eJZOx1tEEuPI9DkzPmddbvQ4HwvARPyRAkIpNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625095; c=relaxed/simple;
	bh=IVWuMXHvJ24EzomPmVm//u7gaDNCPlrLrRC0bENfsmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaKL0UbU2k6VE8oi5JhvOLhrMznqM7YU5hY0h2FwSgYPJ2FL7iTy8v6vci8dFuYs4sikzEVx+IQDYh1M3TVdTjPzuf7QulxOEiTGkAZd/yMVBLkIheaeWkhkJeW8rYotPgwhsPrUznK3z8cB3nkCiUrcVSv2oQ9lDbmYhLXbBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V514V66wjz9xqx0;
	Thu, 28 Mar 2024 19:08:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 4A515140801;
	Thu, 28 Mar 2024 19:24:43 +0800 (CST)
Received: from [10.81.200.225] (unknown [10.81.200.225])
	by APP1 (Coremail) with SMTP id LxC2BwAXCxRwUwVmbnglBQ--.8766S2;
	Thu, 28 Mar 2024 12:24:42 +0100 (CET)
Message-ID: <4ad908dc-ddc5-492e-8ed4-d304156b5810@huaweicloud.com>
Date: Thu, 28 Mar 2024 13:24:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel crash in mknod
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Christian Brauner <christian@brauner.io>, Mimi Zohar <zohar@linux.ibm.com>,
 Paul Moore <paul@paul-moore.com>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
 <4a0b28ba-be57-4443-b91e-1a744a0feabf@huaweicloud.com>
 <20240328-raushalten-krass-cb040068bde9@brauner>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20240328-raushalten-krass-cb040068bde9@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwAXCxRwUwVmbnglBQ--.8766S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWrXrW7uryfJFykZFWDJwb_yoWrCr1kpF
	4rt3WDGws5JFW3Wr1IyF17ua1Sva4rWFW5AF4Fgw15ArnxKr1jqF1SvFyY9FW5Kr4xW34I
	qa17trsxWw4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5fjZQABs3

On 3/28/2024 12:08 PM, Christian Brauner wrote:
> On Thu, Mar 28, 2024 at 12:53:40PM +0200, Roberto Sassu wrote:
>> On 3/26/2024 12:40 PM, Christian Brauner wrote:
>>>> we can change the parameter of security_path_post_mknod() from
>>>> dentry to inode?
>>>
>>> If all current callers only operate on the inode then it seems the best
>>> to only pass the inode. If there's some reason someone later needs a
>>> dentry the hook can always be changed.
>>
>> Ok, so the crash is likely caused by:
>>
>> void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry
>> *dentry)
>> {
>>          if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>
>> I guess we can also simply check if there is an inode attached to the
>> dentry, to minimize the changes. I can do both.
>>
>> More technical question, do I need to do extra checks on the dentry before
>> calling security_path_post_mknod()?
> 
> Why do you need the dentry? The two users I see are ima in [1] and evm in [2].
> Both of them don't care about the dentry. They only care about the
> inode. So why is that hook not just:

Sure, I can definitely do that. Seems an easier fix to do an extra check 
in security_path_post_mknod(), rather than changing the parameter 
everywhere.

Next time, when we introduce new LSM hooks we can try to introduce more 
specific parameters.

Also, consider that the pre hook security_path_mknod() has the dentry as 
parameter. For symmetry, we could keep it in the post hook.

What I was also asking is if I can still call d_backing_inode() on the 
dentry without extra checks, and avoiding the IS_PRIVATE() check if the 
former returns NULL.

> diff --git a/security/security.c b/security/security.c
> index 7e118858b545..025689a7e912 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1799,11 +1799,11 @@ EXPORT_SYMBOL(security_path_mknod);
>    *
>    * Update inode security field after a file has been created.
>    */
> -void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
> +void security_inode_post_mknod(struct mnt_idmap *idmap, struct inode *inode)
>   {
> -       if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +       if (unlikely(IS_PRIVATE(inode)))
>                  return;
> -       call_void_hook(path_post_mknod, idmap, dentry);
> +       call_void_hook(path_post_mknod, idmap, inode);
>   }
> 
>   /**
> 
> And one another thing I'd like to point out is that the security hook is
> called "security_path_post_mknod()" while the evm and ima hooks are
> called evm_post_path_mknod() and ima_post_path_mknod() respectively. In
> other words:
> 
> git grep _path_post_mknod() doesn't show the implementers of that hook
> which is rather unfortunate. It would be better if the pattern were:
> 
> <specific LSM>_$some_$ordered_$words()

I know, yes. Didn't want to change just yet since people familiar with 
the IMA code know the current function name. I don't see any problem to 
rename the functions.

Thanks

Roberto

> [1]:
> static void evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
> {
>          struct inode *inode = d_backing_inode(dentry);
>          struct evm_iint_cache *iint = evm_iint_inode(inode);
> 
>          if (!S_ISREG(inode->i_mode))
>                  return;
> 
>          if (iint)
>                  iint->flags |= EVM_NEW_FILE;
> }
> 
> [2]:
> static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
> {
>          struct ima_iint_cache *iint;
>          struct inode *inode = dentry->d_inode;
>          int must_appraise;
> 
>          if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>                  return;
> 
>          must_appraise = ima_must_appraise(idmap, inode, MAY_ACCESS,
>                                            FILE_CHECK);
>          if (!must_appraise)
>                  return;
> 
>          /* Nothing to do if we can't allocate memory */
>          iint = ima_inode_get(inode);
>          if (!iint)
>                  return;
> 
>          /* needed for re-opening empty files */
>          iint->flags |= IMA_NEW_FILE;
> }
> 
> 
> 
>>
>> Thanks
>>
>> Roberto
>>
>>> For bigger changes it's also worthwhile if the object that's passed down
>>> into the hook-based LSM layer is as specific as possible. If someone
>>> does a change that affects lifetime rules of mounts then any hook that
>>> takes a struct path argument that's unused means going through each LSM
>>> that implements the hook only to find out it's not actually used.
>>> Similar for dentry vs inode imho.
>>


