Return-Path: <linux-fsdevel+bounces-78334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKF+JolfnmmaUwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 03:33:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515B190EE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 03:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A131310215C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 02:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C72E28EA56;
	Wed, 25 Feb 2026 02:32:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28126F46F;
	Wed, 25 Feb 2026 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986766; cv=none; b=l+E45UVhBKtn7DAnmXakzmH5IfW2jfW/Tn9woMeqiMC4Uzvjcx84ZMLZCskH/5ky7YaQR0HEd32a7qHyMoPjU3jKuDma5Cy4dyZHBv+t367R/H67SlZ0ugeY0rCvP5PFgVN/FQSxEyuc/dy/gRI9XgWcESfDN7pCsG1fG+k763c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986766; c=relaxed/simple;
	bh=aG/j1CTumnrhavQPqTjfysHv89qbQiOwddXSaUmOgMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/HVsQTtAARInCqwNAm1tUKkeL8ZP47vm+oa+Gtd9aUxxYFbxe65+rMu4gta2T5GMeLZ7HmYbx6XxszqrMh+wuW29hno0dpLkfiZwuZvlgSqvL+UO/Mj2YciB0DEMuy5GX8h71oKzshk+tJqVSVP0S+4N93uRAQa4PYVf7SeO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fLJX14fZ2zYQtwf;
	Wed, 25 Feb 2026 10:32:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9C73E4056E;
	Wed, 25 Feb 2026 10:32:40 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP4 (Coremail) with SMTP id gCh0CgBnE_REX55p6vqmIg--.46236S3;
	Wed, 25 Feb 2026 10:32:38 +0800 (CST)
Message-ID: <7d2a3f65-4272-46c1-991a-356f0d2323cb@huaweicloud.com>
Date: Wed, 25 Feb 2026 10:32:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] nvme: set max_hw_wzeroes_unmap_sectors if device
 supports DEAC bit
To: Robert Pang <robertpang@google.com>, Zhang Yi <yi.zhang@huawei.com>
Cc: bmarzins@redhat.com, brauner@kernel.org, chaitanyak@nvidia.com,
 chengzhihao1@huawei.com, djwong@kernel.org, dm-devel@lists.linux.dev,
 hch@lst.de, john.g.garry@oracle.com, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com, tytso@mit.edu,
 yangerkun@huawei.com, yukuai3@huawei.com
References: <20250619111806.3546162-3-yi.zhang@huaweicloud.com>
 <20260225000531.3658802-1-robertpang@google.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260225000531.3658802-1-robertpang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnE_REX55p6vqmIg--.46236S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur4rJFyDCw15JF4UuF4fGrg_yoW5ZFyrpF
	4DWry0vrn8WF1UA3yDZw1I9FyUXws5Zry3Wa4kG3W5ZrZ0qryfZr1kuFZ0qa1DGrnrWw4F
	ya1xZryqvasrXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78334-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 1515B190EE9
X-Rspamd-Action: no action

Hi Robert!

On 2/25/2026 8:05 AM, Robert Pang wrote:
> Dear Zhang Yi,
> 
> In reviewing your patch series implementing support for the
> FALLOC_FL_WRITE_ZEROES flag, I noted the logic propagating
> max_write_zeroes_sectors to max_hw_wzeroes_unmap_sectors in commit 545fb46e5bc6
> "nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit" [1]. This
> appears to be intended for devices that support the Write Zeroes command
> alongside the DEAC bit to indicate unmap capability.
> 
> Furthermore, within core.c, the NVME_QUIRK_DEALLOCATE_ZEROES quirk already
> identifies devices that deterministically return zeroes after a deallocate
> command [2]. This quirk currently enables Write Zeroes support via discard in
> existing implementations [3, 4].
> 
> Given this, would it be appropriate to respect NVME_QUIRK_DEALLOCATE_ZEROES also
> to enable unmap Write Zeroes for these devices, following the prior commit
> 6e02318eaea5 "nvme: add support for the Write Zeroes command" [5]? I have
> included a proposed change to nvme_update_ns_info_block() below for your
> consideration.
> 

Thank you for your point. Overall, this makes sense to me, but I have one
question below.

> Best regards
> Robert Pang
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5ebcaa2f859..9c7e2cabfab3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2422,7 +2422,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>          * require that, it must be a no-op if reads from deallocated data
>          * do not return zeroes.
>          */
> -       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3))) {
> +       if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)) ||
> +           (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
> +           (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
                                ^^^^^^^^^^^^^^^^^^
Why do you want to add a check for NVME_CTRL_ONCS_DSM? In nvme_config_discard(),
it appears that we prioritize ctrl->dmrsl, allowing discard to still be
supported even on some non-standard devices where NVME_CTRL_ONCS_DSM is not set.
In nvme_update_disk_info(), if the device only has NVME_QUIRK_DEALLOCATE_ZEROES,
we still populate lim->max_write_zeroes_sectors (which might be non-zero on
devices that support NVME_CTRL_ONCS_WRITE_ZEROES). Right? So I'm not sure if we
only need to check for NVME_QUIRK_DEALLOCATE_ZEROES here.

>                 ns->head->features |= NVME_NS_DEAC;

I think we should not set NVME_NS_DEAC for the quirks case.

Cheers,
Yi.

>                 lim.max_hw_wzeroes_unmap_sectors = lim.max_write_zeroes_sectors;
>         }
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=545fb46e5bc6
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/nvme.h#n72
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n938
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n2122
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e02318eaea5


