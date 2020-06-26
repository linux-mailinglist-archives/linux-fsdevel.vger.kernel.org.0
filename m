Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E563220B6B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZRPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFZRPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:15:31 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAAEC03E979;
        Fri, 26 Jun 2020 10:15:31 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D4C8C374;
        Fri, 26 Jun 2020 17:15:30 +0000 (UTC)
Date:   Fri, 26 Jun 2020 11:15:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        David Sterba <dsterba@suse.com>, Rob Herring <robh@kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/filesystems
Message-ID: <20200626111529.10e9e13b@lwn.net>
In-Reply-To: <20200621133552.46371-1-grandmaster@al2klimov.de>
References: <20200621133552.46371-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 21 Jun 2020 15:35:52 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Documentation/filesystems/hfs.rst                    | 2 +-
>  Documentation/filesystems/hpfs.rst                   | 2 +-
>  Documentation/filesystems/nfs/rpc-server-gss.rst     | 6 +++---
>  Documentation/filesystems/path-lookup.rst            | 6 +++---
>  Documentation/filesystems/ramfs-rootfs-initramfs.rst | 8 ++++----
>  Documentation/filesystems/ubifs-authentication.rst   | 4 ++--
>  Documentation/filesystems/vfs.rst                    | 6 +++---
>  7 files changed, 17 insertions(+), 17 deletions(-)

I've applied this.  But some of the pages referenced here have not changed
in over 20 years; I suspect they may be just a wee bit out of date and not
entirely helpful for people trying to understand the kernel.  I *really*
wish we could be cleaning that stuff up rather than just changing URL
protocols...

Thanks,

jon
