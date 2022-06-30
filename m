Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3E560E28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 02:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiF3AqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 20:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiF3AqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:46:21 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5911340D6;
        Wed, 29 Jun 2022 17:46:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 22E345C0397;
        Wed, 29 Jun 2022 20:46:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Jun 2022 20:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656549980; x=
        1656636380; bh=YGkknG7f4f40yQzuN+h1Ss3pBCm01aDX5rQ1G2imCNI=; b=X
        YOvYhtlD2DjI4WwEt487w47x2rOcAYx1QLMH2wI7rnFvXpJonKhtIEXIjetpYvdT
        FT6stHT/9ll3sDA+Nl17e9TU5dn4S/HYD/A8sQxUD/Du0tFEra5sKUkinCUEl9rZ
        I3i2mq6zE2KkjX7B4uLV/14LSGylCfhzjd/4rlcDHHfOQ0qF+A6KcX5jK+1w76oP
        7Lvh1fb7TXdbbIFby3/xQI9YyNNqOempl27NUWBFpoF8Gna66UFtegV2ubVlzqTr
        Ng8X1oM0528EkS8zeJRdqwgkA2z0dGOzFf4i4QDQm0KJv0B1PMfjRKDcirfvZagm
        SonxaTVlLU4G54K+s873g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656549980; x=
        1656636380; bh=YGkknG7f4f40yQzuN+h1Ss3pBCm01aDX5rQ1G2imCNI=; b=N
        VOLqdKyc3pdKtG4iKvLvOXZdC1/ZVw4QELKQbmRkI33dgQd9UcBvYm6N2mNqIdMB
        V6jEjPnsUd3d0Qo1neBs+W8T3Ls8yUl9jAz5cCy+V1LOv2ndVM+xWuhDuRiT3Tf5
        To6QOu+EnYdwbZMobpRC0yDwjNto4CdKft7ngSe4D2R30KVwJeaejph5ILJJTL7C
        ucPvIADlLhbSvxNpUsl9auaFKnxbE2Q5ahnj3sKL7j9ulIyygJ5sdsmKsINzpGkJ
        6EC9Zw90/LxNszBbPe27I0UlzOW8LbP7lPeMTYE1OqIIXajMmrV8PEhS2d4kbyvr
        1JpeiDPRqePmRRd6gDynw==
X-ME-Sender: <xms:W_K8YsETbB88D2st-_9hQIR6AiS97Fy-zgOkNzIsXmGbRbI_cfc94A>
    <xme:W_K8YlXrpVYEQi6hkZLhXGRM7_ja7RMWoQ8_FoTI7Z-vrMR2CJlLwvNRh9nV1WXmz
    DwfNmZffUaS>
X-ME-Received: <xmr:W_K8YmLpz5Wdim0tyb5_WZMxbG6lyu8NMlLBPM8f3wNqYCK2cQQWmzHwDQI4TMvpuydd3WhsYkVnqLq00c_yCEzdSAVJcjut9ZaWiC_g-wq1VIX9b_ab>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epieevleekgfdtgedufedufedtleetjeetvdehueelvedvleeuhfdutdeigeevleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:XPK8YuHWb_yeKgogFdeuJO7oE_AU-E8f2kBTQma5PUiLO4c1SMpSMA>
    <xmx:XPK8YiVoXGig23DbYHsLZVBICp1StfRI-YHZ2WbnFZpen0oR5A2ijQ>
    <xmx:XPK8YhMy7A3vQG8H2JOVAxZgk66VI0e6VI2oicrNKD9PgpHvNGTomw>
    <xmx:XPK8Ygy73e-pltlTPXxQweW3LWzTAKUD1xak2RFxjgkG7BNMturnMA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jun 2022 20:46:16 -0400 (EDT)
Message-ID: <a9cc2c3d-cc38-4337-a3a6-ceb4c4b1602e@themaw.net>
Date:   Thu, 30 Jun 2022 08:46:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [REPOST PATCH] nfs: fix port value parsing
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
References: <165637590710.37553.7481596265813355098.stgit@donald.themaw.net>
 <cadcb382d47ef037c5b713b099ae46640dfea37d.camel@hammerspace.com>
 <ccd23a54-27b5-e65c-4a97-b169676c23bc@themaw.net>
 <891563475afc32c49fab757b8b56ecdc45b30641.camel@hammerspace.com>
 <fd23da3f-e242-da15-ab1c-3e53490a8577@themaw.net>
 <c81b95d2b68480ead9f3bb88d6cf5a82a43c73b8.camel@hammerspace.com>
 <2dbeb7b8-8994-d610-f536-58d41767a1ec@themaw.net>
In-Reply-To: <2dbeb7b8-8994-d610-f536-58d41767a1ec@themaw.net>
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


On 30/6/22 08:41, Ian Kent wrote:
>
> On 30/6/22 07:57, Trond Myklebust wrote:
>> On Thu, 2022-06-30 at 07:33 +0800, Ian Kent wrote:
>>> On 29/6/22 23:33, Trond Myklebust wrote:
>>>> On Wed, 2022-06-29 at 09:02 +0800, Ian Kent wrote:
>>>>> On 28/6/22 22:34, Trond Myklebust wrote:
>>>>>> On Tue, 2022-06-28 at 08:25 +0800, Ian Kent wrote:
>>>>>>> The valid values of nfs options port and mountport are 0 to
>>>>>>> USHRT_MAX.
>>>>>>>
>>>>>>> The fs parser will return a fail for port values that are
>>>>>>> negative
>>>>>>> and the sloppy option handling then returns success.
>>>>>>>
>>>>>>> But the sloppy option handling is meant to return success for
>>>>>>> invalid
>>>>>>> options not valid options with invalid values.
>>>>>>>
>>>>>>> Parsing these values as s32 rather than u32 prevents the
>>>>>>> parser
>>>>>>> from
>>>>>>> returning a parse fail allowing the later USHRT_MAX option
>>>>>>> check
>>>>>>> to
>>>>>>> correctly return a fail in this case. The result check could
>>>>>>> be
>>>>>>> changed
>>>>>>> to use the int_32 union variant as well but leaving it as a
>>>>>>> uint_32
>>>>>>> check avoids using two logical compares instead of one.
>>>>>>>
>>>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>>>> ---
>>>>>>>     fs/nfs/fs_context.c |    4 ++--
>>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>>>>>> index 9a16897e8dc6..f4da1d2be616 100644
>>>>>>> --- a/fs/nfs/fs_context.c
>>>>>>> +++ b/fs/nfs/fs_context.c
>>>>>>> @@ -156,14 +156,14 @@ static const struct fs_parameter_spec
>>>>>>> nfs_fs_parameters[] = {
>>>>>>>            fsparam_u32 ("minorversion",  Opt_minorversion),
>>>>>>>            fsparam_string("mountaddr",     Opt_mountaddr),
>>>>>>>            fsparam_string("mounthost",     Opt_mounthost),
>>>>>>> -       fsparam_u32 ("mountport",     Opt_mountport),
>>>>>>> +       fsparam_s32 ("mountport",     Opt_mountport),
>>>>>>>            fsparam_string("mountproto",    Opt_mountproto),
>>>>>>>            fsparam_u32 ("mountvers",     Opt_mountvers),
>>>>>>>            fsparam_u32 ("namlen",        Opt_namelen),
>>>>>>>            fsparam_u32 ("nconnect",      Opt_nconnect),
>>>>>>>            fsparam_u32 ("max_connect",   Opt_max_connect),
>>>>>>>            fsparam_string("nfsvers",       Opt_vers),
>>>>>>> -       fsparam_u32   ("port",          Opt_port),
>>>>>>> +       fsparam_s32   ("port",          Opt_port),
>>>>>>>            fsparam_flag_no("posix",        Opt_posix),
>>>>>>>            fsparam_string("proto",         Opt_proto),
>>>>>>>            fsparam_flag_no("rdirplus",     Opt_rdirplus),
>>>>>>>
>>>>>>>
>>>>>> Why don't we just check for the ENOPARAM return value from
>>>>>> fs_parse()?
>>>>> In this case I think the return will be EINVAL.
>>>> My point is that 'sloppy' is only supposed to work to suppress the
>>>> error in the case where an option is not found by the parser. That
>>>> corresponds to the error ENOPARAM.
>>> Well, yes, and that's why ENOPARAM isn't returned and shouldn't be.
>>>
>>> And if the sloppy option is given it doesn't get to check the value
>>>
>>> of the option, it just returns success which isn't right.
>>>
>>>
>>>>> I think that's a bit to general for this case.
>>>>>
>>>>> This seemed like the most sensible way to fix it.
>>>>>
>>>> Your patch works around just one symptom of the problem instead of
>>>> addressing the root cause.
>>>>
>>> Ok, how do you recommend I fix this?
>>>
>> Maybe I'm missing something, but why not this?
>>
>> 8<--------------------------------
>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>> index 9a16897e8dc6..8f1f9b4af89d 100644
>> --- a/fs/nfs/fs_context.c
>> +++ b/fs/nfs/fs_context.c
>> @@ -484,7 +484,7 @@ static int nfs_fs_context_parse_param(struct
>> fs_context *fc,
>>         opt = fs_parse(fc, nfs_fs_parameters, param, &result);
>>       if (opt < 0)
>> -        return ctx->sloppy ? 1 : opt;
>> +        return (opt == -ENOPARAM && ctx->sloppy) ? 1 : opt;
>
>
> Right but fs_parse() will return EINVAL in the case where a valid option
>
> is used but its value is wrong such as where the value given is negative
>
> but the param definition is unsigned (causing the EINVAL).
>
> Of course this case is checked for and handled later in the NFS option
>
> handling ...


Oh wait ... I think I've been too hasty and not understood what you

suggested ... let me ponder that a little ... and thanks for the suggestion.


Ian

>
>
> There's also the question of option ordering which I haven't looked at
>
> closely yet but might not be working properly.
>
>
> Ian
>
>>         if (fc->security)
>>           ctx->has_sec_mnt_opts = 1;
>>
