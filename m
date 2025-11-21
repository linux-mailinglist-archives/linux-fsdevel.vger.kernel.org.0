Return-Path: <linux-fsdevel+bounces-69343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F97C77791
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 818FD2C868
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 05:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224C0273D9A;
	Fri, 21 Nov 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U+nmlgrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A1218027;
	Fri, 21 Nov 2025 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763704321; cv=none; b=f2mCZOo5m8uyV+CWYqz8qfhxSiE71l9RusEcMJFZAyaxymQJ/Tv70TDsx6UxjqEcqF/8mckoizLzkgJArAJYsuQ8bOhXKmDE0On07XlLH6Ku1VwuZGk4JG4ZEKJBBNoImm7Rryj9mlc3xHIbTBLghZRN4bkhc5D0c+7Y+dQA70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763704321; c=relaxed/simple;
	bh=J5ozpRhMt5DRw8aY7oVSeNTVvTjutCb53tnA9L/B8u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpYQpQaQ+r1zxUjDhGH1+nY5WsQZJk3xk1P2AaCGC1yF2szwHHmcMavkIlnge4owYLlYGfZFummXV7xjvhl9UmZQE0rSCV1qMrpujRq9E72M2HIoSGqyhoXHF9Wvhw0t/ObwhMZbjGfMl5pfHNGbKN4kJ3OXQaVnHIJ5psGzuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U+nmlgrw; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zDeCAWOPDDbYEw4rgxZD9hZ1u15GmbWKrE1j0Lg4ZFI=;
	b=U+nmlgrwVe5SZUaxmpEAg917ZsgS20+mzrxcu290I9HUbbqIvCy34GUXgbh2At
	RaNkDNgxtDpWVDJXK0aCByjGpYVo+onkFFtVcFVqm6muIpy8QlRD8FVd0mTGeOvv
	VlHy+JsXByFT3ujADOot9EV/N5TvZxlQ281YBEwb8fZzs=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXWsjL_R9pqV7oBg--.5136S2;
	Fri, 21 Nov 2025 13:51:08 +0800 (CST)
Message-ID: <c921b743-a7cb-4979-8074-266642f05988@163.com>
Date: Fri, 21 Nov 2025 13:51:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] Enable exfat_get_block to support obtaining
 multiple clusters
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20251118082208.1034186-1-chizhiling@163.com>
 <CAKYAXd962j=77AQSk2dVmBeQak3yWhGP5B1TptLfSjzNX23CSg@mail.gmail.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <CAKYAXd962j=77AQSk2dVmBeQak3yWhGP5B1TptLfSjzNX23CSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXWsjL_R9pqV7oBg--.5136S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF1xKw1UKrWrZr43WFyrCrg_yoW5CrWfpr
	Z5K3Z5t3ykXa43Gr4ftw4kXryF934rGFW5J3WxJr43Gr90yF1Skr4DtF98Z3WqkwnYvFs0
	qr18Kr1UuwnrCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0Q6XUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFBcNnWkf9geldAAAsF

On 11/21/25 09:17, Namjae Jeon wrote:
> On Tue, Nov 18, 2025 at 5:26 PM Chi Zhiling <chizhiling@163.com> wrote:
>>
>> From: Chi Zhiling <chizhiling@kylinos.cn>
> Hi Chi,
>>
>> The purpose of this patchset is to prepare for adapting exfat to iomap
>> in the future. Currently, the main issue preventing exfat from supporting
>> iomap is its inability to fetch multiple contiguous clusters.
> Do you have a plan to work iomap support for exfat ?

Hi, Namjae


Firstly, I'm sorry that there are some errors in this patch. Due to my 
carelessness, the current patch did not work as expected. The parts that 
need to be modified are as follows:

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 256ba2af34eb..e52af92b1732 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -311,7 +311,7 @@ static int exfat_get_block(struct inode *inode, 
sector_t iblock,
                 err = exfat_count_contig_clusters(sb, &chain, &count);
                 if (err)
                         return err;
-               max_blocks = (count << sbi->sect_per_clus_bits) - 
sec_offset;
+               mapped_blocks = (count << sbi->sect_per_clus_bits) - 
sec_offset;
         }
         max_blocks = min(mapped_blocks, max_blocks);


Back to the question, I do have plan to support iomap for exfat, but I'm 
still testing how much benefit switching to iomap will bring :)

>>
>> However, this patchset does not directly modify exfat_map_cluster and
>> exfat_get_cluster to support multi-clusters. Instead, after obtaining
>> the first cluster, it uses exfat_count_contig_clusters to retrieve the
>> subsequent contiguous clusters.
>>
>> This approach is the one with the fewest changes among all the solutions
>> I have attempted, making the modifications easier to review.
>>
>> This patchset includes two main changes: one reduces the number of sb_bread
>> calls when accessing adjacent clusters to save time, and the other enables
>> fetching multiple contiguous entries in exfat_get_blocks.
> Are there any performance improvement measurements when applying this patch-set?

I don't have very detailed performance data yet,

With the fix above, I did a simple read test with big file (30G) on my 
pc (cluster = 512), no significantly improvement in IO read speed. but 
the time proportion of exfat_get_block has decreased.

NO_FAT_CHAIN file:
IO speed:                           2.9G/s -> 3.0G/s
proportion of exfat_get_block       26.7% -> 0.2%

FAT_CHAIN file:
IO speed:                           416M/s -> 444M/s
proportion of exfat_get_block       58% -> 27%

Thanks,

>>
>> Chi Zhiling (7):
>>    exfat: add cache option for __exfat_ent_get
>>    exfat: support reuse buffer head for exfat_ent_get
>>    exfat: reuse cache to improve exfat_get_cluster
>>    exfat: improve exfat_count_num_clusters
>>    exfat: improve exfat_find_last_cluster
>>    exfat: introduce exfat_count_contig_clusters
>>    exfat: get mutil-clusters in exfat_get_block
>>
>>   fs/exfat/cache.c    | 11 ++++--
>>   fs/exfat/exfat_fs.h |  6 ++-
>>   fs/exfat/fatent.c   | 90 ++++++++++++++++++++++++++++++++++++---------
>>   fs/exfat/inode.c    | 14 ++++++-
>>   4 files changed, 97 insertions(+), 24 deletions(-)
>>
>> --
>> 2.43.0
>>


