Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADF5237A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 08:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfFYGXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 02:23:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729147AbfFYGXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:23:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P6HAdo024525
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:23:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbcemut4a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:23:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Tue, 25 Jun 2019 07:23:28 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 07:23:25 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P6NOUO52756548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 06:23:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A966AE04D;
        Tue, 25 Jun 2019 06:23:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 848A9AE056;
        Tue, 25 Jun 2019 06:23:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 06:23:22 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V3 1/7] FS: Introduce read callbacks
Date:   Tue, 25 Jun 2019 10:29:42 +0530
Organization: IBM
In-Reply-To: <20190621200355.GA167064@gmail.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com> <20190616160813.24464-2-chandan@linux.ibm.com> <20190621200355.GA167064@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19062506-4275-0000-0000-0000034559C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062506-4276-0000-0000-00003855947F
Message-Id: <3763974.FiHZtjIrND@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday, June 22, 2019 1:33:57 AM IST Eric Biggers wrote:
> Hi Chandan,
> 
> On Sun, Jun 16, 2019 at 09:38:07PM +0530, Chandan Rajendra wrote:
> > Read callbacks implements a state machine to be executed after a
> > buffered read I/O is completed. They help in further processing the file
> > data read from the backing store. Currently, decryption is the only post
> > processing step to be supported.
> > 
> > The execution of the state machine is to be initiated by the endio
> > function associated with the read operation.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/Kconfig                     |   3 +
> >  fs/Makefile                    |   2 +
> >  fs/crypto/Kconfig              |   1 +
> >  fs/crypto/bio.c                |  11 +++
> >  fs/read_callbacks.c            | 174 +++++++++++++++++++++++++++++++++
> >  include/linux/fscrypt.h        |   5 +
> >  include/linux/read_callbacks.h |  38 +++++++
> >  7 files changed, 234 insertions(+)
> >  create mode 100644 fs/read_callbacks.c
> >  create mode 100644 include/linux/read_callbacks.h
> > 
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index f1046cf6ad85..d869859c88da 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -21,6 +21,9 @@ if BLOCK
> >  config FS_IOMAP
> >  	bool
> >  
> > +config FS_READ_CALLBACKS
> > +       bool
> 
> This should be intended with a tab, not spaces.
> 
> > +
> >  source "fs/ext2/Kconfig"
> >  source "fs/ext4/Kconfig"
> >  source "fs/jbd2/Kconfig"
> > diff --git a/fs/Makefile b/fs/Makefile
> > index c9aea23aba56..a1a06f0db5c1 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -21,6 +21,8 @@ else
> >  obj-y +=	no-block.o
> >  endif
> >  
> > +obj-$(CONFIG_FS_READ_CALLBACKS) += read_callbacks.o
> > +
> >  obj-$(CONFIG_PROC_FS) += proc_namespace.o
> 
> Nit: maybe move this to just below the line for iomap.o, to be consistent with
> where FS_READ_CALLBACKS is in the Kconfig file.
> 
> >  
> >  obj-y				+= notify/
> > diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
> > index 24ed99e2eca0..7752f9964280 100644
> > --- a/fs/crypto/Kconfig
> > +++ b/fs/crypto/Kconfig
> > @@ -9,6 +9,7 @@ config FS_ENCRYPTION
> >  	select CRYPTO_CTS
> >  	select CRYPTO_SHA256
> >  	select KEYS
> > +	select FS_READ_CALLBACKS if BLOCK
> >  	help
> >  	  Enable encryption of files and directories.  This
> >  	  feature is similar to ecryptfs, but it is more memory
> > diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> > index 82da2510721f..f677ff93d464 100644
> > --- a/fs/crypto/bio.c
> > +++ b/fs/crypto/bio.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/module.h>
> >  #include <linux/bio.h>
> >  #include <linux/namei.h>
> > +#include <linux/read_callbacks.h>
> >  #include "fscrypt_private.h"
> >  
> >  static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
> > @@ -68,6 +69,16 @@ void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx, struct bio *bio)
> >  }
> >  EXPORT_SYMBOL(fscrypt_enqueue_decrypt_bio);
> >  
> > +void fscrypt_decrypt_work(struct work_struct *work)
> > +{
> > +	struct read_callbacks_ctx *ctx =
> > +		container_of(work, struct read_callbacks_ctx, work);
> > +
> > +	fscrypt_decrypt_bio(ctx->bio);
> > +
> > +	read_callbacks(ctx);
> > +}
> > +
> 
> This seems like a layering violation, since it means that read_callbacks.c calls
> fs/crypto/ *and* fs/crypto/ calls read_callbacks.c.  I don't think fs/crypto/
> should be aware of read_callbacks at all.  Instead we should have a clear
> ordering between the components: the filesystem uses read_callbacks.c and
> fs/crypto/, and read_callbacks.c uses fs/crypto/.  So how about:
> 
> - Move fscrypt_decrypt_work(), fscrypt_decrypt_bh(), and fscrypt_decrypt_bio()
>   into fs/read_callbacks.c and remove the "fscrypt_" prefix from them.
> 
> - Instead of selecting FS_READ_CALLBACKS from FS_ENCRYPTION, select it from
>   EXT4_FS and F2FS_FS (if FS_ENCRYPTION).  I.e., it's really the *filesystems*
>   themselves that use read_callbacks, not fs/crypto/.
> 
> - Move the definition of read_callbacks_ctx into fs/read_callbacks.c, and make
>   read_callbacks() static, so these are private to the read_callbacks component.
> 
> >  int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
> >  				sector_t pblk, unsigned int len)
> >  {
> > diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
> > new file mode 100644
> > index 000000000000..a4196e3de05f
> > --- /dev/null
> > +++ b/fs/read_callbacks.c
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * This file tracks the state machine that needs to be executed after reading
> > + * data from files that are encrypted and/or have verity metadata associated
> > + * with them.
> > + */
> > +#include <linux/module.h>
> > +#include <linux/mm.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/bio.h>
> > +#include <linux/fscrypt.h>
> > +#include <linux/read_callbacks.h>
> > +
> > +#define NUM_PREALLOC_READ_CALLBACK_CTXS	128
> > +
> > +static struct kmem_cache *read_callbacks_ctx_cache;
> > +static mempool_t *read_callbacks_ctx_pool;
> > +
> > +/* Read callback state machine steps */
> > +enum read_callbacks_step {
> > +	STEP_INITIAL = 0,
> > +	STEP_DECRYPT,
> > +};
> > +
> > +static void put_read_callbacks_ctx(struct read_callbacks_ctx *ctx)
> > +{
> > +	mempool_free(ctx, read_callbacks_ctx_pool);
> > +}
> 
> Maybe call this free_read_callbacks_ctx(), so that it doesn't sound like it's
> doing reference counting.
> 
> > +
> > +static void end_read_callbacks_bio(struct bio *bio)
> > +{
> > +	struct read_callbacks_ctx *ctx;
> > +	struct page *page;
> > +	struct bio_vec *bv;
> > +	struct bvec_iter_all iter_all;
> > +
> > +	ctx = bio->bi_private;
> > +
> > +	bio_for_each_segment_all(bv, bio, iter_all) {
> > +		page = bv->bv_page;
> > +
> > +		if (bio->bi_status || PageError(page)) {
> > +			ClearPageUptodate(page);
> > +			SetPageError(page);
> > +		} else {
> > +			SetPageUptodate(page);
> > +		}
> > +
> > +		if (ctx->page_op)
> > +			ctx->page_op(bio, page);
> > +
> > +		unlock_page(page);
> > +	}
> > +
> > +	put_read_callbacks_ctx(ctx);
> > +
> > +	bio_put(bio);
> > +}
> 
> The filesystem itself (or fs/mpage.c) actually has to implement almost all this
> logic as well anyway, because CONFIG_FS_READ_CALLBACKS may be unset.  And the
> ->page_op() callback, which exists only because f2fs needs to update some
> counter, is very ugly.
> 
> IMO, it would be simpler to just make this whole function filesystem-specific,
> as a 'typedef void (*end_bio_func_t)(struct bio *bio);' which gets passed to the
> read_callbacks endio hook.
> 
> Of course, each end_bio_func_t would have to check PageError() to check whether
> any read_callbacks step failed.  But to make that a bit easier and to make it
> get compiled out when CONFIG_FS_READ_CALLBACKS is unset, there could be a helper
> function in read_callbacks.h:
> 
> 	#ifdef CONFIG_FS_READ_CALLBACKS
> 	static inline bool read_callbacks_failed(struct page *page)
> 	{
> 		return PageError(page);
> 	}
> 	#else
> 	static inline bool read_callbacks_failed(struct page *page)
> 	{
> 		return false;
> 	}
> 	#endif
> 
> > +
> > +/**
> > + * read_callbacks() - Execute the read callbacks state machine.
> > + * @ctx: The context structure tracking the current state.
> > + *
> > + * For each state, this function enqueues a work into appropriate subsystem's
> > + * work queue. After performing further processing of the data in the bio's
> > + * pages, the subsystem should invoke read_calbacks() to continue with the next
> > + * state in the state machine.
> > + */
> > +void read_callbacks(struct read_callbacks_ctx *ctx)
> > +{
> > +	/*
> > +	 * We use different work queues for decryption and for verity because
> > +	 * verity may require reading metadata pages that need decryption, and
> > +	 * we shouldn't recurse to the same workqueue.
> > +	 */
> > +	switch (++ctx->cur_step) {
> > +	case STEP_DECRYPT:
> > +		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> > +			INIT_WORK(&ctx->work, fscrypt_decrypt_work);
> > +			fscrypt_enqueue_decrypt_work(&ctx->work);
> > +			return;
> > +		}
> > +		ctx->cur_step++;
> > +		/* fall-through */
> > +	default:
> > +		end_read_callbacks_bio(ctx->bio);
> > +	}
> > +}
> > +EXPORT_SYMBOL(read_callbacks);
> 
> As I mentioned, I think the work functions should be defined in this file rather
> than in fs/crypto/ or fs/verity/, since they're specific to the read_callbacks.
> fs/crypto/ and fs/verity/ should not be aware of read_callbacks at all.
> Moreover, the 'read_callbacks()' function should be static.
> 
> > +
> > +/**
> > + * read_callbacks_end_bio() - Initiate the read callbacks state machine.
> > + * @bio: bio on which read I/O operation has just been completed.
> > + *
> > + * Initiates the execution of the read callbacks state machine when the read
> > + * operation has been completed successfully. If there was an error associated
> > + * with the bio, this function frees the read callbacks context structure stored
> > + * in bio->bi_private (if any).
> > + *
> > + * Return: 1 to indicate that the bio has been handled (including unlocking the
> > + * pages); 0 otherwise.
> > + */
> > +int read_callbacks_end_bio(struct bio *bio)
> > +{
> > +	if (!bio->bi_status && bio->bi_private) {
> > +		read_callbacks((struct read_callbacks_ctx *)(bio->bi_private));
> > +		return 1;
> > +	}
> > +
> > +	if (bio->bi_private)
> > +		put_read_callbacks_ctx((struct read_callbacks_ctx *)(bio->bi_private));
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(read_callbacks_end_bio);
> 
> Okay, several issues here...
> 
> First, the naming of this is really confusing, since it's actually *beginning*
> the read callbacks, not ending them; and it's basically the same name as
> end_read_callbacks_bio(), which actually *is* for ending the read callbacks.
> Since this is the endio hook, how about calling it read_callbacks_endio_bio(),
> and likewise read_callbacks_endio_bh()?
> 
> But more importantly, this doesn't need to have a return value, since the
> read_callbacks layer has to know how to end the bio (meaning unlock the pages
> and mark them uptodate or not) *anyway*, or at least know how to ask the
> filesystem to do it.  So it should just do it if needed, rather than returning 0
> and making the caller do it.
> 
> Also just assign 'ctx = bio->bi_private' at the start of the function; no need
> to access the field 4 times and have unnecessary casts.
> 
> So IMO, the below would be much better:
> 
> void read_callbacks_endio_bio(struct bio *bio, end_bio_func_t end_bio)
> {
> 	struct read_callbacks_ctx *ctx = bio->bi_private;
> 
> 	if (ctx) {
> 		if (!bio->bi_status) {
> 			ctx->end_bio = end_bio;
> 			read_callbacks(ctx);
> 			return;
> 		}
> 		free_read_callbacks_ctx(ctx);
> 	}
> 	end_bio(bio);
> }
> EXPORT_SYMBOL(read_callbacks_endio_bio);
> 
> And then the !CONFIG_FS_READ_CALLBACKS stub:
> 
> static inline void read_callbacks_endio_bio(struct bio *bio,
> 					    end_bio_func_t end_bio)
> {
> 	end_bio(bio);
> }
> 
> Similarly for the buffer_head versions.
> 
> > +
> > +/**
> > + * read_callbacks_setup() - Initialize the read callbacks state machine
> > + * @inode: The file on which read I/O is performed.
> > + * @bio: bio holding page cache pages on which read I/O is performed.
> > + * @page_op: Function to perform filesystem specific operations on a page.
> > + *
> > + * Based on the nature of the file's data (e.g. encrypted), this function
> > + * computes the steps that need to be performed after data is read of the
> > + * backing disk. This information is saved in a context structure. A pointer
> > + * to the context structure is then stored in bio->bi_private for later
> > + * usage.
> > + *
> > + * Return: 0 on success; An error code on failure.
> > + */
> > +int read_callbacks_setup(struct inode *inode, struct bio *bio,
> > +			end_page_op_t page_op)
> > +{
> > +	struct read_callbacks_ctx *ctx = NULL;
> > +	unsigned int enabled_steps = 0;
> > +
> > +	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
> > +		enabled_steps |= 1 << STEP_DECRYPT;
> > +
> > +	if (enabled_steps) {
> > +		ctx = mempool_alloc(read_callbacks_ctx_pool, GFP_NOFS);
> > +		if (!ctx)
> > +			return -ENOMEM;
> > +		ctx->bio = bio;
> > +		ctx->inode = inode;
> > +		ctx->enabled_steps = enabled_steps;
> > +		ctx->cur_step = STEP_INITIAL;
> > +		ctx->page_op = page_op;
> > +		bio->bi_private = ctx;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(read_callbacks_setup);
> 
> Please call it:
> 
> 	read_callbacks_setup_bio()
> 
> Then when you add buffer_head support later in the patchset, rather than adding
> a buffer_head argument to this function, add a new function:
> 
> 	read_callbacks_setup_bh()
> 
> So that all the users don't have to pass both the buffer_head and bio arguments.
> 
> These can use a common function get_read_callbacks_ctx() that creates a
> read_callbacks_ctx for the inode.  E.g., the bio version could look like:
> 
> int read_callbacks_setup_bio(struct inode *inode, struct bio *bio)
> {
> 	struct read_callbacks_ctx *ctx = get_read_callbacks_ctx(inode);
> 
> 	if (ctx) {
> 		if (IS_ERR(ctx))
> 			return PTR_ERR(ctx);
> 		ctx->bio = bio;
> 		ctx->bh = NULL;
> 		bio->bi_private = ctx;
> 	}
> 	return 0;
> }
> EXPORT_SYMBOL(read_callbacks_setup_bio);
> 
> 
> Also, a nit: can you move the read_callbacks_setup_*() functions to near the top
> of the file, since they're called first (before the endio functions)?  Likewise
> in read_callbacks.h.  It would nice to keep the functions in a logical order.
> 
> > diff --git a/include/linux/read_callbacks.h b/include/linux/read_callbacks.h
> > new file mode 100644
> > index 000000000000..aa1ec8ed7a6a
> > --- /dev/null
> > +++ b/include/linux/read_callbacks.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _READ_CALLBACKS_H
> > +#define _READ_CALLBACKS_H
> 
> Headers should be self-contained, but this is missing some prerequisite headers
> and forward declarations.  Try compiling a .c file with this header included
> first.
> 
> > +
> > +typedef void (*end_page_op_t)(struct bio *bio, struct page *page);
> > +
> > +struct read_callbacks_ctx {
> > +	struct bio *bio;
> > +	struct inode *inode;
> > +	struct work_struct work;
> > +	unsigned int cur_step;
> > +	unsigned int enabled_steps;
> > +	end_page_op_t page_op;
> > +};
> 
> As I mentioned, I don't think read_callbacks_ctx should be exposed to
> filesystems like this.  Instead just forward declare it here, and put the actual
> definition in fs/read_callbacks.c.
> 
> > +
> > +#ifdef CONFIG_FS_READ_CALLBACKS
> > +void read_callbacks(struct read_callbacks_ctx *ctx);
> > +int read_callbacks_end_bio(struct bio *bio);
> > +int read_callbacks_setup(struct inode *inode, struct bio *bio,
> > +			end_page_op_t page_op);
> > +#else
> > +static inline void read_callbacks(struct read_callbacks_ctx *ctx)
> > +{
> > +}
> > +
> > +static inline int read_callbacks_end_bio(struct bio *bio)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> 
> This stub needs to return 0, otherwise it breaks fs/mpage.c and f2fs for
> everyone when CONFIG_FS_READ_CALLBACKS is unset.
> 
> But as I mentioned elsewhere, I think this should actually call an end_bio()
> callback itself and return void, which would also avoid this issue.
> 
> > +
> > +static inline int read_callbacks_setup(struct inode *inode,
> > +				struct bio *bio, end_page_op_t page_op)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> 
> Similarly here, this stub needs to return 0.
> 

I agree with all your comments. I will fix them up and post the next version.

-- 
chandan



