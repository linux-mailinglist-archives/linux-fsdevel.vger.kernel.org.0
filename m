Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF305F4882
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJDRbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 13:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJDRas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:30:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438F65551;
        Tue,  4 Oct 2022 10:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B508BB81B54;
        Tue,  4 Oct 2022 17:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5818C433C1;
        Tue,  4 Oct 2022 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904644;
        bh=a1iNRf+UMxlHWdHG1vJfQgc5A3fOfcVJMeUSiTuInao=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=i1UrysBgTNEurj+pJZFNIgA0T6322DnBpKcEzJWsznmn/b7iisMWwyUrtXutKOyxS
         ZNepKS4mkfwo8qZNwIth91rp3WOxfmW6Y8ZcqnB9TeVDkHccLEz1/2KcuHdI/RBexy
         novzrVc5a1J3wboTgHKpfFbdNaWGj6gVib6vo6yXzKroEnAULgwDffddHT3+S7NV9t
         gQA3fURP4HjiFESNkGIW7BLQpMkv9BNl0oOCnJJ4EVoDzZsqtu/rKFGVKc/J5WL1x2
         1Ja5ZiwqClfeWT5ZoF6omEny9HJR7tIfTWtNS58Qsf+lGS7QCl0JWwlsxTtxVWmhPm
         zo/qiHC6em/AQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A383127C005A;
        Tue,  4 Oct 2022 13:30:41 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 13:30:41 -0400
X-ME-Sender: <xms:vm08YxN6-b71-FRbR6Zh9PxJaYD-LBmS35IXWvUC6dXz3UXhYVYpkw>
    <xme:vm08Yz8oYL8W0xOSKSosZAiYnTjo7w9gFpUFmG0OU8Mwp-C5odk5vPk_f-RAYuwBO
    msT9FUcGgIoboANwXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:v208YwQVjpMC0U8DHLhay1DEyKluYPUMClk8LO-Y7pXrqmbECyKpMw>
    <xmx:v208Y9v285aZm7jraIHpmPJ2-IzpmnspUWBjl0L61mxyOdKGze1hBw>
    <xmx:v208Y5eh0C1uhaXbc6a0InoK8bBGzCsA-FrhC-G4tmjYyr8x4VWl_A>
    <xmx:wW08Y1Av36r8wkFLsNw4ipX3VshL1iDaZhjNDQAQkiUCgrDkkAZn1A>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E2FCB31A0062; Tue,  4 Oct 2022 13:30:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <cecf0a31-8473-47bc-9af6-8a809267c9e6@app.fastmail.com>
In-Reply-To: <20221003222133.20948-3-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-3-aliraza@bu.edu>
Date:   Tue, 04 Oct 2022 10:30:18 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Ali Raza" <aliraza@bu.edu>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     "Jonathan Corbet" <corbet@lwn.net>, masahiroy@kernel.org,
        michal.lkml@markovi.net,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        "Paolo Bonzini" <pbonzini@redhat.com>, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu
Subject: Re: [RFC UKL 02/10] x86/boot: Load the PT_TLS segment for Unikernel configs
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
> The kernel normally skips loading this segment as it is not inlcuded in
> standard builds. However, when linked with an application in the Unikernel
> configuration the segment will be present. Load PT_TLS when configured as a
> unikernel.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>
> Signed-off-by: Ali Raza <aliraza@bu.edu>
> ---
>  arch/x86/boot/compressed/misc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index cf690d8712f4..0d07b5661c9c 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -310,6 +310,9 @@ static void parse_elf(void *output)
>  		phdr = &phdrs[i];
> 
>  		switch (phdr->p_type) {
> +#ifdef CONFIG_UNIKERNEL_LINUX
> +		case PT_TLS:
> +#endif

Can you explain why exactly a Linux boot image would have a TLS segment?  What does it do?

>  		case PT_LOAD:
>  #ifdef CONFIG_X86_64
>  			if ((phdr->p_align % 0x200000) != 0)
> -- 
> 2.21.3
