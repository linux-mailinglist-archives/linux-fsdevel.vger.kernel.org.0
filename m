Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFF92CBFF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 15:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgLBOof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 09:44:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44030 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgLBOoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:44:34 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkTM7-0000bh-6i; Wed, 02 Dec 2020 14:43:43 +0000
Date:   Wed, 2 Dec 2020 15:43:42 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] openat2: reject RESOLVE_BENEATH|RESOLVE_IN_ROOT
Message-ID: <20201202144342.dzks7olzr4owv3ev@wittgenstein>
References: <20201027235044.5240-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027235044.5240-1-cyphar@cyphar.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:50:42AM +1100, Aleksa Sarai wrote:
> This was an oversight in the original implementation, as it makes no
> sense to specify both scoping flags to the same openat2(2) invocation
> (before this patch, the result of such an invocation was equivalent to
> RESOLVE_IN_ROOT being ignored).
> 
> This is a userspace-visible ABI change, but the only user of openat2(2)
> at the moment is LXC which doesn't specify both flags and so no
> userspace programs will break as a result.
> 
> Changelog:
>   v2: Split patch so as to separate selftest changes. [Shuah Khan]
>   v1: <https://lore.kernel.org/lkml/20201007103608.17349-1-cyphar@cyphar.com/>
> 
> Aleksa Sarai (2):
>   openat2: reject RESOLVE_BENEATH|RESOLVE_IN_ROOT
>   selftests: openat2: add RESOLVE_ conflict test
> 
>  fs/open.c                                      | 4 ++++
>  tools/testing/selftests/openat2/openat2_test.c | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

I've applied this patchset now. There's no need to have this sit around
another merge window. I'm happy to drop it again in case you're picking
it up later, Al.

Thanks!
Christian
