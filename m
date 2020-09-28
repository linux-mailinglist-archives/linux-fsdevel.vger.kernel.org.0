Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD84B27B824
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 01:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgI1Xac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 19:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgI1Xab (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:30:31 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F1121775;
        Mon, 28 Sep 2020 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601330121;
        bh=htsG7cgCjOWP+vwgIjl2Fqt34Hd6Ri+elKAS7Sa4s9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeRoDOX5fGNEqD17+mt8alMS/Ia9anUvzJ/J58HMWp75rczK5TvFc7upYr25aFTI8
         bTg4Nx/nPXozSDG5jlQS/tXr1awsFaY2y51DJRpQEEk2ieG+nhP8Ujyvy03NzcunRo
         7kVX8u2ZU2gx42MvnDioqFMgJ0OtAzWZ2S6ug+FU=
Date:   Mon, 28 Sep 2020 14:55:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 0/2] fscrypt: avoid ambiguous terms for "no-key name"
Message-ID: <20200928215520.GC1340@sol.localdomain>
References: <20200924042624.98439-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924042624.98439-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:26:22PM -0700, Eric Biggers wrote:
> This series fixes overloading of the terms "ciphertext name" and
> "encrypted name" to also sometimes mean "no-key name".
> The overloading of these terms has caused some confusion.
> 
> No change in behavior.
> 
> Eric Biggers (2):
>   fscrypt: don't call no-key names "ciphertext names"
>   fscrypt: rename DCACHE_ENCRYPTED_NAME to DCACHE_NOKEY_NAME
> 
>  fs/crypto/fname.c       | 16 ++++++++--------
>  fs/crypto/hooks.c       | 13 ++++++-------
>  fs/f2fs/dir.c           |  2 +-
>  include/linux/dcache.h  |  2 +-
>  include/linux/fscrypt.h | 25 ++++++++++++-------------
>  5 files changed, 28 insertions(+), 30 deletions(-)

Applied to fscrypt.git#master for 5.10.

- Eric
