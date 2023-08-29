Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149CB78C547
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjH2N2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbjH2N1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:27:48 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC3FCC4
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 06:27:04 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 46ADC5C019D;
        Tue, 29 Aug 2023 09:27:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 29 Aug 2023 09:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693315621; x=1693402021; bh=NiqF8kHsAHjDKuOge3BvRsuKwFBQqXsctIL
        RUtS4R5I=; b=Yh2WjS5JlEGOBc0hoC024bFo+GaTXhM2wIiii/vaxKXQQ71ZabB
        hqsCX+8C9tz3NWlmeNBCj+v2y/vh8/pihJy6AWI2LLQKt+ZG5o9hmxbW6WzZ4k5d
        eydQgyWarGxGl4+ZlVYXqMl4EITjO0NSYPk0bdCyB4ir373S9vLVzc7LamnnDDwB
        2hyGH09kHze+3FChJRtJOuTu+qNLd+RJS/sevHwOMXJ83EOC6EBKo37nzmAPdDk9
        9iAoKmpXRb2DAXjpiG4MLRWtY+USggdwkx7JRlEaPYlI3A1XpInas3IkQraRORbo
        l7ioqWI1j7SO+/LYh47Q5sRqKlUGWhnSR5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693315621; x=1693402021; bh=NiqF8kHsAHjDKuOge3BvRsuKwFBQqXsctIL
        RUtS4R5I=; b=poGciUdaEw2BamlPZCCCfjdkFbGOrior6s32h+92DZsaI0aK67J
        esYxbn8wYPstIkizU4cTkxXCrhAqaZBnqrdUoOwF3aYou8eM4CTnVU+SRhiWozOE
        gLEnyWVUPoxWizJoGuBKL7ZxN0yFd2xHs2GbnP33vpR9etGXxsyzo1NzgiYWur50
        ZxEZCHkoXetL8vmcwvcYbbEjBJE9BD4QjmHuxeahoXESIPKnvRU+Xv5Zp39a129I
        /r+er5r17Md7EomX4vRxjTP15r6GX2zYMf4HPFQdG4R7Z8a9dE50LbcLwaGRhmgl
        RBu7qE7CS6paAnOygk53XqFEIksudlmQjyA==
X-ME-Sender: <xms:JPLtZCUsoLZeXoPLwSifPvlJuAonH0_d46lnwcI9usg34Aw1zjneHw>
    <xme:JPLtZOkl7rnpe1afS-81gzGN26Ny0eTtniMZLIgBwsCxMZI1w3gb5ITgToMfc56fv
    L6gDxyE7GZ82yyU>
X-ME-Received: <xmr:JPLtZGbSoRjZkj8U_Rxe8rrpAIKNYNak0ntZqTRIwk9dCh6UKARMx3tSyRVBZ1AnkTYlBXNpYOP2eCp0HLuLJ0iVBLCIkhgnKrBQB7tlhj-tz2VpFN7a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefiedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:JPLtZJWl2Y60-esHNd4ULgo14_I2M8XajWXt6xXElZ08_i1afNAuNg>
    <xmx:JPLtZMkiD3V85sLTnjNcm1ELBco7As0xcTZOvwThZcWFtIJkbfvJ1A>
    <xmx:JPLtZOcB5VAuAAUPH1i2TsVmS8XragaAXwczio_ibofRtZv6l9JLkQ>
    <xmx:JfLtZGgdv07dMNMiVUnUQ1FuI4JJLZlv1ejUSK6CQfgggvwzWNfddg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 09:26:59 -0400 (EDT)
Message-ID: <058bb99c-b722-c5f1-6f0c-759f194ed5ff@fastmail.fm>
Date:   Tue, 29 Aug 2023 15:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when
 FOPEN_DIRECT_IO is set
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
References: <20230824150533.2788317-1-bschubert@ddn.com>
 <20230824150533.2788317-5-bschubert@ddn.com>
 <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com>
 <d2a7e7a3-6273-475c-8e7c-96de547a5d71@fastmail.fm>
 <CAJfpegu9MDSB-pCmZr_mz64Cc1r-q8TkNmR7BH6TO3SCq2HAVA@mail.gmail.com>
 <6e0cc058-7163-ffc6-3b7e-b459af4d6f8c@fastmail.fm>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <6e0cc058-7163-ffc6-3b7e-b459af4d6f8c@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/29/23 15:08, Bernd Schubert wrote:
> 
> 
> On 8/28/23 17:05, Miklos Szeredi wrote:
>> On Mon, 28 Aug 2023 at 16:48, Bernd Schubert 
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>> On 8/28/23 13:59, Miklos Szeredi wrote:
>>>> On Thu, 24 Aug 2023 at 17:07, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>>>>> -               if (!is_sync_kiocb(iocb) && iocb->ki_flags & 
>>>>> IOCB_DIRECT) {
>>>>> -                       res = fuse_direct_IO(iocb, from);
>>>>> -               } else {
>>>>> -                       res = fuse_direct_io(&io, from, &iocb->ki_pos,
>>>>> -                                            FUSE_DIO_WRITE);
>>>>> -                       fuse_write_update_attr(inode, iocb->ki_pos, 
>>>>> res);
>>>>
>>>> While I think this is correct, I'd really like if the code to be
>>>> replaced and the replacement are at least somewhat comparable.
>>>
>>> Sorry, I have a hard to time to understand "I'd really like if the code
>>> to be replaced".
>>
>> What I meant is that generic_file_direct_write() is not an obvious
>> replacement for the  above lines of code.
>>
>> The reason is that fuse_direct_IO() is handling the sync and async
>> cases in one function, while the above splits handling it based on
>> IOCB_DIRECT (which is now lost) and is_sync_kiocb(iocb).  If it's okay
>> to lose IOCB_DIRECT then what's the explanation for the above
>> condition?  It could be historic garbage, but we still need to
>> understand what is exactly happening.
> 
> While checking all code path again, I found an additional difference, 
> which I had missed before. FOPEN_DIRECT_IO will now act on 
> ff->fm->fc->async_dio when is is_sync_kiocb(iocb) is set.
> 
> Do you think that is a problem? If so, I could fix it in fuse_direct_IO.

What I mean is something like this

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 85f2f9d3813e..3b383dc8a944 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1635,8 +1635,10 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
  	if (FUSE_IS_DAX(inode))
  		return fuse_dax_write_iter(iocb, from);
  
-	if (ff->open_flags & FOPEN_DIRECT_IO)
+	if (ff->open_flags & FOPEN_DIRECT_IO) {
  		iocb->ki_flags |= IOCB_DIRECT;
+		ff->iocb_direct = 1;
+	}
  
  	return fuse_cache_write_iter(iocb, from);
  }
@@ -2905,6 +2907,15 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
  	io->iocb = iocb;
  	io->blocking = is_sync_kiocb(iocb);
  
+	/* FOPEN_DIRECT_IO historically does not use async for blocking O_DIRECT */
+	if (ff->open_flags & FOPEN_DIRECT_IO) {
+		if (!is_sync_kiocb(iocb) && ff->iocb_direct) {
+			/* no change */
+		} else {
+			io->async = 0;
+		}
+	}
+
  	/* optimization for short read */
  	if (io->async && !io->write && offset + count > i_size) {
  		iov_iter_truncate(iter, fuse_round_up(ff->fm->fc, i_size - offset));
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a56e83b7d29a..d77046875ad5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -231,6 +231,9 @@ struct fuse_file {
  
  	/** Has flock been performed on this file? */
  	bool flock:1;
+
+	/** Has the file been opened with O_DIRECT? */
+	bool iocb_direct:1;
  };
  
  /** One input argument of a request */


Thanks,
Bernd
