Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD64CAC15C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394492AbfIFUZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 16:25:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35066 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394484AbfIFUZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:25:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i6Kmx-0002cR-I1; Fri, 06 Sep 2019 20:24:59 +0000
Date:   Fri, 6 Sep 2019 21:24:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: fuse / work,mount coordination
Message-ID: <20190906202459.GZ1131@ZenIV.linux.org.uk>
References: <20190906170730.GY1131@ZenIV.linux.org.uk>
 <CAJfpegvagSjXYg0zVKeJvJOBKJXBzVPZsBrovX6XM9qUPkB-ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvagSjXYg0zVKeJvJOBKJXBzVPZsBrovX6XM9qUPkB-ng@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:31:39PM +0200, Miklos Szeredi wrote:
> On Fri, Sep 6, 2019 at 7:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Could you switch your branch to pulling vfs.git#work.mount-base,
> > drop cherry-picked "vfs: Create fs_context-aware mount_bdev() replacement"
> > and use get_tree_bdev() instead of vfs_get_block_super()?
> >
> >         I'd like to put #work.mount1 into -next instead of current
> > #work.mount, and doing that would obviously cause conflict with your
> > cherry-pick.  #work.mount-base is the infrastructure part of that
> > series and it'll be in never-rebased mode.
> 
> Done and pushed.

... and the same on my side.
