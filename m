Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B7E5BB351
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIPUN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIPUNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:13:50 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED3AADCE2;
        Fri, 16 Sep 2022 13:13:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A135B5C01B5;
        Fri, 16 Sep 2022 16:13:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 16 Sep 2022 16:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1663359227; x=
        1663445627; bh=r+kD9N586GmRcVTBI3Qz83v5UZ83CiKVka4YsRwf+Pc=; b=C
        3C34kyluypUBPPHY40ETkTOv49+P5NaG4TsQU5eTCq6n3uTHbdfYFCdyZIkiGnev
        ehwfDpZWAHCZASU/2Zl60c2sleMyeRcEN1sFEWQJ5xUzRb2qwXqyu/cqm8zbDYUU
        LoQosoHtJD5HbRHX010t3R2woGV9dBRMh/Q/tQ6Rk41CsOxSWK5UWM5jlmXhcna7
        KMoJgwuYuTSKaDlKxJgQLBNSFeg2ezP2zHlor9tHqOf5qSN6xxrnV3Vi9hI64eWg
        /jFKzvWBOFLrpyb3bRbcR49pfI54nc4ESQX9jLHo/D5GWLNJZsESgFIcsbJUBzFN
        lHY7IwCFTRPtzaidicZvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663359227; x=1663445627; bh=r+kD9N586GmRcVTBI3Qz83v5UZ83
        CiKVka4YsRwf+Pc=; b=GRLhN7RjfqEPyUibtCXy5bjRhgGF7/KGr2tB4vbIJu6l
        0Q78akX+qq9ecbhnDwr8f0+gjQjuas9+JJK3whbCHpNpTDMXxIve9Fuk2frDZAbv
        Y1KmDSEqE9N7V2xYD3CyavT7udaUQgEavJ8BUpi9Annh73bg+GIzHEH/LnQs8IzX
        z2VpKBtFnjaE/WWxQWmWM1slQayH9tdy/fDM4xfc6pIpa6lItmqeX8zQ1dAk/7/O
        HtfRhvrZlvFGjzhDEV4cw/SD11ntkekq4XUaIPYIhlBDNbn8/tKHobHLGfK35qoj
        OGmkxUP4vqQbBeq9HLnpqRQ2ZKUrCRuiYjMuruOfpA==
X-ME-Sender: <xms:-9gkY_rquxM-aletTujXZUBHbMj428CxwPzUNAwxHGQYuWcuz_4b_A>
    <xme:-9gkY5rEje5DsFI04LLqB0xK1T-RmtrgErdxTPrmIvmGu5tbsSeEZIzQooh6e7L2I
    lzP3NTx41ts0EuVZUk>
X-ME-Received: <xmr:-9gkY8NpV7KQukG2z1B-UcKrXdnaZ-Dsd65zOKbtok0lCu5RumDO0mYU8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvtddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleef
    teetledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:-9gkYy6m5Fbywx5Oae5nIUYV_2kUrYzbJk35XznsIXkiw6390WMM3w>
    <xmx:-9gkY-7ZU78k_b31q3vlL2H42DVHcEMrn-_QbEesDah79hYN1fTN3g>
    <xmx:-9gkY6g6zphFiDn-6aKcu8WAHg5j_3blx2KylgJqUGjFf7j_D5MBxA>
    <xmx:-9gkY50dVMvlpppradK0zparBJqvkTxPgwX1z3l5_isJ6FmLaSjGjA>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 16:13:46 -0400 (EDT)
Date:   Fri, 16 Sep 2022 21:13:44 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <YyTY+OaClK+JHCOw@localhost>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202209160727.5FC78B735@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209160727.5FC78B735@keescook>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 07:38:37AM -0700, Kees Cook wrote:
> On Fri, Sep 16, 2022 at 02:41:30PM +0100, Josh Triplett wrote:
> > Currently, execve allocates an mm and parses argv and envp before
> > checking if the path exists. However, the common case of a $PATH search
> > may have several failed calls to exec before a single success. Do a
> > filename lookup for the purposes of returning ENOENT before doing more
> > expensive operations.
> 
> At first I didn't understand how you were seeing this, since I'm so used
> to watching shell scripts under tracing, which correctly use stat():
> 
> $ strace bash -c foo
> stat("/home/keescook/bin/foo", 0x7ffe1f9ddea0) = -1 ENOENT (No such file or directory)
> stat("/usr/local/sbin/foo", 0x7ffe1f9ddea0) = -1 ENOENT (No such file or directory)
> stat("/usr/local/bin/foo", 0x7ffe1f9ddea0) = -1 ENOENT (No such file or directory)
> stat("/usr/sbin/foo", 0x7ffe1f9ddea0)   = -1 ENOENT (No such file or directory)
> stat("/usr/bin/foo", 0x7ffe1f9ddea0)    = -1 ENOENT (No such file or directory)
> stat("/sbin/foo", 0x7ffe1f9ddea0)       = -1 ENOENT (No such file or directory)
> stat("/bin/foo", 0x7ffe1f9ddea0)        = -1 ENOENT (No such file or directory)
> 
> But I see, yes, glibc tries to actually call execve(), which, as you
> say, is extremely heavy:
> 
> $ strace ./execvpe
> ...
> execve("/home/kees/bin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
> execve("/usr/local/sbin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
> execve("/usr/local/bin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
> execve("/usr/sbin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
> execve("/usr/bin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
> execve("/sbin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
> execve("/bin/foo", ["./execvpe"], 0x7ffc542bff38 /* 33 vars */) = -1 ENOENT (No such file or directory)
> 
> This really seems much more like a glibc bug. The shell does it correctly...

musl does the same thing, as do python and perl (likely via execvp or
posix_spawnp). As does gcc when it executes `as`. And I've seen more
than a few programs hand-implement a PATH search the same way. Seems
worth optimizing for.

And with io_uring_spawn, it'll be the substantially easier approach,
since it'll just require one pass (series of execs) rather than two
(stats then exec).

- Josh Triplett
