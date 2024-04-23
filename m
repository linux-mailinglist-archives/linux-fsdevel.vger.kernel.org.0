Return-Path: <linux-fsdevel+bounces-17458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796EA8ADC74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EA61F2227E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383021CA82;
	Tue, 23 Apr 2024 03:53:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F178EEA9;
	Tue, 23 Apr 2024 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844432; cv=none; b=KqHOugSJ9P3B8YJVqVWoD4BGin18QpwOE1IDDW+UerfdGI4Zh6dL/BxWEWCeqrKlmRfCTpO5hhBFy5aiRTv4VWCFtnafEiIYmElTQP6NwwgqmJ4jE4DJEpXKD71EXKafsZkUoHRvK9T2MvXEYXr+s4O+p9ypPtlDgv15vrMfmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844432; c=relaxed/simple;
	bh=gZ01PmgJkAwD/5MjHEhBCay1mXLsSmDco4vWFq4iNlM=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JcQR4TpbQ0yXnuz6GhPJ0ZQxjYAu2djKEyFCMDgPRIYEXXxtPESEvan8CA7vz/yzr16dnPcyhg78v1ZGwN6Pg8PbI81HmCvvSxSUlnReDX8G4HyQObHbouKmrrolRNf6prXinTRPGxhBydZDrxFCVDtNua7msGUv9EPa2oTSmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNpBV3w9fz4f3nbh;
	Tue, 23 Apr 2024 11:53:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AD3781A0B98;
	Tue, 23 Apr 2024 11:53:47 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDH4gvJMCdmmxHfKg--.8936S2;
	Tue, 23 Apr 2024 11:53:47 +0800 (CST)
Subject: Re: [PATCH v5 3/5] writeback: fix build problems of "writeback:
 support retrieving per group debug writeback stats of bdi"
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 bfoster@redhat.com, tj@kernel.org
Cc: dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, sj@kernel.org, sfr@canb.auug.org.au
References: <20240423034643.141219-1-shikemeng@huaweicloud.com>
 <20240423034643.141219-4-shikemeng@huaweicloud.com>
Message-ID: <085442bc-68c8-4d91-952f-c321c4d81825@huaweicloud.com>
Date: Tue, 23 Apr 2024 11:53:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240423034643.141219-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDH4gvJMCdmmxHfKg--.8936S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWfCr48ZrW7Xw43Kr43Awb_yoW8CFy3pa
	9xCa10k3yUXr9rGFnxCFW7Xr90q3y0qay7Wa4kAry2k3ZIgFnxGFySk348Zry8Zas3Gryx
	uan0vFyxJrWqvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 4/23/2024 11:46 AM, Kemeng Shi wrote:
> Fix two build problems:
> 1. implicit declaration of function 'cgroup_ino'.
> 2. unused variable 'stats'.
> 
> After this fix, No build problem is found when CGROUPS is disabled.
> The wb_stats could be successfully retrieved when CGROUP_WRITEBACK is
> disabled:
> cat wb_stats
> WbCgIno:                    1
> WbWriteback:                0 kB
> WbReclaimable:         685440 kB
> WbDirtyThresh:      195530960 kB
> WbDirtied:             691488 kB
> WbWritten:               6048 kB
> WbWriteBandwidth:      102400 kBps
> b_dirty:                    2
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      5
> 
> cat wb_stats
> WbCgIno:                    1
> WbWriteback:                0 kB
> WbReclaimable:         818944 kB
> WbDirtyThresh:      195527484 kB
> WbDirtied:             824992 kB
> WbWritten:               6048 kB
> WbWriteBandwidth:      102400 kBps
> b_dirty:                    2
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      5
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: SeongJae Park <sj@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Sorry for missing reported-by tags.

> ---
>  mm/backing-dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 6ecd11bdce6e..e61bbb1bd622 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -172,7 +172,11 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
>  		   "b_more_io:         %10lu\n"
>  		   "b_dirty_time:      %10lu\n"
>  		   "state:             %10lx\n\n",
> +#ifdef CONFIG_CGROUP_WRITEBACK
>  		   cgroup_ino(wb->memcg_css->cgroup),
> +#else
> +		   1ul,
> +#endif
>  		   K(stats->nr_writeback),
>  		   K(stats->nr_reclaimable),
>  		   K(stats->wb_thresh),
> @@ -192,7 +196,6 @@ static int cgwb_debug_stats_show(struct seq_file *m, void *v)
>  	unsigned long background_thresh;
>  	unsigned long dirty_thresh;
>  	struct bdi_writeback *wb;
> -	struct wb_stats stats;
>  
>  	global_dirty_limits(&background_thresh, &dirty_thresh);
>  
> 


