Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878734107A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 18:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhIRQz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 12:55:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233364AbhIRQz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 12:55:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18IASiYX021290;
        Sat, 18 Sep 2021 12:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=YW0WlFmDdgAP+YgdhIiGXxcxq+Unhv4vQBk2rQWAFr4=;
 b=djEELMw0gJKF2g+OM5WEilOnBJT16iWtwGUFztASiE7ZnBPycu+QZcd2GE9eJfFXA98z
 xji4qfmkTQFpOGmnHGLBR24l3gFh/oibcPsK67/R5eMUJ7dIPFqFxLbXZg6TcgrBYDFO
 Z6tbJs2ZHpqx4bCNNKHu/s4k/nCsJ6vAOxtIe/fhCnYKsL+iSGc9G3Xia2sclBtdUU5Q
 GBERnad9od9/+kUM35lSppN3Ik4VI5q9F9qWEuqul2CtaisJYuXh/1Um75n44749uPsV
 SupXS1T/2u3ICRd48vKobFcjVwd3QqsYyHL9SDpoqi9fMT5Ai4lm/fy2B5skYsdVbS7i 4w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b5ed5m8p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 12:54:14 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18IGrKcE021568;
        Sat, 18 Sep 2021 16:54:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3b57chu9su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 16:54:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18IGsAMR26542504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 16:54:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EACB342041;
        Sat, 18 Sep 2021 16:54:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 641C94203F;
        Sat, 18 Sep 2021 16:54:09 +0000 (GMT)
Received: from localhost (unknown [9.43.63.221])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 18 Sep 2021 16:54:09 +0000 (GMT)
Date:   Sat, 18 Sep 2021 22:24:08 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] dax: prepare pmem for use by zero-initializing
 contents and clearing poisons
Message-ID: <20210918165408.ivsue463wpiitzjw@riteshh-domain>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865031.417973.8372869475521627214.stgit@magnolia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192865031.417973.8372869475521627214.stgit@magnolia>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EWQmT9x7WJhBj_V-3LC6neoilMZHugjU
X-Proofpoint-ORIG-GUID: EWQmT9x7WJhBj_V-3LC6neoilMZHugjU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-18_05,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109180117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/17 06:30PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> Our current "advice" to people using persistent memory and FSDAX who
> wish to recover upon receipt of a media error (aka 'hwpoison') event
> from ACPI is to punch-hole that part of the file and then pwrite it,
> which will magically cause the pmem to be reinitialized and the poison
> to be cleared.
>
> Punching doesn't make any sense at all -- the (re)allocation on pwrite
> does not permit the caller to specify where to find blocks, which means
> that we might not get the same pmem back.  This pushes the user farther
> away from the goal of reinitializing poisoned memory and leads to
> complaints about unnecessary file fragmentation.
>
> AFAICT, the only reason why the "punch and write" dance works at all is
> that the XFS and ext4 currently call blkdev_issue_zeroout when
> allocating pmem ahead of a write call.  Even a regular overwrite won't
> clear the poison, because dax_direct_access is smart enough to bail out
> on poisoned pmem, but not smart enough to clear it.  To be fair, that
> function maps pages and has no idea what kinds of reads and writes the
> caller might want to perform.
>
> Therefore, create a dax_zeroinit_range function that filesystems can to
> reset the pmem contents to zero and clear hardware media error flags.
> This uses the dax page zeroing helper function, which should ensure that
> subsequent accesses will not trip over any pre-existing media errors.

Thanks Darrick for such clear explaination of the problem and your solution.
As I see from this thread [1], it looks like we are heading in this direction,
so I thought of why not review this RFC patch series :)

[1]: https://lore.kernel.org/all/CAPcyv4iAr_Vwwgqw+4wz0RQUXhUUJGGz7_T+p+W6tC4T+k+zNw@mail.gmail.com/

>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/dax.c            |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dax.h |    7 ++++
>  2 files changed, 100 insertions(+)
>
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 4e3e5a283a91..765b80d08605 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1714,3 +1714,96 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  	return dax_insert_pfn_mkwrite(vmf, pfn, order);
>  }
>  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> +
> +static loff_t
> +dax_zeroinit_iter(struct iomap_iter *iter)
> +{
> +	struct iomap *iomap = &iter->iomap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const u64 start = iomap->addr + iter->pos - iomap->offset;
> +	const u64 nr_bytes = iomap_length(iter);
> +	u64 start_page = start >> PAGE_SHIFT;
> +	u64 nr_pages = nr_bytes >> PAGE_SHIFT;
> +	int ret;
> +
> +	if (!iomap->dax_dev)
> +		return -ECANCELED;
> +
> +	/*
> +	 * The physical extent must be page aligned because that's what the dax
> +	 * function requires.
> +	 */
> +	if (!PAGE_ALIGNED(start | nr_bytes))
> +		return -ECANCELED;
> +
> +	/*
> +	 * The dax function, by using pgoff_t, is stuck with unsigned long, so
> +	 * we must check for overflows.
> +	 */
> +	if (start_page >= ULONG_MAX || start_page + nr_pages > ULONG_MAX)
> +		return -ECANCELED;
> +
> +	/* Must be able to zero storage directly without fs intervention. */
> +	if (iomap->flags & IOMAP_F_SHARED)
> +		return -ECANCELED;
> +	if (srcmap != iomap)
> +		return -ECANCELED;
> +
> +	switch (iomap->type) {
> +	case IOMAP_MAPPED:
> +		while (nr_pages > 0) {
> +			/* XXX function only supports one page at a time?! */
> +			ret = dax_zero_page_range(iomap->dax_dev, start_page,
> +					1);
> +			if (ret)
> +				return ret;
> +			start_page++;
> +			nr_pages--;
> +		}
> +
> +		fallthrough;
> +	case IOMAP_UNWRITTEN:
> +		return nr_bytes;
> +	}
> +
> +	/* Reject holes, inline data, or delalloc extents. */
> +	return -ECANCELED;

We reject holes here, but the other vfs plumbing patch [2] mentions
"Holes and unwritten extents are left untouched.".
Shouldn't we just return nr_bytes for IOMAP_HOLE case as well?

[2]: "vfs: add a zero-initialization mode to fallocate"

Although I am not an expert in this area, but the rest of the patch looks
very well crafted to me. Thanks again for such details :)

-ritesh

>
> +}
> +
> +/*
> + * Initialize storage mapped to a DAX-mode file to a known value and ensure the
> + * media are ready to accept read and write commands.  This requires the use of
> + * the dax layer's zero page range function to write zeroes to a pmem region
> + * and to reset any hardware media error state.
> + *
> + * The physical extents must be aligned to page size.  The file must be backed
> + * by a pmem device.  The extents returned must not require copy on write (or
> + * any other mapping interventions from the filesystem) and must be contiguous.
> + * @done will be set to true if the reset succeeded.
> + *
> + * Returns 0 if the zero initialization succeeded, -ECANCELED if the storage
> + * mappings do not support zero initialization, -EOPNOTSUPP if the device does
> + * not support it, or the usual negative errno.
> + */
> +int
> +dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> +		   const struct iomap_ops *ops)
> +{
> +	struct iomap_iter iter = {
> +		.inode		= inode,
> +		.pos		= pos,
> +		.len		= len,
> +		.flags		= IOMAP_REPORT,
> +	};
> +	int ret;
> +
> +	if (!IS_DAX(inode))
> +		return -EINVAL;
> +	if (pos + len > i_size_read(inode))
> +		return -EINVAL;
> +
> +	while ((ret = iomap_iter(&iter, ops)) > 0)
> +		iter.processed = dax_zeroinit_iter(&iter);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dax_zeroinit_range);
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 2619d94c308d..3c873f7c35ba 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -129,6 +129,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
>  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
> +int dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> +			const struct iomap_ops *ops);
>  #else
>  #define generic_fsdax_supported		NULL
>
> @@ -174,6 +176,11 @@ static inline dax_entry_t dax_lock_page(struct page *page)
>  static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
>  {
>  }
> +static inline int dax_zeroinit_range(struct inode *inode, loff_t pos, u64 len,
> +		const struct iomap_ops *ops)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>
>  #if IS_ENABLED(CONFIG_DAX)
>
