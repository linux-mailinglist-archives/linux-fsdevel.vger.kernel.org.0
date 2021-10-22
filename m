Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ADC4375AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 12:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhJVKuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 06:50:07 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34583 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232560AbhJVKuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:50:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 55FD63200A60;
        Fri, 22 Oct 2021 06:47:49 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute2.internal (MEProxy); Fri, 22 Oct 2021 06:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm3; bh=WMH4rbN2enHzZiUCcClkPCqKqZ
        +TbZt9htiNG5WTVD4=; b=H9XZteDWQIZ0c7pWy4DRpLcPH+krwNegxNPVbJ2C5e
        kUzH4m1vyByHKk0uj0keZzSJJgAyVs9b/m9t6SS6uyr3hrD4Jgp2iPyq0gmcODSV
        3R4Ip52IM/qAm6P4HRyzXdg7vOpPKBvOpLkrpkFpBG/4yuI8A9SWrlEJ+MJ60FVU
        c9mkzXqNGRJGkdIVkkgbMCcdkeihY/j6INsra+w4nV+dXvClsm2qOaGyYztN7mH6
        rm1ZYa+xLsuaVBhvvMbm09E2Q42YCEO2XSorWrFsYsZvMyaYeCFOadVxUhWzerKT
        pWTBHDAu3nMxSQOs+xlt4WHnBrCiMghWLoBvCJvIfwfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WMH4rb
        N2enHzZiUCcClkPCqKqZ+TbZt9htiNG5WTVD4=; b=MHt7R9Dv1qrJucMiT4ed8S
        AyFaBOLGwI+cWE7Sr+QkBsaklBIIcOPH2p/NjdQCpTCVW+ntWlgGHWaxfjW6jDww
        mM/Ndy2ikHEYpSWzNUh0lTh0TKXugAE0UUu/wQj44TQMOyZfkanw6YdljRFMh2x/
        kaZiSIfASEh6NYBD/qQE7FuPc3ok4kaAS3wtYeMYZXgbn3B1395Z+ZCcJJflshgI
        ZJq7BgTJOl2a1/TlyUktN5b9eRElo8Eo6tycvRnu2HuYI+rXJgZkuXOJw44rMCeJ
        EfWFoJWYj7tOm6wzR81SEJGN/jDK0ZWnkWMdxDJy8VvgU1mZHJwWKFYTrKtrcKWQ
        ==
X-ME-Sender: <xms:1JZyYZS32mWqsY-AEPL_42_A-WueCb7DZjM7zm7HThguWJS5xl2aKg>
    <xme:1JZyYSw-dbs6cnhsK4n9iIuFE3MOrrmsW1gmND8uQPMTE-ewdPeTp_WynKuBteLlW
    mMwALPl_8p6YpXH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvkedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfpfhikhho
    lhgruhhsucftrghthhdfuceonhhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepffffkeetueegteeifeeutdefieehvedvueevhfekueffgfetteduhfeg
    vefgffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epnhhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:1JZyYe1Yt5YtvETbLIyMuFxPl4kZ3idWOCcLF080mkRKoi9ChYRBPQ>
    <xmx:1JZyYRA3Vashfkp59o8UAWdJgQOWLnOqVulbZSvTdDvMghOJlr-0PQ>
    <xmx:1JZyYSiWxGHBNGYZf_7yL1MFn28CKR5P9NKH2UMkNkIal5YpfXknHA>
    <xmx:1JZyYTsy-VOINkTu5xD9sAc0zMMkXuqFEbdKSaMXeACgmfV4_d9AzQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A33924A006F; Fri, 22 Oct 2021 06:47:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <77b7da23-1c01-46e2-aa90-c08639acb398@www.fastmail.com>
Date:   Fri, 22 Oct 2021 11:47:28 +0100
From:   "Nikolaus Rath" <nikolaus@rath.org>
To:     "Linux FS Devel" <linux-fsdevel@vger.kernel.org>,
        fuse-devel@lists.sourceforge.net,
        "Miklos Szeredi" <miklos@szeredi.hu>
Subject: [FUSE]: io_submit() always blocks?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I noticed that with a FUSE filesystem, calls to io_submit(2) for read re=
quests always block if the request would have to be passed on to the FUS=
E userspace process.=20

Is that expected?

I would have thought that AIO requests could be mapped directly to FUSE =
requests, so there shouldn't be an issue having multiple in flight...?

(I can't tell if the same happens if the data is already in the page cac=
he). This happens even when submitting read requests for different inode=
s.


Best,
-Nikolaus

--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB

