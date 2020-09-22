Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A652745F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 18:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIVQBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 12:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgIVQBk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:01:40 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00672399A;
        Tue, 22 Sep 2020 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600790499;
        bh=+JbPuKTQwLYiRtLrv7dRgf3ndqTICplWlXGxANCBloY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIYsmBEGgBG28a67cc36efeTmr+VyZEYubJkA1CnDNucRlSPGUUMf82astmsgTQ1B
         oNOuT+s12Ov2S/HKXGJWAeiuAaMlIRPqbOrYPRIKP1mi3oYwgjJ2ObNlSgaMEDeXVp
         P6br8rNFA/3F7DPqLISqW6RMXWF8Emrl79vwMOdQ=
Date:   Tue, 22 Sep 2020 09:01:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Daniel Rosenberg <drosen@android.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
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
Message-ID: <20200922160139.GA3718581@google.com>
References: <20200922104807.912914-1-drosen@android.com>
 <20200922135940.GB5599@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922135940.GB5599@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/22, Eric Biggers wrote:
> On Tue, Sep 22, 2020 at 03:48:02AM -0700, Daniel Rosenberg wrote:
> > These patches are on top of the f2fs dev branch
> > 
> > F2FS currently supports casefolding and encryption, but not at
> > the same time. These patches aim to rectify that. In a later follow up,
> > this will be added for Ext4 as well. I've included one ext4 patch from
> > the previous set since it isn't in the f2fs branch, but is needed for the
> > fscrypt changes.
> > 
> > The f2fs-tools changes have already been applied.
> > 
> > Since both fscrypt and casefolding require their own dentry operations,
> > I've moved the responsibility of setting the dentry operations from fscrypt
> > to the filesystems and provided helper functions that should work for most
> > cases.
> > 
> > These are a follow-up to the previously sent patch set
> > "[PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption patches"
> > 
> > Daniel Rosenberg (5):
> >   ext4: Use generic casefolding support
> >   fscrypt: Export fscrypt_d_revalidate
> >   libfs: Add generic function for setting dentry_ops
> >   fscrypt: Have filesystems handle their d_ops
> >   f2fs: Handle casefolding with Encryption
> 
> I only received the cover letter, not the actual patches.  Same for the lore
> archives; they only have the cover letter.

Me too. :)

> 
> - Eric
