Return-Path: <linux-fsdevel+bounces-5677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAFF80EC3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 13:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAB41F2155B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AE35FF0E;
	Tue, 12 Dec 2023 12:41:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9295;
	Tue, 12 Dec 2023 04:41:43 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SqHqB6dJRz9xrpF;
	Tue, 12 Dec 2023 20:24:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1AF9C1404DB;
	Tue, 12 Dec 2023 20:41:34 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHN2H0VHhlfMxgAg--.37324S2;
	Tue, 12 Dec 2023 13:41:33 +0100 (CET)
Message-ID: <b9ce0bad-4e7d-44e2-bdd4-6ebf1b6b196f@huaweicloud.com>
Date: Tue, 12 Dec 2023 13:41:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Seth Forshee
 <sforshee@kernel.org>, miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, zohar@linux.ibm.com, paul@paul-moore.com,
 stefanb@linux.ibm.com, jlayton@kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
 <CAOQ4uxgvKb520_Nbp+Y7KDq3_7t1tx65w5pOP8y6or1prESv+Q@mail.gmail.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAOQ4uxgvKb520_Nbp+Y7KDq3_7t1tx65w5pOP8y6or1prESv+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCHN2H0VHhlfMxgAg--.37324S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1rJFW5Xw43CryftryxKrg_yoWrAryDpF
	WYka4UKrs8tr17AwnFya17XFWjy3yrJ3WUXw1Dtr4kZFyDtF1Sgry7Ka4UuF9rWr1xG34j
	vFWjk347ur9xZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj5ONawAAsL

On 11.12.23 19:31, Amir Goldstein wrote:
> On Mon, Dec 11, 2023 at 4:56 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>>
>> On Fri, 2023-12-08 at 23:01 +0100, Christian Brauner wrote:
>>> On Fri, Dec 08, 2023 at 11:55:19PM +0200, Amir Goldstein wrote:
>>>> On Fri, Dec 8, 2023 at 7:25 PM Roberto Sassu
>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>>
>>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>
>>>>> EVM updates the HMAC in security.evm whenever there is a setxattr or
>>>>> removexattr operation on one of its protected xattrs (e.g. security.ima).
>>>>>
>>>>> Unfortunately, since overlayfs redirects those xattrs operations on the
>>>>> lower filesystem, the EVM HMAC cannot be calculated reliably, since lower
>>>>> inode attributes on which the HMAC is calculated are different from upper
>>>>> inode attributes (for example i_generation and s_uuid).
>>>>>
>>>>> Although maybe it is possible to align such attributes between the lower
>>>>> and the upper inode, another idea is to map security.evm to another name
>>>>> (security.evm_overlayfs)
>>>>
>>>> If we were to accept this solution, this will need to be trusted.overlay.evm
>>>> to properly support private overlay xattr escaping.
>>>>
>>>>> during an xattr operation, so that it does not
>>>>> collide with security.evm set by the lower filesystem.
>>>>
>>>> You are using wrong terminology and it is very confusing to me.
>>>
>>> Same.
>>
>> Argh, sorry...
>>
>>>> see the overlay mount command has lowerdir= and upperdir=.
>>>> Seems that you are using lower filesystem to refer to the upper fs
>>>> and upper filesystem to refer to overlayfs.
>>>>
>>>>>
>>>>> Whenever overlayfs wants to set security.evm, it is actually setting
>>>>> security.evm_overlayfs calculated with the upper inode attributes. The
>>>>> lower filesystem continues to update security.evm.
>>>>>
>>>>
>>>> I understand why that works, but I am having a hard time swallowing
>>>> the solution, mainly because I feel that there are other issues on the
>>>> intersection of overlayfs and IMA and I don't feel confident that this
>>>> addresses them all.
>>
>> This solution is specifically for the collisions on HMACs, nothing
>> else. Does not interfere/solve any other problem.
>>
>>>> If you want to try to convince me, please try to write a complete
>>>> model of how IMA/EVM works with overlayfs, using the section
>>>> "Permission model" in Documentation/filesystems/overlayfs.rst
>>>> as a reference.
>>
>> Ok, I will try.
>>
>> I explain first how EVM works in general, and then why EVM does not
>> work with overlayfs.
>>
> 
> I understand both of those things.
> 
> What I don't understand is WHY EVM needs to work on overlayfs?
> What is the use case?
> What is the threat model?
> 
> The purpose of IMA/EVM as far as I understand it is to detect and
> protect against tampering with data/metadata offline. Right?
> 
> As Seth correctly wrote, overlayfs is just the composition of existing
> underlying layers.
> 
> Noone can tamper with overlayfs without tampering with the underlying
> layers.

Makes sense.

> The correct solution to your problem, and I have tried to say this many
> times, in to completely opt-out of IMA/EVM for overlayfs.
> 
> EVM should not store those versions of HMAC for overlayfs and for
> the underlying layers, it should ONLY store a single version for the
> underlying layer.

If we avoid the checks in IMA and EVM for overlayfs, we need the 
guarantee that everything passes through overlayfs down, and that there 
is no external interference to the lower and upper filesystems (the part 
that is used by overlayfs).

Maybe I'm missing something, I looked at this issue only now, and Mimi 
knows it much better than me.

Roberto

> Because write() in overlayfs always follows by write() to upper layer
> and setxattr() in overlayfs always follows by setxattr() to upper layer
> IMO write() and setxattr() on overlayfs should by ignored by IMA/EVM
> and only write()/setxattr() on underlying fs should be acted by IMA/EVM
> which AFAIK, happens anyway.
> 
> Please let me know if I am missing something,
> 
> Thanks,
> Amir.


