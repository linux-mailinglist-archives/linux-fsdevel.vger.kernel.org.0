Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA66C6E469D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 13:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDQLju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 07:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDQLjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:39:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69054135;
        Mon, 17 Apr 2023 04:39:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so25354969plk.9;
        Mon, 17 Apr 2023 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681731543; x=1684323543;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qmQEBjavqVB6HGdUDxStraiihBR6XFWfttzFMuRixqY=;
        b=PM+pGdu2dlyz2aKkOavasFaOKBkOf1MRnEchlnScs/Q8r+jAFr8IKCLHWnRRoCdAzf
         GhNcoe0hg5c739179YnfhHz0S8MpKDVf3YJEca/c3KAqMCtWHeAiKO+Ydfo30O+yJqJK
         I2jLqyBFdxB/5ghPNoMGF6dIJ1VAi1D7qTymhAMl9Wm89+Ffc0VK8wRNqYJi4qvNGco8
         s8FRCvHYmkTxHjpLiG2s93+Okgx4Vm6f/UMpV2ep/MDriexlMdmh9pmHT8mHcVXSvz7S
         UrYYx6hJL7HYAd0xz10h/kFqof3n8gn6T5jxrOZcIz6x8vMk4DElR4hHOPXulW/yKKmW
         UH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681731543; x=1684323543;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmQEBjavqVB6HGdUDxStraiihBR6XFWfttzFMuRixqY=;
        b=Z45Oib1OIpyo9N0COVNnSeJQnVtJNvpCR53fRV+1uaxmRcvNLJ931csYjlBIeLv19J
         cvzDbI2aOvOdsegF3JKTZL4CW59sGBx8shgxdEsb9x7CXNlLR+LgNQ0lfyRnDWUwoMJx
         BU2iogX2ZXZk7Q6ibH5lFo9wAsj8i+izdWASAVHOBIx+rhZpWJQUXfvGWVNZc7da4hTy
         kOuy5ktghToeZyMICI7Hl3Xje1XzYp8p4AOVNwDo8w898G2s3SMNMVSFJvIp56NljjPo
         1+shMgjvKkJnJnXVgBu/gkFMWZdXUordOlUgnMDoU+PkLXL4O33JHsIZIDI2X4ydoNyh
         DJ6Q==
X-Gm-Message-State: AAQBX9defEKviKCRAGMSl0mW0BKAq89x2XpsAHbvPZRDYF2cOr0SCD6U
        2FjNsGSFOyJFziM5P6I90GA=
X-Google-Smtp-Source: AKy350aZc6SQjtZEdF6S0ETm/ZLwE+OtbFIYmquXJbg5UiyjlGi5PXzv/av7qflfQ5L5ecJ9qhm7XA==
X-Received: by 2002:a17:902:d2c3:b0:1a6:ed6f:d6b7 with SMTP id n3-20020a170902d2c300b001a6ed6fd6b7mr1640074plc.5.1681731543451;
        Mon, 17 Apr 2023 04:39:03 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm5698926plb.137.2023.04.17.04.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 04:39:03 -0700 (PDT)
Date:   Mon, 17 Apr 2023 17:08:57 +0530
Message-Id: <87o7nmivqm.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv5 2/9] fs/buffer.c: Add generic_buffer_fsync implementation
In-Reply-To: <20230417110149.mhrksh4owqkfw5pa@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Sun 16-04-23 15:38:37, Ritesh Harjani (IBM) wrote:
>> Some of the higher layers like iomap takes inode_lock() when calling
>> generic_write_sync().
>> Also writeback already happens from other paths without inode lock,
>> so it's difficult to say that we really need sync_mapping_buffers() to
>> take any inode locking here. Having said that, let's add
>> generic_buffer_fsync() implementation in buffer.c with no
>> inode_lock/unlock() for now so that filesystems like ext2 and
>> ext4's nojournal mode can use it.
>>
>> Ext4 when got converted to iomap for direct-io already copied it's own
>> variant of __generic_file_fsync() without lock. Hence let's add a helper
>> API and use it both in ext2 and ext4.
>>
>> Later we can review other filesystems as well to see if we can make
>> generic_buffer_fsync() which does not take any inode_lock() as the
>> default path.
>>
>> Tested-by: Disha Goel <disgoel@linux.ibm.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> There is a problem with generic_buffer_fsync() that it does not call
> blkdev_issue_flush() so the caller is responsible for doing that. That's
> necessary for ext2 & ext4 so fine for now. But historically this was the
> case with generic_file_fsync() as well and that led to many filesystem
> forgetting to flush caches from fsync(2).

Ok, thanks for the details.

> What is our transition plan for
> these filesystems that currently do the cache flush from
> generic_file_fsync()? Do we want to eventually keep generic_file_fsync()
> doing the cache flush and call generic_buffer_fsync() instead of
> __generic_buffer_fsync() from it?

Frankly speaking, I was thinking we will come back to this question
maybe when we start working on those changes. At this point in time
I only looked at it from ext2 DIO changes perspective.

But since you asked, here is what I think we could do -

Rename generic_file_fsync => generic_buffers_sync() to fs/buffers.c
Then
generic_buffers_sync() {
    ret = generic_buffers_fsync()
    if (!ret)
       blkdev_issue_flush()
}

generic_buffers_fsync() is same as in this patch which does not have the
cache flush operation.
(will rename from generic_buffer_fsync() to generic_buffers_fsync())

Note: The naming is kept such that-
- sync means it will do fsync followed by cache flush.
- fsync means it will only do the file fsync

As I understand - we would eventually like to kill the
inode_lock() variants of generic_file_fsync() and __generic_file_fsync()
after auditing other filesystem code, right?

Then for now what we need is generic_buffers_sync() function which does
not take an inode_lock() and also does cache flush which is required for ext2.
And generic_buffers_fsync() which does not do any cache flush operations
required by filesystem like ext4.

Does that sound good to you? Is the naming also proper?

Is yes, then I can rename the below function to generic_buffers_fsync()
and also create implementation of generic_buffers_sync().
Then let ext2 and ext4 use them.


-ritesh


>
> 								Honza
>
>> ---
>>  fs/buffer.c                 | 43 +++++++++++++++++++++++++++++++++++++
>>  include/linux/buffer_head.h |  2 ++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index 9e1e2add541e..df98f1966a71 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -593,6 +593,49 @@ int sync_mapping_buffers(struct address_space *mapping)
>>  }
>>  EXPORT_SYMBOL(sync_mapping_buffers);
>>
>> +/**
>> + * generic_buffer_fsync - generic buffer fsync implementation
>> + * for simple filesystems with no inode lock
>> + *
>> + * @file:	file to synchronize
>> + * @start:	start offset in bytes
>> + * @end:	end offset in bytes (inclusive)
>> + * @datasync:	only synchronize essential metadata if true
>> + *
>> + * This is a generic implementation of the fsync method for simple
>> + * filesystems which track all non-inode metadata in the buffers list
>> + * hanging off the address_space structure.
>> + */
>> +int generic_buffer_fsync(struct file *file, loff_t start, loff_t end,
>> +			 bool datasync)
>> +{
>> +	struct inode *inode = file->f_mapping->host;
>> +	int err;
>> +	int ret;
>> +
>> +	err = file_write_and_wait_range(file, start, end);
>> +	if (err)
>> +		return err;
>> +
>> +	ret = sync_mapping_buffers(inode->i_mapping);
>> +	if (!(inode->i_state & I_DIRTY_ALL))
>> +		goto out;
>> +	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
>> +		goto out;
>> +
>> +	err = sync_inode_metadata(inode, 1);
>> +	if (ret == 0)
>> +		ret = err;
>> +
>> +out:
>> +	/* check and advance again to catch errors after syncing out buffers */
>> +	err = file_check_and_advance_wb_err(file);
>> +	if (ret == 0)
>> +		ret = err;
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(generic_buffer_fsync);
>> +
>>  /*
>>   * Called when we've recently written block `bblock', and it is known that
>>   * `bblock' was for a buffer_boundary() buffer.  This means that the block at
>> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
>> index 8f14dca5fed7..3170d0792d52 100644
>> --- a/include/linux/buffer_head.h
>> +++ b/include/linux/buffer_head.h
>> @@ -211,6 +211,8 @@ int inode_has_buffers(struct inode *);
>>  void invalidate_inode_buffers(struct inode *);
>>  int remove_inode_buffers(struct inode *inode);
>>  int sync_mapping_buffers(struct address_space *mapping);
>> +int generic_buffer_fsync(struct file *file, loff_t start, loff_t end,
>> +			 bool datasync);
>>  void clean_bdev_aliases(struct block_device *bdev, sector_t block,
>>  			sector_t len);
>>  static inline void clean_bdev_bh_alias(struct buffer_head *bh)
>> --
>> 2.39.2
>>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
