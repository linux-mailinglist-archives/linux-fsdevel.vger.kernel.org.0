Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF08804C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 08:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfHCGrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 02:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHCGrL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:47:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C10A2073D;
        Sat,  3 Aug 2019 06:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564814830;
        bh=aA4Z53Yll/pd8QCsrLOijfOT1YklqcDJ+OCqX5ZkZRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5EDXp/5XxOZ9ykbcNUUQyvA9QdnWkQS5kNwBfZRN8kr0g1DgH9a6JNVOABlYO1Qx
         lmRkB/XIDtiwcvECBrRtPGOq/QaCkmn8I4LufSIuTa8pI5P6iresX7L3MAdPy7F93G
         p/lhbzsL3qWoJplsuamAbxsRN8UDcbpBhTn8tnew=
Date:   Sat, 3 Aug 2019 08:47:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andreas Steinmetz <ast@domdv.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix cuse ENOMEM ioctl breakage in 4.20.0
Message-ID: <20190803064708.GC10855@kroah.com>
References: <1546163027.3036.2.camel@domdv.de>
 <CAJfpegvBvY2hLUc010hgi3JwWPyvT1CK1X2GD3qUe-dBDtoBbA@mail.gmail.com>
 <388f911ccba16dee350bb2534b67d601b44f3a92.camel@domdv.de>
 <CAJfpegtQ11yRhg3+h+dCJ_juc6KGKBLLwB_Vco8+KDACpBmY5w@mail.gmail.com>
 <20190802081501.GK26174@kroah.com>
 <CAJfpegvm=Et+MH+h0QYtF14JCdu+QNpnyKubA3Fd137+Wtc4ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvm=Et+MH+h0QYtF14JCdu+QNpnyKubA3Fd137+Wtc4ew@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:44:20PM +0200, Miklos Szeredi wrote:
> On Fri, Aug 2, 2019 at 10:15 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 28, 2019 at 03:12:28PM +0200, Miklos Szeredi wrote:
> > > On Sat, May 18, 2019 at 3:58 PM Andreas Steinmetz <ast@domdv.de> wrote:
> > >
> > > > > On Sun, Dec 30, 2018 at 10:52 AM Andreas Steinmetz <ast@domdv.de> wrote:
> > > > > > This must have happened somewhen after 4.17.2 and I did find it in
> > > > > > 4.20.0:
> > > > > >
> > > > > > cuse_process_init_reply() doesn't initialize fc->max_pages and thus all
> > > > > > cuse bases ioctls fail with ENOMEM.
> > > > > >
> > > > > > Patch which fixes this is attached.
> > > > >
> > > > > Thanks.  Pushed a slightly different patch:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=for-next&id=666a40e87038221d45d47aa160b26410fd67c1d2
> > > > >
> > >
> > > > It got broken again, ENONEM.
> > > > I do presume that commit 5da784cce4308ae10a79e3c8c41b13fb9568e4e0 is the
> > > > culprit. Could you please fix this and, please, could somebody do a cuse
> > > > regression test after changes to fuse?
> > >
> > > Hi,
> > >
> > > Can you please tell us which kernel is broken?
> >
> > Did this ever get resolved?
> 
> Apparently yes, in v4.20.8 (f191c028cc33).  No other kernel was
> affected, AFAICS.

Wonderful, thanks for letting me know.

greg k-h
