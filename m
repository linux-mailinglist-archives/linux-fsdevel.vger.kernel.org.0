Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEEC5F48A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 19:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJDRi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJDRiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4DB24964;
        Tue,  4 Oct 2022 10:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF9660EC7;
        Tue,  4 Oct 2022 17:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB7CC433C1;
        Tue,  4 Oct 2022 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664905022;
        bh=rtWTTcYorADYGq6pdo3E4C1gL/XjJH4Ahw8UABoFkfI=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=q/fB4trp7ZFaQqGDvhwNiLs10i9rgMUsg2QfJx0IC3phF7cBEBrAXHwN+WwWbzUp1
         RzdYGahFQPJxNoC2y4YFHeZPPOWV1eDkTEXc91zewcA3ElzzHXvVUp4voK+SHKmuIg
         hUq7qR4cBJrCAwZyAaLKAuynY9Vzw1Xkl5ATop5TcdTimzbUbgLTWrjrxTG/hgIY3Z
         2wAApQGGjyC/uRr9tJ95x1Pk87mglecvzYF6r8OQu5fmfwbNzgSn0/tLIiPfoLtvZF
         euWd7QHEMUE2FWyE7I6bh0MZmdGxfLKd9PD/pHFancFU9k0WtyCdbr1A0znUfQ4GT4
         7gNYsvcPqU6Vg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8272F27C0054;
        Tue,  4 Oct 2022 13:37:00 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 13:37:00 -0400
X-ME-Sender: <xms:O288YyYUQNjQFJm4G68BLVVEnopOAc4OUFAlRNnLI7Tj-1GSVP_D-Q>
    <xme:O288Y1bUYHQ2kpyUZ40GEIKNO1wixpLyI_dPLz1nHGdUZkIpUXalaYVQ9czRT1PDd
    ME9vXiMciIw5Nu7AAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:O288Y88EqNY4p2mOLh0mn-lw62fHjHVk7aNQc0YGPYy7-TTIu03sGg>
    <xmx:O288Y0pyk48y3OkJGFQiuOkFw6TPxP7h3HCOSachutJkSgNZCXEIWg>
    <xmx:O288Y9rp8V6hViIgwFT1GgtSNQI7PZoP23J-iynxbFBxtdRtO8fWOg>
    <xmx:PG88Yw8L-Bpi2JLbd259r7sD-IY2W3PR2p8Q3u8uaeu7P3AzsG7ULA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DECA631A0062; Tue,  4 Oct 2022 13:36:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <d32399c1-88ae-4b7d-925e-b82b2a983e30@app.fastmail.com>
In-Reply-To: <20221003222133.20948-6-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-6-aliraza@bu.edu>
Date:   Tue, 04 Oct 2022 10:36:38 -0700
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
Subject: Re: [RFC UKL 05/10] x86/uaccess: Make access_ok UKL aware
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
> When configured for UKL, access_ok needs to account for the unified address
> space that is used by the kernel and the process being run. To do this,
> they need to check the task struct field added earlier to determine where
> the execution that is making the check is running. For a zero value, the
> normal boundary definitions apply, but non-zero value indicates a UKL
> thread and a shared address space should be assumed.

I think this is just wrong.  Why should a UKL process be able to read() to kernel (high-half) memory?

set_fs() is gone.  Please keep it gone.

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
>  arch/x86/include/asm/uaccess.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 913e593a3b45..adef521b2e59 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -37,11 +37,19 @@ static inline bool pagefault_disabled(void);
>   * Return: true (nonzero) if the memory block may be valid, false (zero)
>   * if it is definitely invalid.
>   */
> +#ifdef CONFIG_UNIKERNEL_LINUX
> +#define access_ok(addr, size)					\
> +({									\
> +	WARN_ON_IN_IRQ();						\
> +	(is_ukl_thread() ? 1 : likely(__access_ok(addr, size)));	\
> +})
> +#else
>  #define access_ok(addr, size)					\
>  ({									\
>  	WARN_ON_IN_IRQ();						\
>  	likely(__access_ok(addr, size));				\
>  })
> +#endif
> 
>  #include <asm-generic/access_ok.h>
> 
> -- 
> 2.21.3
