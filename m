Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5613255D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 19:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBYSvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 13:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhBYSvi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:51:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8A1C64F03;
        Thu, 25 Feb 2021 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614279058;
        bh=o45Nk/ThRtDbh8TB+VXox+YC5iOPmiQu7TH0gfp3lyk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ODWbpXfCeIgx2hvzfs4UlwvmOOPwFkrDELGt6KxQesUUs5l7ON+DgqG4d1lgtryIl
         bovrPkQc7g/HlCLeYo+ViK9h+ZdvujlmTXdVEWHpfjxOVv+zuLjFql2YLWt7EE2bII
         x51BTgmyk1bwfbOrtCPmlfpm7Y/zog6Ty8FfTiSPx0SljwcC5JUPMS94R/en0k5rvn
         YKj+ADR9vka7hhceXHJF0kbr60FxGUV0IN6Uw480WDdotjTIXxCP5royI5M05+Gpxi
         hpTkemzn0m6pFBNB3FmcvUbE1ySHxddd0JvlP8vurjOroOPBVDSW6Xby3F9ZegZH1I
         yVnSg728aT6Mw==
Date:   Thu, 25 Feb 2021 10:50:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <YDfxkGkWnLEfsDwZ@gmail.com>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225132647.GB7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:26:47PM +0100, David Sterba wrote:
> 
> LZ4 support has been asked for so many times that it has it's own FAQ
> entry:
> https://btrfs.wiki.kernel.org/index.php/FAQ#Will_btrfs_support_LZ4.3F
> 
> The decompression speed is not the only thing that should be evaluated,
> the way compression works in btrfs (in 4k blocks) does not allow good
> compression ratios and overall LZ4 does not do much better than LZO. So
> this is not worth the additional costs of compatibility. With ZSTD we
> got the high compression and recently there have been added real-time
> compression levels that we'll use in btrfs eventually.

When ZSTD support was being added to btrfs, it was claimed that btrfs compresses
up to 128KB at a time
(https://lore.kernel.org/r/5a7c09dd-3415-0c00-c0f2-a605a0656499@fb.com).
So which is it -- 4KB or 128KB?

- Eric
