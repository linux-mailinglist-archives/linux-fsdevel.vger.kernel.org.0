Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546182AC8DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 23:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgKIWuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 17:50:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgKIWuf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:50:35 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28674206C0;
        Mon,  9 Nov 2020 22:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604962234;
        bh=3zCrnmiSy4pI28U8wV8PlYqpeE16yEzdnAVoONyzohs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x/RoupRNbJK1Pi4mHAwErVHXP/WENGRJgQMMxq9le7k+nzQ6OMr3Ik9Tg6nhy36C1
         yFvZiu/Ji96oaWBRhoIDdUt+aBI3y0PNOh3QbRN0uliX4vy/xne5YwHqkCQB5XM4I4
         qxla2lpMXWy+XbxUgITCAREeyY8g3BQp6Zc+EBOk=
Date:   Mon, 9 Nov 2020 14:50:32 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH 0/5] Add support for Encryption and Casefolding in F2FS
Message-ID: <20201109225032.GA2652236@gmail.com>
References: <20200923010151.69506-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923010151.69506-1-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 01:01:46AM +0000, Daniel Rosenberg wrote:
> These patches are on top of the f2fs dev branch
> 
> F2FS currently supports casefolding and encryption, but not at
> the same time. These patches aim to rectify that. In a later follow up,
> this will be added for Ext4 as well. I've included one ext4 patch from
> the previous set since it isn't in the f2fs branch, but is needed for the
> fscrypt changes.
> 
> The f2fs-tools changes have already been applied.
> 
> Since both fscrypt and casefolding require their own dentry operations,
> I've moved the responsibility of setting the dentry operations from fscrypt
> to the filesystems and provided helper functions that should work for most
> cases.
> 
> These are a follow-up to the previously sent patch set
> "[PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption patches"
> 
> Daniel Rosenberg (5):
>   ext4: Use generic casefolding support
>   fscrypt: Export fscrypt_d_revalidate
>   libfs: Add generic function for setting dentry_ops
>   fscrypt: Have filesystems handle their d_ops
>   f2fs: Handle casefolding with Encryption

Daniel, can you resend this for 5.11, with all remaining comments addressed?
The first two patches made 5.10, but the others didn't.

- Eric
