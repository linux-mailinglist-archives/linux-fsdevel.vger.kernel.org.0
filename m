Return-Path: <linux-fsdevel+bounces-70996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D82CAE988
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 02:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8FD6300FEB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 01:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3527703A;
	Tue,  9 Dec 2025 01:14:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D916271468;
	Tue,  9 Dec 2025 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242878; cv=none; b=vCoQrkPybhaSr1tU0OhjuwOUv+Vh+gMetr9u9+8UjOyeJ/O/i/xD49gXp95BVoqX3Bt6zl0Bg40FUtgCmIOhSeaGmKqzZqEwWuw97WVTXY1gzBvzyJWrB7rnLgY2QJACB5D27J1K96w75Egec3uE4+qqhG8QWyy9y8IUp84nDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242878; c=relaxed/simple;
	bh=aX8V7idETexZpGgf8tvxn2ukSJ5VSRQBjo5sL5Fn5zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7MKgSytM93XkQzYKQ4IBmpyWJXbX23MAwFeKRRjCnkZGH064VUHOc5m/erpEgOWwitithOP0tnyXO6pFQiFWxwalx9Tgf5eC0cpRFIuEYtqnAzCY0PMP2hvOxWsJE65D6nl9Sm0CVqK5OkqpdiPJf6QDP9Xh89hRzpz6IMjn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dQL7l4z2xzYQtgf;
	Tue,  9 Dec 2025 08:58:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4E8FF1A175C;
	Tue,  9 Dec 2025 08:58:40 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBHJlA+dDdpiONbBA--.18208S2;
	Tue, 09 Dec 2025 08:58:40 +0800 (CST)
Message-ID: <075ad534-9a76-4067-97a1-a3219fa4c60e@huaweicloud.com>
Date: Tue, 9 Dec 2025 08:58:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
References: <20251205005841.3942668-1-avagin@google.com>
 <57a7d8c3-a911-4729-bc39-ba3a1d810990@huaweicloud.com>
 <CANaxB-x5qVv_yYR7aYYdrd26uFRk=Zsd243+TeBWMn47wi++eA@mail.gmail.com>
 <bc10cdcb-840f-400e-85b8-3e8ae904f763@huaweicloud.com>
 <CANaxB-yOfS1KPZaZJ_4WG8XeZnB9M_shtWOOONTXQ2CW4mqsSA@mail.gmail.com>
 <6dmgfe5vbbuqw7ycsm4l2ecpv4eppdsau4t22kitjcjglg2gna@dyjlwhfhviif>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <6dmgfe5vbbuqw7ycsm4l2ecpv4eppdsau4t22kitjcjglg2gna@dyjlwhfhviif>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHJlA+dDdpiONbBA--.18208S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4rAr1fJr4DAr1fGrykZrb_yoW8GF1xpF
	WkC3W7Gw4kJ347ZaykZ392qF4FvFW8AFy7Jr15K3s3AFW7u3W8Ar4ftrW5WFsxXr9xC3W2
	vw1YvrWfuan0vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/9 0:48, Michal Koutný wrote:
> Hello Andrei.
> 
> On Fri, Dec 05, 2025 at 12:19:04PM -0800, Andrei Vagin <avagin@gmail.com> wrote:
>> If we are talking about C/R use cases, it should be configured when
>> container is started. It can be adjusted dynamically, but all changes
>> will affect only new processes. The auxiliary vectors are set on execve.
> 
> The questions by Ridong are getting at the reasons why cgroup API
> doesn't sound like a good match for these values.

Eh, The statement "it can be adjusted dynamically, but all changes will affect only new processes"
means that processes created within the same cgroup could end up with different capabilities. This
does not sound like how cgroups typically operate;

> I understand it's tempting to implement this by simply copying some
> masks from the enclosing cgroup but since there's little to be done upon
> (dynamic) change or a process migration it's overkill.
> 
> So I'd look at how other [1] adjustments between fork-exec are done and
> fit it with them. I guess prctl would be an option as a substitute for
> non-existent setauxval().
> 
> Thanks,
> Michal
> 
> [1] Yes, I admit cgroup migration is among them too. Another one is
> setns(2) which is IMO a closer concept for this modified view of HW, I'm
> not sure whether hardware namespaces had been brought up (and rejected)
> in the past.
> 

-- 
Best regards,
Ridong


