Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F186218C40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgGHPtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 11:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbgGHPtf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:49:35 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8132206DF;
        Wed,  8 Jul 2020 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594223375;
        bh=bqLj7/olahh4JFtc4EpL9q3D/iTuGstNCn11lxS2sf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8Azl4TKT9W4MeG9hf8xbb9+IT4Vkm5fDqyl/WJgXll0rwBoEZZB1dPFFsJgHRItn
         xsngg1q+ZlC83YZZmLNlAPECU791bJi6VwWHLb8P6Hma4P91aEvw3Q9UZSycYmYVLW
         G94SP2CKSCoNSdtCH+2ch4YdjpCLigRyNTWJ0A8g=
Date:   Wed, 8 Jul 2020 08:49:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v12 2/4] fs: Add standard casefolding support
Message-ID: <20200708154933.GA915@sol.localdomain>
References: <20200708091237.3922153-1-drosen@google.com>
 <20200708091237.3922153-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708091237.3922153-3-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:12:35AM -0700, Daniel Rosenberg wrote:
> This adds general supporting functions for filesystems that use
> utf8 casefolding. It provides standard dentry_operations and adds the
> necessary structures in struct super_block to allow this standardization.
> 
> The new dentry operations are functionally equivalent to the existing
> operations in ext4 and f2fs, apart from the use of utf8_casefold_hash to
> avoid an allocation.
> 
> By providing a common implementation, all users can benefit from any
> optimizations without needing to port over improvements.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>
