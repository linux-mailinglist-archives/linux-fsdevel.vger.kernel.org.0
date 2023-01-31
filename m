Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614B56836E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 20:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjAaT4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 14:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaT4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:56:19 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC3545884;
        Tue, 31 Jan 2023 11:56:18 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F03C831A;
        Tue, 31 Jan 2023 19:56:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F03C831A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675194978; bh=rT2IqtV9+4VADb/CLkaOZH9H9wZweXHd3Q22cA1GatM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Aa0BFMtztim0oWfX4REvx+USABOXQXdkGA4qSEeF4mp1nx1VJDp8xf5/bXfftRdcj
         rfHEJMAPdUrg+8sHsmg6WWeRWWIslRospgMcipSN8HoL2wqeYNubal/1bzrFQ2xPng
         4ODrA87E5mACsC2+TAS115fehloRneAG7k+GqWWuGzMKzv3pd8sC0TYMUs/C6coVlK
         HgYw2TTnmOK2JWVCSpW+NuH1i2OhQXE2xCFAKEl6YRr/UpRbbUfSDihFzWaXyimRKO
         kmopKZY5bKoB6BqzduCsFcT/y7kvuhkHQ52axeJh3C37ESPt/Kc3FuZCXJwLwtCGM1
         1qRU5P6TeZKqA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: filesystems: vfs: actualize struct
 super_operations description
In-Reply-To: <20230131121608.177250-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230131121608.177250-1-aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 31 Jan 2023 12:56:17 -0700
Message-ID: <87bkme4gwu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com> writes:

> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  Documentation/filesystems/vfs.rst | 74 ++++++++++++++++++++++++-------
>  1 file changed, 59 insertions(+), 15 deletions(-)

Thanks for updating this document!  That said, could I ask you, please,
to resubmit these with a proper changelog?  I'd also suggest copying Al
Viro, who will surely have comments on the changes you have made.

> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index fab3bd702250..8671eafa745a 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -242,33 +242,42 @@ struct super_operations
>  -----------------------
>  
>  This describes how the VFS can manipulate the superblock of your
> -filesystem.  As of kernel 2.6.22, the following members are defined:
> +filesystem.  As of kernel 6.1, the following members are defined:

Why not 6.2 while you're at it?  We might as well be as current as we
can while we're updating things.

Thanks,

jon
