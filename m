Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C327984A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbjIHJRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjIHJRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:17:10 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FD51FD0;
        Fri,  8 Sep 2023 02:17:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 301AE32009A5;
        Fri,  8 Sep 2023 05:16:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 08 Sep 2023 05:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694164616; x=1694251016; bh=s594X3Pv8Q20DGgzxtmI6FameSh057YuP7w
        8HNnn36I=; b=IENODDH7AzFSwGtTbR3rHgPPj2JQzS8oBWBXdbGlhVuufz4koPa
        sJGlFlndbaiRcHGxxggDPhKl7B85dYhj2B6/j6xfzIW2hM4jowg3EMJa6+S1pXU+
        7B3YFceQNlNZLl5EUiWB25ar1UEIqFl62eYDG1tbpJC5HsscpBWFHxesa1+fdmom
        6vYplJLT3nKiZheyW/Qvk1JzKERg6rjrogbj9Vml/zcfAugkpJlR8xj/+HqWb+FH
        1lFTMleN6ptEyV37EhLqX7t7HqqLgPxBPRgRCVlmmeQNucjGokVrJQV+2miBN5/7
        JYShFBCPOJlG9Pl9EfLjXO0QhXmdTy9mEHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694164616; x=1694251016; bh=s594X3Pv8Q20DGgzxtmI6FameSh057YuP7w
        8HNnn36I=; b=UQtokjSsACbcBigP/XC3C+rwYfKaW21sebnKTfvoblKcbFOqrkw
        ye9wdi1JUMuqbAC7trTpLK7mNiOk9btysJt/X3UxE8cJ7CDVvvxncEGggdstt2Hj
        1YZEIUvpHrY+SaWIqPJ9Ub59TuIqIEwiwdqCi+yGfzd8fYlmhkfBhO5wQpgv6tif
        MHA33h1oiZBYlByxn6V04uVRb6Xk5PAppLKDvITNXgiyyFjtSyI3+ApIFTvVcGNs
        NObhBb8DZnZJFUgA14oeuKpO8ino8K/qWFDCXzdm7gzxVjc3Rv/mWur6a3atu0bN
        qLyvljp2n/LMpGfVBBhc52I/c6DhT41KlfA==
X-ME-Sender: <xms:iOb6ZOTqNrmGMvNRjj_3stWdXZxbF5F1Ve1FseVBIKMUe_cdFffPqg>
    <xme:iOb6ZDz3kL2ERV4tip-a-vlpuPwTpMEbk8sgBM6pHSjFGuRc1khSp7MY0AAkIdqbN
    9_-qr1Ve4M_KMG4>
X-ME-Received: <xmr:iOb6ZL2Eid8IEISuA9VuE3vQwzOfI0z6ZUrhOZD_Tmj6RpT492-O8mbJtthEOm0_lyNAG0kE0ub5qMsPg54h2MNfjjmToBIFz3ECsMdl3wbsHXcmT1TJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:iOb6ZKC-7kPfCCCFIz8BCG1pn7IeIokZxrjbtsfhAcFP_9hkFIeEGQ>
    <xmx:iOb6ZHiuriNpr8IWWU1TU3mr1PO7ZcBTr739J7p9J6xe9qngRGs44g>
    <xmx:iOb6ZGq1ponF-bzOVIsE_07ZMUA4mpXVQi5kr1F3_LKtwsEf1oYa3g>
    <xmx:iOb6ZHjIVr0xP_5ZawYaJcpUYIJX7qxmy789zWfXAvjOJAmc9J-0Zw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Sep 2023 05:16:55 -0400 (EDT)
Message-ID: <6db09157-2797-b159-9687-3f8e57e35b28@fastmail.fm>
Date:   Fri, 8 Sep 2023 11:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] btrfs: file_remove_privs needs an exclusive lock
Content-Language: en-US, de-DE
To:     Christoph Hellwig <hch@infradead.org>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-btrfs@vger.kernel.org, miklos@szeredi.hu, dsingh@ddn.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230906155903.3287672-1-bschubert@ddn.com>
 <20230906155903.3287672-2-bschubert@ddn.com> <ZPrZr4PEwnyYCPpC@infradead.org>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <ZPrZr4PEwnyYCPpC@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/8/23 10:22, Christoph Hellwig wrote:
> On Wed, Sep 06, 2023 at 05:59:03PM +0200, Bernd Schubert wrote:
>> file_remove_privs might call into notify_change(), which
>> requires to hold an exclusive lock.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> FYI, I'd be really curious about benchmarking this against you version
> that checks xattrs for shared locked writes on files that have xattrs
> but not security ones or setuid bits.  On the one hand being able to
> do the shared lock sounds nice, on the other hand even just looking up
> the xattrs will probably make it slower at least for smaller I/O.


I had checked the history of S_NOSEC and I guess that already tells that
the xattr lookup is too slow (commit 69b4573296469fd3f70cf7044693074980517067)
I don't promise that I benchmark it today, but I can
try to find some time in the next week or the week after. Although I
guess there won't be any difference with my initial patch, as
dentry_needs_remove_privs() also checks for IS_NOSEC(inode) - overhead
was just the additional non inlined function call to
file_needs_remove_privs(). And if the flag was not set, overhead was
looking up xattr two times.


Bernd



