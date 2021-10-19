Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BE54333F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhJSKwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 06:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhJSKwg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:52:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF4BC61154;
        Tue, 19 Oct 2021 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634640623;
        bh=L0poGPzGEIYL2TPnM3Vav05iGMWfIk7Klty6aCujrWU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hhpwCv4+TSuvJTXfVfwSPpVU9VUjtDc1xOV9b/Oo0h/ZW0bpj6fGmjUi8fQy1xJmh
         MDXRtn29lhl+vax+BYu9n0oTTQhjDoSsW0ULRWC+FD68jj4GTbMB3nKqwxCATulhfx
         BpDT3UROXvgjbOaAtHRiTWXPvYIa8rowtLz9xHP/bfpn17GKFEbjh00u3I06maIL7f
         wcxhuszXDtmgaQ28+VhV22uC4bDBLEH5ZAvUP5/FY7try11yGHPTVeDYma7KPJIUFC
         uPzN+YBRaNA3KJoGwLR5ej035byan9HjAalyfZs2z8Tdx3P3p1hYKV15UhkAu48ELC
         4UMYaOkiotwRQ==
Message-ID: <f352a2e4b50a8678a8ddef5177702ecf9040490f.camel@kernel.org>
Subject: Re: [PATCH v3 18/23] fs: remove a comment pointing to the removed
 mandatory-locking file
From:   Jeff Layton <jlayton@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 06:50:21 -0400
In-Reply-To: <887de3a1ecadda3dbfe0adf9df9070f0afa9406c.1634630486.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
         <887de3a1ecadda3dbfe0adf9df9070f0afa9406c.1634630486.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-10-19 at 09:04 +0100, Mauro Carvalho Chehab wrote:
> The mandatory file locking got removed due to its problems, but
> there's still a comment inside fs/locks.c pointing to the removed
> doc.
> 
> Remove it.
> 
> Fixes: f7e33bdbd6d1 ("fs: remove mandatory file locking support")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> 
>  fs/locks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index d397394633be..94feadcdab4e 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -61,7 +61,6 @@
>   *
>   *  Initial implementation of mandatory locks. SunOS turned out to be
>   *  a rotten model, so I implemented the "obvious" semantics.
> - *  See 'Documentation/filesystems/mandatory-locking.rst' for details.
>   *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
>   *
>   *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to

Thanks Mauro. I'll pick this into my locks branch, so it should make
v5.16 as well.
-- 
Jeff Layton <jlayton@kernel.org>

