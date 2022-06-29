Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B355F29B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 03:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiF2BGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 21:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF2BGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:06:21 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37950193F5;
        Tue, 28 Jun 2022 18:06:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 107D53200258;
        Tue, 28 Jun 2022 21:06:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 28 Jun 2022 21:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656464779; x=
        1656551179; bh=K2oGX6SnfanfkQgoCUAA8hU3hd1LuBWTiUjpPxiK7ZY=; b=J
        U7i6WnNuRDBIutZR8YpziE8loY9a8yFaUxXbtI5yEutajDZJE323zTAJfPsLdhnH
        H4imAgv2ZqEUTRNd5U9eeJrenIqGugnKzdD32bMF6KwvYNkjeld9je7WJ2ueDnd/
        BjZZOmUPwwgC8XPSoYGN4OTauFquyr7lRDI9V07uxzZU1L7UBAmKflgcMo7knwWe
        Wsh8kesFHQLXInoBGuUuNIhtLeBKUZ8lF7FLbK7VaL+2/B+x0Hwe5MVrVrIajQ8e
        /fNUT6lyDPhjshBppf7m9+gPJmTJgnW+Og44MdW2ov/NsyZlJLPaPut/z9VPbXru
        1j8uP6Oj4puej71tJa4dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656464779; x=
        1656551179; bh=K2oGX6SnfanfkQgoCUAA8hU3hd1LuBWTiUjpPxiK7ZY=; b=g
        XGUsMOO36N+TFIcUNJAG5GAr63DGkcYVq44J+rI4gbMAadCO4vVza/AJpxczJSP4
        bO3g8HeMnAdtJK2MC4qp7vvTNFTaCt94iM77VbuI7PBlYj7BeG7ZpwS5Iw0AAqeZ
        wv+uSXPjxDu5ae2O1Xbi1TZdVPQEwd8t5pWiYMQcik7gAhqjPzP7v/j7ElPgHsWo
        XPTz4/Ef2H5gRwghvQgNVV8HJYoW1j9OFKlWd4iUb7CcchwWpNfx54olYHMZ4P5n
        KNJz4js672RrNLjQdk2rnNnFoz7hEPMhAkRfQOO4ROv4Nbn19JrBgdJJOSbQvPss
        1xD0gTRfYers3yK4gIZNg==
X-ME-Sender: <xms:iqW7Yjwz5mkSnn8z4PdrpieLGguJpiZOEoS8coFeDYa2VZNSi5W0Gw>
    <xme:iqW7YrTUUXQhv9X8SMSGOutfhpF-JzHg-9w5OI4ku4Gh1bYRgAuuwOlBd6_VoBlMF
    06SSp_mXuqR>
X-ME-Received: <xmr:iqW7YtWgQTFv8nqTxZKdp99fdcIRoAwpGsCNfcw1blUurGLgSELGJQFnkaruT2CFFGZbXabsp_fWb6kkY_1oujk8he3hslx8qXvO6ZayUhzylbZlJmXu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:i6W7YthEsC6ypUhDblC-MFTClrklNK-k40PAqIGbQJWdaraRPR4alA>
    <xmx:i6W7YlAkS0K8wIb3lnzGT3728nAxCrFC7zs-kfvHBWJ-V4t-OEpVvQ>
    <xmx:i6W7YmLyRBfF97VxsqO35ttMTizMuAw4hWvBw-RF27OEXvc3cLJpeA>
    <xmx:i6W7Yo4ehHDYgenbTJQ6geLYYVlBzUBDrKRu-KxaO85VTVok4Vf2Qg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jun 2022 21:06:15 -0400 (EDT)
Message-ID: <e2c566f9-47e4-cfdc-ad4a-426ecdfb16e4@themaw.net>
Date:   Wed, 29 Jun 2022 09:06:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] vfs: parse: deal with zero length string value
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
 <165637625215.37717.9592144816249092137.stgit@donald.themaw.net>
 <YrtAqQoyFG/6Y4un@ZenIV>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <YrtAqQoyFG/6Y4un@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/6/22 01:55, Al Viro wrote:
> On Tue, Jun 28, 2022 at 08:30:52AM +0800, Ian Kent wrote:
>> Parsing an fs string that has zero length should result in the parameter
>> being set to NULL so that downstream processing handles it correctly.
>> For example, the proc mount table processing should print "(none)" in
>> this case to preserve mount record field count, but if the value points
>> to the NULL string this doesn't happen.
> 	Hmmm...  And what happens if you feed that to ->parse_param(), which
> calls fs_parse(), which decides that param->key looks like a name of e.g.
> u32 option and calls fs_param_is_u32() to see what's what?  OOPS is a form
> of rejection, I suppose, but...

Oh ... yes, would you be ok with an update that moves the

"param.type = fs_value_is_string;" inside the above else

clause?


Ian

