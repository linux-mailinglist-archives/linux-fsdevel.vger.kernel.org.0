Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC96182053
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 19:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgCKSDb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 14:03:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37541 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:03:31 -0400
Received: from 2.general.sarnold.us.vpn ([10.172.64.71] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.arnold@canonical.com>)
        id 1jC5hY-0003jD-1j; Wed, 11 Mar 2020 18:03:28 +0000
Date:   Wed, 11 Mar 2020 18:03:26 +0000
From:   Seth Arnold <seth.arnold@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs_parse: Remove pr_notice() about each validation
Message-ID: <20200311180326.GA2007141@millbarge>
References: <202003061617.A8835CAAF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <202003061617.A8835CAAF@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:20:02PM -0800, Kees Cook wrote:
> This notice fills my boot logs with scary-looking asterisks but doesn't
> really tell me anything. Let's just remove it; validation errors
> are already reported separately, so this is just a redundant list of
> filesystems.
> 
> $ dmesg | grep VALIDATE
> [    0.306256] *** VALIDATE tmpfs ***
> [    0.307422] *** VALIDATE proc ***
> [    0.308355] *** VALIDATE cgroup ***
> [    0.308741] *** VALIDATE cgroup2 ***
> [    0.813256] *** VALIDATE bpf ***
> [    0.815272] *** VALIDATE ramfs ***
> [    0.815665] *** VALIDATE hugetlbfs ***
> [    0.876970] *** VALIDATE nfs ***
> [    0.877383] *** VALIDATE nfs4 ***
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Excellent, these messages haven't been useful in helping users diagnose
problems and they look quite noisy considering how mundane they are.

Reviewed-by: Seth Arnold <seth.arnold@canonical.com>

Thanks

> ---
>  fs/fs_parser.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 7e6fb43f9541..ab53e42a874a 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -368,8 +368,6 @@ bool fs_validate_description(const char *name,
>  	const struct fs_parameter_spec *param, *p2;
>  	bool good = true;
>  
> -	pr_notice("*** VALIDATE %s ***\n", name);
> -
>  	for (param = desc; param->name; param++) {
>  		/* Check for duplicate parameter names */
>  		for (p2 = desc; p2 < param; p2++) {
> -- 
> 2.20.1
> 
> 
> -- 
> Kees Cook
