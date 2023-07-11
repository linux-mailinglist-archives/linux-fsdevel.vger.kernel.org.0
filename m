Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7074ECDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 13:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGKLcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKLcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:32:09 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E2EA6;
        Tue, 11 Jul 2023 04:32:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 755C55C00E7;
        Tue, 11 Jul 2023 07:32:05 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Tue, 11 Jul 2023 07:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689075125; x=1689161525; bh=/C
        vj5KuDdmHIGd859qaJsBs/f1fpWATGo78ystxolZ8=; b=C4Tl5XZgJGIc7j43HJ
        4fGyI/IRlktc3w6e0XFyC1Sg6fp8cLDzoB1xPJ/yosSCoI1QS/IIkA7A0lmOtSB5
        8dS0sjpFCOyKj521J54iNrg2Ng8+adx4HMWT43DkM+FJcICGaQpids1RewgEq1Xj
        0mY/MPzvKuffj8CGY+mzm9mDWmVhhvEbPTNxnU75mrfiB7BL+Eq7WxgavTeKOobo
        O8eQk0OtdaNegptl2lVjD4jRydZYvCjVnTJ66OECZngYMjqizqY133wtbpYlGLGk
        nxZgL729F0mocqDVx9p2E8s6g3NUBTZ0kf1O2D7yx4W09UvSleY+E25vqJ6FkgSF
        Hfrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689075125; x=1689161525; bh=/Cvj5KuDdmHIG
        d859qaJsBs/f1fpWATGo78ystxolZ8=; b=QqHVCmHeA3F+kyNbq+cIkQQCEtoHx
        HsAMIDNNGIYjXVDzLpogMsF84iRhwfmY38lNiYRP4tDLqwRRID821vzTvgRLSw2N
        iQqDY6Iq8rWyG9lLkEmR5e/UJG9diErjrD8AFbczp0X5rKkN8AG44+gfgfPaGLvL
        hEL9WPOz/L9mb0cXjNy3JPxTH2oZtFGu2NYSMi0+g5/Ya/upwP8K+ycBfabbXSDS
        pC7VjP6/HjSulVngpPClEkB50uvje1m9i5hPtX8K305ne5TzZEfZciWBQo/Qos9j
        xbHxrcsOpeJnDp6IHEvgnIXFodpKlEk/s2SWjSA3iqRI90V/hVTnTDDhA==
X-ME-Sender: <xms:tT2tZMq7b3F3GuNwIAVPns9-hrMV7r0Yc6YT9LqOf-jJMKbcl7Fh9A>
    <xme:tT2tZCqNeEHxlc-UStg0uiSOgPvE3_cLgP_6sxhq7l1ERIaLmgg6bipvjEiyrkpas
    EjV8FZ1WrtLpcs-7GM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:tT2tZBMvQLXICA6Yc7Zt2AWWWwfYYPHBdt_zdRvw9CwK-9s0jeSfHQ>
    <xmx:tT2tZD6JBvvCY4Z7UDnCJz03QOvfOhdkKUjt4ButXwR1zHx1yx7H8Q>
    <xmx:tT2tZL7ngUbKLupOWUkuw3qJR51wOdtRI_3lKoDd41m846IM35HoCQ>
    <xmx:tT2tZPiMQDZ505eWhA_Ewk2IXxTzTQEwFwWy0ucHcigyBE5CiFgBjQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ECECE1700090; Tue, 11 Jul 2023 07:32:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <55fee4b7-41f0-4f24-ad0e-a4527486bad1@app.fastmail.com>
In-Reply-To: <e48c4d4046de97205fd52a73f77e9b203c3b871e.1689074739.git.legion@kernel.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <e48c4d4046de97205fd52a73f77e9b203c3b871e.1689074739.git.legion@kernel.org>
Date:   Tue, 11 Jul 2023 13:31:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexey Gladkov" <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc:     "Palmer Dabbelt" <palmer@sifive.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Catalin Marinas" <catalin.marinas@arm.com>, christian@brauner.io,
        "Rich Felker" <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Deepa Dinamani" <deepa.kernel@gmail.com>,
        "Helge Deller" <deller@gmx.de>,
        "David Howells" <dhowells@redhat.com>, fenghua.yu@intel.com,
        firoz.khan@linaro.org, "Florian Weimer" <fweimer@redhat.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, heiko.carstens@de.ibm.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>, jhogan@kernel.org,
        "Kim Phillips" <kim.phillips@arm.com>, ldv@altlinux.org,
        linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
        linuxppc-dev@lists.ozlabs.org, "Andy Lutomirski" <luto@kernel.org>,
        "Matt Turner" <mattst88@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Michal Simek" <monstr@monstr.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Namhyung Kim" <namhyung@kernel.org>, paul.burton@mips.com,
        "Paul Mackerras" <paulus@samba.org>,
        "Peter Zijlstra" <peterz@infradead.org>, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, stefan@agner.ch,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tony Luck" <tony.luck@intel.com>, tycho@tycho.ws,
        "Will Deacon" <will@kernel.org>, x86@kernel.org,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v3 3/5] arch: Register fchmodat4, usually as syscall 451
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023, at 13:25, Alexey Gladkov wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
>
> This registers the new fchmodat4 syscall in most places as nuber 451,
> with alpha being the exception where it's 561.  I found all these sites
> by grepping for fspick, which I assume has found me everything.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

In linux-6.5-rc1, number 451 is used for __NR_cachestat, the
next free one at the moment is 452.

>  arch/arm/tools/syscall.tbl                  | 1 +
>  arch/arm64/include/asm/unistd32.h           | 2 ++

Unfortunately, you still also need to change __NR_compat_syscalls
in arch/arm64/include/asm/unistd.h. Aside from these two issues,
your patch is the correct way to hook up a new syscall.

   Arnd
