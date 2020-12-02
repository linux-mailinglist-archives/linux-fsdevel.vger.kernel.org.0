Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE952CC62D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 20:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgLBTGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 14:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgLBTGs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:06:48 -0500
Date:   Wed, 2 Dec 2020 20:06:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606935967;
        bh=+HLzvDVDrH5nyM2zbDYvKZq3sm1MBLtCbEEGFslk2Ag=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=16l8A/PXOjzkFYxHNR+MJUW3ewc+SeZ3me9PlqkI1Ft5UrTDRQuuISHC5yv6zf6s0
         /R4YBYdHdYL9ZwaWYODBcL0GO1cG65svOgfC/NoSfFpVCetMVME9mbgfaaM42nYWho
         MohE/GQtKY4EqaelQJkPJFzDwcY0NTLP+bbl/2CQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <X8flmVAwl0158872@kroah.com>
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
 <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com>
 <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com>
 <641397.1606926232@warthog.procyon.org.uk>
 <CAJfpegsQxi+_ttNshHu5MP+uLn3px9+nZRoTLTxh9-xwU8s1yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsQxi+_ttNshHu5MP+uLn3px9+nZRoTLTxh9-xwU8s1yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 06:41:43PM +0100, Miklos Szeredi wrote:
> On Wed, Dec 2, 2020 at 5:24 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > > Stable cc also?
> > >
> > > Cc: <stable@vger.kernel.org> # 5.8
> >
> > That seems to be unnecessary, provided there's a Fixes: tag.
> 
> Is it?
> 
> Fixes: means it fixes a patch, Cc: stable means it needs to be
> included in stable kernels.  The two are not necessarily the same.
> 
> Greg?

You are correct.  cc: stable, as is documented in
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
ensures that the patch will get merged into the stable tree.

Fixes: is independent of it.  It's great to have for stable patches so
that I know how far back to backport patches.

We do scan all commits for Fixes: tags that do not have cc: stable, and
try to pick them up when we can and have the time to do so.  But it's
not guaranteed at all that this will happen.

I don't know why people keep getting confused about this, we don't
document the "Fixes: means it goes to stable" anywhere...

thanks,

greg k-h
