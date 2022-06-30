Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36367560E23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 02:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiF3AmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 20:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiF3AmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:42:06 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD63FD8C;
        Wed, 29 Jun 2022 17:42:05 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 99E495C0399;
        Wed, 29 Jun 2022 20:42:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 29 Jun 2022 20:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656549722; x=
        1656636122; bh=Mki3uW4XtTEZ1lpVskvDGQTCJICQKRqvyMZuq0H1KiE=; b=i
        L8fqVM8rx3AVYhqv99ckJwmifRsJYB62QPj8wW5UBpWHQtE/hOlPD5pWVEjVO9Zy
        FJx2G/VZWkEkWLmqD5E7KDSWnise7QjE0/YowO/laeK8SeJn9dw2w6iCwM3j19M7
        1jOzIsXJyhYLRCunaDwDVVl3neW+VHV/5AWLKytEkuLI+TJeJCNOP4wg1MI2wkD+
        T7s3oJTzjv0SPMXL6I4RcgXUSINF7lkgGCf7lkGyDAWcS2CfHbKMeBPoAQuXi5Ix
        gocOGB/Tc4HJ7fLE5kr01fbQ8M9QL3589bpRRw/MqN1BTpxhYbEtTfl9eTJ7JRV3
        P65WsdbGdxO7CidfrMs5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656549722; x=
        1656636122; bh=Mki3uW4XtTEZ1lpVskvDGQTCJICQKRqvyMZuq0H1KiE=; b=k
        IvwoUWowJEUeSe+eJPR44cKqAJUBWBpK0DQ+DYG18sGFeO6CnQ0WvMUN0LEZ1ItJ
        vKQRmyJ6Uqi5ttowWL52thaL3QZ9w1oo8B9i51+OQABM7nfRCigrVvZNxyZjcewK
        Zs/0Iu3Kn0OFo/r2AWECr2VVB3fAaWWQu4yEiqg1Rk9028u8NHkfDKrIXE7lO7O0
        2qtkVGTxrZ0xnnXxHifsEn39u+DrFSZCbucJDp7yVDMPn3oBm6MG1eUsXkPWLFld
        +ynKRWusdrLhUYFKNXIcVm1mfjoSrqPQktJZ5kaeqzNLid52YgYnB1+zJyEjEbTT
        eU86YIvzByr0LFrBKdmIQ==
X-ME-Sender: <xms:WvG8YpI2EFsD0TYRXnS5BD-gkO07FHt89X6MGyhZBwBkClhmmOHY4w>
    <xme:WvG8YlKEfInSWcfOtOX0osS7n9Svnh5UNCvJNhw5UGacNZmc8pP_xjbehKn98J7hK
    qgucR9J4oFR>
X-ME-Received: <xmr:WvG8Yhtb3nc6faALoKtYbB6iRS_JJVwf99JwmTtU0ViONZy204jKTf8HwX3p4MOoIk3Pg8LiZVHCJzZdkcUxcmfpEKFGyUQ1QoE5XnL6h2nEIKGOOHe9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:WvG8YqZ4TnvTbHZBtz0EphyJ8VeNudOdWD9emge_SaKOfNOi-uh-_w>
    <xmx:WvG8YgZHGmpPeY9JHlne37bAg-1wXSOGmBi_ZRv6v03B9YecUmFr_w>
    <xmx:WvG8YuA9bvcsWCrBLHF7XGUXuxlC9Ke-iYyTjdKYME13oUPPjk7qgA>
    <xmx:WvG8YnXPf0ljYcHTNh4aAdBOEXiXaGnggH-pB7KViZPztCLvo9LlcQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jun 2022 20:41:59 -0400 (EDT)
Message-ID: <2dbeb7b8-8994-d610-f536-58d41767a1ec@themaw.net>
Date:   Thu, 30 Jun 2022 08:41:55 +0800
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
 <ccd23a54-27b5-e65c-4a97-b169676c23bc@themaw.net>
 <891563475afc32c49fab757b8b56ecdc45b30641.camel@hammerspace.com>
 <fd23da3f-e242-da15-ab1c-3e53490a8577@themaw.net>
 <c81b95d2b68480ead9f3bb88d6cf5a82a43c73b8.camel@hammerspace.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <c81b95d2b68480ead9f3bb88d6cf5a82a43c73b8.camel@hammerspace.com>
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


On 30/6/22 07:57, Trond Myklebust wrote:
> On Thu, 2022-06-30 at 07:33 +0800, Ian Kent wrote:
>> On 29/6/22 23:33, Trond Myklebust wrote:
>>> On Wed, 2022-06-29 at 09:02 +0800, Ian Kent wrote:
>>>> On 28/6/22 22:34, Trond Myklebust wrote:
>>>>> On Tue, 2022-06-28 at 08:25 +0800, Ian Kent wrote:
>>>>>> The valid values of nfs options port and mountport are 0 to
>>>>>> USHRT_MAX.
>>>>>>
>>>>>> The fs parser will return a fail for port values that are
>>>>>> negative
>>>>>> and the sloppy option handling then returns success.
>>>>>>
>>>>>> But the sloppy option handling is meant to return success for
>>>>>> invalid
>>>>>> options not valid options with invalid values.
>>>>>>
>>>>>> Parsing these values as s32 rather than u32 prevents the
>>>>>> parser
>>>>>> from
>>>>>> returning a parse fail allowing the later USHRT_MAX option
>>>>>> check
>>>>>> to
>>>>>> correctly return a fail in this case. The result check could
>>>>>> be
>>>>>> changed
>>>>>> to use the int_32 union variant as well but leaving it as a
>>>>>> uint_32
>>>>>> check avoids using two logical compares instead of one.
>>>>>>
>>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>>> ---
>>>>>>     fs/nfs/fs_context.c |    4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>>>>> index 9a16897e8dc6..f4da1d2be616 100644
>>>>>> --- a/fs/nfs/fs_context.c
>>>>>> +++ b/fs/nfs/fs_context.c
>>>>>> @@ -156,14 +156,14 @@ static const struct fs_parameter_spec
>>>>>> nfs_fs_parameters[] = {
>>>>>>            fsparam_u32   ("minorversion",  Opt_minorversion),
>>>>>>            fsparam_string("mountaddr",     Opt_mountaddr),
>>>>>>            fsparam_string("mounthost",     Opt_mounthost),
>>>>>> -       fsparam_u32   ("mountport",     Opt_mountport),
>>>>>> +       fsparam_s32   ("mountport",     Opt_mountport),
>>>>>>            fsparam_string("mountproto",    Opt_mountproto),
>>>>>>            fsparam_u32   ("mountvers",     Opt_mountvers),
>>>>>>            fsparam_u32   ("namlen",        Opt_namelen),
>>>>>>            fsparam_u32   ("nconnect",      Opt_nconnect),
>>>>>>            fsparam_u32   ("max_connect",   Opt_max_connect),
>>>>>>            fsparam_string("nfsvers",       Opt_vers),
>>>>>> -       fsparam_u32   ("port",          Opt_port),
>>>>>> +       fsparam_s32   ("port",          Opt_port),
>>>>>>            fsparam_flag_no("posix",        Opt_posix),
>>>>>>            fsparam_string("proto",         Opt_proto),
>>>>>>            fsparam_flag_no("rdirplus",     Opt_rdirplus),
>>>>>>
>>>>>>
>>>>> Why don't we just check for the ENOPARAM return value from
>>>>> fs_parse()?
>>>> In this case I think the return will be EINVAL.
>>> My point is that 'sloppy' is only supposed to work to suppress the
>>> error in the case where an option is not found by the parser. That
>>> corresponds to the error ENOPARAM.
>> Well, yes, and that's why ENOPARAM isn't returned and shouldn't be.
>>
>> And if the sloppy option is given it doesn't get to check the value
>>
>> of the option, it just returns success which isn't right.
>>
>>
>>>> I think that's a bit to general for this case.
>>>>
>>>> This seemed like the most sensible way to fix it.
>>>>
>>> Your patch works around just one symptom of the problem instead of
>>> addressing the root cause.
>>>
>> Ok, how do you recommend I fix this?
>>
> Maybe I'm missing something, but why not this?
>
> 8<--------------------------------
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 9a16897e8dc6..8f1f9b4af89d 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -484,7 +484,7 @@ static int nfs_fs_context_parse_param(struct
> fs_context *fc,
>   
>   	opt = fs_parse(fc, nfs_fs_parameters, param, &result);
>   	if (opt < 0)
> -		return ctx->sloppy ? 1 : opt;
> +		return (opt == -ENOPARAM && ctx->sloppy) ? 1 : opt;


Right but fs_parse() will return EINVAL in the case where a valid option

is used but its value is wrong such as where the value given is negative

but the param definition is unsigned (causing the EINVAL).

Of course this case is checked for and handled later in the NFS option

handling ...


There's also the question of option ordering which I haven't looked at

closely yet but might not be working properly.


Ian

>   
>   	if (fc->security)
>   		ctx->has_sec_mnt_opts = 1;
>
