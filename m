Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C9344591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCVNXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:23:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50820 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCVNVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:21:13 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOKUR-0000r3-V7; Mon, 22 Mar 2021 13:21:04 +0000
Date:   Mon, 22 Mar 2021 14:21:03 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] posix-acl: avoid -Wempty-body warning
Message-ID: <20210322132103.qiun2rjilnlgztxe@wittgenstein>
References: <20210322131402.3117465-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322131402.3117465-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:13:59PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The fallthrough comment for an ignored cmpxchg() return value
> produces a harmless warning with 'make W=1':
> 
> fs/posix_acl.c: In function 'get_acl':
> fs/posix_acl.c:127:36: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   127 |                 /* fall through */ ;
>       |                                    ^
> 
> Simplify it as a step towards a clean W=1 build.  As all architectures
> define cmpxchg() as a statement expression these days, it is no longer
> necessary to evaluate its return code, and the if() can just be droped.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks you!
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
