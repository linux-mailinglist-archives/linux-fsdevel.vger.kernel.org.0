Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B743B510E35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 03:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiD0Bpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 21:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbiD0Bpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:45:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77264338B4
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 18:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651023745; x=1682559745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eQ7XBnug6z28Gc0LOiGVTTqObhpPTVEc1gKirvGGTx4=;
  b=o/Jv0a8o//sN49mD8+fJCQEPWChKx658R3iy99vvSW5QQe+TvirhVWAk
   dKfZIavRS10e9KTCoSSC52UD5sRVFxZ1UOivXpalYEnl4I460R2I5fFga
   b5mn0j5h2mtxMKTVZjwYudy+BkfR7uumiLr8DuMM1qoBLrUxMPeWmOkyG
   wku7262bhKML4QGDSIdN1WZKYj77WYw/kW9RI2j/KyywCh7XL0w6HLZRe
   wQXQErgzKqYvDZO2GEJ+1xQMaOPWBf47XzXCs8B1lhqAcjFR1cIo4b6fS
   E2sflVh9/j/4huYkfNDFQA9/7yLquxSBCcgacp17OUlskKdfjhzMF37IJ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="199800857"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 09:42:22 +0800
IronPort-SDR: qXN+DXvKLNt0bfwwO65JZ+pIwreUpfKiHWPGnskSBzHfRGlrnqAJPnqG3+oKGgnR6xv11dVIed
 1UJ7aymv3ply7g9ymT6Bpv7UWBB4VgG1iw79r2zp1PLN5inCM3O5WbH81Bf66+oZbZy5SBAZpS
 hWv9+F3PSMfAZ3ncoqLliAfTWZzquSYSfbTgeB0OSZSgp/GXfPmPGVgbOH7IjVMa5x9ePAsH12
 /mAk2hunm4l8sBpX6iuyu1aJcJeo0FTG2yUO8RbXjI79JIJenox7CuVJ9WWgzfrA0bcWz0BPwu
 AqegCSWwN5CE7WVL49gMa73/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:12:32 -0700
IronPort-SDR: n1NLd0XTUUgIr5+OKSpm5zQ1gB289UvdfFrG8AgmgOfdE8rnZUTltSUNzj/7Err5KmbfB7oJCl
 Fvx2YOUm/AtM0EeQ7eXCVvrZRfNa/g5Xp7N+0Wvrv70Hwj9SsDQ/UxS2tnMafxbD6cm+c4gxpp
 7u+EgaU6xua3547ImOaSHbQzUOYd0OJJHOr4jQoqYi2zah5Gcx//WTZf7wft2fQPceiNgMaKmw
 WxdS+r0VydkyQ4xo8qihvuU5dWzDPDVjwIuTjCCw7+y/SR6kry5I+QyYCpGX+bEae2gQJ5LOKU
 fTw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:42:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp1hY26q6z1SVnx
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 18:42:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651023737; x=1653615738; bh=eQ7XBnug6z28Gc0LOiGVTTqObhpPTVEc1gK
        irvGGTx4=; b=q5RCzTSzhw7PCoj7EcWmWe0wWvOuSq8N8ONwWocdUau5zScSQGn
        m0Z5PsmSgkhM2iWuDo/u2S109kK6yrpSPIsR4nTauDgKFHfuNET7mnwgTL/1D6VX
        ttI7FeDDGtDf4H+QYqdxgdDNVLoNCREHm5/G7p1e7W6jnIikIN8Rz8V6YWnrDYA2
        2rUxnD2y7//huIjflokbA06ga1XqxN0hhO5VXkCgze1a8zI9PRm6Pl02O6+fhVXX
        UIjjHpTYQJaU32F/g5YaIOL9JKWcX7uUnK4YcpEHVzipR+4sqwEKHl01x8g0W74V
        X8FSzmk4GbrhzzlA/1W2HNtkxhDZwuIrHbA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eSNOw22Av4eS for <linux-fsdevel@vger.kernel.org>;
        Tue, 26 Apr 2022 18:42:17 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp1hK3pPvz1Rvlc;
        Tue, 26 Apr 2022 18:42:09 -0700 (PDT)
Message-ID: <ab926e49-1fe6-fe10-2377-079268bc2d44@opensource.wdc.com>
Date:   Wed, 27 Apr 2022 10:42:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 10/10] fs: add support for copy file range in zonefs
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426102042epcas5p201aa0d9143d7bc650ae7858383b69288@epcas5p2.samsung.com>
 <20220426101241.30100-11-nj.shetty@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-11-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/22 19:12, Nitesh Shetty wrote:
> From: Arnav Dawn <arnav.dawn@samsung.com>
> 
> copy_file_range is implemented using copy offload,
> copy offloading to device is always enabled.
> To disable copy offloading mount with "no_copy_offload" mount option.
> At present copy offload is only used, if the source and destination files
> are on same block device, otherwise copy file range is completed by
> generic copy file range.

Why not integrate copy offload inside generic_copy_file_range() ?

> 
> copy file range implemented as following:
> 	- write pending writes on the src and dest files
> 	- drop page cache for dest file if its conv zone
> 	- copy the range using offload
> 	- update dest file info
> 
> For all failure cases we fallback to generic file copy range
> At present this implementation does not support conv aggregation
> 
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>  fs/zonefs/super.c  | 178 ++++++++++++++++++++++++++++++++++++++++++++-
>  fs/zonefs/zonefs.h |   1 +
>  2 files changed, 178 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index b3b0b71fdf6c..60563b592bf2 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -901,6 +901,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>  	else
>  		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
>  				   &zonefs_write_dio_ops, 0, 0);
> +

Unnecessary white line change.

>  	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
>  	    (ret > 0 || ret == -EIOCBQUEUED)) {
>  		if (ret > 0)
> @@ -1189,6 +1190,171 @@ static int zonefs_file_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +static int zonefs_is_file_size_ok(struct inode *src_inode, struct inode *dst_inode,
> +			   loff_t src_off, loff_t dst_off, size_t len)

This function is badly named. It is not checking if the size of files is
OK, is is checking if the copy offsets are OK.

> +{
> +	loff_t size, endoff;
> +
> +	size = i_size_read(src_inode);
> +	/* Don't copy beyond source file EOF. */
> +	if (src_off + len > size) {
> +		zonefs_err(src_inode->i_sb, "Copy beyond EOF (%llu + %zu > %llu)\n",
> +		     src_off, len, size);
> +		return -EOPNOTSUPP;

Reading beyond EOF returns 0, not an error, for any FS, including zonefs.
So why return an error here ?

> +	}
> +
> +	endoff = dst_off + len;
> +	if (inode_newsize_ok(dst_inode, endoff))
> +		return -EOPNOTSUPP;

This is not EOPNOTSUPP. This is EINVAL since the user is asking for
something that we know will fail due to the unaligned destination.

Furthermore, this code does not consider the zone type for the file. Since
the dest file could be a an aggregated conventional zone file which is
larger than a sequential zone file, this is not using the right limit.
This must be checked against i_max_size of struct zonefs_inode_info.

Note that inode_newsize_ok() must be called with inode->i_mutex held but
you never took that lock.

Also, the dest file could be a conventional zone file used for swap. And
you are not checking that. You have plenty of other checks missing. See
generic_copy_file_checks(). Calling that function should be fine for
zonefs too.

> +
> +
> +	return 0;
> +}
> +static ssize_t __zonefs_send_copy(struct zonefs_inode_info *src_zi, loff_t src_off,
> +				struct zonefs_inode_info *dst_zi, loff_t dst_off, size_t len)

Please rename this zonefs_issue_copy().

> +{
> +	struct block_device *src_bdev = src_zi->i_vnode.i_sb->s_bdev;
> +	struct block_device *dst_bdev = dst_zi->i_vnode.i_sb->s_bdev;
> +	struct range_entry *rlist;
> +	int ret = -EIO;

Initializing ret is not needed.

> +
> +	rlist = kmalloc(sizeof(*rlist), GFP_KERNEL);

No NULL check ?

> +	rlist[0].dst = (dst_zi->i_zsector << SECTOR_SHIFT) + dst_off;
> +	rlist[0].src = (src_zi->i_zsector << SECTOR_SHIFT) + src_off;
> +	rlist[0].len = len;
> +	rlist[0].comp_len = 0;
> +	ret = blkdev_issue_copy(src_bdev, 1, rlist, dst_bdev, GFP_KERNEL);
> +	if (ret) {
> +		if (rlist[0].comp_len != len) {

Pack this condition with the previous if using &&.

> +			ret = rlist[0].comp_len;
> +			kfree(rlist);
> +			return ret;

These 2 lines are not needed, the same is done below.

> +		}
> +	}
> +	kfree(rlist);
> +	return len;

And how do you handle this failing ? Where is zonefs_io_error() called ?
Without a call to that function, there is no way to guarantee that the
destination file state is still in sync with the zone state. This can fail
for all sorts of reasons (e.g. zone went offline), and that needs to be
checked.

> +}
> +static ssize_t __zonefs_copy_file_range(struct file *src_file, loff_t src_off,
> +				      struct file *dst_file, loff_t dst_off,
> +				      size_t len, unsigned int flags)
> +{
> +	struct inode *src_inode = file_inode(src_file);
> +	struct inode *dst_inode = file_inode(dst_file);
> +	struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> +	struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +	struct block_device *src_bdev = src_inode->i_sb->s_bdev;
> +	struct block_device *dst_bdev = dst_inode->i_sb->s_bdev;
> +	struct super_block *src_sb = src_inode->i_sb;
> +	struct zonefs_sb_info *src_sbi = ZONEFS_SB(src_sb);
> +	struct super_block *dst_sb = dst_inode->i_sb;
> +	struct zonefs_sb_info *dst_sbi = ZONEFS_SB(dst_sb);
> +	ssize_t ret = -EIO, bytes;
> +
> +	if (src_bdev != dst_bdev) {
> +		zonefs_err(src_sb, "Copying files across two devices\n");
> +			return -EXDEV;

Weird indentation. And the error message is not needed.
The test can also be simplified to

if (src_inode->i_sb != dst_inode->i_sb)

> +	}
> +
> +	/*
> +	 * Some of the checks below will return -EOPNOTSUPP,
> +	 * which will force a generic copy
> +	 */
> +
> +	if (!(src_sbi->s_mount_opts & ZONEFS_MNTOPT_COPY_FILE)
> +		|| !(dst_sbi->s_mount_opts & ZONEFS_MNTOPT_COPY_FILE))
> +		return -EOPNOTSUPP;

I do not see the point of having this option. See below.

> +
> +	/* Start by sync'ing the source and destination files ifor conv zones */
> +	if (src_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +		ret = file_write_and_wait_range(src_file, src_off, (src_off + len));
> +		if (ret < 0) {
> +			zonefs_err(src_sb, "failed to write source file (%zd)\n", ret);
> +			goto out;
> +		}
> +	}
> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +		ret = file_write_and_wait_range(dst_file, dst_off, (dst_off + len));
> +		if (ret < 0) {
> +			zonefs_err(dst_sb, "failed to write destination file (%zd)\n", ret);
> +			goto out;
> +		}
> +	}

And what about inode_dio_wait() for sequential dst file ? Not needed ?

> +	mutex_lock(&dst_zi->i_truncate_mutex);
> +	if (len > dst_zi->i_max_size - dst_zi->i_wpoffset) {
> +		/* Adjust length */
> +		len -= dst_zi->i_max_size - dst_zi->i_wpoffset;
> +		if (len <= 0) {
> +			mutex_unlock(&dst_zi->i_truncate_mutex);
> +			return -EOPNOTSUPP;

If len is 0, return 0.

> +		}
> +	}
> +	if (dst_off != dst_zi->i_wpoffset) {
> +		mutex_unlock(&dst_zi->i_truncate_mutex);
> +		return -EOPNOTSUPP; /* copy not at zone write ptr */

This must be an EINVAL. See zonefs_file_dio_write().
The condition is also invalid since the file can be a conventional zone
file which allows to write anywhere. Did you really test this code properly ?

> +	}
> +	mutex_lock(&src_zi->i_truncate_mutex);
> +	ret = zonefs_is_file_size_ok(src_inode, dst_inode, src_off, dst_off, len);
> +	if (ret < 0) {
> +		mutex_unlock(&src_zi->i_truncate_mutex);
> +		mutex_unlock(&dst_zi->i_truncate_mutex);
> +		goto out;
> +	}
> +	mutex_unlock(&src_zi->i_truncate_mutex);
> +
> +	/* Drop dst file cached pages for a conv zone*/
> +	if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +		ret = invalidate_inode_pages2_range(dst_inode->i_mapping,
> +						    dst_off >> PAGE_SHIFT,
> +						    (dst_off + len) >> PAGE_SHIFT);
> +		if (ret < 0) {
> +			zonefs_err(dst_sb, "Failed to invalidate inode pages (%zd)\n", ret);
> +			ret = 0;

And you still go on ? That will corrupt data. No way. This error must be
returned to fail the copy.

> +		}
> +	}
> +	bytes = __zonefs_send_copy(src_zi, src_off, dst_zi, dst_off, len);
> +	ret += bytes;

You cannot hold i_truncate_mutex while doing IOs because if there is an
error, there will be a deadlock. Also, __zonefs_send_copy() can return an
error and that is not checked.

> +
> +	file_update_time(dst_file);
> +	zonefs_update_stats(dst_inode, dst_off + bytes);
> +	zonefs_i_size_write(dst_inode, dst_off + bytes);
> +	dst_zi->i_wpoffset += bytes;
> +	mutex_unlock(&dst_zi->i_truncate_mutex);
> +
> +
> +

2 extra uneeded blank lines.

> +	/*
> +	 * if we still have some bytes left, do splice copy
> +	 */

This comment fits on a single line.

> +	if (bytes && (bytes < len)) {
> +		zonefs_info(src_sb, "Final partial copy of %zu bytes\n", len);
> +		bytes = do_splice_direct(src_file, &src_off, dst_file,
> +					 &dst_off, len, flags);

And this can fail because other writes may be coming in since you never
locked inode->i_mutex.

> +		if (bytes > 0)
> +			ret += bytes;
> +		else
> +			zonefs_info(src_sb, "Failed partial copy (%zd)\n", bytes);

Error message not needed.

> +	}
> +
> +out:
> +
> +	return ret;
> +}
> +
> +static ssize_t zonefs_copy_file_range(struct file *src_file, loff_t src_off,
> +				    struct file *dst_file, loff_t dst_off,
> +				    size_t len, unsigned int flags)
> +{
> +	ssize_t ret;
> +
> +	ret = __zonefs_copy_file_range(src_file, src_off, dst_file, dst_off,
> +				     len, flags);
> +

Useless blank line. __zonefs_copy_file_range() needs to be split into
zonefs_copy_file_checks() and zonefs_copy_file(). The below call to
generic_copy_file_range() should go into zonefs_copy_file().
zonefs_copy_file() calling either generic_copy_file_range() if the device
does not have copy offload or zonefs_issue_copy() if it does.

> +	if (ret == -EOPNOTSUPP || ret == -EXDEV)> +		ret = generic_copy_file_range(src_file, src_off, dst_file,
> +					      dst_off, len, flags);

This function is not taking the inode_lock() for source and est files.
This means that this can run with concurent regular writes and truncate
and that potentially can result in some very weird results, unaligned
write errors and the FS going read-only.


> +	return ret;
> +}
> +
>  static const struct file_operations zonefs_file_operations = {
>  	.open		= zonefs_file_open,
>  	.release	= zonefs_file_release,
> @@ -1200,6 +1366,7 @@ static const struct file_operations zonefs_file_operations = {
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.iopoll		= iocb_bio_iopoll,
> +	.copy_file_range = zonefs_copy_file_range,
>  };
>  
>  static struct kmem_cache *zonefs_inode_cachep;
> @@ -1262,7 +1429,7 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  
>  enum {
>  	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
> -	Opt_explicit_open, Opt_err,
> +	Opt_explicit_open, Opt_no_copy_offload, Opt_err,

This mount option does not make much sense. Copy file range was not
supported until now. Existing applications are thus not using it. Adding
support for copy_file_range op will not break these applications so it can
be unconditionally supported.


>  };
>  
>  static const match_table_t tokens = {
> @@ -1271,6 +1438,7 @@ static const match_table_t tokens = {
>  	{ Opt_errors_zol,	"errors=zone-offline"},
>  	{ Opt_errors_repair,	"errors=repair"},
>  	{ Opt_explicit_open,	"explicit-open" },
> +	{ Opt_no_copy_offload,	"no_copy_offload" },
>  	{ Opt_err,		NULL}
>  };
>  
> @@ -1280,6 +1448,7 @@ static int zonefs_parse_options(struct super_block *sb, char *options)
>  	substring_t args[MAX_OPT_ARGS];
>  	char *p;
>  
> +	sbi->s_mount_opts |= ZONEFS_MNTOPT_COPY_FILE;
>  	if (!options)
>  		return 0;
>  
> @@ -1310,6 +1479,9 @@ static int zonefs_parse_options(struct super_block *sb, char *options)
>  		case Opt_explicit_open:
>  			sbi->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
>  			break;
> +		case Opt_no_copy_offload:
> +			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_COPY_FILE;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1330,6 +1502,8 @@ static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",errors=zone-offline");
>  	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_REPAIR)
>  		seq_puts(seq, ",errors=repair");
> +	if (sbi->s_mount_opts & ZONEFS_MNTOPT_COPY_FILE)
> +		seq_puts(seq, ",copy_offload");
>  
>  	return 0;
>  }
> @@ -1769,6 +1943,8 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	atomic_set(&sbi->s_active_seq_files, 0);
>  	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
>  
> +	/* set copy support by default */
> +	sbi->s_mount_opts |= ZONEFS_MNTOPT_COPY_FILE;
>  	ret = zonefs_read_super(sb);
>  	if (ret)
>  		return ret;
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> index 4b3de66c3233..efa6632c4b6a 100644
> --- a/fs/zonefs/zonefs.h
> +++ b/fs/zonefs/zonefs.h
> @@ -162,6 +162,7 @@ enum zonefs_features {
>  	(ZONEFS_MNTOPT_ERRORS_RO | ZONEFS_MNTOPT_ERRORS_ZRO | \
>  	 ZONEFS_MNTOPT_ERRORS_ZOL | ZONEFS_MNTOPT_ERRORS_REPAIR)
>  #define ZONEFS_MNTOPT_EXPLICIT_OPEN	(1 << 4) /* Explicit open/close of zones on open/close */
> +#define ZONEFS_MNTOPT_COPY_FILE		(1 << 5) /* enable copy file range offload to kernel */
>  
>  /*
>   * In-memory Super block information.


-- 
Damien Le Moal
Western Digital Research
