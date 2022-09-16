Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069F45BAE64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 15:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIPNli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 09:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPNlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:41:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D925FF56;
        Fri, 16 Sep 2022 06:41:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B37B85C01E7;
        Fri, 16 Sep 2022 09:41:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 16 Sep 2022 09:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663335692; x=1663422092; bh=yKfhkt+nNY
        e7MJg9PTxKXWyH3AaqpGz2T9Q7AFW5CyE=; b=H9bEUU0sl289Dfe6Z3OILZXJy0
        pbNxJPMD7xpYYQ8oX7c7+4rZJXMq8ewyhkCS30NarFu6G8nT1bNiyKr94G/hzPW9
        yvpcLdbxROmISaC3gEj7LOV2M7fcNvi7O37tqrLn586hwR1mWsUhOFh4L653ZTUa
        iJmWXMWvIPnrZOCWn8C7aaJRGbP8ovJea+hJU92A0WwN+j0JB4rHmXmgd4goHrMi
        TgmQQ3tfsXp9n6012Rr3PJrmtb68M/qGoKRwk0gDjSQ1TpPYj+0Ve8IGT/Klls8m
        EgbWgAlV1YEC02JG0cIxwSSZ3Tc+jB0mVHNNDOz8l01sCOWPaW3XeBmZQFlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663335692; x=
        1663422092; bh=yKfhkt+nNYe7MJg9PTxKXWyH3AaqpGz2T9Q7AFW5CyE=; b=Z
        7kTJ1kOl9TZDg/jeNqY0Rv1GqINBx845N+Ar9670OK/2mlJFHjkLbq6ARcI/U5Mb
        lo+6Yo4Gg5GABL+3JEKMMd5bq5YjQVtdjid6QQh124eSNt9PAWogOyamVsP2Mqix
        x239FQIoHNulFN0OQOWU7113qHNzxFpeSx3+m/e9uCD9sgMhw26SkwTD5TJ7z3zs
        QANvn/VZknO6DjCbqB7+Hy24HEWwXYZudOz+JjqirqrlRESfEWOeWvVlj9OMhKUy
        D0nau9T/rorYSgf2cdlN6Y4dCm6o8CbnImfcf3AkpumGs/CctDQ0ycfdqNhUN5KQ
        2qZUXCmBzBttgsJexkCgw==
X-ME-Sender: <xms:DH0kYzyVziDUak7yh6LDOHZJoyIM_UCp4OR4G_FOLyXUu6LndjbD9g>
    <xme:DH0kY7SOT3XCDWnUUuXWeJwn8JW-GR3XduoLbqnbl4CDCTnzZpZqvpf5ifq6zo9kE
    qYPaxScPjRM22wdBYg>
X-ME-Received: <xmr:DH0kY9XSZQr158XVoiighu-1aS4dhwfNabuqZPqF_NeQYVF28e80DObYPN6e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvtddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomheplfhoshhhucfv
    rhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenucggtf
    frrghtthgvrhhnpeduvdelheettdfgvddvleegueefudegudevffekjeegffefvdeikeeh
    vdehleekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:DH0kY9iOBUDnWM0fNV6Q1Rc6MLyuarRXI4pd7qWJkkq_AGYTA_E95g>
    <xmx:DH0kY1CmF3xy7GPZjWonL7U3fXtEcIc-ff1eZeBe3ntOFLXbNfadQQ>
    <xmx:DH0kY2JMJEiy-P1Hn2Lj_BX_VNIWtzwJFxBphcSrrvVuvxNvOEDmMA>
    <xmx:DH0kYw_aZEcZfuc7KwE8W9h0L4BaMNUHR-PB9OP4vAH_j8z-ECHDxw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 09:41:31 -0400 (EDT)
Date:   Fri, 16 Sep 2022 14:41:30 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search before
 allocating mm
Message-ID: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, execve allocates an mm and parses argv and envp before
checking if the path exists. However, the common case of a $PATH search
may have several failed calls to exec before a single success. Do a
filename lookup for the purposes of returning ENOENT before doing more
expensive operations.

This does not create a TOCTTOU race, because this can only happen if the
file didn't exist at some point during the exec call, and that point is
permitted to be when we did our lookup.

To measure performance, I ran 2000 fork and execvpe calls with a
seven-element PATH in which the file was found in the seventh directory
(representative of the common case as /usr/bin is the seventh directory
on my $PATH), as well as 2000 fork and execve calls with an absolute
path to an existing binary. I recorded the minimum time for each, to
eliminate noise from context switches and similar.

Without fast-path:
fork/execvpe: 49876ns
fork/execve:  32773ns

With fast-path:
fork/execvpe: 36890ns
fork/execve:  32069ns

The cost of the additional lookup seems to be in the noise for a
successful exec, but it provides a 26% improvement for the path search
case by speeding up the six failed execs.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

Discussed this at Plumbers with Kees Cook; turned out to be even more of
a win than anticipated.

 fs/exec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 9a5ca7b82bfc..fe786aeb2f1b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1881,6 +1881,16 @@ static int do_execveat_common(int fd, struct filename *filename,
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
+	/* Fast-path ENOENT for $PATH search failures, before we alloc an mm or
+	 * parse arguments. */
+	if (fd == AT_FDCWD && flags == 0 && filename->name[0] == '/') {
+		struct path path;
+		retval = filename_lookup(AT_FDCWD, filename, 0, &path, NULL);
+		if (retval == -ENOENT)
+			goto out_ret;
+		path_put(&path);
+	}
+
 	/*
 	 * We move the actual failure in case of RLIMIT_NPROC excess from
 	 * set*uid() to execve() because too many poorly written programs
-- 
2.37.2

