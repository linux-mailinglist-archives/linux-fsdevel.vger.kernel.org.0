Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F871D5A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEOUFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:05:20 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48425 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgEOUFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:05:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 8A8816E4;
        Fri, 15 May 2020 16:05:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 15 May 2020 16:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=LXBXH9o+rLdwwbUDuQJ021k0pL
        Z0G5I8ZpYzswhyhKI=; b=W40qUF72mmSfP877BF/5nJuFxZUAkLYHddd8j7w8J9
        QGAf3ydLOmWQ7gAof0J7dushWAn99bwq1gXbAfIDmXxFUn+JPgWMbTra93UIoBFH
        DsC0KkfO/WFSmMWHRFsFfn0vl5gnPUJa7Rwg86ExhyMIzrD0Vqaf9LMVyPs6LiQ1
        j188AnP6m6LjGs2tF21r1vBGdV2qqLGUaas3VKaSJUBp1g4DAc7W/DiM7YM7ZFPi
        kojbb+7BN3l4mJDZ+iC+te6Q2Ce+UQYXcIiYxIcXtf6SKcOnSxSShF/8+YdpH3vc
        LudGX1/bIWzITDiIMQ8Ds+CayfiWLGxocqV0GChh6JtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LXBXH9
        o+rLdwwbUDuQJ021k0pLZ0G5I8ZpYzswhyhKI=; b=WnYWUI/mHpcqm5i0uifUlm
        AibvzGkhgSikM7tufwQ5xE0HC4t3gdYnvjM3GUbmR62fTNzKL/hnKtcGkS2lf+re
        KfR/y7MlFPs1+cm1KFB3LUiosmDUsMFi3SzUCE6UlH6Fsk9MngNr1iCMNX1gxHFq
        v9RtAQHA5vuOQ4gJzujLa6VF/8MSWDsYn2MapVvSLIbEvbZf0ykJrdbR7IpOivMt
        2ZI/PVhWeNop9QkeWzEYFyd9nPzq1EsSizuSLnAlNs3bnlJGwAYYOO+u2PgSAIKd
        l9HaOZD7xzglfz3dSpnrxUFP+KIc2IjIyANgUTd71QbiQb1TLlkLLjpe3MMG/CYg
        ==
X-ME-Sender: <xms:_vW-Xt8F3dR1b_JmQ72Jrp7sp1RnWXZmZ8BWbweXGCgZjvxtoF82Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgfgsehtqhdttd
    dtreejnecuhfhrohhmpefpihhkohhlrghushcutfgrthhhuceopfhikhholhgruhhssehr
    rghthhdrohhrgheqnecuggftrfgrthhtvghrnhepfeethffgjefhleekudeileduueffud
    evvdevfeekvedtveegveefjefgvdeutdeknecukfhppedukeehrdefrdelgedrudelgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkoh
    hlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:_vW-Xhv260jQNtNw_N8dg7B2floPRsMHUTc_SsiQ2-my-4kNIPcMOg>
    <xmx:_vW-XrBj2E25BLGMdxWmjYpX0Mt3Dq6LD4isxbt0BOVE8WSZQAXGBw>
    <xmx:_vW-Xhf-1VlysVXORqZDatGNU_zHtg2UswnNHFJJtvnt29YKlSHKVQ>
    <xmx:__W-XrYso6P_ks26fiz5YcFPephhFUMQQBi0pKGH1NnSi0JykRvHPQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 16D493066352;
        Fri, 15 May 2020 16:05:18 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 32A8337;
        Fri, 15 May 2020 20:05:17 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 18EAEE0317; Fri, 15 May 2020 21:03:54 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        miklos <mszeredi@redhat.com>
Subject: Unable to access fuse mountpoint with seteuid()
Mail-Copies-To: never
Mail-Followup-To: linux-fsdevel@vger.kernel.org, fuse-devel
        <fuse-devel@lists.sourceforge.net>, miklos <mszeredi@redhat.com>
Date:   Fri, 15 May 2020 21:03:54 +0100
Message-ID: <871rnlq82d.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I've written a setuid root program that tries to access a FUSE
mountpoint owned by the calling user. I'm running seteuid(getuid()) to
drop privileges, but still don't seem to be able to access the
mountpoint.

Is that a bug or a feature? If it's a feature, is there any other way to
get access to the mountpoint? All I want is the st_dev value...

Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
