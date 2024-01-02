Return-Path: <linux-fsdevel+bounces-7086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50D821B80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7E71F227AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAD5F9F7;
	Tue,  2 Jan 2024 12:15:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF1EEC6;
	Tue,  2 Jan 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4T49v03yQfz9yKXF;
	Tue,  2 Jan 2024 19:42:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2BF741407FC;
	Tue,  2 Jan 2024 19:56:44 +0800 (CST)
Received: from [10.48.129.192] (unknown [10.48.129.192])
	by APP2 (Coremail) with SMTP id GxC2BwBnGGLs+ZNlT9WtAw--.57596S2;
	Tue, 02 Jan 2024 12:56:43 +0100 (CET)
Message-ID: <42911719-547d-443a-b2f2-07b0cfb11f7a@huaweicloud.com>
Date: Tue, 2 Jan 2024 12:56:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 21/24] evm: Move to LSM infrastructure
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
 <20231214170834.3324559-22-roberto.sassu@huaweicloud.com>
 <b03e68e9fa1803d6b2cc7a2c0260f78a05a4d88e.camel@linux.ibm.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <b03e68e9fa1803d6b2cc7a2c0260f78a05a4d88e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBnGGLs+ZNlT9WtAw--.57596S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr15Kr1DtrW5Zr1DXryftFb_yoW5JrW3pr
	sxG3Wjkw4DZFW7Kry8tF48X39Y9FWfGrW7Xw4vgrs2vFnrAr18try8Cay7ZFy5Cr4vkFnY
	qFW7Arn5urn8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj5giOwABs+

On 12/26/2023 11:13 PM, Mimi Zohar wrote:
> On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> As for IMA, move hardcoded EVM function calls from various places in the
>> kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
>> (last and always enabled like 'ima'). The order in the Makefile ensures
>> that 'evm' hooks are executed after 'ima' ones.
>>
>> Make EVM functions as static (except for evm_inode_init_security(), which
>> is exported), and register them as hook implementations in init_evm_lsm().
>>
>> Unlike before (see commit to move IMA to the LSM infrastructure),
>> evm_inode_post_setattr(), evm_inode_post_set_acl(),
>> evm_inode_post_remove_acl(), and evm_inode_post_removexattr() are not
>> executed for private inodes.
>>
> 
> Missing is a comment on moving the inline function definitions -
> evm_inode_remove_acl(), evm_inode_post_remove_acl(), and
> evm_inode_post_set_acl() - to evm_main.c.

Ok.

>> Finally, add the LSM_ID_EVM case in lsm_list_modules_test.c
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
> 
> [...]
>> @@ -2307,9 +2299,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>>   
>>   	if (ret == 1)
>>   		ret = cap_inode_setxattr(dentry, name, value, size, flags);
>> -	if (ret)
>> -		return ret;
>> -	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
>> +	return ret;
>>   }
> 
> Even though capability will be called after EVM, it doesn't make a
> difference in this instance.
> 
> [...]
> 
>>   /**
>> @@ -2493,9 +2472,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>>   	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
>>   	if (ret == 1)
>>   		ret = cap_inode_removexattr(idmap, dentry, name);
>> -	if (ret)
>> -		return ret;
>> -	return evm_inode_removexattr(idmap, dentry, name);
>> +	return ret;
>>   }
> 
> 'security.capability' is one of the EVM protected xattrs.  As
> capability isn't an LSM, it will now be called after EVM, which is a
> problem.

Uhm, according to this comment in security_inode_removexattr() and 
security_inode_setxattr():

	/*
	 * SELinux and Smack integrate the cap call,
	 * so assume that all LSMs supplying this call do so.
	 */

We can add the call to IMA and EVM as well, to be compliant.

However, I'm missing why the two cases are different. It seems 
cap_inode_set/removexattr() are doing just checks.

Thanks

Roberto


