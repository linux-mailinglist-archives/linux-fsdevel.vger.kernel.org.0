Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF52763B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjGZPpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjGZPpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:45:05 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDE6E47;
        Wed, 26 Jul 2023 08:45:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5994B320094D;
        Wed, 26 Jul 2023 11:45:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 11:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690386302; x=1690472702; bh=5JHQWc7fIr5yWMFZ7HQ4DfnYA0AEVbvufUW
        OsS08iP0=; b=x2IFDSO+wUnEkLoaYchqP8zzaT6j53QOYdy1wMRUYptKyDRdLm7
        Iz63Ht7yp+vAMh5x4o9RZH/yMSwxcr7rwF1EYnkPTG5or8M2UcfN52OE+XHxNSGZ
        ceaScNSdqlFfLL3uIuA+AUiEQAEq5vYPRJky3WioqZjoTts13vbMnb77RSQ/a5b7
        oCZzknWiv9EkR4DkYsZqLtIyXZf518V+BDCmTsPb2B8GtXBQXetjzenrYcirJq91
        BbkhT5xygBcWMnOkfETm8Ga/a3ZsFftYGJEHaF/sJK75CTIvrF3fgRfgDX2VN0Lc
        eNDbwG3Jxo8v9qRVqAR3LUlt0Lu/qzg7NGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1690386302; x=
        1690472702; bh=5JHQWc7fIr5yWMFZ7HQ4DfnYA0AEVbvufUWOsS08iP0=; b=t
        kLM2+G3Oy+zblWDZFHanAl/hKO4LnSNpsagGXVPBCX3kvV0/GGW/rgQK2LGq0Axk
        MEHDplzVXXn1470GDj32pvwHtCKADYXyu6ID9dR55hwqiMwhHZTlndBssa+cy6gF
        7Ap6Q4c9HVUNHTcXk/okbthdfXwuiQS1slyiC195cqDG3oZjsHXylouSAMuEMOaZ
        dBFjKNcmZCbErKZighVMLtqJapuY5Wfg3bUR6XrXVWD43jZx8Mw3hP7eB4K7zIb7
        5qM7JYzp5/ffCUirgmR2FD8dlIKXe7mNTkPHsgX+TAztyfm2KbAtE5AjQOzo40+j
        1eP7G/qj+yj835QYUEfFg==
X-ME-Sender: <xms:fj_BZDMevFOALPTMO8-H3rh44Rc9RgS91HDcSKT-JnMVkC_mb6EWOA>
    <xme:fj_BZN_JNAMk5cKp0TFuSpb5CiiHFnL5ip5FdOaAj0oXDGqLNT-S97U_VWYYjm2q0
    uDujIM8vbxmlVah>
X-ME-Received: <xmr:fj_BZCSmzD0hFJsPTFvbbL_YoRJ7TkgtLcZLCXIb-eBHMfgvTPOtlTyp4Wzl8KT6zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddutddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdef
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpedtudeuueevgeek
    feehieeukedvudelieevteevuedtueffhfeuteeivedvhfduvdenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:fj_BZHuBetPyDLlL_0NeaxlJIACPLD88kfpHHNh1N8vq3Y4XWhryxg>
    <xmx:fj_BZLdnJV88ezrU8yJ24hStwR_mEPypSdvhjgi-yWDu6vY1Rs9u0w>
    <xmx:fj_BZD0vtu21W19VVGIWbl1ft8h1u0r_GOiZRDmqJ__WrKE2TABPlQ>
    <xmx:fj_BZMoUe-ITCDfNovwHwiCqAaseG1ctvcfz1RjHLQwmtlyJtl9OuA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 11:45:02 -0400 (EDT)
Message-ID: <0731f4b9-cd4e-2cb3-43ba-c74d238b824f@fastmail.fm>
Date:   Wed, 26 Jul 2023 17:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
Content-Language: en-US
To:     Jaco Kroon <jaco@uls.co.za>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726105953.843-1-jaco@uls.co.za>
 <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
 <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/26/23 17:26, Jaco Kroon wrote:
> Hi,
> 
> On 2023/07/26 15:53, Bernd Schubert wrote:
>>
>>
>> On 7/26/23 12:59, Jaco Kroon wrote:
>>> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
>>> ---
>>>   fs/fuse/Kconfig   | 16 ++++++++++++++++
>>>   fs/fuse/readdir.c | 42 ++++++++++++++++++++++++------------------
>>>   2 files changed, 40 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>>> index 038ed0b9aaa5..0783f9ee5cd3 100644
>>> --- a/fs/fuse/Kconfig
>>> +++ b/fs/fuse/Kconfig
>>> @@ -18,6 +18,22 @@ config FUSE_FS
>>>         If you want to develop a userspace FS, or if you want to use
>>>         a filesystem based on FUSE, answer Y or M.
>>>   +config FUSE_READDIR_ORDER
>>> +    int
>>> +    range 0 5
>>> +    default 5
>>> +    help
>>> +        readdir performance varies greatly depending on the size of 
>>> the read.
>>> +        Larger buffers results in larger reads, thus fewer reads and 
>>> higher
>>> +        performance in return.
>>> +
>>> +        You may want to reduce this value on seriously constrained 
>>> memory
>>> +        systems where 128KiB (assuming 4KiB pages) cache pages is 
>>> not ideal.
>>> +
>>> +        This value reprents the order of the number of pages to 
>>> allocate (ie,
>>> +        the shift value).  A value of 0 is thus 1 page (4KiB) where 
>>> 5 is 32
>>> +        pages (128KiB).
>>> +
>>
>> I like the idea of a larger readdir size, but shouldn't that be a 
>> server/daemon/library decision which size to use, instead of kernel 
>> compile time? So should be part of FUSE_INIT negotiation?
> 
> Yes sure, but there still needs to be a default.  And one page at a time 
> doesn't cut it.

With FUSE_INIT userspace would make that decision, based on what kernel 
fuse suggests? process_init_reply() already handles other limits - I 
don't see why readdir max has to be compile time option. Maybe a module 
option to set the limit?

Thanks,
Bernd
