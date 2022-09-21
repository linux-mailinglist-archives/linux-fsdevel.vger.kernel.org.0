Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851045BF5F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 07:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIUFf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 01:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUFf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:35:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874166B8F6;
        Tue, 20 Sep 2022 22:35:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 539EE5C00E5;
        Wed, 21 Sep 2022 01:35:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Sep 2022 01:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1663738554; x=
        1663824954; bh=2UULJx/vem16HYHhCNkienz2tAyT+A6FYxpwNK2en5g=; b=Z
        7FrXqF3T4L4cjkmA0xf7FNtYEM5M0l+9LCxsurqg+7XhF2fmCiXG2+6u3XRrjfNJ
        n3VtU/KkbeFkaTKjYM5qACfrObzixk8FqE7A1xBmoupIrNeWaAkTArG12MP3dhdv
        NVoRAPqnUmGdOdEEkT7DwMphpZd5ozdBGEY26+KU7gUnQA/k30cda/xotZi9DA03
        Ny18QcMQdPC2oJFmXMurEUY8itrAe0wb91NBR1AXWsXOlMMIg9967Q42iV7Ue9cQ
        d8iSL4wsZCzxDQHR9GzvlRtoz/JadozZ4bMdenWaI8TaGafrognGhhllso/eq67R
        w1DL0TPOmsmOcFztu730A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663738554; x=
        1663824954; bh=2UULJx/vem16HYHhCNkienz2tAyT+A6FYxpwNK2en5g=; b=A
        W7G/31ZwSKdqKXrWzqN/39PJMXAbEzCTg3Wil7w/82nM27DoPxdjUxLfx3wO/FhK
        0yYMbspzFwD5La1ot9T6LekKkWnEzhmZu1QebnufV23M2ciEzNuNfstgPfjmcEJb
        ce5uOzmvsSv8SRpduLtiF7RYftZZEv30tsNllsqEeEwe5f5LIvm4JArgtNdySMQK
        I6epc7e/15Aq1PWJjviVyskIBe/gd/P1LdAqw5gvyuiFFg2bfqJaPUP09vt/ZU5J
        xHeK6vfif3SnFiueJ+fiEy9zKOKgWWsNeCnpz/GXSQ55qbjKnJn8m9MuwYcZ8bbL
        hJgPIoDWgJfdzsQQI5kpQ==
X-ME-Sender: <xms:uaIqY_Lc9LolHGSkHSrljcAWHXVa5Cy5MlZUJGklo2XWB8VQ-B6Jew>
    <xme:uaIqYzKb0WsNMCtEOr_DgrUy9FiO9RJVWaAz_ek0cxrMP0UssMgigdxU1uYQd5mc1
    moFOmcOl2c4>
X-ME-Received: <xmr:uaIqY3tYJp_soxT6TdnVcPh7Vzbk09PmxViu6uLSxKbnG2XnG7sXgUruFnh3U3bsZzeJTysVpKjhl7Bwt3_jY16XZ-kKrRyFGK8NWbxlBeobXRDWiLI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeftddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epjeehvdetgeejteeuleeigeefieduudfgteelgefggeetvdefveethfdtjeevledtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:uaIqY4aaGbeJAcZTw0OUdzh2LGva25Y040C662xckf4TDQkY81bBXQ>
    <xmx:uaIqY2bzhtpzdxn89a2fI2US0nY_4tJGEMu54Bq7cMtsBkSZE21hBw>
    <xmx:uaIqY8DiEaFsKs7PRifkrD884cn_qvhgtdE7Kks9_AOoVqNv4LOznQ>
    <xmx:uqIqY7Ni--rum54E5uMy7_cKu3TeS4Sq_PvDhLs7sSKvKG-e0bBK3A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Sep 2022 01:35:50 -0400 (EDT)
Message-ID: <bf2a24ee-fa0d-d93e-ba6a-f814a5f8641c@themaw.net>
Date:   Wed, 21 Sep 2022 13:35:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [REPOST PATCH v3 0/2] vfs: fix a mount table handling problem
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <166365872189.39016.10771273319597352356.stgit@donald.themaw.net>
 <Yypm+GO6eMdV0QQ0@mit.edu> <7064c4cc-4098-6744-298d-fddb3621ca41@themaw.net>
In-Reply-To: <7064c4cc-4098-6744-298d-fddb3621ca41@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 21/9/22 12:38, Ian Kent wrote:
>
> On 21/9/22 09:20, Theodore Ts'o wrote:
>> On Tue, Sep 20, 2022 at 03:26:17PM +0800, Ian Kent wrote:
>>> Whenever a mount has an empty "source" (aka mnt_fsname), the glibc
>>> function getmntent incorrectly parses its input, resulting in reporting
>>> incorrect data to the caller.
>>>
>>> The problem is that the get_mnt_entry() function in glibc's
>>> misc/mntent_r.c assumes that leading whitespace on a line can always
>>> be discarded because it will always be followed by a # for the case
>>> of a comment or a non-whitespace character that's part of the value
>>> of the first field. However, this assumption is violated when the
>>> value of the first field is an empty string.
>>>
>>> This is fixed in the mount API code by simply checking for a pointer
>>> that contains a NULL and treating it as a NULL pointer.
>> Why not simply have the mount API code disallow a zero-length "source"
>> / mnt_fsname?
>
> Hi Ted,
>
>
> I suppose but it seems to me that, for certain file systems, mostly
>
> pseudo file systems, the source isn't needed and is left out ... so
>
> disallowing a zero length source could lead to quite a bit of breakage.

There's handling consistency too.


Ideally any empty string parameter will print "(none)" when listing

the proc mount tables. Mostly that happens in the proc code because

the field is NULL so if an empty string is specified due to having

to provide a positional parameter or for some other reason then

handling it by setting the zero length string to NULL in the mount

API is conveniently central. We could fix it in the proc code too

but then we might see cases get missed over time and we sacrifice

an opportunity to improve consistency.


To my mind continuing to allow it and dealing with what needs to be

done to make that work consistently seemed like the better long

term approach.


So based on that logic, sticky speaking, the ext patch shouldn't

retain the zero length string check but for now ...


>
>
> Ian
>
