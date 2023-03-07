Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E988A6AE9F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 18:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCGR3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 12:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCGR3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:29:00 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B0D97FD0;
        Tue,  7 Mar 2023 09:24:03 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0AE282D3;
        Tue,  7 Mar 2023 17:24:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0AE282D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678209843; bh=nP6YO86jhXCaevYKimI6MIho94hrU18up/Swr6sKn10=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gHUG/ArDIUIsgAEysxyiO1cUKun99iCP9pp4PRuR/cTtR0SjeNP9G1wtdocftX/QG
         lpXqe+xIHK9LJRTqlrJH/XcykxC2hZaisLN/OIMajOa3IN6mDimTzifqIjIx4XShhK
         B+rxjPcVDEWZeQQ2w7ME3DvX1TQfQsW9J6df6/BtSaFrBsl8x8QCYgTru+nf1iHhDh
         ykfotDM/I8C8RmKgvW6zuVrQ1mEoiN2MBo5dxU3czSAshu7Kk3PP+odlBkqRjYuePj
         8PaVKuNAlkCJI37V0VF6pD4yJxf6MOed1iykAR2m8Z6tG7OehwIUa2oJGa7Nj6RcEp
         GJvuI3yMdrnlw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Glenn Washburn <development@efficientek.com>
Cc:     Glenn Washburn <development@efficientek.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Correct missing "d_" prefix for dentry_operations
 member d_weak_revalidate
In-Reply-To: <20230227184042.2375235-1-development@efficientek.com>
References: <20230227184042.2375235-1-development@efficientek.com>
Date:   Tue, 07 Mar 2023 10:24:02 -0700
Message-ID: <87ttywo4p9.fsf@meer.lwn.net>
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

Glenn Washburn <development@efficientek.com> writes:

> The details for struct dentry_operations member d_weak_revalidate is
> missing a "d_" prefix.
>
> Fixes: af96c1e304f7 (docs: filesystems: vfs: Convert vfs.txt to RST)
> Signed-off-by: Glenn Washburn <development@efficientek.com>
> ---
>  Documentation/filesystems/vfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Checkpatch whined about that Fixes line (missing the quotes around the
patch subject), which caused me to go back and look.  Sure enough, the
RST conversion introduced that error...so I fixed Fixes.

jon
