Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C437B6C433B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 07:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCVGeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 02:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVGeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:34:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F51A662
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 23:34:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j13so17631489pjd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679466860;
        h=in-reply-to:subject:cc:to:from:references:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xVORIYLUDBw/vwN+dxcW37FQq20Saj4Q759rbebxSCA=;
        b=at5oSBWA49bjSw1pN6/v1gsafmMFn9fTwjzzDcPKd1nw+fOqexYXq1FUHrdIW/735L
         C4LhWI7c3iSgh+6vgb520o+6Bb0m4gvibu9yyDs3s/KLqn/iYI88x9W3nAC91M9/mt2F
         ATEkToU1m5qtl1YdjINBx8oofdolPG+dRfT0mdJbtBuFrEimFAhKqsQCWJ8do8s6tYH/
         dD/v/B22BV6AjccyoVICeqnuE61gi0C2Sdds8f2kU4DN0ylMJQeMWD3Ci/mejzJq9bEN
         HktGqGMO8EcDqQB8yhLlgpp1DWl+5kG5Jn+wvKaEw0ksSBhVvWwYJtksdmkpqsRcoUqk
         Z8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679466860;
        h=in-reply-to:subject:cc:to:from:references:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVORIYLUDBw/vwN+dxcW37FQq20Saj4Q759rbebxSCA=;
        b=EpwkA4Co6nCg01GDPOrvd1NAD1FbvK4y1NgeMqkViJeA2VaRgikSiEi+FE12jGIOk+
         W3ZxnxQzaZv4HqzA9rxdVHdL1JtMyvaeqOw7TkuHtEQdISu7dRvEebGH02ONqVZj7txM
         0OTJfGg6r9/MOnhyw2VrHBtdEvI7BOBPaN6w/Hje9aUQTW1YGoaLpiU5tK1eGRtuLL5E
         JTZ7b3WZJJ6lIKmFHDETCl+C13iXVI3P9WHmj4LU2gCKHUEMnoocJJN+8nFY8/A+VEa5
         2sM7n4jsp5BERlU5gAvx5Ypiiu+O0hbdQw1mWFHqxzJqWSjJSu3xQh+O4DqtAGgDMlxE
         ezvg==
X-Gm-Message-State: AO0yUKV7KpxonWdQpXvtPpueRbOdPiflHxx9LwWEq17IOZMbLPmqqiMO
        LdWvI+aWvNA09dkAdOIDJ6A=
X-Google-Smtp-Source: AK7set++U9tSyCeQbTpSgJ2Ya1Y1pGdxlpf4L04QdVscXiQbe1/vVdzejDcQ4dU6srnaeX/jpwiIkQ==
X-Received: by 2002:a05:6a20:bcaf:b0:d5:6e91:f019 with SMTP id fx47-20020a056a20bcaf00b000d56e91f019mr4910532pzb.33.1679466859480;
        Tue, 21 Mar 2023 23:34:19 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:469f:1474:7c59:3a57:aab6])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b00627f2f23624sm5512072pfi.159.2023.03.21.23.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:34:18 -0700 (PDT)
Date:   Wed, 22 Mar 2023 12:04:01 +0530
Message-Id: <87zg85pa5i.fsf@doe.com>
References: <87ttz889ns.fsf@doe.com> <eae9d2125de1887f55186668937df7475b0a33f4.1678977084.git.ritesh.list@gmail.com> <20230320175139.l5oqbwuae4schgcu@quack3>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [RFCv1][WIP] ext2: Move direct-io to use iomap
In-Reply-To: <20230320175139.l5oqbwuae4schgcu@quack3>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Thanks Jan for your feedback!

Jan Kara <jack@suse.cz> writes:

> On Thu 16-03-23 20:10:29, Ritesh Harjani (IBM) wrote:
>> [DO NOT MERGE] [WORK-IN-PROGRESS]
>>
>> Hello Jan,
>>
>> This is an initial version of the patch set which I wanted to share
>> before today's call. This is still work in progress but atleast passes
>> the set of test cases which I had kept for dio testing (except 1 from my
>> list).
>>
>> Looks like there won't be much/any changes required from iomap side to
>> support ext2 moving to iomap apis.
>>
>> I will be doing some more testing specifically test generic/083 which is
>> occassionally failing in my testing.
>> Also once this is stabilized, I can do some performance testing too if you
>> feel so. Last I remembered we saw some performance regressions when ext4
>> moved to iomap for dio.
>>
>> PS: Please ignore if there are some silly mistakes. As I said, I wanted
>> to get this out before today's discussion. :)
>>
>> Thanks for your help!!
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext2/ext2.h  |   1 +
>>  fs/ext2/file.c  | 114 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/ext2/inode.c |  20 +--------
>>  3 files changed, 117 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
>> index cb78d7dcfb95..cb5e309fe040 100644
>> --- a/fs/ext2/ext2.h
>> +++ b/fs/ext2/ext2.h
>> @@ -753,6 +753,7 @@ extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
>>  extern struct inode *ext2_iget (struct super_block *, unsigned long);
>>  extern int ext2_write_inode (struct inode *, struct writeback_control *);
>>  extern void ext2_evict_inode(struct inode *);
>> +extern void ext2_write_failed(struct address_space *mapping, loff_t to);
>>  extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
>>  extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
>>  extern int ext2_getattr (struct mnt_idmap *, const struct path *,
>> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
>> index 6b4bebe982ca..7a8561304559 100644
>> --- a/fs/ext2/file.c
>> +++ b/fs/ext2/file.c
>> @@ -161,12 +161,123 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>>  	return ret;
>>  }
>>
>> +static ssize_t ext2_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>> +{
>> +	struct file *file = iocb->ki_filp;
>> +	struct inode *inode = file->f_mapping->host;
>> +	ssize_t ret;
>> +
>> +	inode_lock_shared(inode);
>> +	ret = iomap_dio_rw(iocb, to, &ext2_iomap_ops, NULL, 0, NULL, 0);
>> +	inode_unlock_shared(inode);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>> +				 int error, unsigned int flags)
>> +{
>> +	loff_t pos = iocb->ki_pos;
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +
>> +	if (error)
>> +		return error;
>> +
>
> I guess you should carry over here relevant bits of the comment from
> ext4_dio_write_end_io() explaining that doing i_size update here is
> necessary and actually safe.
>

Yes, sure. Will do that in the next rev.

>> +	pos += size;
>> +	if (pos > i_size_read(inode))
>> +		i_size_write(inode, pos);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iomap_dio_ops ext2_dio_write_ops = {
>> +	.end_io = ext2_dio_write_end_io,
>> +};
>> +
>> +static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>> +{
>> +	struct file *file = iocb->ki_filp;
>> +	struct inode *inode = file->f_mapping->host;
>> +	ssize_t ret;
>> +	unsigned int flags;
>> +	unsigned long blocksize = inode->i_sb->s_blocksize;
>> +	loff_t offset = iocb->ki_pos;
>> +	loff_t count = iov_iter_count(from);
>> +
>> +
>> +	inode_lock(inode);
>> +	ret = generic_write_checks(iocb, from);
>> +	if (ret <= 0)
>> +		goto out_unlock;
>> +	ret = file_remove_privs(file);
>> +	if (ret)
>> +		goto out_unlock;
>> +	ret = file_update_time(file);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	/*
>> +	 * We pass IOMAP_DIO_NOSYNC because otherwise iomap_dio_rw()
>> +	 * calls for generic_write_sync in iomap_dio_complete().
>> +	 * Since ext2_fsync nmust be called w/o inode lock,
>> +	 * hence we pass IOMAP_DIO_NOSYNC and handle generic_write_sync()
>> +	 * ourselves.
>> +	 */
>> +	flags = IOMAP_DIO_NOSYNC;
>
> Meh, this is kind of ugly and we should come up with something better for
> simple filesystems so that they don't have to play these games. Frankly,
> these days I doubt there's anybody really needing inode_lock in
> __generic_file_fsync(). Neither sync_mapping_buffers() nor
> sync_inode_metadata() need inode_lock for their self-consistency. So it is
> only about flushing more consistent set of metadata to disk when fsync(2)
> races with other write(2)s to the same file so after a crash we have higher
> chances of seeing some real state of the file. But I'm not sure it's really
> worth keeping for filesystems that are still using sync_mapping_buffers().
> People that care about consistency after a crash have IMHO moved to other
> filesystems long ago.
>

One way which hch is suggesting is to use __iomap_dio_rw() -> unlock
inode -> call generic_write_sync(). I haven't yet worked on this part.
Are you suggesting to rip of inode_lock from __generic_file_fsync()?
Won't it have a much larger implications?


>> +
>> +	/* use IOMAP_DIO_FORCE_WAIT for unaligned of extending writes */
> 						  ^^ or
>

Yup. will fix it.

>> +	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
>> +	   (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize)))
>> +		flags |= IOMAP_DIO_FORCE_WAIT;
>> +
>> +	ret = iomap_dio_rw(iocb, from, &ext2_iomap_ops, &ext2_dio_write_ops,
>> +			   flags, NULL, 0);
>> +
>> +	if (ret == -ENOTBLK)
>> +		ret = 0;
>
> So iomap_dio_rw() doesn't have the DIO_SKIP_HOLES behavior of
> blockdev_direct_IO(). Thus you have to implement that in your
> ext2_iomap_ops, in particular in iomap_begin...
>

Aah yes. Thanks for pointing that out -
ext2_iomap_begin() should have something like this -
	/*
	 * We cannot fill holes in indirect tree based inodes as that could
	 * expose stale data in the case of a crash. Use the magic error code
	 * to fallback to buffered I/O.
	 */

Also I think ext2_iomap_end() should also handle a case like in ext4 -

	/*
	 * Check to see whether an error occurred while writing out the data to
	 * the allocated blocks. If so, return the magic error code so that we
	 * fallback to buffered I/O and attempt to complete the remainder of
	 * the I/O. Any blocks that may have been allocated in preparation for
	 * the direct I/O will be reused during buffered I/O.
	 */
	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
		return -ENOTBLK;


I am wondering if we have testcases in xfstests which really tests these
functionalities also or not? Let me give it a try...
... So I did and somehow couldn't find any testcase which fails w/o
above changes.

I also ran LTP dio tests (./runltp -f dio -d /mnt1/scratch/tmp/) with the
current patches on ext2 and all the tests passed. So it seems LTP
doesn't have tests to trigger stale data exposure problems.

Do you know of any test case which could trigger this? Otherwise I can
finish updating the patches and then work on writing some test cases to
trigger this.

Another query -

We have this function ext2_iomap_end() (pasted below)
which calls ext2_write_failed().

Here IMO two cases are possible -

1. written is 0. which means an error has occurred.
In that case calling ext2_write_failed() make sense.

2. consider a case where written > 0 && written < length.
(This is possible right?). In that case we still go and call
ext2_write_failed(). This function will truncate the pagecache and disk
blocks beyong i_size. Now we haven't yet updated inode->i_size (we do
that in ->end_io which gets called in the end during completion)
So that means it just removes everything.

Then in ext2_dax_write_iter(), we might go and update inode->i_size
to iocb->ki_pos including for short writes. This looks like it isn't
consistent because earlier we had destroyed all the blocks for the short
writes and we will be returning ret > 0 to the user saying these many
bytes have been written.
Again I haven't yet found a test case at least not in xfstests which
can trigger this short writes. Let me know your thoughts on this.
All of this lies on the fact that there can be a case where
written > 0 && written < length. I will read more to see if this even
happens or not. But I atleast wanted to capture this somewhere.

static int
ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
		ssize_t written, unsigned flags, struct iomap *iomap)
{
	if (iomap->type == IOMAP_MAPPED &&
	    written < length &&
	    (flags & IOMAP_WRITE))
		ext2_write_failed(inode->i_mapping, offset + length);
	return 0;
}

void ext2_write_failed(struct address_space *mapping, loff_t to)
{
	struct inode *inode = mapping->host;

	if (to > inode->i_size) {
		truncate_pagecache(inode, inode->i_size);
		ext2_truncate_blocks(inode, inode->i_size);
	}
}

ext2_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
<...>
	ret = dax_iomap_rw(iocb, from, &ext2_iomap_ops);
	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
		i_size_write(inode, iocb->ki_pos);
		mark_inode_dirty(inode);
	}
<...>


Another thing -
In dax while truncating the inode i_size in ext2_setsize(),
I think we don't properly call dax_zero_blocks() when we are trying to
zero the last block beyond EOF. i.e. for e.g. it can be called with len
as 0 if newsize is page_aligned. It then will call ext2_get_blocks() with
len = 0 and can bug_on at maxblocks == 0.

I think it should be this. I will spend some more time analyzing this
and also test it once against DAX paths.

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 7ff669d0b6d2..cc264b1e288c 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1243,9 +1243,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
        inode_dio_wait(inode);

        if (IS_DAX(inode))
-               error = dax_zero_range(inode, newsize,
-                                      PAGE_ALIGN(newsize) - newsize, NULL,
-                                      &ext2_iomap_ops);
+               error = dax_truncate_page(inode, newsize, NULL,
+                                         &ext2_iomap_ops);
        else
                error = block_truncate_page(inode->i_mapping,
                                newsize, ext2_get_block);

-ritesh


> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
