Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823E255F296
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 03:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiF2BDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 21:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiF2BC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:02:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8F31CB2E;
        Tue, 28 Jun 2022 18:02:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 595CD32004AE;
        Tue, 28 Jun 2022 21:02:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 Jun 2022 21:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656464574; x=
        1656550974; bh=O3faQ1y3t8QAbrkwy968BG0REtnIuxMqIwDQcV5UfqQ=; b=C
        74wr8n5zRFexaZ7gbYCK9BarhV0RTPEXe2xUYAU8psxdDdfOhnGVhc6yhSxUulCw
        6MYCFG09LkT9l6zt8D9GCHVDFbHLkM9Ia2sbj6j5hw5gJWamsT8hEnfL9EY+zWYr
        qb8rrMegRvxo/imifQMbhDn2HNmnnqvAbkfSHzt5Xc3S+Y3RGGqIzznaf+3R3Gpr
        hJuN6KPwLdv/uPBbqZUnTGHV6oJv1YQ+4Els8Hvz3S3gQckS6/G9U5NBEIDEzqoi
        VMmy8jsBIEQA39yS3TlV1ibmU9myfZUfBcGCJDL4Iuz0BqT3NJBp9Hej5yPwulOj
        Ck/VXbZEeX8Co7k6XSzpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656464574; x=
        1656550974; bh=O3faQ1y3t8QAbrkwy968BG0REtnIuxMqIwDQcV5UfqQ=; b=I
        16ksKoWS26jeFBmXNOgwZe3re6l8Vh7ZisbWm6rmVkNiS3GD1JNXq9sWaoYO7sVj
        ezO63KzDooqiOHOwq5ze/tFU9wgZNSN+V4EVFr9pwVG0RPZYvOB1yQdnFgrGTOC3
        xuKDsOmxzzvc3m+GxyoWSQNRXzGncNeaCQeOxvc1bJgZcEkgZMIJJSk0vDJHBKC9
        tS8GruQfCs1nd+L992z6gbbi66U3soGM3g7SVkzmsJwuQtzhoxePc+X/4o4uUBD4
        2EJ9+wnG+EHIZWleKjXidbmQ8N81OqtrgH4CUPC383C5+2hDZER952FMajn4qi3g
        7GoYTnTKUSNpveMKbAEZA==
X-ME-Sender: <xms:vqS7Ykvn0zj2oAIkYJW9PUb1M_2p49u_Hp_f1T5ShBkDP9p508T8Mw>
    <xme:vqS7Yhf5IB82IAtUutrAt3zbUhVD4IpnsklnhV5fjfBkZeTrlRabGrM_i0PywYoHM
    ZW9TXm3Pyvn>
X-ME-Received: <xmr:vqS7YvwQaWuJmT38F4j29ba-kUzREql5MJiMdONW5RHT29nQRVatzZY_DrODWD4yFQ_DcHB6Uzh0zLBdOuWmd8f-AWlb9IEZmLwkNHf75Qlq7fRL9PO2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:vqS7YnMPMpbLHnnwtfHRK9T-tL6iXBQKJ2WgFDaEk4q2Pdrk4IhJTg>
    <xmx:vqS7Yk-qeSFRJkaYkqQlBxS0vrBR4mTYLXN9-2vWiy3tBn5U-GSp7g>
    <xmx:vqS7YvUZi5MUg6xq-rCYuS39jhiDAZ8auitp7DDETDjgQ0PuXL7BRA>
    <xmx:vqS7YoZvC5xlSX49OYTJrOuWTfhwy_7rrevZXEmJIxGYZFaeqyUy7g>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jun 2022 21:02:51 -0400 (EDT)
Message-ID: <ccd23a54-27b5-e65c-4a97-b169676c23bc@themaw.net>
Date:   Wed, 29 Jun 2022 09:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [REPOST PATCH] nfs: fix port value parsing
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
References: <165637590710.37553.7481596265813355098.stgit@donald.themaw.net>
 <cadcb382d47ef037c5b713b099ae46640dfea37d.camel@hammerspace.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <cadcb382d47ef037c5b713b099ae46640dfea37d.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 28/6/22 22:34, Trond Myklebust wrote:
> On Tue, 2022-06-28 at 08:25 +0800, Ian Kent wrote:
>> The valid values of nfs options port and mountport are 0 to
>> USHRT_MAX.
>>
>> The fs parser will return a fail for port values that are negative
>> and the sloppy option handling then returns success.
>>
>> But the sloppy option handling is meant to return success for invalid
>> options not valid options with invalid values.
>>
>> Parsing these values as s32 rather than u32 prevents the parser from
>> returning a parse fail allowing the later USHRT_MAX option check to
>> correctly return a fail in this case. The result check could be
>> changed
>> to use the int_32 union variant as well but leaving it as a uint_32
>> check avoids using two logical compares instead of one.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> ---
>>   fs/nfs/fs_context.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>> index 9a16897e8dc6..f4da1d2be616 100644
>> --- a/fs/nfs/fs_context.c
>> +++ b/fs/nfs/fs_context.c
>> @@ -156,14 +156,14 @@ static const struct fs_parameter_spec
>> nfs_fs_parameters[] = {
>>          fsparam_u32   ("minorversion",  Opt_minorversion),
>>          fsparam_string("mountaddr",     Opt_mountaddr),
>>          fsparam_string("mounthost",     Opt_mounthost),
>> -       fsparam_u32   ("mountport",     Opt_mountport),
>> +       fsparam_s32   ("mountport",     Opt_mountport),
>>          fsparam_string("mountproto",    Opt_mountproto),
>>          fsparam_u32   ("mountvers",     Opt_mountvers),
>>          fsparam_u32   ("namlen",        Opt_namelen),
>>          fsparam_u32   ("nconnect",      Opt_nconnect),
>>          fsparam_u32   ("max_connect",   Opt_max_connect),
>>          fsparam_string("nfsvers",       Opt_vers),
>> -       fsparam_u32   ("port",          Opt_port),
>> +       fsparam_s32   ("port",          Opt_port),
>>          fsparam_flag_no("posix",        Opt_posix),
>>          fsparam_string("proto",         Opt_proto),
>>          fsparam_flag_no("rdirplus",     Opt_rdirplus),
>>
>>
> Why don't we just check for the ENOPARAM return value from fs_parse()?

In this case I think the return will be EINVAL.

I think that's a bit to general for this case.

This seemed like the most sensible way to fix it.


Ian

