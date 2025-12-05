Return-Path: <linux-fsdevel+bounces-70809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CECA7D47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 14:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E678C313A85D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A431A04E;
	Fri,  5 Dec 2025 10:04:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FF2F5A1E;
	Fri,  5 Dec 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929079; cv=none; b=reiN6KDjNIYQ07l1JOIHoNx9N4E0DqajnkYA2nnnQdWa9jJ4m6pGcZq4k3hYLLOzkKS7qkhzshgc/yAb19OI/I8XpwHIiqzUbqT4JyeXfA9ElUYVpE1rXKaGuTvSE2GGWmGa4SLicilgCc4ADsCkUI6rDpECAMo/FA0oSErUBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929079; c=relaxed/simple;
	bh=nuagCK51ZtnQPHTJYIZYgIFBKhZVBuxN7VePzApKX+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghg38J3z1GfPyTN6eiFGZTrOPxfMmRz/oyK8HWuy6ByMzKAWECx3r7EKe9KfvSVCXeSs6gFwb4Wy51TZcduuZAD7TbAV1pNNqcIlLk7oN2xc2X7IaStdrFVS0h/7n62G6Eowo+cIe/e36n1FXDNaKAxKNg5e+ahKIbEbf1msUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dN6RS6zsZzYQv1Y;
	Fri,  5 Dec 2025 18:04:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8086E1A0F86;
	Fri,  5 Dec 2025 18:04:27 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAH5k8qrjJpxiuzAg--.50456S2;
	Fri, 05 Dec 2025 18:04:27 +0800 (CST)
Message-ID: <bc10cdcb-840f-400e-85b8-3e8ae904f763@huaweicloud.com>
Date: Fri, 5 Dec 2025 18:04:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
To: Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
References: <20251205005841.3942668-1-avagin@google.com>
 <57a7d8c3-a911-4729-bc39-ba3a1d810990@huaweicloud.com>
 <CANaxB-x5qVv_yYR7aYYdrd26uFRk=Zsd243+TeBWMn47wi++eA@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CANaxB-x5qVv_yYR7aYYdrd26uFRk=Zsd243+TeBWMn47wi++eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAH5k8qrjJpxiuzAg--.50456S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8trykXrykCw43ZFy7Wrg_yoW5Cw4rpa
	9rJF15Kan7Ja1Yvan2q3y0qr1FkrZ3Ja15Jrn5K34Sy3s8Gr1SvF1SyFWrAF1DGr4xZ3Wj
	vrWY93y7ur4jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/5 14:39, Andrei Vagin wrote:
> On Thu, Dec 4, 2025 at 6:52 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>>
>>
>> On 2025/12/5 8:58, Andrei Vagin wrote:
>>> This patch series introduces a mechanism to mask hardware capabilities
>>> (AT_HWCAP) reported to user-space processes via the misc cgroup
>>> controller.
>>>
>>> To support C/R operations (snapshots, live migration) in heterogeneous
>>> clusters, we must ensure that processes utilize CPU features available
>>> on all potential target nodes. To solve this, we need to advertise a
>>> common feature set across the cluster. This patchset allows users to
>>> configure a mask for AT_HWCAP, AT_HWCAP2. This ensures that applications
>>> within a container only detect and use features guaranteed to be
>>> available on all potential target hosts.
>>>
>>
>> Could you elaborate on how this mask mechanism would be used in practice?
>>
>> Based on my understanding of the implementation, the parent’s mask is effectively a subset of the
>> child’s mask, meaning the parent does not impose any additional restrictions on its children. This
>> behavior appears to differ from typical cgroup controllers, where children are further constrained
>> by their parent’s settings. This raises the question: is the cgroup model an appropriate fit for
>> this functionality?
> 
> Chen,
> 
> Thank you for the question. I think I was not clear enough in the
> description.
> 
> The misc.mask file works by masking out available features; any feature
> bit set in the mask will not be advertised to processes within that
> cgroup. When a child cgroup is created, its effective mask is  a
> combination of its own mask and its parent's effective mask. This means
> any feature masked by either the parent or the child will be hidden from
> processes in the child cgroup.
> 
> For example:
> - If a parent cgroup masks out feature A (mask=0b001), processes in it
>   won't see feature A.
> - If we create a child cgroup under it and set its mask to hide feature
>   B (mask=0b010), the effective mask for processes in the child cgroup
>   becomes 0b011. They will see neither feature A nor B.
> 

Let me ask some basic questions:

When is the misc.mask typically set? Is it only configured before starting a container (e.g., before
docker run), or can it be adjusted dynamically while processes are already running?

I'm concerned about a potential scenario: If a child process initially has access to a CPU feature,
but then its parent cgroup masks that feature out, could the child process remain unaware of this
change?

Specifically, if a process has already cached or relied on a CPU capability before the mask was
applied, would it continue to assume it has that capability, leading to potential issues if it
attempts to use instructions that are now masked out?

Does such a scenario exist in practice?

> This ensures that a feature hidden by a parent cannot be re-enabled by a
> child. A child can only impose further restrictions by masking out
> additional features. I think this behaviour is well aligned with the cgroup
> model.
> 
> Thanks,
> Andrei

-- 
Best regards,
Ridong


