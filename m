Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39C778E980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbjHaJeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 05:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjHaJeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:34:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2AE194
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 02:34:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 434153200942;
        Thu, 31 Aug 2023 05:34:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 31 Aug 2023 05:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693474450; x=1693560850; bh=/a1n3symXStpff9cwML22yksAnHXsMksQH0
        WrADmQXY=; b=DBPuAnmOzGpt0sAaH0hUVacXvTfB0H8P3W/zzEMq3sTnJx9cXGv
        LipOKKM27CUsDK2hOjLxpniIxILop8NDsnc3GszMjBZcHteY2vhGcihiMvUJEL9T
        1L6yjjanmgxELf+Zut6nBANzBB9MXrupT1IsV9kdJaNkrH4UDy2T8BZex7rGx4mY
        X4hdHrRYvgueRhfwsBhZVPqB4/s8ihiguLAhscMa8oK9rIOgEcPcmMDQSi8QkW9j
        wwfM4ARPWFCANl77NVlaUy0V4SMCz5pxJ189wSbqxQFexolF1YLN5ORzmd9PI/dj
        jJsSZl+oa6Np5zh4B+EY/ALbHcG2LPTLGJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693474450; x=1693560850; bh=/a1n3symXStpff9cwML22yksAnHXsMksQH0
        WrADmQXY=; b=pP/dUiU1yQKwviXA1pDymcbZlLwfrMpp94+Frhzv+ySlVW6IOBb
        BPZ1/Gkl9TyYw/2r9jyqhAWhvY6rNekb90qP5sW1fgdSt4cEPbLPbx4X1nBZBweb
        w0hl5QskCwHMmX9m/qusbYooJT0/IFOEaJ0D30W90tIbATAuMO989ZWiQCzgit9j
        9ulWJkdOBJzVL6x5/6XZEWAjUjjy3bkPWz9hRyAaYY19yhBWXEpMsrZ/sPn5YxWT
        2CzKz7XMAqV5jbS0Lds9NacJvu2j0E2757A2aUGtzsrLuAZy+YBqZG4xHVgW7xJw
        SAzj8cJAiUF8ee0y29CdbbDFKY8/BJdJpfw==
X-ME-Sender: <xms:kV7wZPMZrmqt-Z9YmfnibfuRGpr_qZVkAuvrX_rJ6Qi4QrvpR_nxyA>
    <xme:kV7wZJ96a8W3rarxzmU9b8ZpX5p1cUk_cbJNtyTfkwsBkcodynzEwa0froU8TLAsi
    kjAmowduYosXK0e>
X-ME-Received: <xmr:kV7wZORn4oJP4uSX17mjtlnd9LeuBM9qwxTQJm-NxJDdZEXHb_No97aHQteiaqSkcXVr_P8-BfuI0Q4Gq78zWcL9fiFgu2ZuBhZw9D2ufWEHctABzfL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:kV7wZDuA0ObnOd5L4VPnw-SJMjMCi3oSiXkpMV9TdcIFFr8nBkmTdA>
    <xmx:kV7wZHdfozbUPpMUd-VItySdLxT6Y-9fWIENrgPK_-bWrmvP01lL7g>
    <xmx:kV7wZP0r7789R9IXZINpL99HJXM2ZxZ4AkWNoA3dq8EO-axEg2C2cA>
    <xmx:kl7wZO6RoXOJeTYL4-98oesScpG2-SBaNrqUi5zQOAlFDGpRQCFXFg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 05:34:08 -0400 (EDT)
Message-ID: <ba998811-636e-f2e4-8b59-173798d9b46f@fastmail.fm>
Date:   Thu, 31 Aug 2023 11:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 5/6] fuse: Remove fuse_direct_write_iter code path / use
 IOCB_DIRECT
To:     Hao Xu <hao.xu@linux.dev>, Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org
Cc:     miklos@szeredi.hu, dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
 <20230829161116.2914040-6-bschubert@ddn.com>
 <5eaa9d17-b27c-1fbe-2575-1c4bc57f024e@linux.dev>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <5eaa9d17-b27c-1fbe-2575-1c4bc57f024e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/31/23 11:19, Hao Xu wrote:
> On 8/30/23 00:11, Bernd Schubert wrote:
>> fuse_direct_write_iter is basically duplicating what is already
>> in fuse_cache_write_iter/generic_file_direct_write. That can be
>> avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
>> fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
>> and fuse_direct_write_iter can be removed.
>>
>> Before it was using for FOPEN_DIRECT_IO
>>
>> 1) async (!is_sync_kiocb(iocb)) && IOCB_DIRECT
>>
>> fuse_file_write_iter
>>      fuse_direct_write_iter
>>          fuse_direct_IO
>>              fuse_send_dio
>>
>> 2) sync (is_sync_kiocb(iocb)) or IOCB_DIRECT not being set
>>
>> fuse_file_write_iter
>>      fuse_direct_write_iter
>>          fuse_send_dio
>>
>> 3) FOPEN_DIRECT_IO not set
>>
>> Same as the consolidates path below
>>
>> The new consolidated code path is always
>>
>> fuse_file_write_iter
>>      fuse_cache_write_iter
>>          generic_file_write_iter
>>               __generic_file_write_iter
>>                   generic_file_direct_write
>>                       mapping->a_ops->direct_IO / fuse_direct_IO
>>                           fuse_send_dio
>>
>> So in general for FOPEN_DIRECT_IO the code path gets longer. Additionally
>> fuse_direct_IO does an allocation of struct fuse_io_priv - might be a bit
>> slower in micro benchmarks.
>> Also, the IOCB_DIRECT information gets lost (as we now set it outselves).
>> But then IOCB_DIRECT is directly related to O_DIRECT set in
>> struct file::f_flags.
>>
>> An additional change is for condition 2 above, which might will now do
>> async IO on the condition ff->fm->fc->async_dio. Given that async IO for
>> FOPEN_DIRECT_IO was especially introduced in commit
>> 'commit 23c94e1cdcbf ("fuse: Switch to using async direct IO for
>>   FOPEN_DIRECT_IO")'
>> it should not matter. Especially as fuse_direct_IO is blocking for
>> is_sync_kiocb(), at worst it has another slight overhead.
>>
>> Advantage is the removal of code paths and conditions and it is now also
>> possible to remove FOPEN_DIRECT_IO conditions in fuse_send_dio
>> (in a later patch).
>>
>> Cc: Hao Xu <howeyxu@tencent.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Dharmendra Singh <dsingh@ddn.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   fs/fuse/file.c | 54 ++++----------------------------------------------
>>   1 file changed, 4 insertions(+), 50 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index f9d21804d313..0b3363eec435 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1602,52 +1602,6 @@ static ssize_t fuse_direct_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>       return res;
>>   }
>> -static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct 
>> iov_iter *from)
>> -{
>> -    struct inode *inode = file_inode(iocb->ki_filp);
>> -    struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
>> -    ssize_t res;
>> -    bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
>> -
>> -    /*
>> -     * Take exclusive lock if
>> -     * - Parallel direct writes are disabled - a user space decision
>> -     * - Parallel direct writes are enabled and i_size is being 
>> extended.
>> -     *   This might not be needed at all, but needs further 
>> investigation.
>> -     */
>> -    if (exclusive_lock)
>> -        inode_lock(inode);
>> -    else {
>> -        inode_lock_shared(inode);
>> -
>> -        /* A race with truncate might have come up as the decision for
>> -         * the lock type was done without holding the lock, check again.
>> -         */
>> -        if (fuse_io_past_eof(iocb, from)) {
>> -            inode_unlock_shared(inode);
>> -            inode_lock(inode);
>> -            exclusive_lock = true;
>> -        }
>> -    }
>> -
>> -    res = generic_write_checks(iocb, from);
>> -    if (res > 0) {
>> -        if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
>> -            res = fuse_direct_IO(iocb, from);
>> -        } else {
>> -            res = fuse_send_dio(&io, from, &iocb->ki_pos,
>> -                        FUSE_DIO_WRITE);
>> -            fuse_write_update_attr(inode, iocb->ki_pos, res);
>> -        }
>> -    }
>> -    if (exclusive_lock)
>> -        inode_unlock(inode);
>> -    else
>> -        inode_unlock_shared(inode);
>> -
>> -    return res;
>> -}
>> -
>>   static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct 
>> iov_iter *to)
>>   {
>>       struct file *file = iocb->ki_filp;
>> @@ -1678,10 +1632,10 @@ static ssize_t fuse_file_write_iter(struct 
>> kiocb *iocb, struct iov_iter *from)
>>       if (FUSE_IS_DAX(inode))
>>           return fuse_dax_write_iter(iocb, from);
>> -    if (!(ff->open_flags & FOPEN_DIRECT_IO))
>> -        return fuse_cache_write_iter(iocb, from);
>> -    else
>> -        return fuse_direct_write_iter(iocb, from);
>> +    if (ff->open_flags & FOPEN_DIRECT_IO)
>> +        iocb->ki_flags |= IOCB_DIRECT;
> 
> I think this affect the back-end behavior, changes a buffered IO to 
> direct io. FOPEN_DIRECT_IO means no cache in front-end, but we should
> respect the back-end semantics. We may need another way to indicate
> "we need go the direct io code path while IOCB_DIRECT is not set though".

I'm confused here, I guess with frontend you mean fuse kernel and with 
backend fuse userspace (daemon/server). IOCB_DIRECT is not passed to 
server/daemon, so there is no change? Although maybe I should document 
in fuse_write_flags() to be careful with returned flags and that 
IOCB_DIRECT cannot be trusted - if this should ever passed, one needs to 
use struct file::flags & O_DIRECT.


Thanks,
Bernd


Thanks,
Bernd
