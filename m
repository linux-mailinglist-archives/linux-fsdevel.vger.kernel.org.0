Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06072345A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCWJBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 05:01:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52149 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCWJBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:01:04 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOcuN-0005up-HH; Tue, 23 Mar 2021 09:01:03 +0000
Date:   Tue, 23 Mar 2021 10:01:02 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>,
        James Morris <jamorris@linux.microsoft.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfs/hfsplus: use WARN_ON for sanity check
Message-ID: <20210323090102.fpqa55uys5suodfa@wittgenstein>
References: <20210322223249.2632268-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322223249.2632268-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:32:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about a couple of instances in which a sanity check
> exists but the author wasn't sure how to react to it failing,
> which makes it look like a possible bug:
> 
> fs/hfsplus/inode.c: In function 'hfsplus_cat_read_inode':
> fs/hfsplus/inode.c:503:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   503 |                         /* panic? */;
>       |                                     ^
> fs/hfsplus/inode.c:524:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   524 |                         /* panic? */;
>       |                                     ^
> fs/hfsplus/inode.c: In function 'hfsplus_cat_write_inode':
> fs/hfsplus/inode.c:582:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   582 |                         /* panic? */;
>       |                                     ^
> fs/hfsplus/inode.c:608:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   608 |                         /* panic? */;
>       |                                     ^
> fs/hfs/inode.c: In function 'hfs_write_inode':
> fs/hfs/inode.c:464:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   464 |                         /* panic? */;
>       |                                     ^
> fs/hfs/inode.c:485:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   485 |                         /* panic? */;
>       |                                     ^
> 
> panic() is probably not the correct choice here, but a WARN_ON
> seems appropriate and avoids the compile-time warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks!
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
