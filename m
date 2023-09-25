Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7E7ADC2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjIYPrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjIYPrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:32 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131E91A7;
        Mon, 25 Sep 2023 08:47:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 750045C1F9F;
        Mon, 25 Sep 2023 11:47:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 11:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695656840; x=1695743240; bh=+v
        KhvI/Ayw8ZF2UMd/3KHjztbHQPAFx3voTEU49nlf4=; b=WkfjzfyYFriipTXDab
        kMvNOuVMtPiVAVxp5nPRHIiz3sc424JdoohsczIhiRYO5u8KboaEnDTSxZCHqqr3
        1YbKC3t5TdnBCovjgaRL553v4McpdnCsdq6sa34kS/dIYlEPhRyOgDKXKFW1Zxnu
        WRI5VM41w83BSEFH4JCsDQbCfD5LqeE9ydf4nAbaehkz79Fgh7x3C2KML72OMuuV
        JIbtidNR6OmswPAoiFlie2nyo5g/U4Wb7ZRYTx2rx/n5ohbFSO3d15X3wD+QpmrJ
        PWcFqM0I264rUBA4fLGicgMyiRDCCoz7+Mwa1RKvsnqyKArBJ1lFPpe+S/7y8+dv
        ReOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695656840; x=1695743240; bh=+vKhvI/Ayw8ZF
        2UMd/3KHjztbHQPAFx3voTEU49nlf4=; b=qhW3cYQzCW1SmMCDtbbaOAlLC8MLF
        uRpPar5Pu7DFJzrZsNsD2GTnINJvmscfADFXTQvL/v9Kf9vv7tp2gmaMkZAq3f/H
        QojF0lZ2MEjOxto+IGA/EqxAlogl2gaNie22+Ui6nTrd0Lw8PxhIAx1+rqkvv3u/
        /MhFTeE8CXWcG6zunhRUJGNcCR72d8ru++yvF8gV2KEfBby2Z5LxrLBs1d+0+ttn
        /xD3X8rx5t6UE8dlPxOaR5M5j8u6D8rIOAG1zFRkJvbInpMzoe1AnphDE4yTrDPL
        SicNdoK7VPSGkillo4uyg77GuandCkLZaMz9twEh2AUfUu7WOtycfXe4Q==
X-ME-Sender: <xms:h6sRZd7JelL0FGWIpCurmNpmDBV7yL3sUj2xm2eS2D-hqUMyIAVW3w>
    <xme:h6sRZa6DQ1QsHVJKCHhqEqzJ23j6G15ltitzFpG9yeL98VoeGsoOvPGlU8p-AYOK0
    asvEUCoq2bIu1kU2pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:h6sRZUe91cjMxwK0fX14VR2KnvHzScL0VG5VvLXnMaYRiVetzrUEZQ>
    <xmx:h6sRZWLNZt-HSEc3gc8zdbLiRVUi6puW7dMZPnjUipnHI833MWl9Pg>
    <xmx:h6sRZRJD5wkBjw2mr5X1HQZCfB6GUTYnpji-oNQ6ft6sZpiUIU6LYA>
    <xmx:iKsRZbBbK3gU_S6YiUCjqDqmuYcB5C_8_NqaxbYi7RFwj4gqQjX64w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F8A9B60089; Mon, 25 Sep 2023 11:47:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <15fb406a-0f12-4708-abe7-91a464fecbc2@app.fastmail.com>
In-Reply-To: <CAJfpegvAVJUhgKZH2Dqo1s1xyT3nSopUg6J+8pEFYOnFDssH8g@mail.gmail.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com>
 <20230925-total-debatten-2a1f839fde5a@brauner>
 <CAJfpegvUCoKebYS=_3eZtCH49nObotuWc=_khFcHshKjRG8h6Q@mail.gmail.com>
 <20230925-wahlrecht-zuber-3cdc5a83d345@brauner>
 <CAJfpegvAVJUhgKZH2Dqo1s1xyT3nSopUg6J+8pEFYOnFDssH8g@mail.gmail.com>
Date:   Mon, 25 Sep 2023 17:46:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Christian Brauner" <brauner@kernel.org>
Cc:     "Miklos Szeredi" <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Karel Zak" <kzak@redhat.com>, "Ian Kent" <raven@themaw.net>,
        "David Howells" <dhowells@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <christian@brauner.io>,
        "Amir Goldstein" <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023, at 15:20, Miklos Szeredi wrote:
> On Mon, 25 Sept 2023 at 15:19, Christian Brauner <brauner@kernel.org> wrote:
>>
>> > How about passing u64 *?
>>
>> struct statmnt_req {
>>         __u64 mnt_id;
>>         __u64 mask;
>> };
>>
>> ?
>
> I'm fine with that as well.

Yes, this looks fine for the compat syscall purpose.

Not sure if losing visibility of the mnt_id and mask in ptrace
or seccomp/bpf is a problem though.

    Arnd
