Return-Path: <linux-fsdevel+bounces-57165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B849BB1F381
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 11:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373E8189AB1A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE48E27FB10;
	Sat,  9 Aug 2025 09:09:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5646A223DF5;
	Sat,  9 Aug 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754730588; cv=none; b=Wtanf+JozmQyYWF9S1rWpJdu98MoQNCYfxZnrj1tOlQahO1eXhMbbTSkEttLNfHBDoNeN0dE5rpnq2SvtWKgMSxqeNYX+2jrgfl1FRkOxG2OklSbIkMTsmFRuq8uiumHyRUYreQ6kdek8ro1C50EIghyBmkfVFKZQQJE4d684Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754730588; c=relaxed/simple;
	bh=jvBCCsN/bTcSJWw7u9VtAcnpfLrJcDCVRN0QJR6lVVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMRj/ClFmiCL9u7qCeUlz74Z0Vxi+cDbgXTZPMZqkwN5BN/d3pqkzoqn2bSOBUbOHZbHkqMzguuoJ2sL9hGXHkDx2jk01apwgHw4phscbktjl0J+M1djs0mZgmVFMXsnvihiZ5znrO+5HMuhXupe0L0mzumZ5VN5DWGyaR6bbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bzZpp2Kd7zYQvBZ;
	Sat,  9 Aug 2025 17:09:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E9F8B1A13FA;
	Sat,  9 Aug 2025 17:09:36 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhJPEJdoWJNZDA--.11172S3;
	Sat, 09 Aug 2025 17:09:36 +0800 (CST)
Message-ID: <c2a00db8-ed34-49bb-8c01-572381451af3@huaweicloud.com>
Date: Sat, 9 Aug 2025 17:09:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
To: Qu Wenruo <wqu@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
 <20250808121659.GC778805@mit.edu>
 <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhJPEJdoWJNZDA--.11172S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy8ZFy3Gr13Kw1rGF45ZFb_yoW5tr4UpF
	W7AF1Fkr4DWr1UuF4293W7Zr4fK34kKa15XFZ5XryUZ3sIqa4xKrnxtFya9FWUKr1I9r4q
	qFZ8JryIvr1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/8/9 6:11, Qu Wenruo wrote:
> 在 2025/8/8 21:46, Theodore Ts'o 写道:
>> On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
>>>
>>> 在 2025/8/8 17:22, Qu Wenruo 写道:
>>>> Hi,
>>>>
>>>> [BACKGROUND]
>>>> Recently I'm testing btrfs with 16KiB block size.
>>>>
>>>> Currently btrfs is artificially limiting subpage block size to 4K.
>>>> But there is a simple patch to change it to support all block sizes <=
>>>> page size in my branch:
>>>>
>>>> https://github.com/adam900710/linux/tree/larger_bs_support
>>>>
>>>> [IOMAP WARNING]
>>>> And I'm running into a very weird kernel warning at btrfs/136, with 16K
>>>> block size and 64K page size.
>>>>
>>>> The problem is, the problem happens with ext3 (using ext4 modeule) with
>>>> 16K block size, and no btrfs is involved yet.
>>
>>
>> Thanks for the bug report!  This looks like it's an issue with using
>> indirect block-mapped file with a 16k block size.  I tried your
>> reproducer using a 1k block size on an x86_64 system, which is how I
>> test problem caused by the block size < page size.  It didn't
>> reproduce there, so it looks like it really needs a 16k block size.
>>
>> Can you say something about what system were you running your testing
>> on --- was it an arm64 system, or a powerpc 64 system (the two most
>> common systems with page size > 4k)?  (I assume you're not trying to
>> do this on an Itanic.  :-)   And was the page size 16k or 64k?
> 
> The architecture is aarch64, the host board is Rock5B (cheap and fast enough), the test machine is a VM on that board, with ovmf as the UEFI firmware.
> 
> The kernel is configured to use 64K page size, the *ext3* system is using 16K block size.
> 
> Currently I tried the following combination with 64K page size and ext3, the result looks like the following
> 
> - 2K block size
> - 4K block size
>   All fine
> 
> - 8K block size
> - 16K block size
>   All the same kernel warning and never ending fsstress
> 
> - 32K block size
> - 64K block size
>   All fine
> 
> I am surprised as you that, not all subpage block size are having problems, just 2 of the less common combinations failed.
> 
> And the most common ones (4K, page size) are all fine.
> 
> Finally, if using ext4 not ext3, all combinations above are fine again.
> 
> So I ran out of ideas why only 2 block sizes fail here...
> 

This issue is caused by an overflow in the calculation of the hole's
length on the forth-level depth for non-extent inodes. For a file system
with a 4KB block size, the calculation will not overflow. For a 64KB
block size, the queried position will not reach the fourth level, so this
issue only occur on the filesystem with a 8KB and 16KB block size.

Hi, Wenruo, could you try the following fix?

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 7de327fa7b1c..d45124318200 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	int indirect_blks;
 	int blocks_to_boundary = 0;
 	int depth;
-	int count = 0;
+	u64 count = 0;
 	ext4_fsblk_t first_block = 0;

 	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 		count++;
 		/* Fill in size of a hole we found */
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, count);
+		map->m_len = umin(map->m_len, count);
 		goto cleanup;
 	}

Thanks,
Yi.



