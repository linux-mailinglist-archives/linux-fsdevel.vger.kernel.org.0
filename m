Return-Path: <linux-fsdevel+bounces-70750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175BCA5EF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 03:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C452030AD325
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 02:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74B2D8777;
	Fri,  5 Dec 2025 02:52:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B322FDE6;
	Fri,  5 Dec 2025 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903156; cv=none; b=n3FhgQSwXABHAesgWxB5gRIPxy5xjo+MuRgGWtrx8FFsT2qC6TMA5daRLNHEXBYmsPcmFToAcTI70KrbTetlS8uNIRxoCus3ZasJxImMdDGI2TXRAgQF1Aq79NqN6Axsi5tta8ZwLVZ+6yjjJDGHTFVzVBCbZTAs7jmYfRER47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903156; c=relaxed/simple;
	bh=yE+1RpK4slMnBZPiOZ/cW1iGpGYP6WqNKFJIBK8MGaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H34mcjzHzpFU08wBGTrOq1NbPlAVxwVVz0+bfisX04RVhMCOWlVNruxxQJqYuR4ZW28wKfutmc/Q4SQAWsKZKuX8Z9nfZeJQYb/TnIYz+VK+sHDZDC9TFw4GxmRRr9TDOPwLT6oW1w8gA7WL/K4Gyou4RRxpbyjp7YPw6Lv2mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dMwrB5ZP5zKHMLq;
	Fri,  5 Dec 2025 10:51:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8F01C1A07C0;
	Fri,  5 Dec 2025 10:52:30 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAX91DtSDJp5tiPAg--.44550S2;
	Fri, 05 Dec 2025 10:52:30 +0800 (CST)
Message-ID: <57a7d8c3-a911-4729-bc39-ba3a1d810990@huaweicloud.com>
Date: Fri, 5 Dec 2025 10:52:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
To: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
References: <20251205005841.3942668-1-avagin@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251205005841.3942668-1-avagin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAX91DtSDJp5tiPAg--.44550S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DXr4UXrW8Kry3Jry8Grg_yoW5GrWfpa
	ykGr13K3Z5tF1fCa1Sq3y0gr1SgFs5Gr4UCrnrJ340y343Jr1Iqr1Iya15ZFWDGrWfZF90
	y3WY93sxuw1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/12/5 8:58, Andrei Vagin wrote:
> This patch series introduces a mechanism to mask hardware capabilities
> (AT_HWCAP) reported to user-space processes via the misc cgroup
> controller.
> 
> To support C/R operations (snapshots, live migration) in heterogeneous
> clusters, we must ensure that processes utilize CPU features available
> on all potential target nodes. To solve this, we need to advertise a
> common feature set across the cluster. This patchset allows users to
> configure a mask for AT_HWCAP, AT_HWCAP2. This ensures that applications
> within a container only detect and use features guaranteed to be
> available on all potential target hosts.
> 

Could you elaborate on how this mask mechanism would be used in practice?

Based on my understanding of the implementation, the parent’s mask is effectively a subset of the
child’s mask, meaning the parent does not impose any additional restrictions on its children. This
behavior appears to differ from typical cgroup controllers, where children are further constrained
by their parent’s settings. This raises the question: is the cgroup model an appropriate fit for
this functionality?

> The first patch adds the mask interface to the misc cgroup controller,
> allowing users to set masks for AT_HWCAP, AT_HWCAP2...
> 
> The second patch adds a selftest to verify the functionality of the new
> interface, ensuring masks are applied and inherited correctly.
> 
> The third patch updates the documentation.
> 
> Cc: Kees Cook <kees@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutný" <mkoutny@suse.com>
> Cc: Vipin Sharma <vipinsh@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> 
> Andrei Vagin (3):
>   cgroup, binfmt_elf: Add hwcap masks to the misc controller
>   selftests/cgroup: Add a test for the misc.mask cgroup interface
>   Documentation: cgroup-v2: Document misc.mask interface
> 
>  Documentation/admin-guide/cgroup-v2.rst    |  25 ++++
>  Documentation/arch/arm64/elf_hwcaps.rst    |  21 ++++
>  fs/binfmt_elf.c                            |  24 +++-
>  include/linux/misc_cgroup.h                |  25 ++++
>  kernel/cgroup/misc.c                       | 126 +++++++++++++++++++++
>  tools/testing/selftests/cgroup/.gitignore  |   1 +
>  tools/testing/selftests/cgroup/Makefile    |   2 +
>  tools/testing/selftests/cgroup/config      |   1 +
>  tools/testing/selftests/cgroup/test_misc.c | 114 +++++++++++++++++++
>  9 files changed, 335 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/cgroup/test_misc.c

-- 
Best regards,
Ridong


