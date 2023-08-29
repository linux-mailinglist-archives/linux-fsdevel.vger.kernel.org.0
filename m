Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F478C4E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjH2NJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjH2NIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:08:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00C90
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 06:08:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 436735C00D4;
        Tue, 29 Aug 2023 09:08:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 29 Aug 2023 09:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693314528; x=1693400928; bh=bNFd63536z5je3n/vlj7ujdPw1psJdsXiE1
        v8vEvN3s=; b=pmXBAleR6fbXJPjk/Ba2gexdYbMs7ise8VV0NZWDpT8TMYMrLSk
        LZlBFBRdYjNz691LvW6OA0nfOrJ3lvc6hh7Ao3AU45um872itFp64FQnZAp11Y6r
        YfQ+eQWU58PvcFRN6pVDcn5xBX7NMpqkHMUOYT+3HJdmP5f5kV2eaBZTqEVoZE/K
        bfee5fU+ontGvOV2joH3XTNB6hCA6fZiRWA9FXEfzNKas+6M8Rj2m97c0EEo9YAm
        tdohFhpe1ZYvTobi9ty77kdKYvxq5ti4+Y3xtG2tUA2OTj15VURIHanX30REtNAP
        USQ3Ru5VoZPZ27mkBC0frv/f2oIaRrTLSaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693314528; x=1693400928; bh=bNFd63536z5je3n/vlj7ujdPw1psJdsXiE1
        v8vEvN3s=; b=0kne1nIA5BD7qeZ9GdLHKqrm9Tgb9Zsb4y/q9jOMnLR5g6P8t05
        v8ExrsVUlunz3jbOB15wlj9ZpfTLlcRG94vGc4ZoubOD3sb7P7nGLh+3IE5lc3e9
        hdem9tKmDSxfA4ulvvDkoWCdI0KnzjdiRb4MLb7cqrm4yZILQ3GXFad9ROgko1C4
        DyEu4QNIXGhNw9XzZumlpcHZSK7of0C2Zi5QHHyIrhrFMqovmQfDYhD1q4JdpqQ/
        2Tirez7YydSzdILQKVWwE+9tTzvYKClDOVoKfIRP+b+/FjVWA4HbTutRRa4USkLO
        X8zWzCwVoT/VKftzWtZjPn+C8gUD8d6aAHA==
X-ME-Sender: <xms:3-3tZMTQwEd5qgKhNtuyFcnOCqkkxekckFIGS9BZrDIp7iCXGof-GA>
    <xme:3-3tZJwXT33awkLK7MqGQIp4CCAvBy-xbbXjd8dzFWa9bRKH5JNTLdz_nmKl6Ij9X
    np7idzAbQ20MSZc>
X-ME-Received: <xmr:3-3tZJ2NE21DjlV9_o6HhoPeIgjgj2nuN61t2-Q_P7MGhTQUfRc5LjLD4RZlvPUlO2TeZw0hI6jU-fx_VHfykWZsIMqVki79q0FJp-w-fgFbe_ccQAM_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefiedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:3-3tZADGLfpld7AGu9sSGb6V58v65RlViuscCYTq-dyBNuGXEDIQ6w>
    <xmx:3-3tZFgSpWn-1hQ6IKzssU3Q4W0tAHpAhbMQ8pFM_PFG01qKgntC3A>
    <xmx:3-3tZMp7ygMWW40PHUv5X2IKQ8JhMz3HfN-GQmhW2EsQv3QTqx4KOQ>
    <xmx:4O3tZKvQ1n8xoaFInSCxHzYvy73cFkKpvUWGBwWJqGC6XnKnTkvXIA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 09:08:47 -0400 (EDT)
Message-ID: <6e0cc058-7163-ffc6-3b7e-b459af4d6f8c@fastmail.fm>
Date:   Tue, 29 Aug 2023 15:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when
 FOPEN_DIRECT_IO is set
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
 <20230824150533.2788317-5-bschubert@ddn.com>
 <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com>
 <d2a7e7a3-6273-475c-8e7c-96de547a5d71@fastmail.fm>
 <CAJfpegu9MDSB-pCmZr_mz64Cc1r-q8TkNmR7BH6TO3SCq2HAVA@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegu9MDSB-pCmZr_mz64Cc1r-q8TkNmR7BH6TO3SCq2HAVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/28/23 17:05, Miklos Szeredi wrote:
> On Mon, 28 Aug 2023 at 16:48, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>> On 8/28/23 13:59, Miklos Szeredi wrote:
>>> On Thu, 24 Aug 2023 at 17:07, Bernd Schubert <bschubert@ddn.com> wrote:
> 
>>>> -               if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
>>>> -                       res = fuse_direct_IO(iocb, from);
>>>> -               } else {
>>>> -                       res = fuse_direct_io(&io, from, &iocb->ki_pos,
>>>> -                                            FUSE_DIO_WRITE);
>>>> -                       fuse_write_update_attr(inode, iocb->ki_pos, res);
>>>
>>> While I think this is correct, I'd really like if the code to be
>>> replaced and the replacement are at least somewhat comparable.
>>
>> Sorry, I have a hard to time to understand "I'd really like if the code
>> to be replaced".
> 
> What I meant is that generic_file_direct_write() is not an obvious
> replacement for the  above lines of code.
> 
> The reason is that fuse_direct_IO() is handling the sync and async
> cases in one function, while the above splits handling it based on
> IOCB_DIRECT (which is now lost) and is_sync_kiocb(iocb).  If it's okay
> to lose IOCB_DIRECT then what's the explanation for the above
> condition?  It could be historic garbage, but we still need to
> understand what is exactly happening.

While checking all code path again, I found an additional difference, 
which I had missed before. FOPEN_DIRECT_IO will now act on 
ff->fm->fc->async_dio when is is_sync_kiocb(iocb) is set.

Do you think that is a problem? If so, I could fix it in fuse_direct_IO.


Thanks,
Bernd
