Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B0738652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjFUOJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFUOJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:09:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10271FFA;
        Wed, 21 Jun 2023 07:09:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B4C55C0215;
        Wed, 21 Jun 2023 10:09:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 21 Jun 2023 10:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687356553; x=1687442953; bh=dY
        2wjH1dPAUyXPlv+3pWnq0L8c8fn4MgP9qZzKyqERE=; b=EuqG2xunpquoWrkWcv
        EeKIsjZ2G1bP3mTutqDHkKl+TK9U9RL6lmE2Ky1sq3knzkkTp9RKgHV5XVHgj7rd
        k22pYnZgNSzTe5g4bno7u1xUniGLC9NCUgQVPmPLmnAOtnn3YLFxm11CaA1o2Aa2
        5+T4l3Jc3a1a8029+2nj+h/PCTJjHRY0IUXYY6jVd6f3ldsgbL6Jl9Fae8U1feNe
        YxZgOejfLiuBn85Fvbu8eUVzIbgf43IpEdwjlTq0Qxulr5BYcKsbVt5lBklioToa
        RsRX7YrTMxU5SroNNLZyy2uF1aKSe5WTp/V6xpvqOt5VAtsB3rs7kLOUO4MxrAlE
        o13Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687356553; x=1687442953; bh=dY2wjH1dPAUyX
        Plv+3pWnq0L8c8fn4MgP9qZzKyqERE=; b=RODJF+5zQFElZUj9yTx3I0bpynVwr
        azzDz1bCJ7O/B+nFtBpB8WTPjdP/4lxvovk4xajAm/xqBJmRBRrVbYOZisqRw2r8
        IumAalEBCOjpjDBE0id0y+V+jvIUCm0A0OitQ8OvVeu8+jHLGVu1r5PuIuYvus+y
        4R70uPNVHZ1V5yl58kMytZeHWpzlajRdRTI8CAOSBBHVPOCiPF6DkyhlckzOEZNz
        1UTu+3IaAw0ts5w7IX3ZmMBiwytG3NHlWJ+Ge7gT5teuaDQcbrxtjYj3K8cet4Zm
        7FO4qNiQ2bcXdyK6JvY9VmLvdz/O8pSnIen3taQrSymse1l5xfQv2Rylw==
X-ME-Sender: <xms:iASTZCrtnqmTkymsUhAWWEOz6bZgYRT8TzSX_R0SBHEqIPVwsuW-Kw>
    <xme:iASTZArTbFifVyUzIDbQ6_js3PM1EQoOGqdXwK3uwGH_tlfFQzCtLt1cNnbeeSUee
    aHPPcgMn1nFYMYPut8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:iASTZHMviZzP9hoCrCy3nIZEIujHdXlpIxNI2mAVMur1Ips6WidB_A>
    <xmx:iASTZB7y8aPbopri1bV1ftcVbSuMWWWPLsBTOtKPAbvUvWWhyyvYmw>
    <xmx:iASTZB7PdqGOmEk4PYfhWqb6pG7oaquSQnIxwH6_NfL-C0nII5qsuQ>
    <xmx:iQSTZATrc-jQP-PCSGGUyWqlRjo20psZPGQlbtBqtbhtUrhBGU_X4A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A1BEB60086; Wed, 21 Jun 2023 10:09:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <89dfc918-9757-4487-aa72-615f7029f6c1@app.fastmail.com>
In-Reply-To: <CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com>
References: <CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com>
Date:   Wed, 21 Jun 2023 16:08:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
        linux-block <linux-block@vger.kernel.org>,
        "LTP List" <ltp@lists.linux.it>, linux-mm <linux-mm@kvack.org>,
        "Rahul Rameshbabu" <rrameshbabu@nvidia.com>,
        "Richard Cochran" <richardcochran@gmail.com>
Cc:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Maciek Machnikowski" <maciek@machnikowski.net>,
        "Richard Cochran" <richardcochran@gmail.com>,
        "Shuah Khan" <shuah@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>
Subject: Re: next: ltp: fs: read_all: block sda: the capability attribute has been
 deprecated. - supervisor instruction fetch in kernel mode
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023, at 16:01, Naresh Kamboju wrote:
> While running LTP fs testing on x86_64 device the following kernel BUG:
> notice with Linux next-20230621.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Steps to reproduce:
>
> # cd /opt/ltp
> # ./runltp -f fs
>
> Test log:
> ======
> read_all.c:687: TPASS: Finished reading files
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
> tst_test.c:1558: TINFO: Timeout per run is 0h 06m 40s
> read_all.c:568: TINFO: Worker timeout set to 10% of max_runtime: 1000ms
> [ 1344.664349] block sda: the capability attribute has been deprecated.

I think the oops is unrelated to the line above

> [ 1344.679885] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 1344.686839] #PF: supervisor instruction fetch in kernel mode
> [ 1344.692490] #PF: error_code(0x0010) - not-present page
> [ 1344.697620] PGD 8000000105569067 P4D 8000000105569067 PUD 1056ed067 PMD 0
> [ 1344.704494] Oops: 0010 [#1] PREEMPT SMP PTI
> [ 1344.708680] CPU: 0 PID: 5649 Comm: read_all Not tainted
> 6.4.0-rc7-next-20230621 #1
> [ 1344.716245] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [ 1344.723629] RIP: 0010:0x0
> [ 1344.726257] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [ 1344.732780] RSP: 0018:ffff98d38123bd38 EFLAGS: 00010286
> [ 1344.737998] RAX: 0000000000000000 RBX: ffffffffbea38720 RCX: 0000000000000000
> [ 1344.745123] RDX: ffff979e42e31000 RSI: ffffffffbea38720 RDI: ffff979e40371900
> [ 1344.752246] RBP: ffff98d38123bd48 R08: ffff979e4080a0f0 R09: 0000000000000001
> [ 1344.759371] R10: ffff979e42e31000 R11: 0000000000000000 R12: ffff979e42e31000
> [ 1344.766495] R13: 0000000000000001 R14: ffff979e432dd2f8 R15: ffff979e432dd2d0
> [ 1344.773621] FS:  00007ff745d4b740(0000) GS:ffff97a1a7a00000(0000)
> knlGS:0000000000000000
> [ 1344.781704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1344.787442] CR2: ffffffffffffffd6 CR3: 000000010563c004 CR4: 00000000003706f0
> [ 1344.794587] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1344.801733] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1344.808857] Call Trace:
> [ 1344.811301]  <TASK>
> [ 1344.813399]  ? show_regs+0x6e/0x80
> [ 1344.816804]  ? __die+0x29/0x70
> [ 1344.819857]  ? page_fault_oops+0x154/0x470
> [ 1344.823957]  ? do_user_addr_fault+0x355/0x6c0
> [ 1344.828314]  ? exc_page_fault+0x6e/0x170
> [ 1344.832239]  ? asm_exc_page_fault+0x2b/0x30
> [ 1344.836420]  max_phase_adjustment_show+0x23/0x50

The function is newly added by commit c3b60ab7a4dff ("ptp: Add 
getmaxphase callback to ptp_clock_info"), adding everyone from
that patch to Cc.

     Arnd
