Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF5250C00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHXXAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 19:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgHXXAS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:00:18 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2CAF20706;
        Mon, 24 Aug 2020 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598310017;
        bh=hFYSfq3Ws1eknk28E3gL3qTiauzIGTJVHWsHQW8VQvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwB9HxxApRF52tXIKzjRRnfjyHr+VskuNN3QHQlCpBUNtIGoS05zhpZkDJeSa8UKv
         0yDtOTSqjqF0MBw9q4pS2f/bBfuqOBO0JsMXsfqX+0U4CowfHdNFg1y1t9Ya9bmMgw
         WIeTiN+FRS091HsV5kYbVekcIDXi3RBOG5gvbIAc=
Date:   Mon, 24 Aug 2020 16:00:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption
 patches
Message-ID: <20200824230015.GA810@sol.localdomain>
References: <20200708091237.3922153-1-drosen@google.com>
 <20200720170951.GE1292162@gmail.com>
 <20200727164508.GE1138@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727164508.GE1138@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 09:45:08AM -0700, Eric Biggers wrote:
> On Mon, Jul 20, 2020 at 10:09:51AM -0700, Eric Biggers wrote:
> > On Wed, Jul 08, 2020 at 02:12:33AM -0700, Daniel Rosenberg wrote:
> > > This lays the ground work for enabling casefolding and encryption at the
> > > same time for ext4 and f2fs. A future set of patches will enable that
> > > functionality.
> > > 
> > > These unify the highly similar dentry_operations that ext4 and f2fs both
> > > use for casefolding. In addition, they improve d_hash by not requiring a
> > > new string allocation.
> > > 
> > > Daniel Rosenberg (4):
> > >   unicode: Add utf8_casefold_hash
> > >   fs: Add standard casefolding support
> > >   f2fs: Use generic casefolding support
> > >   ext4: Use generic casefolding support
> > > 
> > 
> > Ted, are you interested in taking this through the ext4 tree for 5.9?
> > 
> > - Eric
> 
> Ping?
> 

Unfortunately this patchset got ignored for 5.9.

Ted, will you have any interest in taking this patchset for 5.10?  Or should
Jaegeuk just take patches 1-3 via the f2fs tree?

The fscrypt tree is also an option, but I feel it's not really appropriate since
this patchset is just a refactoring of the existing casefolding support.

More reviews on patches 1-2 would be appreciated too.  So far just Gabriel and I
have reviewed them.  I was hoping that other people would review them too.

- Eric
