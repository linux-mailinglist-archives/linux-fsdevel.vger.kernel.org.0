Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45E636FFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 02:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKXBsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 20:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKXBsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:48:06 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D791DEE22
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 17:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669254484; x=1700790484;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=N2FhLLtnNgmNj+JO4Jpf49iCpELlXJhmTuTgmijgAec=;
  b=ZShXNS5wv3BtEjtTLZ8g4R9f2H8ORIPDBv5u9m/0AT7S52vp6geM7knW
   YSrayOA+3SnJBCjz+x34G9/GKn+dy+rcOPc7G8sjY/nWg58enOzhL8qv7
   EDXDsq4nU99pURSBbsrufr8ifBnqBSkcsogKq78cPRIbJQeLQ+NjXMxe3
   VAehrPjbkUvdIqTwEl0O7YRIQf7JJLvqNsySFYbC91gAscM53vibOXCGv
   hNJ4jfAtqiKKgGmK1XHkznhHBZIEOYGci34fHLjqiuuJ8n70XNyACMNaJ
   bX1ToLq7DdtVcal75gQB4Z1t72xdEK/qykvH/q4dy3stpc78ZTn2LCNFQ
   w==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665417600"; 
   d="scan'208";a="215291791"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2022 09:48:03 +0800
IronPort-SDR: VmVE4oTgzBpCHWzftLaixAe0g0Qk7SUZgYVH6iqJe4aAvt91L3Hy7a9CeF2ACL0nQAgQoPwG+1
 rk5IGBNnJbzCFp9p2ilqMa1xwOE8B9IR/C/rbuGNIvKg8Q0lcFHN/gwu/Rzh8DJHKZm/7NkV7P
 h9AO2XlCJH3/661mVirRuUQt54rJ5EOcSrlq/qzq/Rznm/C6kBMXvqZB8Xa5LGA3gwzJMd0aQe
 atrzxcPKe6O67Fwb3xKOtvmH8q3GFyx5CLYdEukdfPeLVWV6Ca+BMk/egx5ON6f2jQ8QGr4pNm
 lo0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 17:06:50 -0800
IronPort-SDR: kF4ykB1uS2NCW0hma58uTaEo47BfeU9tAQMHyCy/HMF/0yufS+GOqFJ7rGag8SdvFdD8QZOfoO
 iq5ItxN7Nk7FKp0Dm0n1e5Mw6DDT7GxkwZxzAqdkE+ZUYP3HbOujmFEIVO+HbniaFoEU/dQeXX
 ISbiVVnyoYjrrH0iqnbST2Bw4K2TeYr5FkvjisMREmeT/+3sQfWvbxa7w/SSJfzaHwmPKluNDS
 0Y1QYnCVgMHFkOxl35MgWD/+aeobbHR/lxneTC7SHzaZpZ4V7qkaH4Wf0QYUmmDRe1u3qmOfiA
 ocg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 17:48:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NHgql3jTJz1Rwt8
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 17:48:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669254480; x=1671846481; bh=N2FhLLtnNgmNj+JO4Jpf49iCpELlXJhmTuT
        gmijgAec=; b=YHoTm+dkvFiXcokW5oA423bAdkL6utRZKwmbtgN62IenxWVhbBs
        J9nWrFX10pCN9ltqb+SFTad22/y1UftQLYMCX2Ei+2gjFWN7GF1m7aGG7PQel8ba
        5CupV61RMVVsYLlJAnftpYnmuglGYpwjKHfAlOd6UhHG/WazA5sVUE7Tgfzg1jsN
        Mxv6/1wdGzjTxM1YPr53bDyDzzjo6G43N/wZzhHCaELmI7goonffi+kllNbpZPhT
        zuFPWD/NjAQMPEOfcU1qOokdhLqzPtnSchvQpLG+nn2fnJ+0Jxma9bVTaYZ9at7p
        dElZZYC3eAbiPQzucKP6w8tBkuMunUrkmNw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hOIstQJr2C9l for <linux-fsdevel@vger.kernel.org>;
        Wed, 23 Nov 2022 17:48:00 -0800 (PST)
Received: from [10.225.163.55] (unknown [10.225.163.55])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NHgqc3Zlkz1RvLy;
        Wed, 23 Nov 2022 17:47:56 -0800 (PST)
Message-ID: <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
Date:   Thu, 24 Nov 2022 10:47:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        james.smart@broadcom.com, kch@nvidia.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-11-nj.shetty@samsung.com>
 <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/22 10:32, Damien Le Moal wrote:
> On 11/23/22 14:58, Nitesh Shetty wrote:
>> copy_file_range is implemented using copy offload,
>> copy offloading to device is always enabled.
>> To disable copy offloading mount with "no_copy_offload" mount option.
> 
> And were is the code that handle this option ?
> 
>> At present copy offload is only used, if the source and destination files
>> are on same block device, otherwise copy file range is completed by
>> generic copy file range.
>>
>> copy file range implemented as following:
>> 	- write pending writes on the src and dest files
>> 	- drop page cache for dest file if its conv zone
>> 	- copy the range using offload
>> 	- update dest file info
>>
>> For all failure cases we fallback to generic file copy range
> 
> For all cases ? That would be weird. What would be the point of trying to
> copy again if e.g. the dest zone has gone offline or read only ?
> 
>> At present this implementation does not support conv aggregation
> 
> Please check this commit message overall: the grammar and punctuation
> could really be improved.
> 
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>  fs/zonefs/super.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 179 insertions(+)
>>
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>> index abc9a85106f2..15613433d4ae 100644
>> --- a/fs/zonefs/super.c
>> +++ b/fs/zonefs/super.c
>> @@ -1223,6 +1223,183 @@ static int zonefs_file_release(struct inode *inode, struct file *file)
>>  	return 0;
>>  }
>>  
>> +static int zonefs_is_file_copy_offset_ok(struct inode *src_inode,
>> +		struct inode *dst_inode, loff_t src_off, loff_t dst_off,
>> +		size_t *len)
>> +{
>> +	loff_t size, endoff;
>> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
>> +
>> +	inode_lock(src_inode);
>> +	size = i_size_read(src_inode);
>> +	inode_unlock(src_inode);
>> +	/* Don't copy beyond source file EOF. */
>> +	if (src_off < size) {
>> +		if (src_off + *len > size)
>> +			*len = (size - (src_off + *len));
>> +	} else
>> +		*len = 0;
> 
> Missing curly brackets for the else.
> 
>> +
>> +	mutex_lock(&dst_zi->i_truncate_mutex);
>> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
>> +		if (*len > dst_zi->i_max_size - dst_zi->i_wpoffset)
>> +			*len -= dst_zi->i_max_size - dst_zi->i_wpoffset;
>> +
>> +		if (dst_off != dst_zi->i_wpoffset)
>> +			goto err;
>> +	}
>> +	mutex_unlock(&dst_zi->i_truncate_mutex);
>> +
>> +	endoff = dst_off + *len;
>> +	inode_lock(dst_inode);
>> +	if (endoff > dst_zi->i_max_size ||
>> +			inode_newsize_ok(dst_inode, endoff)) {
>> +		inode_unlock(dst_inode);
>> +		goto err;
> 
> And here truncate mutex is not locked, but goto err will unlock it. This
> is broken...
> 
>> +	}
>> +	inode_unlock(dst_inode);
> 
> ...The locking is completely broken in this function anyway. You take the
> lock, look at something, then release the lock. Then what if a write or a
> trunctate comes in when the inode is not locked ? This is completely
> broken. The inode should be locked with no dio pending when this function
> is called. This is only to check if everything is ok. This has no business
> playing with the inode and truncate locks.
> 
>> +
>> +	return 0;
>> +err:
>> +	mutex_unlock(&dst_zi->i_truncate_mutex);
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t zonefs_issue_copy(struct zonefs_inode_info *src_zi,
>> +		loff_t src_off, struct zonefs_inode_info *dst_zi,
>> +		loff_t dst_off, size_t len)
>> +{
>> +	struct block_device *src_bdev = src_zi->i_vnode.i_sb->s_bdev;
>> +	struct block_device *dst_bdev = dst_zi->i_vnode.i_sb->s_bdev;
>> +	struct range_entry *rlist = NULL;
>> +	int ret = len;
>> +
>> +	rlist = kmalloc(sizeof(*rlist), GFP_KERNEL);
> 
> GFP_NOIO ?
> 
>> +	if (!rlist)
>> +		return -ENOMEM;
>> +
>> +	rlist[0].dst = (dst_zi->i_zsector << SECTOR_SHIFT) + dst_off;
>> +	rlist[0].src = (src_zi->i_zsector << SECTOR_SHIFT) + src_off;
>> +	rlist[0].len = len;
>> +	rlist[0].comp_len = 0;
>> +	ret = blkdev_issue_copy(src_bdev, dst_bdev, rlist, 1, NULL, NULL,
>> +			GFP_KERNEL);
>> +	if (rlist[0].comp_len > 0)
>> +		ret = rlist[0].comp_len;
>> +	kfree(rlist);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Returns length of possible copy, else returns error */
>> +static ssize_t zonefs_copy_file_checks(struct file *src_file, loff_t src_off,
>> +					struct file *dst_file, loff_t dst_off,
>> +					size_t *len, unsigned int flags)
>> +{
>> +	struct inode *src_inode = file_inode(src_file);
>> +	struct inode *dst_inode = file_inode(dst_file);
>> +	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
>> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
>> +	ssize_t ret;
>> +
>> +	if (src_inode->i_sb != dst_inode->i_sb)
>> +		return -EXDEV;
>> +
>> +	/* Start by sync'ing the source and destination files for conv zones */
>> +	if (src_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
>> +		ret = file_write_and_wait_range(src_file, src_off,
>> +				(src_off + *len));
>> +		if (ret < 0)
>> +			goto io_error;
>> +	}
>> +	inode_dio_wait(src_inode);
> 
> That is not a "check". So having this in a function called
> zonefs_copy_file_checks() is a little strange.
> 
>> +
>> +	/* Start by sync'ing the source and destination files ifor conv zones */
> 
> Same comment repeated, with typos.
> 
>> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
>> +		ret = file_write_and_wait_range(dst_file, dst_off,
>> +				(dst_off + *len));
>> +		if (ret < 0)
>> +			goto io_error;
>> +	}
>> +	inode_dio_wait(dst_inode);
>> +
>> +	/* Drop dst file cached pages for a conv zone*/
>> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
>> +		ret = invalidate_inode_pages2_range(dst_inode->i_mapping,
>> +				dst_off >> PAGE_SHIFT,
>> +				(dst_off + *len) >> PAGE_SHIFT);
>> +		if (ret < 0)
>> +			goto io_error;
>> +	}
>> +
>> +	ret = zonefs_is_file_copy_offset_ok(src_inode, dst_inode, src_off,
>> +			dst_off, len);
>> +	if (ret < 0)
> 
> if (ret)
> 
>> +		return ret;
>> +
>> +	return *len;
>> +
>> +io_error:
>> +	zonefs_io_error(dst_inode, true);
>> +	return ret;
>> +}
>> +
>> +static ssize_t zonefs_copy_file(struct file *src_file, loff_t src_off,
>> +		struct file *dst_file, loff_t dst_off,
>> +		size_t len, unsigned int flags)
>> +{
>> +	struct inode *src_inode = file_inode(src_file);
>> +	struct inode *dst_inode = file_inode(dst_file);
>> +	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
>> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
>> +	ssize_t ret = 0, bytes;
>> +
>> +	inode_lock(src_inode);
>> +	inode_lock(dst_inode);
> 
> So you did zonefs_copy_file_checks() outside of these locks, which mean
> that everything about the source and destination files may have changed.
> This does not work.

I forgot to mention that locking 2 inodes blindly like this can leads to
deadlocks if another process tries a copy range from dst to src at the
same time (lock order is reversed and so can deadlock).

> 
>> +	bytes = zonefs_issue_copy(src_zi, src_off, dst_zi, dst_off, len);
>> +	if (bytes < 0)
>> +		goto unlock_exit;
>> +
>> +	ret += bytes;
>> +
>> +	file_update_time(dst_file);
>> +	mutex_lock(&dst_zi->i_truncate_mutex);
>> +	zonefs_update_stats(dst_inode, dst_off + bytes);
>> +	zonefs_i_size_write(dst_inode, dst_off + bytes);
>> +	dst_zi->i_wpoffset += bytes;
> 
> This is wierd. iszie for dst will be dst_zi->i_wpoffset. So please do:
> 
> 	dst_zi->i_wpoffset += bytes;
> 	zonefs_i_size_write(dst_inode, dst_zi->i_wpoffset);
> 
>> +	mutex_unlock(&dst_zi->i_truncate_mutex);
> 
> And you are not taking care of the accounting for active zones here. If
> the copy made the dst zone full, it is not active anymore. You need to
> call zonefs_account_active();
> 
>> +	/* if we still have some bytes left, do splice copy */
>> +	if (bytes && (bytes < len)) {
>> +		bytes = do_splice_direct(src_file, &src_off, dst_file,
>> +					 &dst_off, len, flags);
> 
> No way.
> 
>> +		if (bytes > 0)
>> +			ret += bytes;
>> +	}
>> +unlock_exit:
>> +	if (ret < 0)
>> +		zonefs_io_error(dst_inode, true);
> 
> How can you be sure that you even did an IO when you get an error ?
> zonefs_issue_copy() may have failed on its kmalloc() and no IO was done.
> 
>> +	inode_unlock(src_inode);
>> +	inode_unlock(dst_inode);
>> +	return ret;
>> +}
>> +
>> +static ssize_t zonefs_copy_file_range(struct file *src_file, loff_t src_off,
>> +				      struct file *dst_file, loff_t dst_off,
>> +				      size_t len, unsigned int flags)
>> +{
>> +	ssize_t ret = -EIO;
> 
> This does not need to be initialized.
> 
>> +
>> +	ret = zonefs_copy_file_checks(src_file, src_off, dst_file, dst_off,
>> +				     &len, flags);
> 
> These checks need to be done for the generic implementation too, no ? Why
> would checking this automatically trigger the offload ? What if the device
> does not support offloading ?
> 
>> +	if (ret > 0)
>> +		ret = zonefs_copy_file(src_file, src_off, dst_file, dst_off,
>> +				     len, flags);
> 
> return here, then no need for the else. But see above. This seems all
> broken to me.
> 
>> +	else if (ret < 0 && ret == -EXDEV)
>> +		ret = generic_copy_file_range(src_file, src_off, dst_file,
>> +					      dst_off, len, flags);
>> +	return ret;
>> +}
>> +
>>  static const struct file_operations zonefs_file_operations = {
>>  	.open		= zonefs_file_open,
>>  	.release	= zonefs_file_release,
>> @@ -1234,6 +1411,7 @@ static const struct file_operations zonefs_file_operations = {
>>  	.splice_read	= generic_file_splice_read,
>>  	.splice_write	= iter_file_splice_write,
>>  	.iopoll		= iocb_bio_iopoll,
>> +	.copy_file_range = zonefs_copy_file_range,
>>  };
>>  
>>  static struct kmem_cache *zonefs_inode_cachep;
>> @@ -1804,6 +1982,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>>  	atomic_set(&sbi->s_active_seq_files, 0);
>>  	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
>>  
>> +	/* set copy support by default */
> 
> What is this comment supposed to be for ?
> 
>>  	ret = zonefs_read_super(sb);
>>  	if (ret)
>>  		return ret;
> 

-- 
Damien Le Moal
Western Digital Research

