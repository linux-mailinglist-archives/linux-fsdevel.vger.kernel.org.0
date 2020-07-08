Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1E217CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 03:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgGHBom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 21:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgGHBom (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:44:42 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50755206DF;
        Wed,  8 Jul 2020 01:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594172681;
        bh=pc9r2MlQ4YV78AG0esE4ppDqeMfOm93xI5UmXgp5gqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QA5sGO5qUiLKD4ECswpWLjjMFqRtnVqe1TpN2o5l+JL6AMbY49ekIgI2f+lN+1OzN
         CpYzIZysoQcDNnfJWfLju4xO+Q6RkMAy4njljS9zJ24uFFljUEDXTXsHuSFPA9bRdu
         ocaEleHjB6OsO9CNhqwYyabxBcbLRQwGKW2j0Aco=
Date:   Tue, 7 Jul 2020 18:44:39 -0700
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
Subject: Re: [PATCH v10 4/4] ext4: Use generic casefolding support
Message-ID: <20200708014439.GH839@sol.localdomain>
References: <20200707113123.3429337-1-drosen@google.com>
 <20200707113123.3429337-5-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707113123.3429337-5-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:31:23AM -0700, Daniel Rosenberg wrote:
> This switches ext4 over to the generic support provided in
> the previous patch.
> 
> Since casefolded dentries behave the same in ext4 and f2fs, we decrease
> the maintenance burden by unifying them, and any optimizations will
> immediately apply to both.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/ext4/dir.c   | 64 ++-----------------------------------------------
>  fs/ext4/ext4.h  | 12 ----------
>  fs/ext4/hash.c  |  2 +-
>  fs/ext4/namei.c | 20 +++++++---------
>  fs/ext4/super.c | 12 +++++-----
>  5 files changed, 17 insertions(+), 93 deletions(-)
> 

Looks good, you can add:

    Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
