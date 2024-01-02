Return-Path: <linux-fsdevel+bounces-7083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2AC821A8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0FB1C215D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D926DDDD;
	Tue,  2 Jan 2024 10:54:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFFD507;
	Tue,  2 Jan 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4T48R00yTDz9xGZH;
	Tue,  2 Jan 2024 18:36:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 689EF140D05;
	Tue,  2 Jan 2024 18:54:11 +0800 (CST)
Received: from [10.48.129.192] (unknown [10.48.129.192])
	by APP2 (Coremail) with SMTP id GxC2BwAnIlxD65NlVSetAw--.48730S2;
	Tue, 02 Jan 2024 11:54:10 +0100 (CET)
Message-ID: <997cfb2f-a493-4f02-9e75-6ebb525c8406@huaweicloud.com>
Date: Tue, 2 Jan 2024 11:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 23/24] ima: Make it independent from 'integrity' LSM
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
 <20231214170834.3324559-24-roberto.sassu@huaweicloud.com>
 <5aa5986266c3a3f834114a835378455cbbff7b64.camel@linux.ibm.com>
 <ff8e6341-1ff0-4163-b5c7-236a0e8bdc7c@huaweicloud.com>
 <96f82924cd2fda95f0c89341215e128419bf77fd.camel@linux.ibm.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <96f82924cd2fda95f0c89341215e128419bf77fd.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAnIlxD65NlVSetAw--.48730S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1xAF47CF1rZFWkGF4xXrb_yoW5AFWrpF
	Z7Ka4UGr1DZry2kw4vya9xZrWfK395WFW7urn0kr1kAr1vvrn0qF40kr1UuFy5Gr1Ut3WI
	qF4UG3sxZ3Wqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj5QiDQABsH

On 12/27/2023 8:21 PM, Mimi Zohar wrote:
> On Wed, 2023-12-27 at 17:39 +0100, Roberto Sassu wrote:
>> On 12/27/2023 2:22 PM, Mimi Zohar wrote:
>>> On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>
>>>> Make the 'ima' LSM independent from the 'integrity' LSM by introducing IMA
>>>> own integrity metadata (ima_iint_cache structure, with IMA-specific fields
>>>> from the integrity_iint_cache structure), and by managing it directly from
>>>> the 'ima' LSM.
>>>>
>>>> Move the remaining IMA-specific flags to security/integrity/ima/ima.h,
>>>> since they are now unnecessary in the common integrity layer.
>>>>
>>>> Replace integrity_iint_cache with ima_iint_cache in various places
>>>> of the IMA code.
>>>>
>>>> Then, reserve space in the security blob for the entire ima_iint_cache
>>>> structure, so that it is available for all inodes having the security blob
>>>> allocated (those for which security_inode_alloc() was called).  Adjust the
>>>> IMA code accordingly, call ima_iint_inode() to retrieve the ima_iint_cache
>>>> structure. Keep the non-NULL checks since there can be inodes without
>>>> security blob.
>>>
>>> Previously the 'iint' memory was only allocated for regular files in
>>> policy and were tagged S_IMA.  This patch totally changes when and how
>>> memory is being allocated.  Does it make sense to allocate memory at
>>> security_inode_alloc()?  Is this change really necessary for making IMA
>>> a full fledged LSM?
>>
>> Good question. I think it wouldn't be necessary, we can reuse the same
>> approach as in the patch 'integrity: Switch from rbtree to LSM-managed
>> blob for integrity_iint_cache'.
> 
> Going forward with the v8 proposed solution would require some real
> memory usage analysis for different types of policies.
> 
> To me the "integrity: Switch from rbtree to LSM-managed blob for
> integrity_iint_cache" makes a lot more sense.   Looking back at the
> original thread, your reasons back then for not directly allocating the
> integrity_iint_cache are still valid for the ima_iint_cache structure.

Uhm, ok. It should not be too difficult to restore the old mechanism for 
ima_iint_cache. Will do it in v9.

Thanks

Roberto

> Mimi
> 
>>>
>>>>
>>>> Don't include the inode pointer as field in the ima_iint_cache structure,
>>>> since the association with the inode is clear. Since the inode field is
>>>> missing in ima_iint_cache, pass the extra inode parameter to
>>>> ima_get_verity_digest().
>>>>
>>>> Finally, register ima_inode_alloc_security/ima_inode_free_security() to
>>>> initialize/deinitialize the new ima_iint_cache structure (before this task
>>>> was done by iint_init_always() and iint_free()). Also, duplicate
>>>> iint_lockdep_annotate() for the ima_iint_cache structure, and name it
>>>> ima_iint_lockdep_annotate().
>>>>
>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>
> 


