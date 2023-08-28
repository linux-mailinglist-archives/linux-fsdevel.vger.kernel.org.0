Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B032378B391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjH1Os7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjH1Ost (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:48:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899A139
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 07:48:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0A1443200B30;
        Mon, 28 Aug 2023 10:48:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 28 Aug 2023 10:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693234113; x=1693320513; bh=u4u/sg93eCauE4wHciOftW/3EIXea1QPzrK
        pZ6XpDV4=; b=pF4wI5q1GAb+HZwKJUuf7n/RUmRrOGHKarZcV5WzBwVfty1gwvy
        /63LdRVtZe/sxAw0LImBTkZPzjAEh6oR3mcv78C1CTbPjMK1tM8gnhrRX5JGQl1V
        Oneb4cdq0//ahgL5568Ql9TUAAbcTZ/yFzVH/qiOqcO0hSXpB1kbJCFMAKYux+Ns
        218OGXPOZi6PT4SErKD7zREgW6+hILL0KGS7eegEHqnbrc7shKDKx6W+P4Tczg6q
        ocqRe235wYK17750usWIzvh/VyUH461QBUMdQxCJULqDc393kYggyZ0MEEmJIywe
        Jc/zaNt/PFFVO3IwdJBNpORpa4LWzjuL3Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693234113; x=1693320513; bh=u4u/sg93eCauE4wHciOftW/3EIXea1QPzrK
        pZ6XpDV4=; b=TxIP4TmSH4VgjhGqnx4PbBCsIXX387osjXzMXWmw/Zo/VZzmNQu
        ZPgulReJJnHHsMQAzws/uLldIIPqoeoJStkPKNM82uE1+9QTPvySapIqxBfewQ1/
        aNjq0EJwbTu3UdDRGGY4js8eRzSGcDpqNCYWgI/lgu1xyKnfEc7ESf70s7pXYQ+j
        6G3ud19TeCmwO1mGgiGuf0h0bOuf/gMFWN30KqREAdAYjGWT64yLjhwv2sxC7jwv
        ZH4Af1Dl1To3HraG3ImdirnJroyaDrqg0dbeq1x+nNTPk+Zuy1rNzoesIoYOk3fZ
        syhDavfdypVFvWY3z/iemt58f0JrRvNh1Qw==
X-ME-Sender: <xms:wbPsZKVoX3sjULN1BJjyia9Fzn_bz9WAnJ0FMGy0TI_eSIirJfsVQw>
    <xme:wbPsZGnotRVukB50LkxFL485ZoSbvCHvaN0MXTJ-7e2cNyrt9wU3yYqh-pnWgV1h4
    AoQvnzBlPzfjqb3>
X-ME-Received: <xmr:wbPsZOaibvNQTHx3k9q6ItD8oZxUPo6gjvfT3wHC5Nko3U0qMZOuM9D6kW0f7H5yyZb_MPmnBzV0coj4ZKwQisCEpFqkEgBbipRvHcx21YNU0gAehnVd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:wbPsZBVsYfGvcW5UNd1VXko6nIdiFNarKcROjzKiCP6DXRfy1s_H9Q>
    <xmx:wbPsZEmnNWMgod_FU9z7kkEHfdxTEdLc8W2mSc0oGsV_n_4md-cvhw>
    <xmx:wbPsZGdsVni7OThmtwKBxglAxER7XpMcYdjJXYkjOXwWKtEa1wpTWw>
    <xmx:wbPsZOhXA7rTuDnDL5z79oNzkCjxUSOvdnyOeetZdXL24lCGIbDmBQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 10:48:32 -0400 (EDT)
Message-ID: <d2a7e7a3-6273-475c-8e7c-96de547a5d71@fastmail.fm>
Date:   Mon, 28 Aug 2023 16:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when
 FOPEN_DIRECT_IO is set
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
        Hao Xu <howeyxu@tencent.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
 <20230824150533.2788317-5-bschubert@ddn.com>
 <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/28/23 13:59, Miklos Szeredi wrote:
> On Thu, 24 Aug 2023 at 17:07, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> fuse_direct_write_iter is basically duplicating what is already
>> in fuse_cache_write_iter/generic_file_direct_write. That can be
>> avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
>> fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
>> and fuse_direct_write_iter can be removed.
>>
>> Cc: Hao Xu <howeyxu@tencent.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Dharmendra Singh <dsingh@ddn.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   fs/fuse/file.c | 54 ++++----------------------------------------------
>>   1 file changed, 4 insertions(+), 50 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 905ce3bb0047..09277a54b711 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1589,52 +1589,6 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>          return res;
>>   }
>>
>> -static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>> -{
>> -       struct inode *inode = file_inode(iocb->ki_filp);
>> -       struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
>> -       ssize_t res;
>> -       bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
>> -
>> -       /*
>> -        * Take exclusive lock if
>> -        * - Parallel direct writes are disabled - a user space decision
>> -        * - Parallel direct writes are enabled and i_size is being extended.
>> -        *   This might not be needed at all, but needs further investigation.
>> -        */
>> -       if (exclusive_lock)
>> -               inode_lock(inode);
>> -       else {
>> -               inode_lock_shared(inode);
>> -
>> -               /* A race with truncate might have come up as the decision for
>> -                * the lock type was done without holding the lock, check again.
>> -                */
>> -               if (fuse_direct_write_extending_i_size(iocb, from)) {
>> -                       inode_unlock_shared(inode);
>> -                       inode_lock(inode);
>> -                       exclusive_lock = true;
>> -               }
>> -       }
>> -
>> -       res = generic_write_checks(iocb, from);
>> -       if (res > 0) {
>> -               if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
>> -                       res = fuse_direct_IO(iocb, from);
>> -               } else {
>> -                       res = fuse_direct_io(&io, from, &iocb->ki_pos,
>> -                                            FUSE_DIO_WRITE);
>> -                       fuse_write_update_attr(inode, iocb->ki_pos, res);
> 
> While I think this is correct, I'd really like if the code to be
> replaced and the replacement are at least somewhat comparable.

Sorry, I have a hard to time to understand "I'd really like if the code 
to be replaced".

> 
> Currently fuse_direct_IO() handles all cases (of which are many since
> the requester can be sync or async and the server can be sync or
> async).
> 
> Could this mess be cleaned up somehow?


I guess what you mean is to make the the replacement more obvious? I can 
try... I need to think about how to do that. Before submitting the patch 
I had looked up different code paths and I think fuse_direct_IO (called 
by fuse_cache_write_iter -> generic_file_direct_write) all handles it.

Maybe a new patch like this in fuse_file_write_iter

if (condition1)
     fuse_cache_write_iter

if (condition2)
     fuse_cache_write_iter

...

and once all conditions in fuse_direct_write_iter are handled in 
fuse_file_write_iter another the final patch (what is current this 4/5) 
to remove fuse_direct_write_iter?


> 
> Also could we make the function names of fuse_direct_IO() and
> fuse_direct_io() less similar, as this is a very annoying (though
> minor) issue.


Entirely agreed, I had already thought about it, but wasn't sure why it 
was named like this and didn't want to change too much.


Thanks,
Bernd
