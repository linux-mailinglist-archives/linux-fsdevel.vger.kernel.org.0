Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA8C6C695D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCWNTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCWNTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:19:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7111EBC1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 06:19:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a16so17099311pjs.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679577571;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xohg3uq6108EmfZvk0MIVoAmjVW9Bugj9pZNC8wNbe0=;
        b=TkbAP6KqZX03cbb8R+a5mHWL6DpiJOEAM9c0RT2fgi1rkbAOAMdg3Ed2RcNTykbBJx
         TM836e2J+MIRsHIkc0nTHHPWvnnclzWEZ91aSAI/14z1dRTgqHaJHlApsEz35fRdmr9Y
         q8Y0Rs1K8ekag1cK02HMYWzFSKD4tJYo1+qqbM1E1om0S3vtwGUNVRenG8xgja38PtG9
         g6xZlvdRceT1jkKUDqB+Oa4Uc3qtAKmM2OCWqJ4q93zGOSR39NxOttFGOKSiw7/S/Ths
         9gaI5drEL7g98jibEWSQHAR5PS+Q2BaZEznr1es/aOEVzCXYPOlrUR3yo8aFxZN4gdNI
         rRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679577571;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xohg3uq6108EmfZvk0MIVoAmjVW9Bugj9pZNC8wNbe0=;
        b=C+idyQq0KRbXk3FD0bm8BbPykokBRdf5O/Fqn/rhqWdY0bC4K692l+uWy4hYW59Jq1
         I7YWaKw7ckXGDCvn2Btju51W84B/6xFp4DBeJICB9L/jJWM3OXJACTr0cmX2L9jbqzws
         Cg1Phvs03qQgKv59LnHXbZXAYtKa/YvC5hF4H4HpPc3D/toOzNPK9I1QFyIT+n886j6+
         kBLHnLH9cW05a2ECSXu2BEk0PI7CqPVpCKFq/QuKCipjic9XjcCkmwdunVV94UW11UxV
         RcSS62QfqbaOwo4elspTU0eox/7UwFnJ1cI5lWxUzjXCT+eNb5+/vu9vTxBFIVkbzIMF
         FJtQ==
X-Gm-Message-State: AO0yUKVvhKwmCcJQl+Z5gWfPS1e9w2apTf5pWjW9ZnKzQQkrDecT+T0z
        ogws2mEi1IVxOvp+lJ1HdCCxfmWELynmfw==
X-Google-Smtp-Source: AK7set8K2Xw4AY/Dy+AqAftH72CaH3bRger0FihC6TkZf+3ogu8p2AT/er2GdHy/T/0Aj50wFKT4iA==
X-Received: by 2002:a17:902:fb10:b0:19e:9807:de48 with SMTP id le16-20020a170902fb1000b0019e9807de48mr5315160plb.23.1679577571459;
        Thu, 23 Mar 2023 06:19:31 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:469f:1474:7c59:3a57:aab6])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902b41100b001992e74d058sm204926plr.7.2023.03.23.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:19:31 -0700 (PDT)
Date:   Thu, 23 Mar 2023 18:49:10 +0530
Message-Id: <87wn37ppv5.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [RFCv1][WIP] ext2: Move direct-io to use iomap
In-Reply-To: <20230323113030.ryne2oq27b6cx6xz@quack3>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

Hi Jan,

> On Wed 22-03-23 12:04:01, Ritesh Harjani wrote:
>> Jan Kara <jack@suse.cz> writes:
>> >> +	pos += size;
>> >> +	if (pos > i_size_read(inode))
>> >> +		i_size_write(inode, pos);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static const struct iomap_dio_ops ext2_dio_write_ops = {
>> >> +	.end_io = ext2_dio_write_end_io,
>> >> +};
>> >> +
>> >> +static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>> >> +{
>> >> +	struct file *file = iocb->ki_filp;
>> >> +	struct inode *inode = file->f_mapping->host;
>> >> +	ssize_t ret;
>> >> +	unsigned int flags;
>> >> +	unsigned long blocksize = inode->i_sb->s_blocksize;
>> >> +	loff_t offset = iocb->ki_pos;
>> >> +	loff_t count = iov_iter_count(from);
>> >> +
>> >> +
>> >> +	inode_lock(inode);
>> >> +	ret = generic_write_checks(iocb, from);
>> >> +	if (ret <= 0)
>> >> +		goto out_unlock;
>> >> +	ret = file_remove_privs(file);
>> >> +	if (ret)
>> >> +		goto out_unlock;
>> >> +	ret = file_update_time(file);
>> >> +	if (ret)
>> >> +		goto out_unlock;
>> >> +
>> >> +	/*
>> >> +	 * We pass IOMAP_DIO_NOSYNC because otherwise iomap_dio_rw()
>> >> +	 * calls for generic_write_sync in iomap_dio_complete().
>> >> +	 * Since ext2_fsync nmust be called w/o inode lock,
>> >> +	 * hence we pass IOMAP_DIO_NOSYNC and handle generic_write_sync()
>> >> +	 * ourselves.
>> >> +	 */
>> >> +	flags = IOMAP_DIO_NOSYNC;
>> >
>> > Meh, this is kind of ugly and we should come up with something better for
>> > simple filesystems so that they don't have to play these games. Frankly,
>> > these days I doubt there's anybody really needing inode_lock in
>> > __generic_file_fsync(). Neither sync_mapping_buffers() nor
>> > sync_inode_metadata() need inode_lock for their self-consistency. So it is
>> > only about flushing more consistent set of metadata to disk when fsync(2)
>> > races with other write(2)s to the same file so after a crash we have higher
>> > chances of seeing some real state of the file. But I'm not sure it's really
>> > worth keeping for filesystems that are still using sync_mapping_buffers().
>> > People that care about consistency after a crash have IMHO moved to other
>> > filesystems long ago.
>> >
>>
>> One way which hch is suggesting is to use __iomap_dio_rw() -> unlock
>> inode -> call generic_write_sync(). I haven't yet worked on this part.
>
> So I see two problems with what Christoph suggests:
>
> a) It is unfortunate API design to require trivial (and low maintenance)
>    filesystem to do these relatively complex locking games. But this can
>    be solved by providing appropriate wrapper for them I guess.
>
> b) When you unlock the inode, other stuff can happen with the inode. And
>    e.g. i_size update needs to happen after IO is completed so filesystems
>    would have to be taught to avoid say two racing expanding writes. That's
>    IMHO really too much to ask.
>

yes, that's the reason I was not touching it and I thought I will
get back to it once I figure out other things.


>> Are you suggesting to rip of inode_lock from __generic_file_fsync()?
>> Won't it have a much larger implications?
>
> Yes and yes :). But inode writeback already happens from other paths
> without inode_lock so there's hardly any surprise there.
> sync_mapping_buffers() is impossible to "customize" by filesystems and the
> generic code is fine without inode_lock. So I have hard time imagining how
> any filesystem would really depend on inode_lock in this path (famous last
> words ;)).
>

Ok sure. I will spend sometime looking into this code and history. And
if everything looks good, will rip off inode_lock() from __generic_file_fsync().


>> >> +	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
>> >> +	   (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize)))
>> >> +		flags |= IOMAP_DIO_FORCE_WAIT;
>> >> +
>> >> +	ret = iomap_dio_rw(iocb, from, &ext2_iomap_ops, &ext2_dio_write_ops,
>> >> +			   flags, NULL, 0);
>> >> +
>> >> +	if (ret == -ENOTBLK)
>> >> +		ret = 0;
>> >
>> > So iomap_dio_rw() doesn't have the DIO_SKIP_HOLES behavior of
>> > blockdev_direct_IO(). Thus you have to implement that in your
>> > ext2_iomap_ops, in particular in iomap_begin...
>> >
>>
>> Aah yes. Thanks for pointing that out -
>> ext2_iomap_begin() should have something like this -
>> 	/*
>> 	 * We cannot fill holes in indirect tree based inodes as that could
>> 	 * expose stale data in the case of a crash. Use the magic error code
>> 	 * to fallback to buffered I/O.
>> 	 */
>>
>> Also I think ext2_iomap_end() should also handle a case like in ext4 -
>>
>> 	/*
>> 	 * Check to see whether an error occurred while writing out the data to
>> 	 * the allocated blocks. If so, return the magic error code so that we
>> 	 * fallback to buffered I/O and attempt to complete the remainder of
>> 	 * the I/O. Any blocks that may have been allocated in preparation for
>> 	 * the direct I/O will be reused during buffered I/O.
>> 	 */
>> 	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
>> 		return -ENOTBLK;
>>
>>
>> I am wondering if we have testcases in xfstests which really tests these
>> functionalities also or not? Let me give it a try...
>> ... So I did and somehow couldn't find any testcase which fails w/o
>> above changes.
>
> I guess we don't. It isn't that simple (but certainly possible) to test for
> stale data exposure...
>

Yes, I am currently working on writing a aio dio test case to simulate
this. AFAIU, the stale data exposure problems with non-extent filesystem
is because it doesn't support unwritten extents. So in such case, if
we submit an aio-dio we on a hole (inside file i_size), then a racing
buffered read can race with it. That is, if the block allocation
happens via aio-dio then the buffered read can read stale data from
that block which is within inode i_size.

This is not a problem for extending file writes because we anyway update
file i_size after the write is done (and aio-dio is also synchronous
against extending file writes but that's is to avoid race against other
aio-dio).

And this is not a problem for fileystems which supports unwritten extent
because we can always allocate an unwritten extent inside a hole and then a
racing buffered read cannot read stale data (because unwritten extents returns 0).
Then unwritten to written conversion can happen at the end once the
data is already written to these blocks.


>> Another query -
>>
>> We have this function ext2_iomap_end() (pasted below)
>> which calls ext2_write_failed().
>>
>> Here IMO two cases are possible -
>>
>> 1. written is 0. which means an error has occurred.
>> In that case calling ext2_write_failed() make sense.
>>
>> 2. consider a case where written > 0 && written < length.
>> (This is possible right?). In that case we still go and call
>> ext2_write_failed(). This function will truncate the pagecache and disk
>> blocks beyong i_size. Now we haven't yet updated inode->i_size (we do
>> that in ->end_io which gets called in the end during completion)
>> So that means it just removes everything.
>>
>> Then in ext2_dax_write_iter(), we might go and update inode->i_size
>> to iocb->ki_pos including for short writes. This looks like it isn't
>> consistent because earlier we had destroyed all the blocks for the short
>> writes and we will be returning ret > 0 to the user saying these many
>> bytes have been written.
>> Again I haven't yet found a test case at least not in xfstests which
>> can trigger this short writes. Let me know your thoughts on this.
>> All of this lies on the fact that there can be a case where
>> written > 0 && written < length. I will read more to see if this even
>> happens or not. But I atleast wanted to capture this somewhere.
>
> So as far as I remember, direct IO writes as implemented in iomap are
> all-or-nothing (see iomap_dio_complete()). But it would be good to assert
> that in ext4 code to avoid surprises if the generic code changes.
>

Ok, I was talking about error paths. But I think I will park this one to
go through later.

>> Another thing -
>> In dax while truncating the inode i_size in ext2_setsize(),
>> I think we don't properly call dax_zero_blocks() when we are trying to
>> zero the last block beyond EOF. i.e. for e.g. it can be called with len
>> as 0 if newsize is page_aligned. It then will call ext2_get_blocks() with
>> len = 0 and can bug_on at maxblocks == 0.
>
> How will it call ext2_get_blocks() with len == 0? AFAICS iomap_iter() will
> not call iomap_begin() at all if iter.len == 0.
>

It can. In dax_zero_range() if we pass len = 0, then iomap_iter() can get
can get called with 0 len and it will call ->iomap_begin() with 0
len.
Maybe a WARN_ON() would certainly help in iomap_iter() to check against 0
iter->len to be passed to ->iomap_begin()

(Note iter->len and iter->iomap.length are different)

>> I think it should be this. I will spend some more time analyzing this
>> and also test it once against DAX paths.
>>
>> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
>> index 7ff669d0b6d2..cc264b1e288c 100644
>> --- a/fs/ext2/inode.c
>> +++ b/fs/ext2/inode.c
>> @@ -1243,9 +1243,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>>         inode_dio_wait(inode);
>>
>>         if (IS_DAX(inode))
>> -               error = dax_zero_range(inode, newsize,
>> -                                      PAGE_ALIGN(newsize) - newsize, NULL,
>> -                                      &ext2_iomap_ops);
>> +               error = dax_truncate_page(inode, newsize, NULL,
>> +                                         &ext2_iomap_ops);
>>         else
>>                 error = block_truncate_page(inode->i_mapping,
>>                                 newsize, ext2_get_block);
>
> That being said this is indeed a nice cleanup.

Sure. I will add this patch in the beginning of the next revision.

-ritesh
