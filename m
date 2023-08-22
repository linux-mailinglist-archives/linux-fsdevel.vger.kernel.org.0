Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A880178498B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjHVSrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 14:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjHVSrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:47:04 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A033CCE5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 11:47:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B78143200908;
        Tue, 22 Aug 2023 14:47:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 22 Aug 2023 14:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692730021; x=1692816421; bh=FatECveXA/ElEKcMqx73Jt5dQ7YrLluFK37
        nJSqe+iw=; b=DqrfHXlIAbOn0dzTY5ZnzPcwP2+AnHkavJtFXjzOu0h9wQ9Wjpa
        t2ss9JuFsikBjgXyr4AVv0QXvknacWXuurAFLq5T6GTEw+WnhPXNRDgcf6FSeGbZ
        LdwxYumaJwAuk7CZdh7vxQJW3Ai1VQoHn6+LyjzeN2cElUOOANTm3/ngEyAsZWkB
        5bEqhhOpATp4yaIFPFtGdl004H/IsW+nrbupzfWo8gJxahQ23Fa8sCKy76Gn0i89
        qGSei3H6n0fIx3J+yHuuf3X+DfoncZrwuEZg9RHUmTjgiKAvnV3ExQEms7AvDPhc
        RgK0b2W26jwYZP7rDXmJK41rxkSDsH8p/2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692730021; x=1692816421; bh=FatECveXA/ElEKcMqx73Jt5dQ7YrLluFK37
        nJSqe+iw=; b=h1bEMImbb67cjKL6rYtweTOWDAnJubdknlYZt6/+DfC5n1Yjj7i
        WB98VJEN4WiswNASYb5nZytlQy3YJ9Y3TUbEouWFp7C6yVm1L2++M2qaBiGZFmS4
        EM6KvAPlAa8zKuXSY9Lx1YLmzXahUcsiDIuJ9sMVoxijQu90m4j29GhTK31zK1zD
        SnHot2iUUN6t1BfQ0vMKPJaJ6tE8pHInCL3nvMg8wQ+K/XttaX6e8pWBycE09gxy
        cb1JssItPbmLrb5YUCKL7inxBNSirBftT5jcfetqakWPO2ox7tuuq6pbluGbbvM8
        FBW/mtPoyjz9JjAMUFMkOLNziD6mpgKna9A==
X-ME-Sender: <xms:pALlZM2_34jG_yoSQX-yAXltix0kGpJeBuD0VsYlab8y1UVjZD2y4w>
    <xme:pALlZHH0iCy5x4r9dBQAgHDzdN2gUUUzcFwuOovSUgLuV2mFvnXCNSt-DgRuPP45C
    rAhAld3bKAHb22b>
X-ME-Received: <xmr:pALlZE7yeU9mbbgL31N07xFCwp2rTRv1aL0GLGuP111GFaiaU-pGGG62OGY5bwnNUyfS18IulGojFiQe-ixdMaSm7e4ay89nLpTilJSZ94ZdMfF-YrSW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudej
    jeeiheehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:pALlZF2raa8Lvx9wo_kDjkwtZbtxUFdIqs3sn2KhR6SlKshWwWIUyw>
    <xmx:pALlZPFI83uB0tc67qXkFv3xflSk-V7pj9Kg-h7WQ2JETuSkRRhaBw>
    <xmx:pALlZO8wMRd1uqYk-_JlfFkeJLrC8KyXSdO8YGqbF9-42j4jlK1jZA>
    <xmx:pQLlZAPOZDySDFyn-0qFlIQwFpXaQovlNGEeZHUjoqrZRhIvXYRG9w>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 14:46:59 -0400 (EDT)
Message-ID: <1d58149e-d21f-e809-6ddc-25045268a0e0@fastmail.fm>
Date:   Tue, 22 Aug 2023 20:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] [RFC for fuse-next ] fuse: DIO writes always use the
 same code path
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dharmendra Singh <dsingh@ddn.com>
References: <20230821174753.2736850-1-bschubert@ddn.com>
 <20230821174753.2736850-2-bschubert@ddn.com>
 <CAJfpegv6Q5O435xSrYUMEQAvvkObV6gWws8Ju7C+PrSKwjmSew@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegv6Q5O435xSrYUMEQAvvkObV6gWws8Ju7C+PrSKwjmSew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/22/23 11:53, Miklos Szeredi wrote:
> On Mon, 21 Aug 2023 at 19:48, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> There were two code paths direct-io writes could
>> take. When daemon/server side did not set FOPEN_DIRECT_IO
>>      fuse_cache_write_iter -> direct_write_fallback
>> and with FOPEN_DIRECT_IO being set
>>      fuse_direct_write_iter
>>
>> Advantage of fuse_direct_write_iter is that it has optimizations
>> for parallel DIO writes - it might only take a shared inode lock,
>> instead of the exclusive lock.
>>
>> With commits b5a2a3a0b776/80e4f25262f9 the fuse_direct_write_iter
>> path also handles concurrent page IO (dirty flush and page release),
>> just the condition on fc->direct_io_relax had to be removed.
>>
>> Performance wise this basically gives the same improvements as
>> commit 153524053bbb, just O_DIRECT is sufficient, without the need
>> that server side sets FOPEN_DIRECT_IO
>> (it has to set FOPEN_PARALLEL_DIRECT_WRITES), though.
> 
> Consolidating the various direct IO paths would be really nice.
> 
> Problem is that fuse_direct_write_iter() lacks some code from
> generic_file_direct_write() and also completely lacks
> direct_write_fallback().   So more thought needs to go into this.

Thanks for looking at it! Hmm, right, I see. I guess at least
direct_write_fallback() should be done for the new relaxed
mmap mode.

Entirely duplicating generic_file_direct_write()
to generic_file_direct_write doesn't seem to be nice either.

Regarding the inode lock, it might be easier to
change fuse_cache_write_iter() to a shared lock, although that
does not help when fc->writeback_cache is enabled, which has yet
another code path. Although I'm not sure that is needed
direct IO. For the start, what do you think about

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..b1b9f2b9a37d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1307,7 +1307,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
         ssize_t err;
         struct fuse_conn *fc = get_fuse_conn(inode);
  
-       if (fc->writeback_cache) {
+       if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
                 /* Update size (EOF optimization) and mode (SUID clearing) */
                 err = fuse_update_attributes(mapping->host, file,
                                              STATX_SIZE | STATX_MODE);


Thanks,
Bernd
