Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AC91D59E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 21:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEOTWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 15:22:44 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40089 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgEOTWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 15:22:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 712C0AD4;
        Fri, 15 May 2020 15:22:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 May 2020 15:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=EItfF4iKTPwzzfpr4Yj8ZuxwQb
        kCS9atun/WMEk8O0Q=; b=waDxF1HrkN9oE5rhj7GNEQwnM39Vak3v2TcT8+P3zM
        tP91oas46JXCsNXYxQ8fgNabkh49gGFUvcUbwidPzpCAq+7VV5CRZQH5LaBDTXab
        rFQKYid4zcECwQFzaj4lqFfxD8/cUKAaH9SJIlRuoz36l0KN+V/AMMNYe0sL/66N
        9m+T3nWMS0pBM3Gd9ZZdrr0xT4MQiAdOddOI9NPBPGFljWyha+5HPBucaTz/fzkB
        l0eI2QwnwijwKlnGxOGtjPthvbvJHLWVtRJpBFTeXTAVFyzjTkYN8F37w+0rqWVZ
        GSpUJtyMIojc1a3eCJTZvSn7/+w9QY/RYfBn5hUIHZpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EItfF4
        iKTPwzzfpr4Yj8ZuxwQbkCS9atun/WMEk8O0Q=; b=BKEsmB0fjX0f7ITnoooEt/
        lh6VcmpnUn4urDRFG3fuhg504cLhuxMILluCjSMsgmZGHvKz2MGKzmhJ/HfQR3n7
        5HGrUP9HwuA62g2fHbR9WCmJ5qncw2508nkAy8HYsHd8ZPMwYd9qtK7PwgHYTNIz
        EK0ASXxmIUtS7Gt0YPbeCVtZuP7SVW1ULe/nsGTfRdWW2HDcpTQUZXCYBODWZePm
        +okGb8f6s/ccyBa5GxVm4vUuvKsZppvgGhMLFogAMuR81XWxGapGNdp1R00VVLyu
        yKHrX7Ssf6ILbqHpfp26gBpnWVSOS2AYFOM4JtLo7T3AFhEsZTG/Y/4T6vLu8sig
        ==
X-ME-Sender: <xms:Auy-Xg6Vr4sBHCCryej43vkTMq5q-NumOlrnl5j_tOawrN8mTBtPTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhholhgr
    uhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeftefhgfejhfelkeduieeludeuffduvedvveefkeevtdevgeevfeejgfdvuedt
    keenucfkphepudekhedrfedrleegrdduleegnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:Auy-Xh4niw4RFCf0irvitUTf3N9nhHS66VbMH7vToPyVLW5CVcWMdQ>
    <xmx:Auy-XvfzbEG1YdQhTLQN2xBXiLzc3Y1xyKhkk481LgaK94XKT7qVSw>
    <xmx:Auy-XlI2Kx2npKKZMkSqkP4U8N5LEiIV2i6vsKTVlAMH9zvimr9Xog>
    <xmx:A-y-XrXEjlC3mkCeTBbd0G3ZUOuqJMrALGC7NN27TP2Q-NDDzLKowA>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F7B13280065;
        Fri, 15 May 2020 15:22:42 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 3D23C37;
        Fri, 15 May 2020 19:22:41 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 25900E0317; Fri, 15 May 2020 20:21:18 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     fuse-devel@lists.sourceforge.net, miklos <mszeredi@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Determining owner of a (fuse) mountpoint?
Mail-Copies-To: never
Mail-Followup-To: fuse-devel@lists.sourceforge.net, miklos
        <mszeredi@redhat.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 15 May 2020 20:21:18 +0100
Message-ID: <874kshqa1d.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Given a (FUSE) mountpoint (potentially mounted without -o allow_root),
is there a way for root to determine its "owner" (i.e. the user who has
started the FUSE process and invoked fusermount) that does not depend on
cooperation of the user/filesystem?

Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
