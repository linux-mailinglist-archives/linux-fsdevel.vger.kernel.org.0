Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF507B6D10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjJCP2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJCP2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:28:31 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D20683;
        Tue,  3 Oct 2023 08:28:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B2C0D381;
        Tue,  3 Oct 2023 15:28:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B2C0D381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696346908; bh=RSy9yvL4W1Cu9T7AF0rbbsqRV+E7dse1w3wvltkALnE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OCKiwsmb1dMTalzna5izUhvcHzilXRzbdi5vIzb5ohHPZCUS01Zi73MZi/32CSpO7
         MYBb0nh8Af8d0oG/MHr1bvybYYw+0Ul/YPsiij3Kdz36onaTBrMcSz2CCVcP77kpAn
         3RO9h0qtKY49lx09pht44Pq70s2ZavjRt3QU2B+rVHRtpZnR6jDl2TZzgMDCmF7W9o
         CZ/SPS1mgNCsASH6J03YQKUI3yGXtyC29N9NhrelrHJ1nvtT4JYlny5KZvdxijRkjD
         gG7Q1iO0b6y/NASjENCXB+vB7QBlru98P15ZcdfOMfbqXMZ1pRpks9tWRRvq+swagT
         RFFGFvTqJAN0Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Glauber Costa <glommer@openvz.org>
Subject: Re: [PATCH] docs: admin-guide: sysctl: fix details of struct
 dentry_stat_t
In-Reply-To: <20230923195144.26043-1-rdunlap@infradead.org>
References: <20230923195144.26043-1-rdunlap@infradead.org>
Date:   Tue, 03 Oct 2023 09:28:27 -0600
Message-ID: <877co3g1yc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Commit c8c0c239d5ab moved struct dentry_stat_t to fs/dcache.c but
> did not update its location in Documentation, so update that now.
> Also change each struct member from int to long as done in
> commit 3942c07ccf98.
>
> Fixes: c8c0c239d5ab ("fs: move dcache sysctls to its own file")
> Fixes: 3942c07ccf98 ("fs: bump inode and dentry counters to long")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Glauber Costa <glommer@openvz.org>
> ---
>  Documentation/admin-guide/sysctl/fs.rst |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff -- a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -42,16 +42,16 @@ pre-allocation or re-sizing of any kerne
>  dentry-state
>  ------------
>  
> -This file shows the values in ``struct dentry_stat``, as defined in
> -``linux/include/linux/dcache.h``::
> +This file shows the values in ``struct dentry_stat_t``, as defined in
> +``fs/dcache.c``::

Applied, thanks.

jon
