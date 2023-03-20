Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDEB6C1B31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 17:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjCTQUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 12:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjCTQT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:19:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B140298D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 09:11:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j13so12640432pjd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679328705;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xs85zXA0FLZRHe7v0i3MbFeGMJjNZb7cHoH6pL8h2Mw=;
        b=SlBkrd3a3KCNec2FChzCjhI2tTU0iEFcypholsUZMEpr+wkTW6G8dDqensjYH71yN9
         +nEGpSejWUsG7g3PStzPn2ILLZmit6pCEHp4XAvZyrElhb+txeNFn2om4e0uVU1dXbZ/
         I6uE4us4ZDZudqCTU7aDhZP98SZl3GbLMSeqibw7WRCHT4HAhDYo3RVd0USSw/jDTkMu
         K80tse3mAE8pIueXNAY4jRAiicsAAdJXNKRS8W3laSG0WRpJ3tsYqXbeCKaiihYhLV+a
         gC+rPZ5huWWM1oBBMDj/Zr38fh4bBgwzRCknWP+LyKXfoy/PxZKZOWEpBlFYN4sZfwYE
         ZhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328705;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xs85zXA0FLZRHe7v0i3MbFeGMJjNZb7cHoH6pL8h2Mw=;
        b=YO6Z0xXSdhqmJh0Y4z6ZwkzK08m9R/1RHd4eRipTTwjGCFLY5dd3oO54bbL5RlHBcA
         AM/+PreBWj10lQrKOP4mhG9+uHPxTMP6I4H839bXi7ToDwv4Him9pwFebBtKzHkGjd0c
         mwNuiowzNq+N08dS/LBekTd0eqMV442vT2oUqYndIc7Pi4GgjDrgLXBXtCrW1aLIJGuR
         nGSPVHO0LFiIN6iMlARTe9RQ+Q+WLEb+fCE5lBbwK8cblYVFtTv8JOFyEzBBoGyzn1Ao
         +FYTx3BVT35svkoCvwWgE6F2A6ig0wKdGCwSzjIVPnjf+kxEt9QIj38ZyRzH9u61X9Ml
         B5Pg==
X-Gm-Message-State: AO0yUKURrAkbBz4NJiUEHDvKomP24zjwscFyGxHUE4Oo/ADF/4J0hevo
        ptljgErrYKLSnO0MR16XF/Yr3+GpWINKxw==
X-Google-Smtp-Source: AK7set/dk11fvFG53i/glaHTQimV/h1JnY1DP0NCrQOqfwxYSVLnqtWnVbHY4fVYSHjCxB5gZkCpAw==
X-Received: by 2002:a17:902:f243:b0:1a1:a5d9:146d with SMTP id j3-20020a170902f24300b001a1a5d9146dmr11509080plc.65.1679328704886;
        Mon, 20 Mar 2023 09:11:44 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:469f:1474:7c59:3a57:aab6])
        by smtp.gmail.com with ESMTPSA id x13-20020a1709027c0d00b001a06677948dsm6891969pll.293.2023.03.20.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:11:44 -0700 (PDT)
Date:   Mon, 20 Mar 2023 21:41:25 +0530
Message-Id: <87ttyfz9le.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [RFCv1][WIP] ext2: Move direct-io to use iomap
In-Reply-To: <20230316154143.GA11351@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Thu, Mar 16, 2023 at 08:10:29PM +0530, Ritesh Harjani (IBM) wrote:
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
>
> kiocb_modified() instead of calling file_remove_privs?

Yes, looks likle it is a replacement for file_remove_privs and
file_update_time().


>> +
>> +	/*
>> +	 * We pass IOMAP_DIO_NOSYNC because otherwise iomap_dio_rw()
>> +	 * calls for generic_write_sync in iomap_dio_complete().
>> +	 * Since ext2_fsync nmust be called w/o inode lock,
>> +	 * hence we pass IOMAP_DIO_NOSYNC and handle generic_write_sync()
>> +	 * ourselves.
>> +	 */
>> +	flags = IOMAP_DIO_NOSYNC;
>> +
>> +	/* use IOMAP_DIO_FORCE_WAIT for unaligned of extending writes */
>> +	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
>> +	   (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize)))
>> +		flags |= IOMAP_DIO_FORCE_WAIT;
>> +
>> +	ret = iomap_dio_rw(iocb, from, &ext2_iomap_ops, &ext2_dio_write_ops,
>> +			   flags, NULL, 0);
>> +
>> +	if (ret == -ENOTBLK)
>> +		ret = 0;
>> +
>> +	if (ret < 0 && ret != -EIOCBQUEUED)
>> +		ext2_write_failed(inode->i_mapping, offset + count);
>> +
>> +	/* handle case for partial write or fallback to buffered write */
>> +	if (ret >= 0 && iov_iter_count(from)) {
>> +		loff_t pos, endbyte;
>> +		ssize_t status;
>> +		ssize_t ret2;
>> +
>> +		pos = iocb->ki_pos;
>> +		status = generic_perform_write(iocb, from);
>> +		if (unlikely(status < 0)) {
>> +			ret = status;
>> +			goto out_unlock;
>> +		}
>> +		endbyte = pos + status - 1;
>> +		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
>> +						    endbyte);
>> +		if (ret2 == 0) {
>> +			iocb->ki_pos = endbyte + 1;
>> +			ret += status;
>> +			invalidate_mapping_pages(inode->i_mapping,
>> +						 pos >> PAGE_SHIFT,
>> +						 endbyte >> PAGE_SHIFT);
>> +		}
>> +	}
>
> (Why not fall back to the actual buffered write path?)
>

Because then we can handle everything related to DIO in
ext4_dio_file_write() itself e.g. As per the semantics of DIO we should
ensure that page-cache pages are written to disk and invalidated before
returning (filemap_write_and_wait_range() and invalidate_mapping_pages())

> Otherwise this looks like a reasonable first start.

Thanks!

-ritesh
