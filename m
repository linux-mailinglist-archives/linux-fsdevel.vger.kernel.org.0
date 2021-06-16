Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC603AA261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhFPR1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 13:27:09 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:48549 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhFPR1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:27:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0AB7113D1;
        Wed, 16 Jun 2021 13:25:01 -0400 (EDT)
Received: from imap7 ([10.202.2.57])
  by compute3.internal (MEProxy); Wed, 16 Jun 2021 13:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=S3DHl
        yc/BMJX68WhfArXVLByW4W5EXk1LuJ7CQ8Flj0=; b=U6kE+tqO7Puh6HUUiJCFH
        0KsaEuQrKYlQcU+LY/gINYiNn+vHV6iR/RB9s+JXrTRxIdE2jeA6jjqQlph+kZXg
        HZAKHAEkq1KZ1Fkb4TwyyPRRrjlL1XP3K7auWIY0ukXbPC9HmY86NuD6arLhrP1Z
        hakRrE4p6ycYzQKf2t47mMtIv5drJKKgI6BlJ4lGd2VXpUg1iOaReQtWHYfpwac1
        xXhgK78xCle8XmVORZkSp3SNWOsHgCyrFJRT5xB447leAPkVVlnzkBjd1ghAHllX
        W57gSaCKSrqkwKGrlEaSClYFDv/H6KUmjAXkFcxLSJ8qnxKFYvd1PeMAzr50GbjC
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=S3DHlyc/BMJX68WhfArXVLByW4W5EXk1LuJ7CQ8Fl
        j0=; b=J1ZjvB2wOca8vhK+LllxzmglHVPZnxTNo+b5OZtMYrX9UpuvC2zLh6Tyd
        vzGB7HtZ9dbxqDffhLdNVaEwmrJuSYiVrgRc9S6jyAcwG/gh6I51OKAZNvi/6lQC
        Ne31c8DurAl3mKtWYcWuK8JvBx2kDzvbodgh7D2P7eO5v7bmhPcFLBIImztOWv1Y
        vDJi//lJpH7T9MTWW9O18n6vzPhXxW2uYvryLPhm13S8oah8qb1P+cSgeKXzd38Z
        3oEdpmBA9t8T6ayCvlbvp0jK/T/gM/hbrFk7SekUdg5QRBflqgfmB3BmA2a9kAfN
        w08KxsxJwLjFfUqajJGuipAF+Bp4A==
X-ME-Sender: <xms:7TPKYHDMODsWMcA6vHYQPAXIt97bYZBznOhkZreyC0vivrJsoJjUyw>
    <xme:7TPKYNjHER7wR5s2GOam2PPKjZbXNfBtmzLrDLN4iqiQI6FezD48As58IUlmw0wIt
    sqoMtIybVdLM33U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdfp
    ihhkohhlrghushcutfgrthhhfdcuoehnihhkohhlrghushesrhgrthhhrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeevuefgkeelkefgveejffdukeetleetfefgudfhudeljeduhfel
    ueehgfekteeujeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhholhgruhhssehrrght
    hhdrohhrgh
X-ME-Proxy: <xmx:7TPKYCl_nknizYHUDlbFzbpjBK9M3MvfbL-SpX4geig0WzKD_u2vdQ>
    <xmx:7TPKYJxmassu1LN-zy7XWSFw5VB9a_kOJ7S3Xr2qdzCg0SefM-P19Q>
    <xmx:7TPKYMSckVD1NDH4XputNI6PX_hBpDwk72AHCnMICQrzp-hI4JWZPA>
    <xmx:7TPKYBLVc-49qb0Rjv_u1uX3zpI-Z2d1Wl6XVOF3TlymT46sFEho7A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 38E23360060; Wed, 16 Jun 2021 13:25:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <d7a38600-5b4b-487e-9362-790a7b5dde05@www.fastmail.com>
In-Reply-To: <CAOQ4uxi3vK1eyWk69asycmo5PTyUE9+o7-Ha17CTXYytQiWPZQ@mail.gmail.com>
References: <20210609181158.479781-1-amir73il@gmail.com>
 <CAOQ4uxi3vK1eyWk69asycmo5PTyUE9+o7-Ha17CTXYytQiWPZQ@mail.gmail.com>
Date:   Wed, 16 Jun 2021 18:24:40 +0100
From:   "Nikolaus Rath" <nikolaus@rath.org>
To:     "Amir Goldstein" <amir73il@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Max Reitz" <mreitz@redhat.com>, "Vivek Goyal" <vgoyal@redhat.com>,
        "Linux FS Devel" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

On Wed, 16 Jun 2021, at 16:03, Amir Goldstein wrote:
> Per request from Nikolaus, I modified the passthrough_hp example
> to reuse inodes on last close+unlink, so it now hits the failure in th=
e
> new test with upstream kernel and it passes the test with this kernel =
fix.
>=20
> Thanks,
> Amir.
>=20
> [2] https://github.com/libfuse/libfuse/pull/612

Actually, I am no longer sure this was a good idea. Having the libfuse t=
est suite detect problems that with the kernel doesn't seem to helpful..=
 I think the testsuite should identify problems in libfuse.  Currently, =
having the tests means that users might be hesitant to update to the new=
er libfuse because of the failing test - when in fact there is nothing w=
rong with libfuse at all.

I assume the test will start failing on some future kernel (which is why=
 it passed CL), and then start passing again for some kernel after that?=


Best,
-Nikolaus
--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB

