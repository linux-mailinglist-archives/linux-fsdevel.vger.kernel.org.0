Return-Path: <linux-fsdevel+bounces-78466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP7XKEIqoGlrfwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 12:10:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA081A4DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 12:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6011306B784
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEBA33A038;
	Thu, 26 Feb 2026 11:09:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D4336EF7;
	Thu, 26 Feb 2026 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104197; cv=none; b=SULtdEGNpYN1tlh6oMj1xTLrDMaikCqALO+VDUL0PDGCvd57U8lxXvtx5YqCDONOk3W+VzETpD7CdbC8QdBBa/RvVmsvodG97s9IcHqHBkTcDQ6Mj4Yr3P9gvomXqYPVP2ygeRPOyH7h+T/0Wh3FUSUC+MyaIBGrg49u6+H2g/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104197; c=relaxed/simple;
	bh=tGJd/yOzp/uuX/6Z03jyOFPxRlrff2uK13N8ULGzr3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2LWUnnNDjtfbXsyf77/TCO/PIzRqj9/5yYAdSXnT2gCzf/OZr9BtoqUvDR0YYkKSHDFiu2G5nU4achIDL0OTH6SVy9/LJs0iW3efD/X+S60r7SKngD8hgLJRGA00Dohxk3k8K2Yqw9zvZ5GETkPrKB0EMNrLQvXk7jyDiIN2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fM7xZ119JzKHML8;
	Thu, 26 Feb 2026 19:08:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 520184056F;
	Thu, 26 Feb 2026 19:09:47 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP4 (Coremail) with SMTP id gCh0CgAHZ_f2KaBpG75MIw--.17526S3;
	Thu, 26 Feb 2026 19:09:44 +0800 (CST)
Message-ID: <8a45c55f-8abe-4cdf-be70-208550edf320@huaweicloud.com>
Date: Thu, 26 Feb 2026 19:09:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
To: Robert Pang <robertpang@google.com>
Cc: Zhang Yi <yi.zhang@huawei.com>, bmarzins@redhat.com, brauner@kernel.org,
 chaitanyak@nvidia.com, chengzhihao1@huawei.com, djwong@kernel.org,
 dm-devel@lists.linux.dev, hch@lst.de, john.g.garry@oracle.com,
 linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, martin.petersen@oracle.com,
 shinichiro.kawasaki@wdc.com, tytso@mit.edu, yangerkun@huawei.com,
 yukuai3@huawei.com
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com>
 <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
 <CAJhEC05L7QEc9iY7gFZVK3SPYvFhtFyURss6xQgZ-qWwZZkFjA@mail.gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <CAJhEC05L7QEc9iY7gFZVK3SPYvFhtFyURss6xQgZ-qWwZZkFjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHZ_f2KaBpG75MIw--.17526S3
X-Coremail-Antispam: 1UD129KBjvJXoWxArW8Gr4xCr1rtry7AFyUtrb_yoW7Gr4UpF
	4UWFyIvrZ8WF1UA3yqvw1I9FyUJ3s5ZryxWa4DG3W5Zryqqr1SvF1kuFZ09FWDGrn8uw4S
	ya18Ar9Fv3ZxZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78466-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:mid,huaweicloud.com:email]
X-Rspamd-Queue-Id: 1BA081A4DF0
X-Rspamd-Action: no action

On 2/26/2026 5:43 AM, Robert Pang wrote:
> Dear Zhang Yi
> 
> Thank you for your quick response. Please see my comments below:
> 
> On Tue, Feb 24, 2026 at 6:32 PM Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>
>> Hi Robert!
>>
>> On 2/25/2026 8:05 AM, Robert Pang wrote:
>>> Dear Zhang Yi,
>>>
>>> In reviewing your patch series implementing support for the
>>> FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
>>> max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545fb46e5bc6
>>> "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1]. This
>>> appears to be intended for devices that support the Write Zeroes command
>>> alongside the DEAC bit to indicate unmap capability.
>>>
>>> Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk already
>>> identifies devices that deterministically return zeroes after a deallocate
>>> command [2]. This quirk currently enables Write Zeroes support via discard in
>>> existing implementations [3, 4].
>>>
>>> Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZEROES also
>>> to enable unmap Write Zeroes for these devices, following the prior commit
>>> 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I have
>>> included a proposed change to nvme_update_ns_info_block() below for your
>>> consideration.
>>>
>>
>> Thank you for your point. Overall, this makes sense to me, but I have one
>> question below.
>>
>>> Best regards
>>> Robert Pang
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index f5ebcaa2f859..9c7e2cabfab3 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>>>          * require that, it must be a no-op if reads from deallocated data
>>>          * do not return zeroes.
>>>          */
>>> -       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3))) {
>>> +       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)) ||
>>> +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
>>> +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
>>                                 ^^^^^^^^^^^^^^^^^^
>> Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_discard(),
>> it appears that we prioritize ctrl->dmrsl, allowing discard to still be
>> supported even on some non-standard devices where NVME_CTRL_ONCS_DSM is not set.
>> In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCATE_ZEROES,
>> we still populate lim->max_write_zeroes_sectors (which might be non-zero on
>> devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not sure if we
>> only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.
>>
> The check for NVME_CTRL_ONCS_DSM is to follow the same check in [3]. There, the
> check was added by 58a0c875ce02 "nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES
> when DSM is not supported" [6]. The idea is to limit
> NVME_QUIRK_DEALLOCATE_ZEROES
> to those devices that support DSM.
> 

OK.

>>>                 ns->head->features |= NVME_NS_DEAC;
>>
>> I think we should not set NVME_NS_DEAC for the quirks case.
>>
> Make sense. In that case, will it be more appropriate to set
> max_hw_wzeroes_unmap_sectors in nvme_update_disk_info() where
> NVME_QUIRK_DEALLOCATE_ZEROES is checked? I.e.
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5ebcaa2f859..3f5dd3f867e9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2120,9 +2120,10 @@ static bool nvme_update_disk_info(struct
> nvme_ns *ns, struct nvme_id_ns *id,
>         lim->io_min = phys_bs;
>         lim->io_opt = io_opt;
>         if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> -           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
> +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
>                 lim->max_write_zeroes_sectors = UINT_MAX;
> -       else
> +               lim->max_hw_wzeroes_unmap_sectors = UINT_MAX;
> +       } else
>                 lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;
>         return valid;
>  }
> 

Yeah, it looks good to me.

Best regards,
Yi.

> Best regards
> Robert
> 
>> Cheers,
>> Yi.
>>
>>>                 lim.max_hw_wzeroes_unmap_sectors = lim.max_write_zeroes_sectors;
>>>         }
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=545fb46e5bc6
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/nvme.h#n72
>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n938
>>> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n2122
>>> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e02318eaea5
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58a0c875ce02


