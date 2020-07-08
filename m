Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B18217C9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 03:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgGHBgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 21:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgGHBgD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:36:03 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B10C206DF;
        Wed,  8 Jul 2020 01:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594172163;
        bh=qcbZMOsf+PZnops4wxmQpE3tL1Fo9+d/2GUsJmsYjRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIPsXsDLGfJZLRa1uNPa8ep30GgD6VKtvrZTTnemio7/ps8+6BWHWzAWJQ3kgCdbJ
         SLzHPVMXTtzp7DK5m8QY5tcgIMCxcEwoJBid15CKOrWRwHBUsiwjH+7AtJ5wLO9ZZC
         c4Hzd9QK+N+6zgugVMC3ygDzISmy6Lm2tQYB99aE=
Date:   Tue, 7 Jul 2020 18:36:01 -0700
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
Subject: Re: [PATCH v10 1/4] unicode: Add utf8_casefold_hash
Message-ID: <20200708013601.GF839@sol.localdomain>
References: <20200707113123.3429337-1-drosen@google.com>
 <20200707113123.3429337-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707113123.3429337-2-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:31:20AM -0700, Daniel Rosenberg wrote:
> This adds a case insensitive hash function to allow taking the hash
> without needing to allocate a casefolded copy of the string.
> 
> The existing d_hash implementations for casefolding allocates memory
> within rcu-walk, by avoiding it we can be more efficient and avoid
> worrying about a failed allocation.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

You can add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

If you have a chance please fix the grammar in the commit message though:

"The existing d_hash implementations for casefolding allocate memory
within rcu-walk.  By avoiding this we can be more efficient and avoid
worrying about a failed allocation."

- Eric
