Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2218BEBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 18:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCSRt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 13:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCSRt6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:49:58 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEAF320754;
        Thu, 19 Mar 2020 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584640198;
        bh=q270uO9rTu9c4Si3zJtl3gemlVNKHIaUhROgwEp7OBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjAeE0xh2CCBZepqFsBambYtHD23HJxQcmO5QvWPIVvcL9Hj3zrL/gqQXSIPdsLQV
         wf18INyaAJRrwz4uM3izP8cWDD0FPXAt7Ws1mnPcPaCgqIXnwR72MZo90M6T8GsYbY
         gv602IpzAB8trxpqGo8X3iDp5eociKy8nLMp6X0s=
Date:   Thu, 19 Mar 2020 10:49:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] fscrypt: add ioctl to get file's encryption nonce
Message-ID: <20200319174956.GA86395@gmail.com>
References: <20200314205052.93294-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314205052.93294-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 14, 2020 at 01:50:48PM -0700, Eric Biggers wrote:
> This patchset adds an ioctl FS_IOC_GET_ENCRYPTION_NONCE which retrieves
> the nonce from an encrypted file or directory.
> 
> This is useful for automated ciphertext verification testing.
> 
> See patch #1 for more details.
> 
> Eric Biggers (4):
>   fscrypt: add FS_IOC_GET_ENCRYPTION_NONCE ioctl
>   ext4: wire up FS_IOC_GET_ENCRYPTION_NONCE
>   f2fs: wire up FS_IOC_GET_ENCRYPTION_NONCE
>   ubifs: wire up FS_IOC_GET_ENCRYPTION_NONCE
> 
>  Documentation/filesystems/fscrypt.rst | 11 +++++++++++
>  fs/crypto/fscrypt_private.h           | 20 ++++++++++++++++++++
>  fs/crypto/keysetup.c                  | 16 ++--------------
>  fs/crypto/policy.c                    | 21 ++++++++++++++++++++-
>  fs/ext4/ioctl.c                       |  6 ++++++
>  fs/f2fs/file.c                        | 11 +++++++++++
>  fs/ubifs/ioctl.c                      |  4 ++++
>  include/linux/fscrypt.h               |  6 ++++++
>  include/uapi/linux/fscrypt.h          |  1 +
>  9 files changed, 81 insertions(+), 15 deletions(-)
> 
> 
> base-commit: 98d54f81e36ba3bf92172791eba5ca5bd813989b

Any comments on this?

- Eric
