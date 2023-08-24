Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7713D786C52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbjHXJwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 05:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbjHXJwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:52:03 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465B170F
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 02:52:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1CAB15C0103;
        Thu, 24 Aug 2023 05:52:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 24 Aug 2023 05:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692870721; x=1692957121; bh=WFCGou9IU8/Qtgt/+d6AwSTt9G7My//OW64
        NGyhQV/A=; b=KOS4s8ggL8rJNxOKlDzUL5XCxmTqkcGufWUekN0+3n/d2qi5qLU
        Y+qngO0mBbVCcAgcqnLkoe6lyzZerIlxEb4yUmVWAIahfIQbwgAGk1Fe8nDJt7LF
        QKA2koTmJQ2zKwTVJgRWzTE0UkuRX3coU1Xi+wpnN9lVjUFA3+aK3cabot+C8qfc
        MzSoX8hKGtf3KUehejIwlojTpRqLOChCvhkHxGEe5Nz8sqx70lMt6MFAEYLjFwIq
        nhQIHttZcmyKLhloh1X3TwHf8LNv/yBPQzgRTVGxNKkAl4UcivFrUuUJCU6uL+mZ
        prakSfsRlyd7D//ESzRrvRnS2khvh8hjfDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692870721; x=1692957121; bh=WFCGou9IU8/Qtgt/+d6AwSTt9G7My//OW64
        NGyhQV/A=; b=irfVvdk+6/1dvElnlfTBTxSTsyOwm0yIPC4xVuhp1aBuh1iXBS/
        RetkAdeVZ0ZTrtJpEtBWy+jXiryEJljnTACicI43IznDeM2HJUTGZEUmCF7om4nm
        wK8uWQsN2bH/C4sJ1KzzLdy3Zcee5uMbwzjFfu2j80JmlQTdUatbdxA2SqjsVxny
        miGBbr+8qC9XaTBOJaP3UgM56Dc7MmsnOFIyWfqhTlF4hez1DehI7EqFZCql5lht
        JWQHO2gIy5yatuO1/lC57DyLtzK3Zol9Crt6mlcQ5PM8h2sFeGb/CqRMxlmuYnCw
        yHFPZc5Rq3pekNQwowXAGmBugIYF24/s7Xg==
X-ME-Sender: <xms:QCjnZEy0ZjoArausKpzhLVy9_-uup87mmp6jw8hV5YLtTXdeba9DwA>
    <xme:QCjnZIQovYlBezh4N7OU-fhdgi7ACTzPYNwJdoudM5P0plX1Dh0NKs4Ko2EoQuSk_
    KA3HP1gDq6_9KW5>
X-ME-Received: <xmr:QCjnZGUwAWFu4_RNDELB2OsdjKtbP2gK9KfyYOEnUdlStijv9-azcJdd7r8cllsD8x9lFsezoB2IbOdLjQo0ktaxPPN44WZDnCeM69JDFrjMIMyKSK0t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddviedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepgfehveetueevleektddukefffedvheeuveff
    jeeivdejleehvddtvedukeejheejnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:QCjnZCjF-9aFbVVFXw89Unn-NhDI4TJf8nTbBT0dkpSL4Q6DOSHvDg>
    <xmx:QCjnZGCmeGkpJ35ylJ7d0je-SZAXhr4z7C9pHXmt9EYJ7_JHv8EsHw>
    <xmx:QCjnZDKzP29zlr5n2mGPL0KNl9E85VLK_tqjbNj4hWE0XLQsI0g_2A>
    <xmx:QSjnZI3EWX9hhQi0wD681M3Do9AS2G_XzD3ZGpMtZdaf7LvFJDJjyA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Aug 2023 05:51:59 -0400 (EDT)
Message-ID: <98d1e901-8d17-ba83-9f99-c05ddd61a356@fastmail.fm>
Date:   Thu, 24 Aug 2023 11:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [fuse-devel] [PATCH 1/2] [RFC for fuse-next ] fuse: DIO writes
 always use the same code path
To:     Hao Xu <hao.xu@linux.dev>, Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     fuse-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>,
        Hao Xu <howeyxu@tencent.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        linux-fsdevel@vger.kernel.org
References: <20230821174753.2736850-1-bschubert@ddn.com>
 <20230821174753.2736850-2-bschubert@ddn.com>
 <CAJfpegv6Q5O435xSrYUMEQAvvkObV6gWws8Ju7C+PrSKwjmSew@mail.gmail.com>
 <a4d031fa-c5cb-2fe8-5869-ec8ad35cc4ee@linux.dev>
 <6cd82251-beb9-9657-dba0-37624a6a47c5@fastmail.fm>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <6cd82251-beb9-9657-dba0-37624a6a47c5@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/24/23 11:43, Bernd Schubert wrote:
> 
> 
> On 8/24/23 06:32, Hao Xu wrote:
>>
>> On 8/22/23 17:53, Miklos Szeredi via fuse-devel wrote:
>>> On Mon, 21 Aug 2023 at 19:48, Bernd Schubert <bschubert@ddn.com> wrote:
>>>> There were two code paths direct-io writes could
>>>> take. When daemon/server side did not set FOPEN_DIRECT_IO
>>>>      fuse_cache_write_iter -> direct_write_fallback
>>>> and with FOPEN_DIRECT_IO being set
>>>>      fuse_direct_write_iter
>>>>
>>>> Advantage of fuse_direct_write_iter is that it has optimizations
>>>> for parallel DIO writes - it might only take a shared inode lock,
>>>> instead of the exclusive lock.
>>>>
>>>> With commits b5a2a3a0b776/80e4f25262f9 the fuse_direct_write_iter
>>>> path also handles concurrent page IO (dirty flush and page release),
>>>> just the condition on fc->direct_io_relax had to be removed.
>>>>
>>>> Performance wise this basically gives the same improvements as
>>>> commit 153524053bbb, just O_DIRECT is sufficient, without the need
>>>> that server side sets FOPEN_DIRECT_IO
>>>> (it has to set FOPEN_PARALLEL_DIRECT_WRITES), though.
>>> Consolidating the various direct IO paths would be really nice.
>>>
>>> Problem is that fuse_direct_write_iter() lacks some code from
>>> generic_file_direct_write() and also completely lacks
>>
>>
>> I see, seems the page invalidation post direct write is needed
>>
>> as well.
>>
> 
> I'm in the middle of verifying code paths, but I wonder if we can
> remove the entire function at all.

Sorry, doesn't remove fuse_direct_io(), but would go via 
generic_file_direct_write, which already has page invalidation.

> 
> 
> https://github.com/bsbernd/linux/commit/fe082a0795fe5839211488e9645732b5f3809bea
> 
> on this branch
> 
> https://github.com/bsbernd/linux/commits/o-direct-shared-lock
> 
> 
> Also totally untested - I hope I did not miss anything...
> 
> 
> Thanks,
> Bernd
