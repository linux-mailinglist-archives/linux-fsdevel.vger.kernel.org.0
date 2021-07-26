Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7903D51F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 05:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhGZDSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 23:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhGZDSG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:18:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FA6960EB2;
        Mon, 26 Jul 2021 03:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627271915;
        bh=WPLxji5Fu3Q2Q6hrxcLMN8a8q3esfgs4pl4CERub5YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgmYCrRdhNjrVPAoHCovW00SjzclRfqwwr+TF3YR2+VJF1OfgIcpNJhkK4eByklBX
         1XsJZZP4DbXkPdxsLdLYxA0F0+DFSdkn+q82TKancpVQOq8njTx5CMjF365UH0jLct
         +XR0U8gxeOY8AKCfFMl8mQ4vk8iUZzr5EkvUdRyExEMjbU5Ihr5JHoZbSbzkOIcn1x
         KnYkutj0MPTAemKe1UU4n1kFuON6bpcSgNOo/rQL9qTHaQ9hC4omSBP1szv45dUwzW
         D9kauqkb7x7Q6cQlBmkD77q96XTWfchBYyNXTSZkExEq3gQ9n9Bt7ND2MMha2wKIni
         Y6XgTywBxx92g==
Date:   Sun, 25 Jul 2021 20:58:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] fscrypt: report correct st_size for encrypted
 symlinks
Message-ID: <YP4y6izInCXVJMup@sol.localdomain>
References: <20210702065350.209646-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702065350.209646-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 01, 2021 at 11:53:45PM -0700, Eric Biggers wrote:
> This series makes the stat() family of syscalls start reporting the
> correct size for encrypted symlinks.
> 
> See patch 1 for a detailed explanation of the problem and solution.
> 
> Patch 1 adds a helper function that computes the correct size for an
> encrypted symlink.  Patches 2-4 make the filesystems with fscrypt
> support use it, and patch 5 updates the documentation.
> 
> This series applies to mainline commit 3dbdb38e2869.
> 
> Eric Biggers (5):
>   fscrypt: add fscrypt_symlink_getattr() for computing st_size
>   ext4: report correct st_size for encrypted symlinks
>   f2fs: report correct st_size for encrypted symlinks
>   ubifs: report correct st_size for encrypted symlinks
>   fscrypt: remove mention of symlink st_size quirk from documentation
> 
>  Documentation/filesystems/fscrypt.rst |  5 ---
>  fs/crypto/hooks.c                     | 44 +++++++++++++++++++++++++++
>  fs/ext4/symlink.c                     | 12 +++++++-
>  fs/f2fs/namei.c                       | 12 +++++++-
>  fs/ubifs/file.c                       | 13 +++++++-
>  include/linux/fscrypt.h               |  7 +++++
>  6 files changed, 85 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 3dbdb38e286903ec220aaf1fb29a8d94297da246

All applied to fscrypt.git#master for 5.15.

- Eric
