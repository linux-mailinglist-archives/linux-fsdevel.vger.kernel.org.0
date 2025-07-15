Return-Path: <linux-fsdevel+bounces-54957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47103B05AA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AB5178596
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0F2DE70C;
	Tue, 15 Jul 2025 12:52:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD800246BD7;
	Tue, 15 Jul 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583939; cv=none; b=UPmcUoE6ZWsfvpTX3kM/FCWu38dL+aezv2sZOeWn62LxiCaLkvwTiiauzXWO7IrqFNgwftlCyrjzDDI6xacpI16K9sdiO7O5RoUgRoO09pmiHmnjb07HEEHMQqsdVXSN04NsVZr0nQ6x9/tkbPbRtYZQk3tUr8T4jKmYymwZRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583939; c=relaxed/simple;
	bh=dv1L5jZ2MbEwURTnF49N0FpRk6CB5430YcdaSs4rFtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5s8J6Z9EPs2yU1L6ekB2RgVe9GBGnRjAPHO+CjlFvlWn+WQmHIRFD3N4LE+gOOkdwvnsuMg+QpOeZ98jO0dzEvEFvaJ5J+fNF53QR804LcnIrF7bEjyBsTX6X75hfQVD9YOad0a458AECgHv/ZckXJn1sjvxGQq2G2Az+T5wqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bhJxC1SkVzKHMgK;
	Tue, 15 Jul 2025 20:52:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C05D51A01A6;
	Tue, 15 Jul 2025 20:52:13 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgBn4dv7TnZot9BgAQ--.28426S3;
	Tue, 15 Jul 2025 20:52:13 +0800 (CST)
Message-ID: <5ce3b294-b6e0-45c6-bb55-fdd0ddf6c1f2@huaweicloud.com>
Date: Tue, 15 Jul 2025 20:52:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ext4: fix the compile error of
 EXT4_MAX_PAGECACHE_ORDER macro
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
 ojaswin@linux.ibm.com, sfr@canb.auug.org.au, yi.zhang@huawei.com,
 libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250715031203.2966086-1-yi.zhang@huaweicloud.com>
 <20250715040623.GA112967@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250715040623.GA112967@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBn4dv7TnZot9BgAQ--.28426S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur1rKFW7Cr15ArWkurWDtwb_yoWrAFW5pa
	y7C3WDJa4xJw1UZFWkZa17J3yxC3W0vF17ur1fJa97tF1DWr1xKFy2gF4qvFWxJr4xJr12
	v3Wayr4DJa4vy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/15 12:06, Theodore Ts'o wrote:
> On Tue, Jul 15, 2025 at 11:12:03AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Since both the input and output parameters of the
>> EXT4_MAX_PAGECACHE_ORDER should be unsigned int type, switch to using
>> umin() instead of min(). This will silence the compile error reported by
>> _compiletime_assert() on powerpc.
> 
> I've updated patch "ext4: limit the maximum folio order" with the
> one-character change in the patch.  Thanks for providing the fix, and
> thanks for Stephe for reporting the build failure on PowerPC.
> 
> I've updated the dev and pu branches.  (The proposed update patches
> are the patch series that I'm currently testing and is under review.)

Thank you for updating the original patch.

Best Regards,
Yi.

> 
> *   e30451675144 - (HEAD -> pu, ext4/pu) Merge branch 'bl/scalable-allocations' into pu (9 minutes ago)
> |\  
> | * abbcf4c5726d - (bl/scalable-allocations) ext4: implement linear-like traversal across order xarrays (10 minutes ago)
> | * b81f9dc5d0ba - ext4: refactor choose group to scan group (10 minutes ago)
> | * 7f4f2b5fcc3c - ext4: convert free groups order lists to xarrays (10 minutes ago)
> | * e47286abe4d8 - ext4: factor out ext4_mb_scan_group() (10 minutes ago)
> | * d1751cabc522 - ext4: factor out ext4_mb_might_prefetch() (10 minutes ago)
> | * e91438837515 - ext4: factor out __ext4_mb_scan_group() (10 minutes ago)
> | * 681eed57747a - ext4: fix largest free orders lists corruption on mb_optimize_scan switch (10 minutes ago)
> | * f63c2c051c86 - ext4: fix zombie groups in average fragment size lists (10 minutes ago)
> | * 985751249886 - ext4: merge freed extent with existing extents before insertion (10 minutes ago)
> | * f73e72c088df - ext4: convert sbi->s_mb_free_pending to atomic_t (10 minutes ago)
> | * 7963f5081eb7 - ext4: fix typo in CR_GOAL_LEN_SLOW comment (10 minutes ago)
> | * fe14b9db818e - ext4: get rid of some obsolete EXT4_MB_HINT flags (10 minutes ago)
> | * f9090356786d - ext4: utilize multiple global goals to reduce contention (10 minutes ago)
> | * 83f7fa7c57df - ext4: remove unnecessary s_md_lock on update s_mb_last_group (10 minutes ago)
> | * 79aef63bd0e5 - ext4: remove unnecessary s_mb_last_start (10 minutes ago)
> | * b29898a8ca5c - ext4: separate stream goal hits from s_bal_goals for better tracking (10 minutes ago)
> | * 7555f2d09299 - ext4: add ext4_try_lock_group() to skip busy groups (10 minutes ago)
> * |   92c2926d33ce - Merge branch 'tt/dotdot' into pu (10 minutes ago)
> |\ \  
> | |/  
> |/|   
> | * 4a1458d4d3a6 - (tt/dotdot) ext4: refactor the inline directory conversion and new directory codepaths (11 minutes ago)
> | * c75c1d7897e5 - ext4: use memcpy() instead of strcpy() (11 minutes ago)
> | * 63f1e6f25c71 - ext4: replace strcmp with direct comparison for '.' and '..' (11 minutes ago)
> |/  
> * b12f423d598f - (ext4/dev, dev) ext4: limit the maximum folio order (15 minutes ago)
> * 5137d6c8906b - ext4: fix insufficient credits calculation in ext4_meta_trans_blocks() (24 hours ago)
> * 57661f28756c - ext4: replace ext4_writepage_trans_blocks() (24 hours ago)
> * bbbf150f3f85 - ext4: reserved credits for one extent during the folio writeback (24 hours ago)
> * 95ad8ee45cdb - ext4: correct the reserved credits for extent conversion (24 hours ago)
> * 6b132759b0fe - ext4: enhance tracepoints during the folios writeback (24 hours ago)
> * e2c4c49dee64 - ext4: restart handle if credits are insufficient during allocating blocks (24 hours ago)
> * 2bddafea3d0d - ext4: refactor the block allocation process of ext4_page_mkwrite() (24 hours ago)
> * ded2d726a304 - ext4: fix stale data if it bail out of the extents mapping loop (24 hours ago)
> * f922c8c2461b - ext4: move the calculation of wbc->nr_to_write to mpage_folio_done() (24 hours ago)
> * 1bfe6354e097 - ext4: process folios writeback in bytes (24 hours ago)
> * a073e8577f18 - ext4: remove unused EXT_STATS macro from ext4_extents.h (2 days ago)
> * c5da1f66940d - ext4: remove unnecessary duplicate check in ext4_map_blocks() (3 days ago)
> * b6f3801727e4 - ext4: remove duplicate check for EXT4_FC_REPLAY (4 days ago)
> 
>        	   	      		    	  - Ted


