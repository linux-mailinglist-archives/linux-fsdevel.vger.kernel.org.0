Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B9E78DBDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbjH3Sh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244013AbjH3MNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:13:39 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA91B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:13:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 50CA93200933;
        Wed, 30 Aug 2023 08:13:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 30 Aug 2023 08:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693397605; x=1693484005; bh=XzzcCQUsx0i4hqTD6D5QTjZiuONIdNuBU4j
        TP9sO5+0=; b=qbsNSVlepoy8aY38gaLv8er7K8hnc0y4sPfvd1PGsNhfemFUjyp
        TpHgzJPURsHvQQbOkAkAUoZrcxrFBBEdZTdbVC1b0mHfI++JUaPdgs/Q/ozG4yxw
        6iG+F4ula+ECcPUaooHMAHWJFt6xmj47RqDDEYv1TwlEANyqSNOltqczryIimAcy
        Gq9pzKaWvG94yp9DdR+aaufVJoNG4C6KPp2elIsOqL0RrU+XSEJY1w7xq6QrQ7H2
        s42WlCEf0SqT7L0HQXtFPSRyQR0wM15bXikPFK9k4mW+U35cLhu5PWQ80cGE6/lW
        SAzScGhu5w8Mq3r/wDQ56/3nEVPc68UJSGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693397605; x=1693484005; bh=XzzcCQUsx0i4hqTD6D5QTjZiuONIdNuBU4j
        TP9sO5+0=; b=hLOdaq7O1pkUVmwPo+SgGiMAIIfkdu7ayd/SlIRD8nuK8zSFsFc
        1xQRfPkrGKe/KdSgPJjf0bpi1o8b+tfFPew4Iqhh3q/f5/UBHjU54b93FndeA2s9
        MxWd18chRGhFp455g8+rpPh1JxTAeqHbLU0DSzJru2+wx2ezpear5wxsTR2TIlp/
        E2Ac7k5dfCNk0Nt7VyP/rf4PEb3GzkYnfBqLdOXih4P6tBxTKsIjumk7iOjp0oYu
        nqyfvu6omm2WP9nFF42zO7l4btIWP2GKwjI61y4uvRmKJG2slqXhFspwOBMiePTs
        k9vMfRsDVPQZT8OB0rdUjRVZPmIRMKQKaZA==
X-ME-Sender: <xms:ZTLvZDkw6x2VeBWxNMlQwNcIYNWmif_y5rtunsjn-_VWLf_PVQwfCA>
    <xme:ZTLvZG3a-DQkneKQfEuRosClSelt-mjmVNkYzl_j_BTV0NZo7Cc_WowBJsuOcGqtN
    QMweAGlkAQMYesW>
X-ME-Received: <xmr:ZTLvZJpGD_yRpdy4vh-yb8unX9dQ6350oSE7k-_tH1S9K3HvxsBddAQ5kYkWic5lPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegrrghkvghfsehfrghsthhmrghilhdrfhhmqeenucggtf
    frrghtthgvrhhnpedugfdukedtveeuvedtiefhtdeivdfgueejheeuiefgjeffkeduueei
    heffgfeuvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrghkvghfsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:ZTLvZLnXyvKg-1C6QQ9ErzaN6XmxkezfkUdfIqnwHyPl9XCOFk5_gA>
    <xmx:ZTLvZB3U_Sa84IEuNbKli97SY_PqZjwRm3s6EINrZjYiLi3ZYVdSOA>
    <xmx:ZTLvZKv6R9gcKboJT_lUZKJTwcbq1tAe43RYuIKG5PKFbJoKRwE9uQ>
    <xmx:ZTLvZMQS_KHMomcb1MTwklht10EaRx6wPH6LZcO2jPKKKHcLd2wBKQ>
Feedback-ID: id8a84192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 08:13:24 -0400 (EDT)
Message-ID: <efade42b-2c32-2f22-07a4-7541b60d3c32@fastmail.fm>
Date:   Wed, 30 Aug 2023 14:13:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/6] fuse: Create helper function if DIO write needs
 exclusive lock
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
 <20230829161116.2914040-3-bschubert@ddn.com>
 <CAJfpegvnxrmU=GgxGxZCh4oyhBk3HrPeWGLqwR7quJ2RPv5JjQ@mail.gmail.com>
Content-Language: en-US
From:   Bernd Schubert <aakef@fastmail.fm>
In-Reply-To: <CAJfpegvnxrmU=GgxGxZCh4oyhBk3HrPeWGLqwR7quJ2RPv5JjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/30/23 12:57, Miklos Szeredi wrote:
> On Tue, 29 Aug 2023 at 18:11, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> This is just a preparation to avoid code duplication in the next
>> commit.
>>
>> Cc: Hao Xu <howeyxu@tencent.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Dharmendra Singh <dsingh@ddn.com>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   fs/fuse/file.c | 48 +++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 33 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index b1b9f2b9a37d..6b8b9512c336 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1298,6 +1298,37 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
>>          return res;
>>   }
>>
>> +static bool fuse_io_past_eof(struct kiocb *iocb,
>> +                                              struct iov_iter *iter)
>> +{
>> +       struct inode *inode = file_inode(iocb->ki_filp);
>> +
>> +       return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
>> +}
>> +
>> +/*
>> + * @return true if an exclusive lock direct IO writes is needed
>> + */
>> +static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
>> +{
>> +       struct file *file = iocb->ki_filp;
>> +       struct fuse_file *ff = file->private_data;
>> +
>> +       /* server side has to advise that it supports parallel dio writes */
>> +       if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
>> +               return false;
> 
> You got the return values the wrong way around.  I can fix this, no
> need to resend.

Ooops, sorry! Do you mind to take this series for next merge round? I 
obviously didn't test the latest series yet and I would like to first 
test performance and do several rounds of xfs tests. That should be done 
by Monday, but might be a bit late for 6.6


Thanks,
Bernd
