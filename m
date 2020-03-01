Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47851174D80
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 14:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCANU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 08:20:27 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49163 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCANU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 08:20:27 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 58C93662;
        Sun,  1 Mar 2020 08:20:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 01 Mar 2020 08:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=KvygRvQozRKLyIWLDkSMub00eO
        FXckQys0Hx6JlwCLA=; b=iBpJQdXXSSa1v9cQyGxyQR4DYqpLJZ0ut/0HY3IaKN
        IGED9+SZJoBDydt95RTUpo87ODDFo/tgcsTz38ULvmrYfQdUY0yRcaf/1/vDC0MT
        YDtok3BalbUot3QLlogY8gz9Is74YoHLJuUZYUKzGTtsHcFyDYhAQi+xSXWHMnmV
        6h5M8mvUbyz1G2zMMOS0BiwtQeTe6BN/qHLqlKkfOThnIS+Z1kR9iMGIO8ovE4l4
        M/KcpmEgBzbxUXdjYk9QCxcwCYvR8RhfAmsqURCiMKIkcOQjc2mPfV3Up4EGbAi3
        cOimhoBgF3uWS6QJTZqbwTze3YKtbJ3YNhD8D8QGFaFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KvygRv
        QozRKLyIWLDkSMub00eOFXckQys0Hx6JlwCLA=; b=bmSVP31aG5cSHNiPxZTrak
        P38noXC5eCXvEXhRnOP871DqveY00FXsGK7kBixEmHc5LXg3ofvFFHPNa8cciKlH
        /UnJXQE9jBILvn4irhbVNwWQ3ho1ygU9yO/slBgB4e2fG/G7N9SRw65ehgoojPJI
        T8WUiNiGSXWyFM2vSouQ4avsBvF3gJcPrsWhXrRb7yp7quCzlZGx/QVQIOd2Jytd
        noB9w4nkMe3KaV8sMW7/X/EeRjYpigg9H2VFp8MZf6uW0HD6FYYvOJNi8DJuAdIW
        TK3NlevKaw17YTyxOBcdgmr7VpbkHVoLeH2rM3inxn/X8o/vTIXBHNP2p6If3juw
        ==
X-ME-Sender: <xms:mbZbXi9z-fO0_B9QHXva8B_ZOleXo4004lfFxgqltEElJhtjiz7zig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhholhgr
    uhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucfkphepudekhe
    drfedrleegrdduleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:mbZbXovkmcj-qtHCeyHE9I2dAM5jxAWbHShncpCKjsfz7A7uKGXU6A>
    <xmx:mbZbXlonSBvBYWxtvPpSl0grN54rffrDKyb6iNo6Np0fMeAdZM5lWg>
    <xmx:mbZbXlnm5evBCzPdq5PFpTJIYXDo2mkZqhASKZWjvtFqWg4vJzkaJQ>
    <xmx:mbZbXjLgg_J5v8g_d8q0DS_DvDZxYAsnujrA0PdLdXovjCsF1ZP0SQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E9693060D1A;
        Sun,  1 Mar 2020 08:20:25 -0500 (EST)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 6FCC94A;
        Sun,  1 Mar 2020 13:20:24 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 4533CE050C; Sun,  1 Mar 2020 13:20:24 +0000 (GMT)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [fuse] Effects of opening with O_DIRECT
Mail-Copies-To: never
Mail-Followup-To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos
        Szeredi <mszeredi@redhat.com>
Date:   Sun, 01 Mar 2020 13:20:24 +0000
Message-ID: <8736as2ovb.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

What happens if a file (on a FUSE mountpoint) is opened without
O_DIRECT, has some data in the page cache, and is then opened a second
with O_DIRECT?

Will reads with O_DIRECT come from the page cache (if there's a hit), or
be passed through to the fuse daemon?

What happens to writes (with and without O_DIRECT, and assuming that
writeback caching is active)? It seems to me that in order to keep
consistent, either caching has to be disabled for both file descriptors
or enabled for both...


Thanks!
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
