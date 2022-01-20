Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ECD4949DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbiATIrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:47:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60202 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359369AbiATIrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:47:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7031FB81D09;
        Thu, 20 Jan 2022 08:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F25C340E5;
        Thu, 20 Jan 2022 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642668432;
        bh=uymmtLY3ykuPPTJX+D/fvcl6pnd2cceSyUotgGzVGCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7HNn4fFPcTaohBWRYUvtow+lpJ341SlzUM+TXWkJid/DyRMTy6qoXvV86VQMMlmX
         NZ3VBTfMzmyFcxmxDbCYfCvgJR7V/nRhWehA1csKmiEpLG/uisCiFb41cCnKZq0RQE
         6LetKDDsWl0GvyeeG9JfWthQXvvdTaDAWyQ6KquleByCdX8aAytkVXevzpSYDVexjW
         cwgfhXKlJut1iVe2kjap0DHPSfDJTDS4qByL8EJGI90UEiV0STBb9klbH0xFYlITHv
         NG50dCdnZQJ+O2BUTHw9hCL7NzVS/XTLLnGDW1lkfPWqFXnuvFpg/4A1fv80Mde0+9
         hhtanxufmvxSw==
Date:   Thu, 20 Jan 2022 09:47:07 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mount: warn only once about timestamp range
 expiration
Message-ID: <20220120084707.bsiyxudl4yfqqywd@wittgenstein>
References: <20220119202934.26495-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119202934.26495-1-ailiop@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:29:34PM +0100, Anthony Iliopoulos wrote:
> Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp
> expiry") introduced a mount warning regarding filesystem timestamp
> limits, that is printed upon each writable mount or remount.
> 
> This can result in a lot of unnecessary messages in the kernel log in
> setups where filesystems are being frequently remounted (or mounted
> multiple times).
> 
> Avoid this by setting a superblock flag which indicates that the warning
> has been emitted at least once for any particular mount, as suggested in
> [1].
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> 
> [1] https://lore.kernel.org/CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com/
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
