Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB72807D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgJATfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 15:35:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52127 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729990AbgJATdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:33:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1118D5801AD;
        Thu,  1 Oct 2020 15:33:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 01 Oct 2020 15:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=T
        avF71lBlL6nBdjv5tFqv1tjUk2DGNXMCqE9op0VZ2Q=; b=H7sl1jHjD7RJU5Xfy
        R7+BWtx6TORRox+x/EBMJICRYKvR6xgTrQ+djSOjK1xEUENmSxmfDaReKKu1sVSX
        oVoZ0W/NrADNHFEg7vOIurQmHwFwU2RQXEUcIZuzNLyH6/a3h67/QgAu2Otkpt4J
        ZVGx4VlJz4B/HG2XT+irPPs5LkC/d52PPyv5mi816tRUzPK72rAlsTRRVelu4yTu
        FmpBXbepqilYZY+Z1bSxXXETyMEeJ8Rq+Tm2GVFoRJ57PiTuyXiFTKMK2vNltzNO
        tSh43UpIhFUvYWTNrZK0hS9nILr26nXi9Z2cQzBl3jWBRe5RN9CBFTz8AdZN7PDt
        GNyqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=TavF71lBlL6nBdjv5tFqv1tjUk2DGNXMCqE9op0VZ
        2Q=; b=hAH2AVTa9yCO7FGUQGrojKp/3r6j0dYp8ieilCpUAuZP7vcDYF9spGl7/
        ZCF0cwDyATtI9QvAm2bXy8iC5s2FQx/kusgT89ax1PTgED1hwFS2XuB+qcWcJ5do
        DIYigOh6swsrd6ekJBSMf0v8ZvfvTnALIWSsD9zL+ddF90LcSAK86olirh7ULGXI
        P9I6h++5tyIlIvI1R40pI4BO/Ac0TG7Z2b9nSOFH5ANXktE6bz/YSd9XUMXRC2PG
        Ml4nHJU1W1aKT+C/4BS1ZfisY3A2uaOcef6bvY+DFgjDLdmyGliiEB98Zsvqoesz
        +FXH6Y5wyIrugIY1sITtfUZ5gBhIA==
X-ME-Sender: <xms:_S52X187-qJxUt7IQ-jYKh0FfXBFw3u32M0ThHucgNiJhDkiItUJyQ>
    <xme:_S52X5u9bJvf-deIsQ_khz8fGcdpuZy-bgparwGQyQ9obhtV_UWfcFs0pksZ4Ll9K
    -E-X31M1Bhj5ReYDSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnheplefgudefleejhefhvedufeegudffgfelgeevgfejfeffieeufefgffet
    udeljeefnecukfhppeduvdekrddutdejrddvgedurddujeeinecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhi
    iiiirg
X-ME-Proxy: <xmx:_S52XzBV6gtZHK1akrygkJU1hQhCNNEC-GqUotHiOC8Qt9ROd43xcw>
    <xmx:_S52X5fRcgiySVAueUx9Dzr_6NNywkMDxpsPseB0L0XPQaHnvjiwGg>
    <xmx:_S52X6OrqCaEHBqw9O47JJfc5eBWrFPnYdlxjp5XgJquckmunk4uEw>
    <xmx:Ay92XzMHukmtAlVW3f0yw7L0osJxhu2Evb0JtOoYWHOQTQ8AXQ5EGyGGevY>
Received: from cisco (unknown [128.107.241.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50394306467E;
        Thu,  1 Oct 2020 15:33:08 -0400 (EDT)
Date:   Thu, 1 Oct 2020 13:33:06 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: Re: [PATCH v11 2/3] arch: Wire up trusted_for(2)
Message-ID: <20201001193306.GE1260245@cisco>
References: <20201001170232.522331-1-mic@digikod.net>
 <20201001170232.522331-3-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001170232.522331-3-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 01, 2020 at 07:02:31PM +0200, Mickaël Salaün wrote:
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -859,9 +859,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
>  __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
>  #define __NR_faccessat2 439
>  __SYSCALL(__NR_faccessat2, sys_faccessat2)
> +#define __NR_trusted_for 443
> +__SYSCALL(__NR_trusted_for, sys_trusted_for)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 440
> +#define __NR_syscalls 444

Looks like a rebase problem here?

Tycho
