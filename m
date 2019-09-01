Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E06A4895
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfIAJeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 05:34:20 -0400
Received: from sonic309-24.consmr.mail.ir2.yahoo.com ([77.238.179.82]:46675
        "EHLO sonic309-24.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfIAJeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 05:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567330457; bh=g5yXQHB7Kk7HxHhwVdFwXodQM6FzAGkXnqqWXk4trBI=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=JIzevFkam3l4stg2GlqDuqnfDI7FUSI/l+S+Vdv996FVDNE9t+WuGOS6iEZpf0CqN7GGOVkeMAaQtN5JizN4jf5V7Y94Dolktuy9cy167AE680PAv4KfTAmvBVFgPx760FUrEZNUm32zSc22IZLOPuEDs1Ns7hhv1FmUivxhhIS8TqmSrBN5ciSX9FEMPFRF7EtM/TzmMc23AZV2lJaHppKRP/lddx3LHFYuZrRBnl5LN4qDrXnt1RlnATPqikOeZf0bR5VuBdeJ6qQdr/y/Hhd6cQaQG9lqniY8wAwPhah2CB5y5nCg3mx8n46YBNNzT+uVxE3Zmm0CjXIJHJQiQg==
X-YMail-OSG: MFKWzecVM1nIgYnVH80CIQ4xBkj5jYivDMSXEJi57RJCecPkngTHFdDiebUwhG1
 U9ylqANRuSks3o7j6SCMpkLGPkiRWvkpSnju_wKXN10x6O.zMqBlMGYACVjc372pUCNp8z4nfB.H
 kmdZDGzcJt5q62QwD0o04hFwQrUqPI.6NX7s6h29J8gBzQjppXU4oG1x48V7_8mD0FV9qyG4Ya3b
 R1BY3gbGDrik7THCRzafihFAaadBNAUZ4mGK8DO76Kld7yGZy4di3izpC5qusnmjHCVq72a2wUrx
 Sfb0f4SpzNY464s1QFYf7.rJMyvu3aYmx8ijWIt6JNd2CsKWvlg9PXG2E80GZkXo1hE763ojFxwA
 oiePU6CzJQgEEbT.MVp7uPmqbwJyTY6n9MXXW5n7E95B5VNKlDbFyb.qre9G2O_pIauxeejtmdwz
 dlahIwIt7dTYFkpuBfRIMXEhgdb6S9Kgq6a4SGjLKJ90yjnDOVd3TCrGjDSfmeZAbKZGCJUdj.mM
 B9KzKDEJuLgtyGSX2iCFWo__uPwyD0wxeaCNYt4vllMk9ghHCLh_1Z9SkjeVWdUqTYQN7Y0BXInV
 tS._MDOlCbZahW7_IzJ1MgSa3kxU3D2ind7oBsmKr4mJiEA6XCpyrOvTLH.VbsNVeekyLOx6n61_
 aLhyu6_tOG3Sm8AlbIi_VBh9tvWenVqV6RZKZ2zNQp.H8y5UU7KVvMgzXLPEV_q07YLk8GhW9_KW
 NPkUCauRe.XTdnSzRKfzVOlLIrjr8tR7FwVaftcxq8RnAGqQ43YF9MPuaKjLv7wqsp043v6DV4R.
 52WRAWwzaztNHrBkXIUZLj9MjbHjQ5OvkVZn6A2hrW3UKs6Imp_AzmQ2q4OmzTmxMKREv6tiZgTc
 .iMK1fpJFOGIwGK0gz0CkDduBIepZYzMBAAQbT8R1fL.h7mzDFrmMfM1XvfxgBZlPx.X9FRIJiW_
 fHkOMbcaSziSyxS1QLVHbLZTe8vKt83Ak3MdF_F4KIFFKTWaQHQJXuH5yB7ZgiCmcE2RDpqLK3.1
 diWFvNPmmjDSIAOxwYKq070rkR0jd4ZxKam0.3mxKFGqAmWzf617XQzZZWwpyvwxMgiUzzZ3Updg
 0wZDss_oYd.6F1bUDnYaZhxwAVbg8R4pZf2yRgvDpFdupy1h72fHW8LpqeLlMqQu_mNSNWh59bQy
 vbv8f1lfaW3qhUgad9sTI5ZvRIGvRmEJOc9ok_bxrAO_VifkxmGARVaTr4h4W2STwFp9WrKEu0gF
 Tlm66cffmzd2uVxlqkJZJBa37Kk.1IMKyM_AG3Twu2Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Sep 2019 09:34:17 +0000
Received: by smtp419.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd0865617b38edab24fbf9714f9b2201;
          Sun, 01 Sep 2019 09:34:13 +0000 (UTC)
Date:   Sun, 1 Sep 2019 17:34:00 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829102426.GE20598@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

Here are redo-ed comments of your suggestions...

On Thu, Aug 29, 2019 at 03:24:26AM -0700, Christoph Hellwig wrote:
> On Fri, Aug 02, 2019 at 08:53:28PM +0800, Gao Xiang wrote:
> > This adds core functions to get, read an inode.
> > It adds statx support as well.
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> >  fs/erofs/inode.c | 291 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 291 insertions(+)
> >  create mode 100644 fs/erofs/inode.c
> > 
> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > new file mode 100644
> > index 000000000000..b6ea997bc4ae
> > --- /dev/null
> > +++ b/fs/erofs/inode.c
> > @@ -0,0 +1,291 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * linux/fs/erofs/inode.c
> > + *
> > + * Copyright (C) 2017-2018 HUAWEI, Inc.
> > + *             http://www.huawei.com/
> > + * Created by Gao Xiang <gaoxiang25@huawei.com>
> > + */
> > +#include "internal.h"
> > +
> > +#include <trace/events/erofs.h>
> > +
> > +/* no locking */
> > +static int read_inode(struct inode *inode, void *data)
> > +{
> > +	struct erofs_vnode *vi = EROFS_V(inode);
> > +	struct erofs_inode_v1 *v1 = data;
> > +	const unsigned int advise = le16_to_cpu(v1->i_advise);
> > +	erofs_blk_t nblks = 0;
> > +
> > +	vi->datamode = __inode_data_mapping(advise);
> 
> What is the deal with these magic underscores here and various
> other similar helpers?

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-17-hsiangkao@aol.com/

underscores means 'internal' in my thought, it seems somewhat
some common practice of Linux kernel, or some recent discussions
about it?... I didn't notice these discussions...

> 
> > +	/* fast symlink (following ext4) */
> 
> This actually originates in FFS.  But it is so common that the comment
> seems a little pointless.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-9-hsiangkao@aol.com/

> 
> > +	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
> > +		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
> 
> Please just use plain kmalloc everywhere and let the normal kernel
> error injection code take care of injeting any errors.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-20-hsiangkao@aol.com/

> 
> > +		/* inline symlink data shouldn't across page boundary as well */
> 
> ... should not cross ..

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-9-hsiangkao@aol.com/

> 
> > +		if (unlikely(m_pofs + inode->i_size > PAGE_SIZE)) {
> > +			DBG_BUGON(1);
> > +			kfree(lnk);
> > +			return -EIO;
> > +		}
> > +
> > +		/* get in-page inline data */
> 
> s/get/copy/, but the comment seems rather pointless.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-9-hsiangkao@aol.com/

> 
> > +		memcpy(lnk, data + m_pofs, inode->i_size);
> > +		lnk[inode->i_size] = '\0';
> > +
> > +		inode->i_link = lnk;
> > +		set_inode_fast_symlink(inode);
> 
> Please just set the ops directly instead of obsfucating that in a single
> caller, single line inline function.  And please set it instead of the
> normal symlink iops in the same place where you also set those.:w

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-10-hsiangkao@aol.com/

> 
> > +	err = read_inode(inode, data + ofs);
> > +	if (!err) {
> 
> 	if (err)
> 		goto out_unlock;
> 
> .. and save one level of indentation.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-22-hsiangkao@aol.com/

> 
> > +		if (is_inode_layout_compression(inode)) {
> 
> The name of this helper is a little odd.  But I think just
> opencoding it seems generally cleaner anyway.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-11-hsiangkao@aol.com/

> 
> 
> > +			err = -ENOTSUPP;
> > +			goto out_unlock;
> > +		}
> > +
> > +		inode->i_mapping->a_ops = &erofs_raw_access_aops;
> > +
> > +		/* fill last page if inline data is available */
> > +		err = fill_inline_data(inode, data, ofs);
> 
> Well, I think you should move the is_inode_flat_inline and
> (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) checks from that
> helper here, as otherwise you make everyone wonder why you'd always
> fill out the inline data.

fill_inline_data is killed, and the similar function turns into
erofs_fill_symlink which is called at erofs_fill_inode():

 		case S_IFLNK:
-			/* by default, page_get_link is used for symlink */
-			inode->i_op = &erofs_symlink_iops;
+			err = erofs_fill_symlink(inode, data, ofs);
+			if (err)
+				goto out_unlock;
 			inode_nohighmem(inode);
 			break;

> 
> > +static inline struct inode *erofs_iget_locked(struct super_block *sb,
> > +					      erofs_nid_t nid)
> > +{
> > +	const unsigned long hashval = erofs_inode_hash(nid);
> > +
> > +#if BITS_PER_LONG >= 64
> > +	/* it is safe to use iget_locked for >= 64-bit platform */
> > +	return iget_locked(sb, hashval);
> > +#else
> > +	return iget5_locked(sb, hashval, erofs_ilookup_test_actor,
> > +		erofs_iget_set_actor, &nid);
> > +#endif
> 
> Just use the slightly more complicated 32-bit version everywhere so that
> you have a single actually tested code path.  And then remove this
> helper.

As I said before, 64-bit platforms is common currently,
I think iget_locked is enough.
https://lore.kernel.org/r/20190830184606.GA175612@architecture4/

Thanks,
Gao Xiang



