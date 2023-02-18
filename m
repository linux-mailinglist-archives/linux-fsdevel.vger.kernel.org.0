Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF869B8CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 09:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBRIrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 03:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBRIrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:47:18 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B24988D;
        Sat, 18 Feb 2023 00:47:17 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 425D6C01C; Sat, 18 Feb 2023 09:47:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676710060; bh=zfYHy+wWsBlnsKVuoRnVIPGybUVspolwP7KgZ3LmG+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7yvy2xm4r6SpRSR5HAPB9rS3RX5Vw+zfYarqN8k1rcWfXF0TNqY3rA6Skl0T501k
         GMJYP9FRZn8E+rfLZ5jn+RYyi6vAJpZFOoYGbZeVySnUSMpPq55pKxXyrs2k8KjGAm
         fzpSjvsS25N835AWoLMqWXC3blVPoPg9ckVia2cmMOQutMPD6Zqz8/f5MeWxcVYc/l
         mb78RcpJI+ICML6CopdoCiJov8mglVTfsb8XREhsNHGSNznvuEMHOWbEYBEdXc/JWr
         Ekz4PVkGEg7zhnWmshjoeSUlQzEroIzaglfXBcfmCt/QI/geItve1L/DL2Q9QZdU4v
         m0BDZ0RzDSWnA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A2DE0C009;
        Sat, 18 Feb 2023 09:47:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676710059; bh=zfYHy+wWsBlnsKVuoRnVIPGybUVspolwP7KgZ3LmG+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlQjgfGhvZFfYCtotPkc/EeA+rCka4LdbzDMcSM9SgMsW6pLMhYjuvJ+dit84Pmm3
         Wo1CKyPEGcLABXPuMbhD7xckFkfJ95Q+8tQINB249VIMVwfubo91nTfp2M5tQhKUv3
         4KL3HBOXEne00wQwWfnr1t4r9Y6/vAbGrGkO4DehTP6/E6BQsgaBiKxNVW29SkUISr
         DUD72qsw59ZWrZtAwHg0QLm04c3rVRXVT16452qd1Cj5avRJHJcmFsSemBFEsh/5IA
         oMcZsNgP0qbdGOyCNnTo1tI0PzzfcNO4Wj3dTXoLdPgdY1JfzUxjszNMgjRgfXxVrt
         fXqHm7HwMHy3A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id dd33823b;
        Sat, 18 Feb 2023 08:47:11 +0000 (UTC)
Date:   Sat, 18 Feb 2023 17:46:56 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 08/11] fs/9p: Add new mount modes
Message-ID: <Y/CQgOHjg0kmA1Vg@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-9-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-9-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:20AM +0000:
> Add some additional mount modes for cache management including
> specifying directio as a mount option and an option for ignore
> qid.version for determining whether or not a file is cacheable.

direct io is standard enough but ignore QV probably warrants a comment
in the code and not just a word in the commit message.

I see you've added these in Documentation/filesystems/9p.rst in
the "writeback mode fixes" -- I guess we can live with commits
introducing options not being 100% coherent within the series (the
implementation also comes in that fixes commit), but perhaps a '/*
ignore qid.version */' comment in the enum?

> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> index d90141d25d0d..48c7614c9333 100644
> --- a/fs/9p/v9fs.h
> +++ b/fs/9p/v9fs.h
> @@ -37,7 +37,10 @@ enum p9_session_flags {
>  	V9FS_ACCESS_USER	= 0x08,
>  	V9FS_ACCESS_CLIENT	= 0x10,
>  	V9FS_POSIX_ACL		= 0x20,
> -	V9FS_NO_XATTR		= 0x40
> +	V9FS_NO_XATTR		= 0x40,
> +	V9FS_IGNORE_QV		= 0x80,
> +	V9FS_DIRECT_IO		= 0x100,
> +	V9FS_SYNC			= 0x200

... And while we're here, indentation seems off on sync

-- 
Dominique
