Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0546874ED10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGKLmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGKLml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:42:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0AD136;
        Tue, 11 Jul 2023 04:42:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AD2745C00F7;
        Tue, 11 Jul 2023 07:42:39 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Tue, 11 Jul 2023 07:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689075759; x=1689162159; bh=ky
        TmtQ94Bg/o37lAnBcJXDTnDF6sa4YBDC0JstTG714=; b=gtbNFIQOOkHrxN4hav
        3oP75lU8LQIOux8o5t1A5AOT8qTdAHI6+c7vrM3YQYWCs+3Nvg1F6BV3TJiabDbY
        /lXbBNsBsvuqNoe3LWFMQguuPW/4jLxyoK8UKxCLRCMTjb8dFVI+k/KhcgEgF3hh
        BJEbGQ0C/HfJt5EbhoLJBxYDleV5FWApLKvxP/bzBcAkhLhGeuG0+EztHuCii3u7
        9am+quXZGw0H+jB0lYD2YmevjzE1S5Z//PFOyUTNCPBE9689ZD+dLJbhhgz4ltLX
        6nFwDrZZqcFexWYmSu0PcLC1/4D094rs0bzkVrYM4Seu9WrrvgGxOVeqoI8QZjn/
        XSiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689075759; x=1689162159; bh=kyTmtQ94Bg/o3
        7lAnBcJXDTnDF6sa4YBDC0JstTG714=; b=niWM8aPrJQ5hUolpkCao6rVenQnZU
        fiqKidavvngPC7ZINAQdDWhz7uO6cKH2+hXj97e23ZSlXztW4CJ0sQELSp/H/IDW
        WFOfAuXlhVv+TeQ9w3CrU6IDnDnCe9LGpRs6OPMW1isAyJEy8CfANJZmxe7aUO7Q
        jlydbKZqDE0kuHhuSz4itPYSxqukguzNL6dmNBeuSp/IbSo2cSgrkgysoFwbZIk4
        sHSqrqGFXU7XbEyzCpPm5ExUg4RNDV+bjRq1l8+zrIvtCCpE/CQK9ZTvcdD3933K
        bF4vkMScH3PuNUqAWY8+4UJixDteqtPG+g9UoczsjcIEKlPMKOs2iwXYw==
X-ME-Sender: <xms:L0CtZE_ne_WMkwdReZ1uX6hVQXRgra0DwO81qcNdsWgl-VlL6RG_vw>
    <xme:L0CtZMuSXN5qY_cvffFveWSGpbFtBT6A8885nHXC6QAL0huplJuHHLoj3bAkBnD-p
    A8YGF0mxhW4s8ZMPgc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefffeefudevhfehgfejudffudfhjeeftdfhfedtffehieelgfekveeifedujeej
    ueenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdhmuhhslhdqlhhisggtrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:L0CtZKA60S1lK1ry3X0RUBKJmw1LUKh5HdAgQOWfNo6aPOtcCbZ4DA>
    <xmx:L0CtZEciJY2v9IPE5RUZv9dqBQUmMtLJ7-W1k9onN63j_twqjf2iNQ>
    <xmx:L0CtZJMmU91hK7ySJQdpLpwkSXsBEOk1uEzWBnYJ984RtoacQ_aXqg>
    <xmx:L0CtZOm5YB5ORfEYjlZfFUpkaGr4dE2Y2hFDo2mNqiECJPXpHejjzA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F8831700089; Tue, 11 Jul 2023 07:42:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <83363cbb-2431-4520-81a9-0d71f420cb36@app.fastmail.com>
In-Reply-To: <d11b93ad8e3b669afaff942e25c3fca65c6a983c.1689074739.git.legion@kernel.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <d11b93ad8e3b669afaff942e25c3fca65c6a983c.1689074739.git.legion@kernel.org>
Date:   Tue, 11 Jul 2023 13:42:19 +0200
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
Subject: Re: [PATCH v3 2/5] fs: Add fchmodat4()
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
> On the userspace side fchmodat(3) is implemented as a wrapper
> function which implements the POSIX-specified interface. This
> interface differs from the underlying kernel system call, which does not
> have a flags argument. Most implementations require procfs [1][2].
>
> There doesn't appear to be a good userspace workaround for this issue
> but the implementation in the kernel is pretty straight-forward.
>
> The new fchmodat4() syscall allows to pass the AT_SYMLINK_NOFOLLOW flag,
> unlike existing fchmodat.
>
> [1] 
> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/fchmodat.c;h=17eca54051ee28ba1ec3f9aed170a62630959143;hb=a492b1e5ef7ab50c6fdd4e4e9879ea5569ab0a6c#l35
> [2] 
> https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c?id=718f363bc2067b6487900eddc9180c84e7739f80#n28
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

I don't know the history of why we ended up with the different
interface, or whether this was done intentionally in the kernel
or if we want this syscall.

Assuming this is in fact needed, I double-checked that the
implementation looks correct to me and is portable to all the
architectures, without the need for a compat wrapper.

Acked-by: Arnd Bergmann <arnd@arndb.de>
