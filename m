Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E46560D94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 01:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiF2XfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiF2Xe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:34:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C440E72;
        Wed, 29 Jun 2022 16:33:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1CAF65C0470;
        Wed, 29 Jun 2022 19:33:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Jun 2022 19:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656545634; x=
        1656632034; bh=noYt84Jd7q+oGWxeTJZpYrHP+Dz1u6A7BigbFhMFB70=; b=I
        kXy/+6mJ2h5+DucoiNAslvxJxcREuKufNf1U1j0pEO7i9kuZhXO5K2y+zPMSTFX0
        Jixh3/L1i+xewqfUbZ2jzwQV+qslQlj/2K4DzbymDwFXziCNzXCw7AH40Lca0ZMf
        RF3FJW5pNlIaegjH5SAVwkfNl8ZGEG6gUZrFuoZwCS90uSk8jKXcQWIeV9cEd8dZ
        wgQDvcMBvTQ2rr3HtINkoA/sSYcN9E3fxMcHZVXOHOGxbTgh6aVDuWO2lYvZNbsf
        lRLuHB2uh3I6ayQQAH9NWHdvw+z5ZqsXmmGoE44eoiOyBMmegntESitYSZajiIlQ
        REUQG00fFoN0x8qAEggmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656545634; x=
        1656632034; bh=noYt84Jd7q+oGWxeTJZpYrHP+Dz1u6A7BigbFhMFB70=; b=P
        ULmk/1CXKH55EQzWRlHgJK9ReLtP2S7b4pRk6gbh0N++p2dc9/VM4603EJyX9AJH
        n1VWOMju2YxmXCEKn5HFsm4LU3tR2ahalwZat1fz2T7fTQid0rX6vVl/ZT9g3hc/
        mTCTOmawy2sizw5y4NCa7fDcPGfbSnj5q58dhmgQ5HPZoau5DVG5J5CFmM2o4NWo
        hBDHlZspW/FIcbjLioei0TQFkqIeBdmcF8RCRY3saSnGffB5732rGQk3GsdzcE82
        BWhOGaOJCVOJvEi0h4SU75KRVQ0r2gRkJPQTZlT1rbt7eRq6vq3s4hvxUMktMvo3
        gl2A2u7VXbxZ0UDOwo21g==
X-ME-Sender: <xms:YeG8YnrxczlyRNl54X7pwndpFllgY9kNhnOLq-DvhWfnURTAVjj64A>
    <xme:YeG8YhqJv1ELvYcSfACWm6be4AlQ7aVzFmjjZSLszIJ5ot_v6m3n4ATQnVvWnjOB2
    MK1cFIOtxHM>
X-ME-Received: <xmr:YeG8YkMUE8s5tq-lE4e4Kv474VXRfGRnp2lnTWGo7_4uFKQcuMHJoEL7Y1Y0FXT9oqxTz23G6qZL1pS6CvX1hM6L_Crg8wsru4LpCsTPxwbOeVWM1FG7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:YeG8Yq4--6fj5ekZt52MPnhR_DHIwSIL-nvcVC43bmalgezrbVuy7g>
    <xmx:YeG8Ym7I9SgcWyiECk8pEGHukhno07XtfLDKhMiRkUTD1HXI3jUK3g>
    <xmx:YeG8YijHB-3MsxIv41zMcJInhf9oYIbGdYSfrntCtkJpnr5mewylgw>
    <xmx:YuG8Yh3Ax02EXlti0dlr-QS5x9azTKR3z_ATdIs_2r-gRj5eRu0dNg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jun 2022 19:33:50 -0400 (EDT)
Message-ID: <fd23da3f-e242-da15-ab1c-3e53490a8577@themaw.net>
Date:   Thu, 30 Jun 2022 07:33:46 +0800
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
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <891563475afc32c49fab757b8b56ecdc45b30641.camel@hammerspace.com>
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


On 29/6/22 23:33, Trond Myklebust wrote:
> On Wed, 2022-06-29 at 09:02 +0800, Ian Kent wrote:
>> On 28/6/22 22:34, Trond Myklebust wrote:
>>> On Tue, 2022-06-28 at 08:25 +0800, Ian Kent wrote:
>>>> The valid values of nfs options port and mountport are 0 to
>>>> USHRT_MAX.
>>>>
>>>> The fs parser will return a fail for port values that are
>>>> negative
>>>> and the sloppy option handling then returns success.
>>>>
>>>> But the sloppy option handling is meant to return success for
>>>> invalid
>>>> options not valid options with invalid values.
>>>>
>>>> Parsing these values as s32 rather than u32 prevents the parser
>>>> from
>>>> returning a parse fail allowing the later USHRT_MAX option check
>>>> to
>>>> correctly return a fail in this case. The result check could be
>>>> changed
>>>> to use the int_32 union variant as well but leaving it as a
>>>> uint_32
>>>> check avoids using two logical compares instead of one.
>>>>
>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>> ---
>>>>    fs/nfs/fs_context.c |    4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>>> index 9a16897e8dc6..f4da1d2be616 100644
>>>> --- a/fs/nfs/fs_context.c
>>>> +++ b/fs/nfs/fs_context.c
>>>> @@ -156,14 +156,14 @@ static const struct fs_parameter_spec
>>>> nfs_fs_parameters[] = {
>>>>           fsparam_u32   ("minorversion",  Opt_minorversion),
>>>>           fsparam_string("mountaddr",     Opt_mountaddr),
>>>>           fsparam_string("mounthost",     Opt_mounthost),
>>>> -       fsparam_u32   ("mountport",     Opt_mountport),
>>>> +       fsparam_s32   ("mountport",     Opt_mountport),
>>>>           fsparam_string("mountproto",    Opt_mountproto),
>>>>           fsparam_u32   ("mountvers",     Opt_mountvers),
>>>>           fsparam_u32   ("namlen",        Opt_namelen),
>>>>           fsparam_u32   ("nconnect",      Opt_nconnect),
>>>>           fsparam_u32   ("max_connect",   Opt_max_connect),
>>>>           fsparam_string("nfsvers",       Opt_vers),
>>>> -       fsparam_u32   ("port",          Opt_port),
>>>> +       fsparam_s32   ("port",          Opt_port),
>>>>           fsparam_flag_no("posix",        Opt_posix),
>>>>           fsparam_string("proto",         Opt_proto),
>>>>           fsparam_flag_no("rdirplus",     Opt_rdirplus),
>>>>
>>>>
>>> Why don't we just check for the ENOPARAM return value from
>>> fs_parse()?
>> In this case I think the return will be EINVAL.
> My point is that 'sloppy' is only supposed to work to suppress the
> error in the case where an option is not found by the parser. That
> corresponds to the error ENOPARAM.

Well, yes, and that's why ENOPARAM isn't returned and shouldn't be.

And if the sloppy option is given it doesn't get to check the value

of the option, it just returns success which isn't right.


>
>> I think that's a bit to general for this case.
>>
>> This seemed like the most sensible way to fix it.
>>
> Your patch works around just one symptom of the problem instead of
> addressing the root cause.
>
Ok, how do you recommend I fix this?


Ian

