Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A95BB512
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 02:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIQAuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 20:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQAub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 20:50:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD44507F;
        Fri, 16 Sep 2022 17:50:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E3CB35C00F8;
        Fri, 16 Sep 2022 20:50:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 16 Sep 2022 20:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1663375826; x=
        1663462226; bh=QpwiR/HPla4yRVWmvy9AanjoLTeQN+vOn52WdshHMig=; b=P
        ixBUgCnAMwolyRVXKwBB4zbPbTrz/h3pbuZyyvhCeauiGAA66WbgQei4BM1Nr/wi
        HT5qZHY380eEsCQe77lYj7jlHXuowctnbQzw0bSGaU+uEOClLP3PnBlnhkhLTBHd
        D6UE1r5izj8MF3sPGYdeavaKhJnDxCULlDE7r29V7ysLizMj2vR+HIaDOHWupphq
        Ggsb3559y0d0193XoaAWPkvr6Is+4qiFgYfmWI0V6ZmRFwKXgzGSFPAwOPCXd5x8
        78YMGI5FxVdZ/rtUpFEWbC8GVt5bRAVFwaVYJGKX7bdwZ+e75vhMTknGBv/mVdoR
        yytWftIcGn8o7Pkbb6kdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663375826; x=1663462226; bh=QpwiR/HPla4yRVWmvy9AanjoLTeQ
        N+vOn52WdshHMig=; b=gA5jJ+nGAE/Ks3+dLiIcEQ02hCcdYjnh1E1QjLTAHsX0
        7JKR/vFf3wYcNOC8H1T2VEStMOzkxW09TFPg7tTshIdbQ9pu8V1XjiViCVUrnG5A
        bM6/Xpg3hLy2Y46iNEe1mpVNFTjmtzl6qTD7EDhnWbjxyLzCzHQeY85jRj4KzazI
        NN+urUrnA02TUTbppZducvQcLLXscs34Njpp5a0g4D6FEG0qTOw5dgv+WINNs/Px
        73mxXeY3Y6MsC5iv5/UTJEX53hlXtdQW9FjEK//MzTWaiCfeaz3mtJFqqOY/k97y
        9pHX32R/by+MbGk6UmZBhxQi+KHk2oPU0crstxDklA==
X-ME-Sender: <xms:0hklY9STY7CaR4QF6pD6U_KNkC0v3nTezyVer8BHsTzrdWMvoe7yFQ>
    <xme:0hklY2yFnPjH-FUKNC2w5wUrFz8VLJdWhufYM-dRdtzsnUh9UA6oSNsm59ZtQwlLX
    xQCxplXE6-kwxBp-r0>
X-ME-Received: <xmr:0hklYy0vdBneegCFwEspb7YUfW13-k3DqeZK-J8-XGEzaDr_Q86pefom1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvuddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduieegheeijeeuvdetudefvedtjeefgeeufefghfekgfelfeet
    teelvddtffetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:0hklY1DwOQF6W-CLXTmMozV6b8bfBow5q1leLKYDxxSjVbEQvxz2cg>
    <xmx:0hklY2j2lrnmlaSkhvw7c0PwGfn5-9Dm3-cH2Kxt6gAsO7wHkIYBDA>
    <xmx:0hklY5r2bn8idP1SjGy_0Qh1VU8zVtnv4CVEUkkwWLRZSVQ85qqOZg>
    <xmx:0hklY4Zwb1ogk9mN8kfThurHmSF4lSiy4elzfq775lDJ-7VZtfcn4w>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 20:50:25 -0400 (EDT)
Date:   Sat, 17 Sep 2022 01:50:24 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <YyUZ0NHfFF+eVe24@localhost>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202209160727.5FC78B735@keescook>
 <YyTY+OaClK+JHCOw@localhost>
 <202209161637.9EDAF6B18@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209161637.9EDAF6B18@keescook>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 05:11:18PM -0700, Kees Cook wrote:
> I don't like the idea of penalizing the _succeeding_ case, though, which
> happens if we do the path walk twice. So, I went and refactoring the setup
> order, moving the do_open_execat() up into alloc_bprm() instead of where
> it was in bprm_exec(). The result makes it so it is, as you observed,
> before the mm creation and generally expensive argument copying. The
> difference to your patch seems to only be the allocation of the file
> table entry, but avoids the double lookup, so I'm hoping the result is
> actually even faster.

Thanks for giving this a try; I'd wondered how feasible it would be to
just do one lookup.

However, on the same test system with the same test setup, with your
refactor it seems to go slower:
fork/execvpe: 38087ns
fork/execve:  33758ns

For comparison, the previous numbers (which I re-confirmed):

Without fast-path:
fork/execvpe: 49876ns
fork/execve:  32773ns

With my original separate-lookup fast-path:
fork/execvpe: 36890ns
fork/execve:  31551ns


I tried several runs of each, and I seem to get reasonably consistent
results.

My test program just creates a pipe once, then loops on
clock_gettime/fork/execvpe/read, with the spawned child process doing
clock_gettime/write/exit (in asm to minimize overhead). The test PATH is
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:. with
the test program in the current directory.

- Josh Triplett
