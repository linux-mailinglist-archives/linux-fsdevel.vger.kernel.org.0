Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B52B6B9DF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCNSNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 14:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNSM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:12:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE922C9F;
        Tue, 14 Mar 2023 11:12:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7A9DE44A;
        Tue, 14 Mar 2023 18:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7A9DE44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678817577; bh=C2Jo0+NKx7aG1yAi3TKpW+xiGewvFQwGLZLYK6y+3ic=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=riyT7GfS9Dsrq/Uh0slJl2Rqvebfq3qS44UocAf8YxBP+iiTOksD/Os+Gv1N3B9jE
         IePi8fROY6Vfjb3ktM9uczLqF6DHvi/uG6q8CukhfHlnp+6LRs4nZU3btKNpj44mWk
         6I5LbzTo+9FfFG+ifWud6tpl3QeztRKNdVlTiVi/9fIXxTc2fplI+6zTKQ1sCSN+d2
         kJph4PmWFNWqye3mhStiSBfn9HZR0YWwCAgR1EJVJDYD0GSqFE7AvrfS1h0/Kephsz
         1RJEtT1m3JQJ3y9QOxU+LbBKk4KfuVFKWM6ZAHRZ4R2v8BRQxakaXVCqK/Ws1lOuXe
         Kum2/nfa8Vb6Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/2] docs: actualize file_system_type and
 super_operations descriptions
In-Reply-To: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 14 Mar 2023 12:12:56 -0600
Message-ID: <87v8j3ryl3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com> writes:

> Current descriptions are from 2.6.* times, let's update them.
>
> I've noticed that during my work on fuse recovery API.
>
> v2:
> - fixed commit messages according to Jonathan's advice
>
> v3:
> - removed direct kernel version specification as Eric proposed
>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
>
> Alexander Mikhalitsyn (2):
>   docs: filesystems: vfs: actualize struct file_system_type description
>   docs: filesystems: vfs: actualize struct super_operations description
>
>  Documentation/filesystems/vfs.rst | 105 ++++++++++++++++++++++++------
>  1 file changed, 86 insertions(+), 19 deletions(-)

Series applied, thanks.

jon
