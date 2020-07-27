Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B122F59E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgG0QpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgG0QpK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:45:10 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D2C20729;
        Mon, 27 Jul 2020 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595868310;
        bh=Y+WD95sdH0wkH5EJvEWNHVBOc12vKJ3VFxESA0EXbJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05yBUaSDAOP3S38lPECXjCakK/MCIToC7TOXpsu91VGhjXm7eVriyBOClN2zzXa2q
         V1jAjxYNkpVyPN3PGRU5H+Ra1LBAITD3yMT9MG8w1C1DScvyxtYQyFKzFwEM9RVZ8P
         CKxGsmqi8KNPkQVmmpj9NdHYV50J6dO6CH0nUiSo=
Date:   Mon, 27 Jul 2020 09:45:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Rosenberg <drosen@google.com>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption
 patches
Message-ID: <20200727164508.GE1138@sol.localdomain>
References: <20200708091237.3922153-1-drosen@google.com>
 <20200720170951.GE1292162@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720170951.GE1292162@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:09:51AM -0700, Eric Biggers wrote:
> On Wed, Jul 08, 2020 at 02:12:33AM -0700, Daniel Rosenberg wrote:
> > This lays the ground work for enabling casefolding and encryption at the
> > same time for ext4 and f2fs. A future set of patches will enable that
> > functionality.
> > 
> > These unify the highly similar dentry_operations that ext4 and f2fs both
> > use for casefolding. In addition, they improve d_hash by not requiring a
> > new string allocation.
> > 
> > Daniel Rosenberg (4):
> >   unicode: Add utf8_casefold_hash
> >   fs: Add standard casefolding support
> >   f2fs: Use generic casefolding support
> >   ext4: Use generic casefolding support
> > 
> 
> Ted, are you interested in taking this through the ext4 tree for 5.9?
> 
> - Eric

Ping?
