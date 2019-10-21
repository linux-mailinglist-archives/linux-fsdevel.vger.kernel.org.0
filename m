Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFBEDF6C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 22:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbfJUU3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 16:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbfJUU3D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:29:03 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208302067B;
        Mon, 21 Oct 2019 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571689742;
        bh=CDmrDmHjELBAUrBY8WbscTUpVT2+8e+2NK3PWI6nzro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5qbRv4LpeWBtE1dFXuPvLGMU43VkUsF413qTJMikb0SUYiAKqsBz8H+B4RxsiHTy
         K1ecBLlwg21XreJQkSZGAvy327GVxorLtA7PpSuihTbnVPMp+Ke40BFo+vIQtlH4Ir
         VL3jCpymD+r32LxMYYDdh+LA+19mI3hv9+hkOtOU=
Date:   Mon, 21 Oct 2019 13:29:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: ioctl-number: document fscrypt ioctl numbers
Message-ID: <20191021202859.GD122863@gmail.com>
Mail-Followup-To: linux-fscrypt@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
References: <20191009234555.226282-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009234555.226282-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 04:45:55PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 'f' ioctls with numbers 19-26 decimal are currently used for fscrypt
> (a.k.a. ext4/f2fs/ubifs encryption), and up to 39 decimal is reserved
> for future fscrypt use, as per the comment in fs/ext4/ext4.h.  So the
> reserved range is 13-27 hex.
> 
> Document this in ioctl-number.rst.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ioctl/ioctl-number.rst b/Documentation/ioctl/ioctl-number.rst
> index bef79cd4c6b4d..4ef86433bd677 100644
> --- a/Documentation/ioctl/ioctl-number.rst
> +++ b/Documentation/ioctl/ioctl-number.rst
> @@ -233,6 +233,7 @@ Code  Seq#    Include File                                           Comments
>  'f'   00-0F  fs/ext4/ext4.h                                          conflict!
>  'f'   00-0F  linux/fs.h                                              conflict!
>  'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                     conflict!
> +'f'   13-27  linux/fscrypt.h
>  'f'   81-8F  linux/fsverity.h
>  'g'   00-0F  linux/usb/gadgetfs.h
>  'g'   20-2F  linux/usb/g_printer.h
> -- 

Applied to fscrypt.git for 5.5.

- Eric
