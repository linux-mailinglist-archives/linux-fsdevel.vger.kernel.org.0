Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290242F39CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406271AbhALTOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhALTOp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:14:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E00A230F9;
        Tue, 12 Jan 2021 19:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478845;
        bh=HfY5AtfEjHmUSHWdZ3UwZuzVHc2NCzE56hiXY2m6e1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwoxPnudxOLM4lqnZZBSF9w9BP16SXhbLDXlKHv+2Q815g1RB89LfMpGPlj3bb2b1
         jP6tx+iYMKc1cvw04K4Z/lv9IbVk4JyfqwsqXdGNIw5X405I2dSKyyPNiEJqzZHnJ3
         6XF8yEKBRhs3yDiwJ+Y2MsnLlVN0iru1OweKSNFVYYQrZPsNo/2PCJhPDteVGrpkvu
         JReSOlUZzV6NDVYCO98pz7nGvB00P9Y00qi1osy1pSVYrSaHLnY6uHzpZ5HzQ7QHhz
         WxTBhuTCeIGsXy4yrjq+RGf4Ss3X2UVcgspUAOLBBuQnP3tisZgpkl6xo8tRZ2ijfH
         jkgVPrjF5N0YA==
Date:   Tue, 12 Jan 2021 11:14:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH RESEND] libfs: unexport generic_ci_d_compare() and
 generic_ci_d_hash()
Message-ID: <X/30+5rc1bv39moX@sol.localdomain>
References: <20201228232529.45365-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228232529.45365-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 28, 2020 at 03:25:29PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that generic_set_encrypted_ci_d_ops() has been added and ext4 and
> f2fs are using it, it's no longer necessary to export
> generic_ci_d_compare() and generic_ci_d_hash() to filesystems.
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/libfs.c         | 8 +++-----
>  include/linux/fs.h | 5 -----
>  2 files changed, 3 insertions(+), 10 deletions(-)

Jaegeuk, any interest in applying this given that this code came in through the
f2fs tree in the first place?

- Eric
