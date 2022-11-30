Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81C963D132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiK3I6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 03:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiK3I6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:58:47 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FBD3FBB2;
        Wed, 30 Nov 2022 00:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669798723; i=@fujitsu.com;
        bh=UqefX3w7nz8Qysb/jCMNTBimkhTHy3MAVGa8Qu9IR0M=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=cHTUhUOVLWPGMc9escmCPwehEtQcCEGAo3a6uLH/9MzOoE3UP+54H6FLbU0CDJqFJ
         1x8iJqjFKsK6Wv7qQYGoyvQjCeLWSL+iERbKwlHdwsL5LSEYz9nVJn/iZPa3MTSyWk
         B0BvOagNFEyp100LfNbpTUr4HSUqBIuWBS7xrDlsYFn32MdtoO5x/ri/6OtbVdTDYO
         WI0fmJMK+w9Z1DKpxGKX7oY3De+vcWUgqNG3p9hXgB1ejhyzefNVU23qb3gbXHqhj6
         b3wLkP6rmGrTtDnNWQTi0H3cRcsG3/KXZ/YGV4WIMCx5Q1gmapQ4HsGIHOu/51xuF7
         qpkjrK46EIsRA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsViZ8ORpOsk3Z5
  sMHudpMX0qRcYLbYcu8docfkJn8WevSdZLC7vmsNmsevPDnaLlT/+sDqwe5xaJOGxeM9LJo9N
  qzrZPF5snsno8XmTXABrFGtmXlJ+RQJrRsuJh4wFV4orLv08wdbAuDa6i5GLQ0hgI6PEpWM7G
  SGcJUwSW25fYu5i5ARytjFKfJmkBWLzCthJHDt4nwXEZhFQlVh3bRUrRFxQ4uTMJ2BxUYFkib
  7+mWwgtrBAuMS3TyvZQWwRAU2JI9+uMYHYzALrGSW2dApCLJvNKHGgYzNYM5uAjsSFBX/BhnI
  KaEi0L7vGCNFgIbH4zUF2CFteonnrbLDjJAQUJRruz2GCsCskZs1qg7LVJK6e28Q8gVFoFpL7
  ZiEZNQvJqAWMzKsYTYtTi8pSi3SN9ZKKMtMzSnITM3P0Eqt0E/VSS3XLU4tLdA31EsuL9VKLi
  /WKK3OTc1L08lJLNjECYymlmK16B+PbpX/0DjFKcjApifLqi7cnC/El5adUZiQWZ8QXleakFh
  9ilOHgUJLg/QiSEyxKTU+tSMvMAcY1TFqCg0dJhLdQGCjNW1yQmFucmQ6ROsVozLG24cBeZo5
  Jf67tZRZiycvPS5US5zWSBCoVACnNKM2DGwRLN5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAq
  CfMGgdzDk5lXArfvFdApTECnRIq1gZxSkoiQkmpg6tM9uUpkyb60HPaQ/wKG+9nLS3wKPpWX7
  Z+7ru543NXbUTNdV/JeVlSs2Pt4n5/pHcePknEsj8883thb6t7/dx/PLNYjQcz+Eavro/a6Kn
  vaMUZPKPbucNw3efnWtZ8q1O3uVan/lZo+z+Cskbvde1E+tZkfvHPLqy0miKw7lRyYtPv21ve
  3n+tVnX6+x3yGVY7YFrMIGaW99W+zgz/7bvgrsIS76Unh/neq23pu7llzYNUbXpa2U1eD3b43
  NUl+M1Kev9HvGE/XzACuwH/zL+3ukfOdtOL08Vdn2EOunclRnpGYUcyTb/nubvqnBcKrl89Z7
  ixdWnHofum/1066/iEVHFsUnZ0cC+U3fAsMUGIpzkg01GIuKk4EAAPizR6yAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-3.tower-585.messagelabs.com!1669798722!36612!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9632 invoked from network); 30 Nov 2022 08:58:42 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-3.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Nov 2022 08:58:42 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 030561AE;
        Wed, 30 Nov 2022 08:58:42 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id EB0FB1AC;
        Wed, 30 Nov 2022 08:58:41 +0000 (GMT)
Received: from [10.167.216.27] (10.167.216.27) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 30 Nov 2022 08:58:38 +0000
Message-ID: <7aa0a212-4cc8-04bc-10ea-4f0c47915623@fujitsu.com>
Date:   Wed, 30 Nov 2022 16:58:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] fsdax,xfs: fix warning messages at
 dax_[dis]associate_entry()
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>, <dan.j.williams@intel.com>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669301694-16-2-git-send-email-ruansy.fnst@fujitsu.com>
 <Y4bXTywl3PQTY3Er@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <Y4bXTywl3PQTY3Er@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.216.27]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/11/30 12:08, Darrick J. Wong 写道:
> On Thu, Nov 24, 2022 at 02:54:53PM +0000, Shiyang Ruan wrote:
>> This patch fixes the warning message reported in dax_associate_entry()
>> and dax_disassociate_entry().
> 
> Hmm, that's quite a bit to put in a single patch, but I'll try to get
> through this...

Oh sorry...

> 
>> 1. reset page->mapping and ->index when refcount counting down to 0.
>> 2. set IOMAP_F_SHARED flag when iomap read to allow one dax page to be
>> associated more than once for not only write but also read.
> 
> That makes sense, I think.
> 
>> 3. should zero the edge (when not aligned) if srcmap is HOLE or
> 
> When is IOMAP_F_SHARED set on the /source/ mapping?

In fs/xfs/xfs_iomap.c: xfs_direct_write_iomap_begin(): goto 
out_found_cow tag, srcmap is *not set* when the source extent is HOLE, 
then only iomap is set with IOMAP_F_SHARED flag.

Now we come to iomap iter, when we get the srcmap by calling 
iomap_iter_srcmap(iter), the iomap will be returned (because srcmap 
isn't set).  So, in this case, srcmap == iomap, we can think the source 
extent is a HOLE if srcmap->flag & IOMAP_F_SHARED != 0

> 
>> UNWRITTEN.
>> 4. iterator of two files in dedupe should be executed side by side, not
>> nested.
> 
> Why?  Also, this seems like a separate change?

Explain below.

> 
>> 5. use xfs_dax_write_iomap_ops for xfs zero and truncate.
> 
> Makes sense.
> 
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   fs/dax.c           | 114 ++++++++++++++++++++++++++-------------------
>>   fs/xfs/xfs_iomap.c |   6 +--
>>   2 files changed, 69 insertions(+), 51 deletions(-)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 1c6867810cbd..5ea7c0926b7f 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -398,7 +398,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>>   		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
>>   		if (dax_mapping_is_cow(page->mapping)) {
>>   			/* keep the CoW flag if this page is still shared */
>> -			if (page->index-- > 0)
>> +			if (page->index-- > 1)
> 
> Hmm.  So if the fsdax "page" sharing factor drops from 2 to 1, we'll now
> null out the mapping and index?  Before, we only did that when it
> dropped from 1 to 0.
> 
> Does this leave the page with no mapping?  And I guess a subsequent
> access will now take a fault to map it back in?

I confused it with --page->index, the result of "page->index--" is 
page->index itself.

So, assume:
this time, refcount is 2, >1,     minus 1 to 1, then continue;
next time, refcount is 1, not >1, minus 1 to 0, then clear the 
page->mapping.


> 
>>   				continue;
>>   		} else
>>   			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>> @@ -840,12 +840,6 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
>>   		(iter->iomap.flags & IOMAP_F_DIRTY);
>>   }
>>   
>> -static bool dax_fault_is_cow(const struct iomap_iter *iter)
>> -{
>> -	return (iter->flags & IOMAP_WRITE) &&
>> -		(iter->iomap.flags & IOMAP_F_SHARED);
>> -}
>> -
>>   /*
>>    * By this point grab_mapping_entry() has ensured that we have a locked entry
>>    * of the appropriate size so we don't have to worry about downgrading PMDs to
>> @@ -859,13 +853,14 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>>   {
>>   	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>>   	void *new_entry = dax_make_entry(pfn, flags);
>> -	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
>> -	bool cow = dax_fault_is_cow(iter);
>> +	bool write = iter->flags & IOMAP_WRITE;
>> +	bool dirty = write && !dax_fault_is_synchronous(iter, vmf->vma);
>> +	bool shared = iter->iomap.flags & IOMAP_F_SHARED;
>>   
>>   	if (dirty)
>>   		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>>   
>> -	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
>> +	if (shared || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
> 
> Ah, ok, so now we're yanking the mapping if the extent is shared,
> presumably so that...
> 
>>   		unsigned long index = xas->xa_index;
>>   		/* we are replacing a zero page with block mapping */
>>   		if (dax_is_pmd_entry(entry))
>> @@ -877,12 +872,12 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>>   
>>   	xas_reset(xas);
>>   	xas_lock_irq(xas);
>> -	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>> +	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>>   		void *old;
>>   
>>   		dax_disassociate_entry(entry, mapping, false);
>>   		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
>> -				cow);
>> +				shared);
> 
> ...down here we can rebuild the association, but this time we'll set the
> page->mapping to PAGE_MAPPING_DAX_COW?  I see a lot of similar changes,
> so I'm guessing this is how you fixed the failures that were a result of
> read file A -> reflink A to B -> read file B sequences?

Yes, it even failed when mapreading a page shared by two extent of ONE 
file.  But I remember that I had tested these cases before...

> 
>>   		/*
>>   		 * Only swap our new entry into the page cache if the current
>>   		 * entry is a zero page or an empty entry.  If a normal PTE or
>> @@ -902,7 +897,7 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>>   	if (dirty)
>>   		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>>   
>> -	if (cow)
>> +	if (write && shared)
>>   		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
>>   
>>   	xas_unlock_irq(xas);
>> @@ -1107,23 +1102,35 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
> 
> I think this function isn't well named.  It's copying into the parts of
> the @daddr page that are *not* covered by @pos/@length.  In other words,
> it's really copying *around* the range that's supplied, isn't it?

Yes, I used to name it "dax_iomap_copy_edge()", which is not so good 
too.  I'm not good at naming.

> 
>>   	loff_t end = pos + length;
>>   	loff_t pg_end = round_up(end, align_size);
>>   	bool copy_all = head_off == 0 && end == pg_end;
>> +	/* write zero at edge if srcmap is a HOLE or IOMAP_UNWRITTEN */
>> +	bool zero_edge = srcmap->flags & IOMAP_F_SHARED ||
> 
> When is IOMAP_F_SHARED set on the /source/ mapping?  I don't understand
> that circumstance, so I don't understand why we want to zero around in
> that case.

Please see explanation above.

> 
>> +			 srcmap->type == IOMAP_UNWRITTEN;
> 
> Though it's self evident why we'd do that if the source map is
> unwritten.

The new allocated destination pages for CoW is not all zeroed, not like 
new allocated page cache.  Old data remains on it.  So, if the source 
extent doesn't contain valid data (HOLE and UNWRITTEN extent), we need 
to zero the destination range around the @pos+@length.

> 
>>   	void *saddr = 0;
>>   	int ret = 0;
>>   
>> -	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
>> -	if (ret)
>> -		return ret;
>> +	if (!zero_edge) {
>> +		ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	if (copy_all) {
>> -		ret = copy_mc_to_kernel(daddr, saddr, length);
>> -		return ret ? -EIO : 0;
>> +		if (zero_edge)
>> +			memset(daddr, 0, size);
>> +		else
>> +			ret = copy_mc_to_kernel(daddr, saddr, length);
>> +		goto out;
>>   	}
>>   
>>   	/* Copy the head part of the range */
>>   	if (head_off) {
>> -		ret = copy_mc_to_kernel(daddr, saddr, head_off);
>> -		if (ret)
>> -			return -EIO;
>> +		if (zero_edge)
>> +			memset(daddr, 0, head_off);
>> +		else {
>> +			ret = copy_mc_to_kernel(daddr, saddr, head_off);
>> +			if (ret)
>> +				return -EIO;
>> +		}
>>   	}
>>   
>>   	/* Copy the tail part of the range */
>> @@ -1131,12 +1138,19 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
>>   		loff_t tail_off = head_off + length;
>>   		loff_t tail_len = pg_end - end;
>>   
>> -		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
>> -					tail_len);
>> -		if (ret)
>> -			return -EIO;
>> +		if (zero_edge)
>> +			memset(daddr + tail_off, 0, tail_len);
>> +		else {
>> +			ret = copy_mc_to_kernel(daddr + tail_off,
>> +						saddr + tail_off, tail_len);
>> +			if (ret)
>> +				return -EIO;
>> +		}
>>   	}
>> -	return 0;
>> +out:
>> +	if (zero_edge)
>> +		dax_flush(srcmap->dax_dev, daddr, size);
>> +	return ret ? -EIO : 0;
>>   }
>>   
>>   /*
>> @@ -1235,13 +1249,9 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
>>   	if (ret < 0)
>>   		return ret;
>>   	memset(kaddr + offset, 0, size);
>> -	if (srcmap->addr != iomap->addr) {
>> -		ret = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap,
>> -					 kaddr);
>> -		if (ret < 0)
>> -			return ret;
>> -		dax_flush(iomap->dax_dev, kaddr, PAGE_SIZE);
>> -	} else
>> +	if (iomap->flags & IOMAP_F_SHARED)
>> +		ret = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap, kaddr);
>> +	else
>>   		dax_flush(iomap->dax_dev, kaddr + offset, size);
>>   	return ret;
>>   }
>> @@ -1258,6 +1268,15 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>>   	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
>>   		return length;
>>   
>> +	/*
>> +	 * invalidate the pages whose sharing state is to be changed
>> +	 * because of CoW.
>> +	 */
>> +	if (iomap->flags & IOMAP_F_SHARED)
>> +		invalidate_inode_pages2_range(iter->inode->i_mapping,
>> +					      pos >> PAGE_SHIFT,
>> +					      (pos + length - 1) >> PAGE_SHIFT);
>> +
>>   	do {
>>   		unsigned offset = offset_in_page(pos);
>>   		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>> @@ -1318,12 +1337,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   		struct iov_iter *iter)
>>   {
>>   	const struct iomap *iomap = &iomi->iomap;
>> -	const struct iomap *srcmap = &iomi->srcmap;
>> +	const struct iomap *srcmap = iomap_iter_srcmap(iomi);
>>   	loff_t length = iomap_length(iomi);
>>   	loff_t pos = iomi->pos;
>>   	struct dax_device *dax_dev = iomap->dax_dev;
>>   	loff_t end = pos + length, done = 0;
>>   	bool write = iov_iter_rw(iter) == WRITE;
>> +	bool cow = write && iomap->flags & IOMAP_F_SHARED;
>>   	ssize_t ret = 0;
>>   	size_t xfer;
>>   	int id;
>> @@ -1350,7 +1370,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   	 * into page tables. We have to tear down these mappings so that data
>>   	 * written by write(2) is visible in mmap.
>>   	 */
>> -	if (iomap->flags & IOMAP_F_NEW) {
>> +	if (iomap->flags & IOMAP_F_NEW || cow) {
>>   		invalidate_inode_pages2_range(iomi->inode->i_mapping,
>>   					      pos >> PAGE_SHIFT,
>>   					      (end - 1) >> PAGE_SHIFT);
>> @@ -1384,8 +1404,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>>   			break;
>>   		}
>>   
>> -		if (write &&
>> -		    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
>> +		if (cow) {
>>   			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
>>   						 kaddr);
>>   			if (ret)
>> @@ -1532,7 +1551,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>>   		struct xa_state *xas, void **entry, bool pmd)
>>   {
>>   	const struct iomap *iomap = &iter->iomap;
>> -	const struct iomap *srcmap = &iter->srcmap;
>> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>>   	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
>>   	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
>>   	bool write = iter->flags & IOMAP_WRITE;
>> @@ -1563,8 +1582,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>>   
>>   	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
>>   
>> -	if (write &&
>> -	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
>> +	if (write && iomap->flags & IOMAP_F_SHARED) {
>>   		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
>>   		if (err)
>>   			return dax_fault_return(err);
>> @@ -1936,15 +1954,15 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> 
> Does the dedupe change need to be in this patch?  It looks ok both
> before and after, so I don't know why it's necessary.

I'll separate this in next version.

This is the old version:
	while ((ret = iomap_iter(&src_iter, ops)) > 0) {
		while ((ret = iomap_iter(&dst_iter, ops)) > 0) {
			dst_iter.processed = dax_range_compare_iter(&src_iter,
						&dst_iter, len, same);
		}
		if (ret <= 0)
			src_iter.processed = ret;
	}
The inner iter (iomap_begin, actor, iomap_end) may loop more than once. 
In this case, the inner dest_iter updates its iomap, but the outer 
src_iter still keeps the old.  The comparison of new dest_iomap and old 
src_iomap is meanless and it causes the bug.

So, we need to make the two iters able to update their iomaps together.

> 
> Welp, thank you for fixing the problems, at least.  After a couple of
> days it looks like the serious problems have cleared up.
> 

I didn't test the dax code well.  Sorry...


--
Thanks,
Ruan.

> --D
> 
>>   		.len		= len,
>>   		.flags		= IOMAP_DAX,
>>   	};
>> -	int ret;
>> +	int ret, compared = 0;
>>   
>> -	while ((ret = iomap_iter(&src_iter, ops)) > 0) {
>> -		while ((ret = iomap_iter(&dst_iter, ops)) > 0) {
>> -			dst_iter.processed = dax_range_compare_iter(&src_iter,
>> -						&dst_iter, len, same);
>> -		}
>> -		if (ret <= 0)
>> -			src_iter.processed = ret;
>> +	while ((ret = iomap_iter(&src_iter, ops)) > 0 &&
>> +	       (ret = iomap_iter(&dst_iter, ops)) > 0) {
>> +		compared = dax_range_compare_iter(&src_iter, &dst_iter, len,
>> +						  same);
>> +		if (compared < 0)
>> +			return ret;
>> +		src_iter.processed = dst_iter.processed = compared;
>>   	}
>>   	return ret;
>>   }
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 07da03976ec1..d9401d0300ad 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -1215,7 +1215,7 @@ xfs_read_iomap_begin(
>>   		return error;
>>   	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>>   			       &nimaps, 0);
>> -	if (!error && (flags & IOMAP_REPORT))
>> +	if (!error && ((flags & IOMAP_REPORT) || IS_DAX(inode)))
>>   		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
>>   	xfs_iunlock(ip, lockmode);
>>   
>> @@ -1370,7 +1370,7 @@ xfs_zero_range(
>>   
>>   	if (IS_DAX(inode))
>>   		return dax_zero_range(inode, pos, len, did_zero,
>> -				      &xfs_direct_write_iomap_ops);
>> +				      &xfs_dax_write_iomap_ops);
>>   	return iomap_zero_range(inode, pos, len, did_zero,
>>   				&xfs_buffered_write_iomap_ops);
>>   }
>> @@ -1385,7 +1385,7 @@ xfs_truncate_page(
>>   
>>   	if (IS_DAX(inode))
>>   		return dax_truncate_page(inode, pos, did_zero,
>> -					&xfs_direct_write_iomap_ops);
>> +					&xfs_dax_write_iomap_ops);
>>   	return iomap_truncate_page(inode, pos, did_zero,
>>   				   &xfs_buffered_write_iomap_ops);
>>   }
>> -- 
>> 2.38.1
>>
