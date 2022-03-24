Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E062E4E6891
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352598AbiCXSWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 14:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345513AbiCXSWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:22:30 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B577B7C45;
        Thu, 24 Mar 2022 11:20:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id F2F0B3201D51;
        Thu, 24 Mar 2022 14:20:54 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute4.internal (MEProxy); Thu, 24 Mar 2022 14:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=PeIF+16CwFr5dwZV6td5ZY9MK7EpNYGqWNMbQH3Li
        wI=; b=OXTYEJpI6HizrkzqLKQD+EPCR7vxpAhsqB/+bZpjQFp7SKU8Oh9vH1+Ig
        O7tBYDE0L1Gw9uS0seu7GgcEqce2NlQYgdy3dsuSjXaXPwN9NnE9ghXeHNhsUKwa
        MF2CzH6iudg/qif1h0NGT5wdBAM6C1YW/USz8Grx2zAVuMXiNWuIM9vIXM+tDdjt
        Fsc5yz5luGeaf6OLNlhaSZ+0oXJHn109imZPSAqvxQ2WCgoXZtEtk3T1KzUGy4If
        8ikCrVr9lufEaqLznpiaOhA5xK6HXVMKLx3LfkBANCxa02yHNbvN8ueELwDbHJW7
        AbdvhrJlIdC1WbHI1jrjvnp65XWHg==
X-ME-Sender: <xms:hrY8YkmbLiyM7a5_E1iG_aAw0JtMq72PKLBvHWVDcs6qRHiw0vnX2A>
    <xme:hrY8Yj3QnWwRDHFarCsOL7tbt2Tw5dKPpQXeyF_RJH4_ekBPoMA33Pm1O3VolNm6n
    qTkKEq0MGaMqcIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdev
    ohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqne
    cuggftrfgrthhtvghrnhepgfejveeileegledtgffgveelkeeglefhvdeutddtvefgffei
    jeekhfdukefghfehnecuffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshes
    vhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:hrY8YirQ5N1213ijJ_4aZSV8hZud9YwRIvJQbscWqgGER214bfBCeQ>
    <xmx:hrY8YgnKDaWGGa4KQQMn3N_bahwiWU6gwkeV5rl52K7mNohwxFJgog>
    <xmx:hrY8Yi3g8vQzBss0YikBt1Ncd6jmb4Wht7ZU3nwqplV6vomUQsdtkQ>
    <xmx:hrY8Yu9sWu8FjGmovBB-7Cr_-4H88CSZS1HHsy6QpSQrChrDjSx-jw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 59E7C1EE007B; Thu, 24 Mar 2022 14:20:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4911-g925b585eab-fm-20220323.003-g925b585e
Mime-Version: 1.0
Message-Id: <82c881e7-652f-4fab-b313-ee40659c1798@www.fastmail.com>
In-Reply-To: <87zglgoi1e.fsf@brahms.olymp>
References: <20220322141316.41325-1-jlayton@kernel.org>
 <20220322141316.41325-3-jlayton@kernel.org> <87zglgoi1e.fsf@brahms.olymp>
Date:   Thu, 24 Mar 2022 14:20:24 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>,
        "Eric Biggers" <ebiggers@google.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, idryomov@gmail.com,
        xiubli@redhat.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v11 02/51] fscrypt: export fscrypt_base64url_encode and
 fscrypt_base64url_decode
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, Mar 23, 2022, at 10:33 AM, Lu=C3=ADs Henriques wrote:

> So, my current proposal is to use a different encoding table.=20

Another alternative is https://en.wikipedia.org/wiki/Base62
