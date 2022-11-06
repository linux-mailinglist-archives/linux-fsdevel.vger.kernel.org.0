Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF861E25E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 14:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiKFNeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 08:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKFNeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:34:03 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D29DFFF;
        Sun,  6 Nov 2022 05:34:02 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 6DE8A2B06280;
        Sun,  6 Nov 2022 08:33:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 06 Nov 2022 08:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667741636; x=1667748836; bh=qW
        0kL8NboCk/b+RHJv96xFs8vnUwrO9Z41lcOwMOB8E=; b=ZAaJqrKdI5LhW2lFri
        kvU1FsfUECIQD9N8sO7JXPk8AqgarmIjBf+YEbsbOBO8ubzBbwNrBPkd5jYkzzJY
        ScC2Em7YUEr+g6D9JnWHxanDgRisCrQoUvP9pdIfmkY+N21MIxJZOsLa0BME7eZB
        j09FtiK+ieMxgJOBIWdL+qMtTzGGivauJ0ZrqIsDrAGok6TOFnlYQvQj5GGIQ3kA
        wsOeSnWjNdGs/h0GmFbJC9BV8Zp4K/DLenbli05o3q/zHrVAHuCMipaqioURUMJ2
        ktmLmrFICYnTCcGTZYZ4Ime9E3Q4xCp/6vdwevnOkPb4nZAGtEmr1Q5ptRxcqELk
        UQFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667741636; x=1667748836; bh=qW0kL8NboCk/b+RHJv96xFs8vnUw
        rO9Z41lcOwMOB8E=; b=TgL/lROlUJEFEFXtcXVtI1Y26EuNQSY3CAROZ9yWyNYn
        V7zu+k7LtQDQYTYWU3XvCzOo66JkWwLPBcImgww1xw8fL7zW3srwY2b8A7hoMR9V
        hAhSbL/S7Fr8DptVpO3zfcjn+4uCVGZm+e6/og0B0oYjdKBCWKXpzCzskNz9JIJ/
        y41qabStDHrCW3yW/fF1gCM6yGRcC73hJrIlEiRKZQsJCn5hCdj3FGwBpWXmm9M7
        zsQRihm/mZc5K/vWAFhGbBWFp7M1w+VEY5aHQPysbBN9gSm/UAAKHUW/1US5TdpC
        tN3YKlfyGVlJ6kTlUfijHrOeg3DdqPUjFzu7nUR1vw==
X-ME-Sender: <xms:w7dnYwZbT57sBQC872l8BjpzGaPfV8dVLnO1XByQCSs5APaV4xlq9Q>
    <xme:w7dnY7ZBDxmTYZ43UWprMS1aLjT-NaGQf9BKYbV8hsANc0ch5KjDMYSSBmms91Teu
    NY--p1tvLlxd4KnR8M>
X-ME-Received: <xmr:w7dnY6_WsL9IiN274wPkJTZNtrdXKmSKMXNJgOn1P1KurPTm215tWJCEj8zXS9F3spEO1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeigdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:w7dnY6oOZG9W9pqXoZMr-Ff_7yz_takt9x2wrVt_VedyFWfLrriyRg>
    <xmx:w7dnY7q-wn-_ci1Wao2rR-uiYdAWw9Ij-xaB3N_WRsXv6N0sdQ6A_Q>
    <xmx:w7dnY4TtpP3ophLuoBVpRi2mc5-7VBVZJuWAr1NX_T-xB_SaGFaCHg>
    <xmx:xLdnY3BiyQNYUYPNSeq_8_DlQWviDkIBdIO9OnYhbIpVzHY77O89ReWaIYE>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Nov 2022 08:33:55 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5A2BB104149; Sun,  6 Nov 2022 16:33:51 +0300 (+03)
Date:   Sun, 6 Nov 2022 16:33:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, hughd@google.com,
        hannes@cmpxchg.org, david@redhat.com, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@Oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: anonymous shared memory naming
Message-ID: <20221106133351.ukb5quoizkkzyrge@box.shutemov.name>
References: <20221105025342.3130038-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105025342.3130038-1-pasha.tatashin@soleen.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 05, 2022 at 02:53:42AM +0000, Pasha Tatashin wrote:
> Since:
> commit 9a10064f5625 ("mm: add a field to store names for private anonymous
> memory")
> 
> We can set names for private anonymous memory but not for shared
> anonymous memory. However, naming shared anonymous memory just as
> useful for tracking purposes.
> 
> Extend the functionality to be able to set names for shared anon.
> 
> / [anon_shmem:<name>]      an anonymous shared memory mapping that has
>                            been named by userspace
> 
> Sample output:
>         share = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>         rv = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME,
>                    share, SIZE, "shared anon");
> 
> /proc/<pid>/maps (and smaps):
> 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024
> /dev/zero (deleted) [anon_shmem:shared anon]
> 
> pmap $(pgrep a.out)
> 254:   pub/a.out
> 000056093fab2000      4K r---- a.out
> 000056093fab3000      4K r-x-- a.out
> 000056093fab4000      4K r---- a.out
> 000056093fab5000      4K r---- a.out
> 000056093fab6000      4K rw--- a.out
> 000056093fdeb000    132K rw---   [ anon ]
> 00007fc8e2b4c000 262144K rw-s- zero (deleted) [anon_shmem:shared anon]
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/filesystems/proc.rst |  4 +++-
>  fs/proc/task_mmu.c                 |  7 ++++---
>  include/linux/mm.h                 |  2 ++
>  include/linux/mm_types.h           | 27 +++++++++++++--------------
>  mm/madvise.c                       |  7 ++-----
>  mm/shmem.c                         | 13 +++++++++++--
>  6 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 898c99eae8e4..8f1e68460da5 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -431,8 +431,10 @@ is not associated with a file:
>   [stack]                    the stack of the main process
>   [vdso]                     the "virtual dynamic shared object",
>                              the kernel system call handler
> - [anon:<name>]              an anonymous mapping that has been
> + [anon:<name>]              a private anonymous mapping that has been
>                              named by userspace
> + path [anon_shmem:<name>]   an anonymous shared memory mapping that has
> +                            been named by userspace

I expect it to break existing parsers. If the field starts with '/' it is
reasonable to assume the rest of the string to be a path, but it is not
the case now.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
