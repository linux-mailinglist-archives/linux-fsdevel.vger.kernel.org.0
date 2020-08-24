Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36734250C60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 01:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHXXcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 19:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgHXXcL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:32:11 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1090C2074D;
        Mon, 24 Aug 2020 23:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598311931;
        bh=MHWFxrSNWgUFbkwhstp/6s6DxFuZbPykagmrmfORDj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsooUHbL1hbNjt/UxArRuXQ4gDx5qqLpZrSaveZCC0UMlS1Ca4PHW8BaGvurwQ/PM
         0aFlZxQiWzqU2b6+2MLc9JWtCT2OCvP4nSwiSvkH8QOgdW7lsTBnv+LTZoxH5Ucz5x
         sabwm2+ayVwUI+Ntm4IX2sz/ljDaix2w++h75wVY=
Date:   Mon, 24 Aug 2020 16:32:10 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption
 patches
Message-ID: <20200824233210.GA122905@google.com>
References: <20200708091237.3922153-1-drosen@google.com>
 <20200720170951.GE1292162@gmail.com>
 <20200727164508.GE1138@sol.localdomain>
 <20200824230015.GA810@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824230015.GA810@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/24, Eric Biggers wrote:
> On Mon, Jul 27, 2020 at 09:45:08AM -0700, Eric Biggers wrote:
> > On Mon, Jul 20, 2020 at 10:09:51AM -0700, Eric Biggers wrote:
> > > On Wed, Jul 08, 2020 at 02:12:33AM -0700, Daniel Rosenberg wrote:
> > > > This lays the ground work for enabling casefolding and encryption at the
> > > > same time for ext4 and f2fs. A future set of patches will enable that
> > > > functionality.
> > > > 
> > > > These unify the highly similar dentry_operations that ext4 and f2fs both
> > > > use for casefolding. In addition, they improve d_hash by not requiring a
> > > > new string allocation.
> > > > 
> > > > Daniel Rosenberg (4):
> > > >   unicode: Add utf8_casefold_hash
> > > >   fs: Add standard casefolding support
> > > >   f2fs: Use generic casefolding support
> > > >   ext4: Use generic casefolding support
> > > > 
> > > 
> > > Ted, are you interested in taking this through the ext4 tree for 5.9?
> > > 
> > > - Eric
> > 
> > Ping?
> > 
> 
> Unfortunately this patchset got ignored for 5.9.
> 
> Ted, will you have any interest in taking this patchset for 5.10?  Or should
> Jaegeuk just take patches 1-3 via the f2fs tree?

fyi; I think I can merge 1-3, if Al has no concern on 1 & 2. 

> 
> The fscrypt tree is also an option, but I feel it's not really appropriate since
> this patchset is just a refactoring of the existing casefolding support.
> 
> More reviews on patches 1-2 would be appreciated too.  So far just Gabriel and I
> have reviewed them.  I was hoping that other people would review them too.
> 
> - Eric
