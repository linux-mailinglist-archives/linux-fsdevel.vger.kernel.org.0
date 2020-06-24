Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43DE206C1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 08:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgFXGEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 02:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388164AbgFXGEG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:04:06 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AC92085B;
        Wed, 24 Jun 2020 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978645;
        bh=STmnuLbp6dqBamgAzJ+Ue/+bNkc6g/1tpfJs2y+gU6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=po3bfXB92hJ+PijyLMwHXbS/arxBw/0IUAsnaYskimBhp5qtvm5z+v8pGM+WgW9eW
         FLe98JcBQR5dGhNpYT2AcM037Hpb1EdSMM5PBYfhnf2Wgpw7k7/8mYfd7JPRk5E8No
         teVgpd0E/A1IgM2mFReeceA8sMDJhn8YuudMvMdA=
Date:   Tue, 23 Jun 2020 23:04:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v9 4/4] ext4: Use generic casefolding support
Message-ID: <20200624060403.GH844@sol.localdomain>
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-5-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624043341.33364-5-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:33:41PM -0700, Daniel Rosenberg wrote:
> This switches ext4 over to the generic support provided in
> commit 5f829feca774 ("fs: Add standard casefolding support")

Commit IDs aren't determined until the patches are applied.  It's possible for
the person applying the patches to fix them, but in general people will forget,
so it's better not to include non-stable commit IDs.

Also, a sentence explaining *why* this change is good would be helpful.
Commit messages should always have a *why* unless it's obvious.

Likewise for the f2fs commit.

- Eric
