Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D171D57B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgEORYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726372AbgEORYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 13:24:50 -0400
X-Greylist: delayed 91468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 May 2020 10:24:49 PDT
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F3BC061A0C;
        Fri, 15 May 2020 10:24:49 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DC103736;
        Fri, 15 May 2020 17:24:48 +0000 (UTC)
Date:   Fri, 15 May 2020 11:24:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sysctl/kernel: document ngroups_max
Message-ID: <20200515112447.4838b7ba@lwn.net>
In-Reply-To: <20200515160222.7994-1-steve@sk2.org>
References: <20200515160222.7994-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 May 2020 18:02:22 +0200
Stephen Kitt <steve@sk2.org> wrote:

> This is a read-only export of NGROUPS_MAX, so this patch also changes
> the declarations in kernel/sysctl.c to const.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 9 +++++++++
>  kernel/sysctl.c                             | 4 ++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 0d427fd10941..5f12ee07665c 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -459,6 +459,15 @@ Notes:
>       successful IPC object allocation. If an IPC object allocation syscall
>       fails, it is undefined if the value remains unmodified or is reset to -1.
>  
> +
> +ngroups_max
> +===========
> +
> +Maximum number of supplementary groups, _i.e._ the maximum size which
> +``setgroups`` will accept. Exports ``NGROUPS_MAX`` from the kernel.

Applied, thanks.

jon
