Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DF20D1DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgF2So2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgF2So0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:44:26 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26DD520775;
        Mon, 29 Jun 2020 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593456266;
        bh=+KOLxCmwsPTRAh+iG7nBvhdN9ELAStyx3yZ+DIpMSVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJDIKMRCSLEvE0WirVlwv526I2ZGk7neXM71bgloPC2OjkB1QPSUU673s2YYwBV40
         dFOqgJt44qETJs2ymoIBolyAitJBRF6/PPq0ha6wCyEDLoZNoYjKJlTun4mD7F76Pc
         q2uBGcwiSOVQdAcampa0BMCJJlVXHO+uWyoH+9AU=
Date:   Mon, 29 Jun 2020 11:44:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ext4: add inline encryption support
Message-ID: <20200629184424.GG20492@sol.localdomain>
References: <20200629120405.701023-1-satyat@google.com>
 <20200629120405.701023-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629120405.701023-5-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:04:05PM +0000, Satya Tangirala via Linux-f2fs-devel wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up ext4 to support inline encryption via the helper functions which
> fs/crypto/ now provides.  This includes:
> 
> - Adding a mount option 'inlinecrypt' which enables inline encryption
>   on encrypted files where it can be used.
> 
> - Setting the bio_crypt_ctx on bios that will be submitted to an
>   inline-encrypted file.
> 
>   Note: submit_bh_wbc() in fs/buffer.c also needed to be patched for
>   this part, since ext4 sometimes uses ll_rw_block() on file data.
> 
> - Not adding logically discontiguous data to bios that will be submitted
>   to an inline-encrypted file.
> 
> - Not doing filesystem-layer crypto on inline-encrypted files.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

This patch looks good to me.  (I can't technically provide Reviewed-by because
I'm listed as the author.)

Ted and Andreas, can you take a look?

- Eric
