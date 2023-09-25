Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E887AD85A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIYM57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjIYM56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:57:58 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4980B10A;
        Mon, 25 Sep 2023 05:57:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B555B5C2725;
        Mon, 25 Sep 2023 08:57:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 08:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695646671; x=1695733071; bh=GU
        RwEQjHVcDB6mdGxNVBiDVcooHojwDOtnH43Ifl4O0=; b=E0GtQRrGZ4xYAllJad
        I+DxPM0CKNc/UPWHvTvQihcdjR7FYSkLepOWzMuGdug/oP/H4ls008ugct6FSzYh
        wt1OgUEMIO0si9Ep/acl8Z4udTnm1Jp7mW8Yq8TnuCE+5morI7ZxVDG8xjR33ceF
        jhO1c32TKYnGJPDptO+cCKNcq6D2K1PXrrudu6rMnShE89vkcrq3Nb9e+/36s77m
        bEwelchxNEG76wfYMWWplmPUJPmdwEVx82EJd52J41bwUOGwzIc0yh0kKzRlWf7A
        jZIx+sdkC68IbCDk2pA2oaiJ+Xgo2vFVt0lzBtaR+My2OG5r7ENeC8/nqhdhHTXJ
        3W0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695646671; x=1695733071; bh=GURwEQjHVcDB6
        mdGxNVBiDVcooHojwDOtnH43Ifl4O0=; b=R8tclYI2FqII62SdxIlbAvuaduWu6
        FEr6D3l9H9B6wgDzSK7i6qAiui6UCmZG8OkUs58DsRP7UWxp55/9P//JX/8WEwDy
        bp1QnJf0sE6nopvJN+5RT1ykH6aeddglXaZ0H5qT/LjYA6R2j8ctoF6/zeO0aLoC
        brKtXXN/rPKd1n9lLIS/o/kRT3m7qgsjZRdzL+masZAJlI245MTPdvH8BD/5cBlw
        QEf4cUVfC8GQCTZ0YolVzsEKDDbdDW3b0PWrB618niRRUg/QMB1kvgmkt6gxINZ0
        Upg3ZUmV6tTpNJhaPJsg6NBwsabqu9FrlwCMW4ZvHGRK2UhkpJ/Cv8Xmw==
X-ME-Sender: <xms:z4MRZWN1qqBPYKQl3Rf0QXXn8_rs-cymOhdgtTJA8KTQ3TgG2ku0dg>
    <xme:z4MRZU8JRedri1jsDJ9sWWA6maVlyd1DfWiDR45cnWCpD6C_oCZV3f_pJ5pljtV62
    63ud_Yk1nyfMJiWrEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:z4MRZdRI9owEyhLNEsFuWNe7f56A0uhIynzQK7ZgztqUR08rABrCIw>
    <xmx:z4MRZWvmnop5BLLXN0TbEkCoxEcrRkA3uNq4SVHh2eRv0U5UodvYHQ>
    <xmx:z4MRZecBlDkiQRn1EJmf-Kdr6Q9Jg1gqbFrwCXrdGsxicxMuLNT3og>
    <xmx:z4MRZfXbqtPxm8s6mmd2WYSBwH2MaP3a6tycQd6de29EbV4LcgSTow>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 498C3B6008D; Mon, 25 Sep 2023 08:57:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com>
In-Reply-To: <20230913152238.905247-3-mszeredi@redhat.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
Date:   Mon, 25 Sep 2023 14:57:31 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Miklos Szeredi" <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
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

On Wed, Sep 13, 2023, at 17:22, Miklos Szeredi wrote:

>  asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
>  				struct statfs64 __user *buf);
> +asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
> +			    struct statmnt __user *buf, size_t bufsize,
> +			    unsigned int flags);

This definition is problematic on 32-bit architectures for two
reasons:

- 64-bit register arguments are passed in pairs of registers
  on two architectures, so anything passing those needs to
  have a separate entry point for compat syscalls on 64-bit
  architectures. I would suggest also using the same one on
  32-bit ones, so you don't rely on the compiler splitting
  up the long arguments into pairs.

- There is a limit of six argument registers for system call
  entry points, but with two pairs and three single registers
  you end up with seven of them.

The listmnt syscall in patch 3 also has the first problem,
but not the second.

      Arnd
