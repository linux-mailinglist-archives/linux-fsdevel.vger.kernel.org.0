Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447617A3ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 01:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjIQXhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 19:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjIQXg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 19:36:56 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E303910C;
        Sun, 17 Sep 2023 16:36:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FFE75C00A8;
        Sun, 17 Sep 2023 19:36:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 17 Sep 2023 19:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694993807; x=1695080207; bh=bsWkcg3PjB3+b+dNWVfXA89yUdcxjWyNUMe
        d18WGUnc=; b=lrRwu3S+XAYckx49cIDZjNN29bad41IEY462IVLF2LJkJUiYTZa
        I1vTukzn0B1268av/IvWTc3uda8RDon40kPUaVJV0f/5cNDm/HTnFUM2elDZaFqn
        lzw+AMENiMlCaT/30PfY+tBzPKajCLjnBopqkzqqP/hmQXgcX0XsAE9GiptlivMM
        XC4DlY8S6SOhlzSQUvjSZ3+x0zWssmRzrcUcHiCO7GDE7k7FSv1NN3u46L/PvIwg
        QYnTkTnlsz258WKatUhrsKCw+SLh6rcbwI6CfCP9Us4IcuaQQDAuh4PsvXdA84Ej
        y86nzGT6d0D/gpL9oAhX6XIgCKaoPNbUMBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694993807; x=1695080207; bh=bsWkcg3PjB3+b+dNWVfXA89yUdcxjWyNUMe
        d18WGUnc=; b=Rj/z+rjPwTQfwEpdoaDwvZI6BE5p7/jDNgWtsr8KSEgzZd3qtKV
        gAw5/R06eipJuYiLq2CT3p2LQ3BDYhBrGvoOgxTzygYNU+LOS3AiIbNG5CbjYRX8
        jiotAvXKxoSbGTOTozIDvM1UliKeeNDOpHeEGrXTyATnvq2PrzKQq+f3LWtl4WYx
        cunESBi3ieoMu3Q10D+rLAXvDMiwIr2+HHu1QG+7sIGtd1xLQGcZIrqx6eIcn/TR
        iwGRm+BQyeqaeg/HpepSXRVw7R8qwS3iLluVPanK+5tZyQoNzsJ1NoHPB3itstn0
        MDkngzeckr2eQQBRed7Kd+Wa15K99kbcF3g==
X-ME-Sender: <xms:jo0HZQKSEwIlJ78lHNJn503tJtZjqie55m_jTz9ha2Nvb83doQaZXg>
    <xme:jo0HZQITURUwbZlT4tr4zPMMmQ6liNpF75wOjOxo5Ru1cPFSHoKF9htrZ9EQM0KDD
    99nNrS3X7Bz>
X-ME-Received: <xmr:jo0HZQs80SO4OwUK29iICSlVyFku_jHWekJYmFzecWotPf8mASIVp0k1-7BFXOmbCpFOztAQwrU9rcWZWCL5LIIl2HmjHMQLlwaVbO52ryXjtvyZaxAd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:jo0HZdbeD2UPAPtkx-uXSls9ZH1RlyOZ2E2p1POcZkB1dSKh8ooYKg>
    <xmx:jo0HZXbpgYfCdRp1HlR3NkBtvoVa2mnrDWxxGXdkBI5ZpnYpbkj7Qw>
    <xmx:jo0HZZAHv3cDT5vHZEXC0bd01wGy3BvAKRnshQbVziJX3D4n_X9ZnQ>
    <xmx:j40HZUTFrQUIHEH6ZGQUAMZHXX8_Htm_udoSNllh82UueZjQCwCoyw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Sep 2023 19:36:41 -0400 (EDT)
Message-ID: <39dc7081-fef3-007b-eee3-273bff549ecf@themaw.net>
Date:   Mon, 18 Sep 2023 07:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Content-Language: en-US
To:     Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <CAMp4zn-r5BV_T9VBPJf8Z-iG6=ziDEpCdmPgHRRXF78UoOjTjQ@mail.gmail.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAMp4zn-r5BV_T9VBPJf8Z-iG6=ziDEpCdmPgHRRXF78UoOjTjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 18/9/23 02:18, Sargun Dhillon wrote:
> On Wed, Sep 13, 2023 at 9:25 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
>> Add a way to query attributes of a single mount instead of having to parse
>> the complete /proc/$PID/mountinfo, which might be huge.
>>
>> Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
>> needs to be queried based on path, then statx(2) can be used to first query
>> the mount ID belonging to the path.
>>
>> Design is based on a suggestion by Linus:
>>
>>    "So I'd suggest something that is very much like "statfsat()", which gets
>>     a buffer and a length, and returns an extended "struct statfs" *AND*
>>     just a string description at the end."
>>
>> The interface closely mimics that of statx.
>>
>> Handle ASCII attributes by appending after the end of the structure (as per
>> above suggestion).  Allow querying multiple string attributes with
>> individual offset/length for each.  String are nul terminated (termination
>> isn't counted in length).
>>
>> Mount options are also delimited with nul characters.  Unlike proc, special
>> characters are not quoted.
>>
> Thank you for writing this patch. I wish that this had existed the many times
> I've written parsers for mounts files in my life.
>
> What do you think about exposing the locked flags, a la what happens
> on propagation of mount across user namespaces?

Which flags do you mean?


If you mean shared, slave and I think there's a group id as well, etc. 
then yes

they were available in the original fsinfo() implementation as they were 
requested.


So, yes, it would be good to also include those too.


Ian


