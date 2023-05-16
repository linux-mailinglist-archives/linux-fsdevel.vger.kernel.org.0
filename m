Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E77705667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjEPSzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjEPSzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 14:55:17 -0400
X-Greylist: delayed 297 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 11:55:16 PDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E287699;
        Tue, 16 May 2023 11:55:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8590E37C;
        Tue, 16 May 2023 18:55:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8590E37C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684263315; bh=lYsL5gxcUNL0ZhbBkhFGbOvFWuBT3Up+nXOLMdCPIgo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nyJ6bnpc+DA6pRYhuIXIXd2NlOg8Gb14Bb6S8c2lcwMM3kAbyn9NeZhT+dSzIT2Wm
         qe3VdsdTDP4zGVX4FM8kL13900vsDqwKwIIaxCEf78Rud6bkVbAx/053NQGjB1PRfi
         b3vUp8GLwZZXi0rPoenrGUDGUOi8fm2eyNrd5+ZcZ/rWVwvfPOhmZncsaGSbqMHfas
         U9SD89p9aDGQqXlwG22ATzfs4/JElE7IMtE0cNacxUO84J/NWz5LHraWp91CIklnFo
         VSV7uArVDXrrfXWUpCsst70XsiLt7/d9IJX1D53/Z7IR+1QJXJvy7TTwxvSeogDj/1
         KAzHPkq8js2zQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Rob Landley <rob@landley.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation/filesystems: ramfs-rootfs-initramfs: use
 :Author:
In-Reply-To: <20230508055928.3548-1-rdunlap@infradead.org>
References: <20230508055928.3548-1-rdunlap@infradead.org>
Date:   Tue, 16 May 2023 12:55:14 -0600
Message-ID: <87ilcsayy5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Use the :Author: markup instead of making it a chapter heading.
> This cleans up the table of contents for this file.
>
> Fixes: 7f46a240b0a1 ("[PATCH] ramfs, rootfs, and initramfs docs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Rob Landley <rob@landley.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Documentation/filesystems/ramfs-rootfs-initramfs.rst |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff -- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> --- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> +++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> @@ -6,8 +6,7 @@ Ramfs, rootfs and initramfs
>  
>  October 17, 2005
>  
> -Rob Landley <rob@landley.net>
> -=============================
> +:Author: Rob Landley <rob@landley.net>

Applied, thanks.

jon
