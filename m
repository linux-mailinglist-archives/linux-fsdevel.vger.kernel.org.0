Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD17374ECEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGKLco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 07:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKLcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:32:43 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB9012A;
        Tue, 11 Jul 2023 04:32:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A8D4E5C0117;
        Tue, 11 Jul 2023 07:32:41 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Tue, 11 Jul 2023 07:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689075161; x=1689161561; bh=3i
        BxzwnTyVw6BqHPrJ35gyKi0bdZzNDDY557YK2M5BM=; b=JRFvVCUqXTisKlcu78
        V6X1m5LSfDVcIeAFm4i9sZD+uWy9EgvZ+/ileXpa3R/i/cyyrzh9sD5o1jMT/pWb
        eErsQCfKm8c8yTwwLGg34pXoSWqC7ABI9ZHXvTxey9XGiczK6Wf7qDOrjekfkmae
        vub48BvOSfkhsJwvsGSTvvjWdyobXkLBI0s49VfzYahb4NGkrfTPsIo8HycipqB/
        wusp7BIORxxj0Gn9ikvLScqxRVAYg4+pvSdzc6II/+UNlSrBU/+YD+oNAVOm9XR2
        pF3gL50Cz2s4aGlpK9jLq5SyNVyF72ZQjs0jWJZSuFDy5mrH3IOJb0JQbUV/sWBP
        +weA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689075161; x=1689161561; bh=3iBxzwnTyVw6B
        qHPrJ35gyKi0bdZzNDDY557YK2M5BM=; b=lpNBgLU3zxYVrchcOKgdZTHoTgY5D
        N9pkRaXJrHm32Ff9ChM/9SzKx53lNbBJrWNx9gBSeUZByFxNvoC7sYgniB09Zb7U
        ePLSVdOMLT2uc/O147FVCnw9mC6nJlC/v76dAjDmYmkvEZt3ToXWQ6FZ+/gmN/Iz
        MFwpTBkN81VeBB4c0ODv2Wr1UJRHMNKAL15oq5Mwixgj97JXCIoFQiGls+r8y+jU
        RKBCPhAI3YwUEHKil1YBariTOIakoffPQUpLbZC+qBhhcCUN93KuQ3bt9H0DZtSH
        9n97nscvUrVINTVF8W14jVU5Gn1X5RLqUC+bWY2StdFEVKXSOu/RPTlVw==
X-ME-Sender: <xms:2T2tZCndHkEWrf4ichGe-up056Ed_NzOKfnyh9LJrFOPNcs2lQB8OQ>
    <xme:2T2tZJ0cmSxp3pG9OiMq-cu4Z184_05JT_4b5i7cO2GlvTalonlb79gCEMieMhVAg
    oyF8WOdQXq7bCAOxsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2T2tZAqVAgvmZTYYSmDJAMW90knofgfBV0dFXCncETmGZMl2ZOjVkQ>
    <xmx:2T2tZGndG1hacsQtBbE4JJN2Rcg3Y07NydJ93B1X9L4IEgQvZuM3NQ>
    <xmx:2T2tZA1g2fMpHp3leyu0g8m35ywIstK_v4Cgz6TKJwMR4y9OqCL6PQ>
    <xmx:2T2tZFvv-acMQvxZ87Mks25ExxRG4f0GvFZV5yfRMMv-zmcGykaT-w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7023E1700090; Tue, 11 Jul 2023 07:32:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <0c59140d-e58d-4fb6-a94c-f829bb802db3@app.fastmail.com>
In-Reply-To: <3098381cf93a5010e878319c6218d2c5851746c0.1689074739.git.legion@kernel.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <3098381cf93a5010e878319c6218d2c5851746c0.1689074739.git.legion@kernel.org>
Date:   Tue, 11 Jul 2023 13:32:20 +0200
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
Subject: Re: [PATCH v3 1/5] Non-functional cleanup of a "__user * filename"
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
> The next patch defines a very similar interface, which I copied from
> this definition.  Since I'm touching it anyway I don't see any reason
> not to just go fix this one up.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
