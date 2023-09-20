Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD5F7A76CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjITJEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjITJEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:04:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA4CEA
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 02:04:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C36655C01E1;
        Wed, 20 Sep 2023 05:04:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 20 Sep 2023 05:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695200644; x=1695287044; bh=7GeQZh1GwezHHhvIU8QZSHCjvdJwmdW6mIY
        iRuZK4DQ=; b=H9LwJluBbkSv/ixSusNS3l+r5qWy2vXTqKQr2ED7uRqbwMQZxKZ
        pwFLR5GhrTC9Hb6dXxuo+KD4uhEZN6Xo0xy9hhooFxzNW5b750PJIGrwzDcfF1wC
        BYAceyYLgpH5a2cfIv00VKu5Pcpf2b4kApScdDvk4s/4s1oPKTixCs6VqEXFa1S2
        gwyzQp1ljXh/tIStTptR5c+6HJ6DlUlv64lBTkE+V0mXgrQVcGjvAlQpGP+TThIQ
        aby3Z15vrYbtkJPKcI3x99wYBJJpowLY7oUgN402ft12y2LUNB/M258VoJHsrhWK
        pdhGDP3cD3CCLsKCNOeiB6g2UMUYT16Rdjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695200644; x=1695287044; bh=7GeQZh1GwezHHhvIU8QZSHCjvdJwmdW6mIY
        iRuZK4DQ=; b=cf4z08ekHZp46kaEdvlb91BdCVWBjAYTViPj8jea0hFzHM3d6qV
        zvPqwjUwGZ6s2kiq2A40eTJN0ZeaSNnwWB3KUC7ULG4Udb+9SKMlPiQ/R1+NcUIH
        1aIp3RPCsRU12l0W25/FkY/LFjiS9FeZH8ujxLTA8ggWIAa2Bs9IBPaK+TQTOB3N
        MeVSrF9CM8w2XegKZpVKy7LN9ePuzUdQdt+8vClABAHbzH2cFN8cvqoIAjAsohAP
        rL1zR73zj08M0lOaslqXWYeNEH+lffrAezOA0x3x5ZVmsFAKaCvUPIcuSoYe5B/O
        fVHlxFjTnnfBNvvgDtNdJIj3BU4qY/0fApw==
X-ME-Sender: <xms:hLUKZXQV2ADbLU93dza614IxygOcW6d5VCuFuVE-IG1o_43Bl8AoqQ>
    <xme:hLUKZYx2LSZsgtTm8aVmZTPyMW7FmhKeyF8D0A3ulSgdYuzDFwAztbY8PtKPcjjJm
    qyM6QrdHdMXUHdt>
X-ME-Received: <xmr:hLUKZc2ZTcJOV2IouyrE46T02pP6SXaSJMUbUKqHjokXnimRsoLkZMAQnNKNUuIzmPNTUWWY6yweWFLFn0OdxTivjDhtyQ_wU2J5_-V3YQMMOQ4bw3iW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekfedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudevleegleffffekudekgeev
    lefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:hLUKZXAWGEcboowLIBNYJrrJ1Jzq-wYI8EqReqzeRTgH2QadDVoHiA>
    <xmx:hLUKZQjy7fRgget-tDy7LagsOSCvCAAHuZTIpCHBXZV91vTX4Cz8Zg>
    <xmx:hLUKZbrZCaH32zkboqZmnCgd5mjd7ccMdJfbiIOKuFZ2tC-djAmt_w>
    <xmx:hLUKZYdvq5JTH2Z419D4qbvi6eBex-2KioGPhH3S6nx_4bGK4AD-ag>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Sep 2023 05:04:03 -0400 (EDT)
Message-ID: <075cecdf-e059-4432-b3ae-f67594bfc0c9@fastmail.fm>
Date:   Wed, 20 Sep 2023 11:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/fuse: Rename DIRECT_IO_RELAX to
 DIRECT_IO_ALLOW_MMAP
To:     Hanna Czenczek <hreitz@redhat.com>,
        Tyler Fanelli <tfanelli@redhat.com>,
        linux-fsdevel@vger.kernel.org, Hao Xu <hao.xu@linux.dev>
Cc:     mszeredi@redhat.com, gmaglione@redhat.com
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <20230920024001.493477-2-tfanelli@redhat.com>
 <f26589d6-32b6-9665-677e-06397d0a1028@redhat.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <f26589d6-32b6-9665-677e-06397d0a1028@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/20/23 10:31, Hanna Czenczek wrote:
> On 20.09.23 04:40, Tyler Fanelli wrote:
>> - *                       allow shared mmap
>> + * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
>>    */
>>   #define FUSE_ASYNC_READ        (1 << 0)
>>   #define FUSE_POSIX_LOCKS    (1 << 1)
>> @@ -449,7 +448,7 @@ struct fuse_file_lock {
>>   #define FUSE_HAS_INODE_DAX    (1ULL << 33)
>>   #define FUSE_CREATE_SUPP_GROUP    (1ULL << 34)
>>   #define FUSE_HAS_EXPIRE_ONLY    (1ULL << 35)
>> -#define FUSE_DIRECT_IO_RELAX    (1ULL << 36)
>> +#define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
> 
> Is it allowed to remove FUSE_DIRECT_IO_RELAX now that it was already 
> present in a uapi header?
> 
> Personally, I don’t mind keeping the name for the flag and just change 
> the documentation.  Or we might keep the old name as an alias for the 
> new one.

It is only in linux-6.6-rcX, not in any released version. Which is why 
Miklos posted that he is going to send these patches as -rc update and 
not only in 6.7.

Thanks,
Bernd
