Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349D41E6E4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 00:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436821AbgE1WBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 18:01:45 -0400
Received: from fieldses.org ([173.255.197.46]:36576 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436784AbgE1WBe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 18:01:34 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 510926D9; Thu, 28 May 2020 18:01:12 -0400 (EDT)
Date:   Thu, 28 May 2020 18:01:12 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: The file_lock_operatoins.lock API seems to be a BAD API.
Message-ID: <20200528220112.GD20602@fieldses.org>
References: <87a71s8u23.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a71s8u23.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 04:14:44PM +1000, NeilBrown wrote:
> I don't think we should just fix all those bugs in those filesystems.
> I think that F_UNLCK should *always* remove the lock/lease.
> I imaging this happening by  *always* calling posix_lock_file() (or
> similar) in the unlock case - after calling f_op->lock() first if that
> is appropriate.
> 
> What do people think?  It there on obvious reason that is a non-starter?

Isn't NFS unlock like close, in that it may be our only chance to return
IO errors?

But I guess you're not saying that unlock can't return errors, just that
it should always remove the lock whether it returns 0 or not.

Hm.

--b.
