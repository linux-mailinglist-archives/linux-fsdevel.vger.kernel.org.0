Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12465D64F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 15:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbjADOn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 09:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbjADOnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:43:55 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CE0A45E;
        Wed,  4 Jan 2023 06:43:55 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 75BE55C00D8;
        Wed,  4 Jan 2023 09:43:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 09:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672843434; x=1672929834; bh=IP0SBqSeI5
        mc59ZzakVz5++34RGUjvJuQ+gcI75nQXs=; b=VoINooEr5WOspjZwRdnXKqc+bp
        MO59Ddyd/q3wOgjXLAqJFudwj2UxAIQgG3pIooVTwQvAd2icp+a1rD19MdEI/l8F
        T8ippB0TDMBL0BhjvmfDqlYOEc2OtBfSuhPy6vusDnaGiF43M64bpOaNz37qYZ5g
        Ju58xyCyDnuodGPwTbAfSZslG+sOpfo9BdZcLh2MUYclr+BsAwRynHbwEhBU5kMT
        lp6OqfNsHpQRLyKLkyOI4tfRu9LqWE2nW4M//RyV8f/n5jq8QBoCdCKBBueNW+eX
        kMGFrEbIQblm8NSlG0jIoVBxEa1laPZeCqVBl5VlQi/b93IyCB+vGQ2WzN8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672843434; x=1672929834; bh=IP0SBqSeI5mc59ZzakVz5++34RGU
        jvJuQ+gcI75nQXs=; b=Pw5nAxrGGfXBUxTzjcHL9sfteVJyBr8aneachg4KStgZ
        CCOkAN0rcKdiyaelMN36AhxNizJaGu/c09rdLqrdQjUDIVyAg6wE7q8qAzvHop8j
        XCNc9sJdZ6dtne3VgU5O64TmI2y9GQbHhnWXzN6PBErSy46PTCkYhk37K+SsbmLM
        consMgl0Y9frTXRJRqoOewmTeGvsIDLPzX71TGm1yY30QLCY7Xa9ZlZ+OJmPT5RQ
        dxazuvXIugign9bD30jGneRVi69RRPhGoBcr1MTaPNrcIUPsH80gy1VJ5e0LwpTc
        8RpjhG/ibKLRpskSSEVsKxoYw60idjGieU46sDaATw==
X-ME-Sender: <xms:qpC1Y9JR4n9apK9TmXcCX_pUP2VI4bearpNsngO0nqvFQXy2FweOog>
    <xme:qpC1Y5KebZrY83ScsJj9Vw_VQ_6EGkH41y_aXg-BILWsdNM2EEyCGFDR1bgFX8-Q3
    Gh3u75Hs1JvkbtSmMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefgudfg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qpC1Y1sIHP_cdgjpWxNokEAMzClG6wracp465TYqrZBvcGQUiZ_BAA>
    <xmx:qpC1Y-a8OLFOjgpbw_j7lr7yPJ2lWs7Azpo2hagp1Cl-8-L1mkyvBw>
    <xmx:qpC1Y0bWKkMo8jH5FNcGO5nbSx-AbzCPRahp1MC3CXot3GEBkL-CWg>
    <xmx:qpC1Y07xo504-x_7Lw8SQrhtOu3MPfs24B2_b1tCFQDCDzdYRKuIGA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 02214B60086; Wed,  4 Jan 2023 09:43:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
In-Reply-To: <000000000000dbce4e05f170f289@google.com>
References: <000000000000dbce4e05f170f289@google.com>
Date:   Wed, 04 Jan 2023 15:43:33 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Content-Type: text/plain
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 4, 2023, at 15:24, syzbot wrote:

> The issue was bisected to:
>
> commit 55d1cbbbb29e6656c662ee8f73ba1fc4777532eb
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Nov 9 02:35:04 2021 +0000
>
>     hfs/hfsplus: use WARN_ON for sanity check
>

My patch was a mechanical conversion from '/* panic? */'
to 'WARN_ON()' to work around a compiler warning,
and the previous code had been in there since the
2004 HFS rewrite by Roman Zippel.

I know nothing about what this function actually does,
so my best answer is that we could revert my patch
and use pr_debug() instead of WARN_ON() for all of these.

    Arnd
