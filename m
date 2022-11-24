Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33F636FE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 02:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKXBcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 20:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXBcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:32:15 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDAB7CB8A
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 17:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669253534; x=1700789534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ica/S8uPZzawejTcseAyPlFWfKZju02n4YiJspQ8f2A=;
  b=npkubMoCR0UQDJjgU+q9SPLoVeCj4ULm5mvLbaHREGVOdu4E5MwnDgJ9
   6YfxmhbxxQdlAakjREpweE8HXYAaUgas+fWvK6DFbBZQuTX4GxHZLYEqX
   2zLGzGZuuoa1mRDT8DTusJqWjLiqnJVDKBvFjhNTWxwG8qaooPYV/TPIh
   mVcqhsQMOmXVaVPw+JuITQF7Cue/bSF6T9l6KTjPQfR7I8Q+RvUJrYVZe
   Ujv64TnzFkpDqE2RJP1l89QvBOgvcn1my7wJLlh0O+2FpBtiz7YkGwJFU
   hCtYtV27CvIXtIdjUwf5jw5sU5TrOu+uvrSQ8TxCTFvZGLTATu0cfOODZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665417600"; 
   d="scan'208";a="329148106"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2022 09:32:13 +0800
IronPort-SDR: Y07Rt88MkuhpT8Qs1e8PVSezRiJ0AiwPBKQrw/31Qrp+sEkRVLeo4/FSfa34qWDW3TYrdsFaDG
 Y24d/OJTRLql6c8CQ1iQC9WpaUszx0zV9F5TI8E6rwwWoh166p6GA0ubObtPCvX7tYiWBeJi+u
 fy5uMxxiQ222zqsg7ItkXX5P0vWBE42W3ZGTHbX5Ukj6l83WvTN+qt9rHVt09kgUizhMopipX8
 xzgOHPv58KYJRHMCHRyJ8NeWGGNjQ4ckO5nlC+XfTslvltLhe7V7db+DB2sRol6nuKOG+Yt5lr
 qg0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 16:51:00 -0800
IronPort-SDR: N+1uiAiFyJ5Ib6/gt0e1a9i+2V4jL4aA0/+py8PebWtoyZ/zoaHYF+HR/pAtLNi1LbBiRsb6cy
 g2s9bfP7LpGMp3BBkTUhSFuejkgrSEjLjyDVD7iPTo2mzEXw0TVNarz2RFpdalHRU7p5vI6gq5
 1zc8ExfU/tH53pgyNEQfhpAg4u8UPZevOaaRQ2QsX14gVwCp+UslCTeLz41oIisxComETEvu6W
 cb22O2SXPlBuIa5ZWn4OUUMWxWHTrlLmluOlIUyJ/ItzlgaA6Kc2FvpCwOah3vKNfW/mHJ5p67
 LEk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 17:32:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NHgTS3k3Hz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 17:32:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669253530; x=1671845531; bh=ica/S8uPZzawejTcseAyPlFWfKZju02n4Yi
        JspQ8f2A=; b=GzqMRl0UShXbYDCj4a6+8IeU1jodBd44ysKFkz88v7CcQN5Hs54
        vZqvbCQ4+MlPOGbUhuzR0K9cRgMwnqEKXyohgtE6ehuUp+gPug8q1Cn6YqGSV8TZ
        UmeDatGFC0xohs161PDLA4csy9V32HPM15T8AhqDB9c+qKkAl5VAWhKOXIVWUvyK
        ePgXBwfLbxZGEJHqWbbWaFmcbDp2vcybdfSIzTs28x/K3iNkhdfeRDqBFlCnWK6Q
        Xq9xfH/GoRy1oaE1nfaNeC/HHiJoPhAtHiZyBNrhBIwLjIq0bd5stZ2oeB4sqEwt
        20SaisiRNML6Yfnwokfun5hqBeDn36+WKZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dCNTaX2MsWpB for <linux-fsdevel@vger.kernel.org>;
        Wed, 23 Nov 2022 17:32:10 -0800 (PST)
Received: from [10.225.163.55] (unknown [10.225.163.55])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NHgTL2TNbz1RvLy;
        Wed, 23 Nov 2022 17:32:06 -0800 (PST)
Message-ID: <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
Date:   Thu, 24 Nov 2022 10:32:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Content-Language: en-US
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221123055827.26996-11-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/23/22 14:58, Nitesh Shetty wrote:
> copy_file_range is implemented using copy offload,
> copy offloading to device is always enabled.
> To disable copy offloading mount with "no_copy_offload" mount option.

And were is the code that handle this option ?

> At present copy offload is only used, if the source and destination files
> are on same block device, otherwise copy file range is completed by
> generic copy file range.
> 
> copy file range implemented as following:
> 	- write pending writes on the src and dest files
> 	- drop page cache for dest file if its conv zone
> 	- copy the range using offload
> 	- update dest file info
> 
> For all failure cases we fallback to generic file copy range

For all cases ? That would be weird. What would be the point of trying to
copy again if e.g. the dest zone has gone offline or read only ?

> At present this implementation does not support conv aggregation

Please check this commit message overall: the grammar and punctuation
could really be improved.

> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/zonefs/super.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index abc9a85106f2..15613433d4ae 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1223,6 +1223,183 @@ static int zonefs_file_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +static int zonefs_is_file_copy_offset_ok(struct inode *src_inode,
> +		struct inode *dst_inode, loff_t src_off, loff_t dst_off,
> +		size_t *len)
> +{
> +	loff_t size, endoff;
> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +
> +	inode_lock(src_inode);
> +	size = i_size_read(src_inode);
> +	inode_unlock(src_inode);
> +	/* Don't copy beyond source file EOF. */
> +	if (src_off < size) {
> +		if (src_off + *len > size)
> +			*len = (size - (src_off + *len));
> +	} else
> +		*len = 0;

Missing curly brackets for the else.

> +
> +	mutex_lock(&dst_zi->i_truncate_mutex);
> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
> +		if (*len > dst_zi->i_max_size - dst_zi->i_wpoffset)
> +			*len -= dst_zi->i_max_size - dst_zi->i_wpoffset;
> +
> +		if (dst_off != dst_zi->i_wpoffset)
> +			goto err;
> +	}
> +	mutex_unlock(&dst_zi->i_truncate_mutex);
> +
> +	endoff = dst_off + *len;
> +	inode_lock(dst_inode);
> +	if (endoff > dst_zi->i_max_size ||
> +			inode_newsize_ok(dst_inode, endoff)) {
> +		inode_unlock(dst_inode);
> +		goto err;

And here truncate mutex is not locked, but goto err will unlock it. This
is broken...

> +	}
> +	inode_unlock(dst_inode);

...The locking is completely broken in this function anyway. You take the
lock, look at something, then release the lock. Then what if a write or a
trunctate comes in when the inode is not locked ? This is completely
broken. The inode should be locked with no dio pending when this function
is called. This is only to check if everything is ok. This has no business
playing with the inode and truncate locks.

> +
> +	return 0;
> +err:
> +	mutex_unlock(&dst_zi->i_truncate_mutex);
> +	return -EINVAL;
> +}
> +
> +static ssize_t zonefs_issue_copy(struct zonefs_inode_info *src_zi,
> +		loff_t src_off, struct zonefs_inode_info *dst_zi,
> +		loff_t dst_off, size_t len)
> +{
> +	struct block_device *src_bdev = src_zi->i_vnode.i_sb->s_bdev;
> +	struct block_device *dst_bdev = dst_zi->i_vnode.i_sb->s_bdev;
> +	struct range_entry *rlist = NULL;
> +	int ret = len;
> +
> +	rlist = kmalloc(sizeof(*rlist), GFP_KERNEL);

GFP_NOIO ?

> +	if (!rlist)
> +		return -ENOMEM;
> +
> +	rlist[0].dst = (dst_zi->i_zsector << SECTOR_SHIFT) + dst_off;
> +	rlist[0].src = (src_zi->i_zsector << SECTOR_SHIFT) + src_off;
> +	rlist[0].len = len;
> +	rlist[0].comp_len = 0;
> +	ret = blkdev_issue_copy(src_bdev, dst_bdev, rlist, 1, NULL, NULL,
> +			GFP_KERNEL);
> +	if (rlist[0].comp_len > 0)
> +		ret = rlist[0].comp_len;
> +	kfree(rlist);
> +
> +	return ret;
> +}
> +
> +/* Returns length of possible copy, else returns error */
> +static ssize_t zonefs_copy_file_checks(struct file *src_file, loff_t src_off,
> +					struct file *dst_file, loff_t dst_off,
> +					size_t *len, unsigned int flags)
> +{
> +	struct inode *src_inode = file_inode(src_file);
> +	struct inode *dst_inode = file_inode(dst_file);
> +	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +	ssize_t ret;
> +
> +	if (src_inode->i_sb != dst_inode->i_sb)
> +		return -EXDEV;
> +
> +	/* Start by sync'ing the source and destination files for conv zones */
> +	if (src_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +		ret = file_write_and_wait_range(src_file, src_off,
> +				(src_off + *len));
> +		if (ret < 0)
> +			goto io_error;
> +	}
> +	inode_dio_wait(src_inode);

That is not a "check". So having this in a function called
zonefs_copy_file_checks() is a little strange.

> +
> +	/* Start by sync'ing the source and destination files ifor conv zones */

Same comment repeated, with typos.

> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +		ret = file_write_and_wait_range(dst_file, dst_off,
> +				(dst_off + *len));
> +		if (ret < 0)
> +			goto io_error;
> +	}
> +	inode_dio_wait(dst_inode);
> +
> +	/* Drop dst file cached pages for a conv zone*/
> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +		ret = invalidate_inode_pages2_range(dst_inode->i_mapping,
> +				dst_off >> PAGE_SHIFT,
> +				(dst_off + *len) >> PAGE_SHIFT);
> +		if (ret < 0)
> +			goto io_error;
> +	}
> +
> +	ret = zonefs_is_file_copy_offset_ok(src_inode, dst_inode, src_off,
> +			dst_off, len);
> +	if (ret < 0)

if (ret)

> +		return ret;
> +
> +	return *len;
> +
> +io_error:
> +	zonefs_io_error(dst_inode, true);
> +	return ret;
> +}
> +
> +static ssize_t zonefs_copy_file(struct file *src_file, loff_t src_off,
> +		struct file *dst_file, loff_t dst_off,
> +		size_t len, unsigned int flags)
> +{
> +	struct inode *src_inode = file_inode(src_file);
> +	struct inode *dst_inode = file_inode(dst_file);
> +	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +	ssize_t ret = 0, bytes;
> +
> +	inode_lock(src_inode);
> +	inode_lock(dst_inode);

So you did zonefs_copy_file_checks() outside of these locks, which mean
that everything about the source and destination files may have changed.
This does not work.

> +	bytes = zonefs_issue_copy(src_zi, src_off, dst_zi, dst_off, len);
> +	if (bytes < 0)
> +		goto unlock_exit;
> +
> +	ret += bytes;
> +
> +	file_update_time(dst_file);
> +	mutex_lock(&dst_zi->i_truncate_mutex);
> +	zonefs_update_stats(dst_inode, dst_off + bytes);
> +	zonefs_i_size_write(dst_inode, dst_off + bytes);
> +	dst_zi->i_wpoffset += bytes;

This is wierd. iszie for dst will be dst_zi->i_wpoffset. So please do:

	dst_zi->i_wpoffset += bytes;
	zonefs_i_size_write(dst_inode, dst_zi->i_wpoffset);

> +	mutex_unlock(&dst_zi->i_truncate_mutex);

And you are not taking care of the accounting for active zones here. If
the copy made the dst zone full, it is not active anymore. You need to
call zonefs_account_active();

> +	/* if we still have some bytes left, do splice copy */
> +	if (bytes && (bytes < len)) {
> +		bytes = do_splice_direct(src_file, &src_off, dst_file,
> +					 &dst_off, len, flags);

No way.

> +		if (bytes > 0)
> +			ret += bytes;
> +	}
> +unlock_exit:
> +	if (ret < 0)
> +		zonefs_io_error(dst_inode, true);

How can you be sure that you even did an IO when you get an error ?
zonefs_issue_copy() may have failed on its kmalloc() and no IO was done.

> +	inode_unlock(src_inode);
> +	inode_unlock(dst_inode);
> +	return ret;
> +}
> +
> +static ssize_t zonefs_copy_file_range(struct file *src_file, loff_t src_off,
> +				      struct file *dst_file, loff_t dst_off,
> +				      size_t len, unsigned int flags)
> +{
> +	ssize_t ret = -EIO;

This does not need to be initialized.

> +
> +	ret = zonefs_copy_file_checks(src_file, src_off, dst_file, dst_off,
> +				     &len, flags);

These checks need to be done for the generic implementation too, no ? Why
would checking this automatically trigger the offload ? What if the device
does not support offloading ?

> +	if (ret > 0)
> +		ret = zonefs_copy_file(src_file, src_off, dst_file, dst_off,
> +				     len, flags);

return here, then no need for the else. But see above. This seems all
broken to me.

> +	else if (ret < 0 && ret == -EXDEV)
> +		ret = generic_copy_file_range(src_file, src_off, dst_file,
> +					      dst_off, len, flags);
> +	return ret;
> +}
> +
>  static const struct file_operations zonefs_file_operations = {
>  	.open		= zonefs_file_open,
>  	.release	= zonefs_file_release,
> @@ -1234,6 +1411,7 @@ static const struct file_operations zonefs_file_operations = {
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.iopoll		= iocb_bio_iopoll,
> +	.copy_file_range = zonefs_copy_file_range,
>  };
>  
>  static struct kmem_cache *zonefs_inode_cachep;
> @@ -1804,6 +1982,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	atomic_set(&sbi->s_active_seq_files, 0);
>  	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
>  
> +	/* set copy support by default */

What is this comment supposed to be for ?

>  	ret = zonefs_read_super(sb);
>  	if (ret)
>  		return ret;

-- 
Damien Le Moal
Western Digital Research

