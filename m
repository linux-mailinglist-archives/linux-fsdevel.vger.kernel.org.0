Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637085BBD83
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 13:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIRLDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIRLDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:03:10 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CE925E9F
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 04:03:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DD7DA5C02CC;
        Sun, 18 Sep 2022 07:03:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 18 Sep 2022 07:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1663498986; x=1663585386; bh=V3kEsfeDBJ
        N4CdGXOE4NkgGPA+jJODsqE1SbYEllR3I=; b=oNXvtddFP6PtVB1pKkkYgg4te/
        sIOO5eNwPbMq/loNy6INkpm9sqW/kcHI95/1mUh8A6aoiqxPa9Lkq2ERYfBIt6qn
        XXM4riEx2DLvAPA5mQyfMlkYtfbOucp8RSwY0JHaX89d3rnJXgXI2ThlOPYxE0OO
        RNb54w9Db6bDGbwIDGkwWkZE9L7isTbk3pC5sDl9eZJwXZMxf/49yCIWx/eKcSdN
        OANpAdyWlNHmXx9PE3sWa3MQnWb3lzdX6c0oLIFNFYRnam+RxS4LsCf9qBWW1+1a
        CDjQVTHgV6FjcQv2qj162q5uVwxAp8fB2jOrAAD0SJKEk14aKHX2HUZDREbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663498986; x=1663585386; bh=V3kEsfeDBJN4CdGXOE4NkgGPA+jJ
        ODsqE1SbYEllR3I=; b=wwGAD7c7mptySBOhYxf1Ikl8uEvDcnewhg5tvNrSLU5J
        7sO25KFSxCO0g/LaEC7DGjJnWxRmV/fWpaX9Ji5edet5zZD624SLc29aCnr6SnsF
        R2JzktmGT5W9PkS1Ro24nplYLx4DnsMHICJNooY9ILNmvqw7iQY48mdclX27gVNU
        xWmgw071yogzK6TaAzLbWgYZA3V8t2iAzbUp20DIReUo4B30ImzJNFI8I6mwmR1p
        w80hFCcF+XrT9dTuv4AqJY2Age5V2SA3LX0rfg4sFe0O25ze9WWDQjzVsCBYI/R1
        ASfnY2zAcTmEdkeF77TJYxMoJzqS08rdQVNaKwk0Tw==
X-ME-Sender: <xms:6vomYwjSlbG58JdXq38dBCONaLVOK581jH-tlOooM7Sx795g1JNKNg>
    <xme:6vomY5C50w58uAYOONwATieXUltV-YaERhyl3_iE-CCubLFMHxpJHK9VbvogIrXci
    o4UhzECGHT6L7NF>
X-ME-Received: <xmr:6vomY4G6_XBjgovicsFraH1ZbX5uCYXIem5zWBZ_i7hWUxjfQtbLJI74ymwtsNfAVEHt_NDMfmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvhedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhholhgr
    uhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeftefhgfejhfelkeduieeludeuffduvedvveefkeevtdevgeevfeejgfdvuedt
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpih
    hkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:6vomYxS7ZyN8CzgvLvdm4hJXZvfWAYBGRK_1yklHI6iZVNAr9l0-lQ>
    <xmx:6vomY9xj8k-ukAnDoH4Z5aYH1m_zeuDVmOjsBxoBNS6A-LiYfTk9uw>
    <xmx:6vomY_7Ioid9sfAXVk_eKKMH0S5U_4GWJ5wFDNbAVC0_Z9txjHVAnQ>
    <xmx:6vomY18QMOu4J8Ja5_es_Ik5alSxnrlt_xMo_cQnF0mGQ-Ma_LyMgw>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Sep 2022 07:03:06 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id CAF10670;
        Sun, 18 Sep 2022 11:03:04 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 4985AD8013; Sun, 18 Sep 2022 12:03:04 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Subject: Should FUSE set IO_FLUSHER for the userspace process?
Mail-Copies-To: never
Mail-Followup-To: Linux FS Devel <linux-fsdevel@vger.kernel.org>, miklos
        <mszeredi@redhat.com>
Date:   Sun, 18 Sep 2022 12:03:04 +0100
Message-ID: <87mtaxt05z.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Should the FUSE kernel driver perhaps set PR_SET_IO_FLUSHER for the FUSE
userspace process daemon when a connection is opened?

If I understand correctly, this is necessary to avoid a deadlocks if the
kernel needs to reclaim memory that has to be written back through FUSE.

I don't think it's possible to do this in userspace, since the process
may lack the necessary capabilities.

Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
