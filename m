Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AC23D8ED7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhG1NUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 09:20:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46716 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:20:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1F5701FFC7;
        Wed, 28 Jul 2021 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627478445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lCc5x9urEAZbNeY9OEDsNeOQwSlhy+n+fY25TCQ64aM=;
        b=JeqZj2gEBvBQQh9j/aIB1HSyc0nVD4VVFybRuvBCWo9NMLpa0XkD9cNEquZSTUUl3KbVjr
        ZhtB97LKSLY+64j5EVEfceX4QWyIG4bkJ4uS7++WZXhw1nUO8ZO826AgSmDsXRWnraCBOF
        spw6swU04pemMW7ZVGS6aJfCH2b1tsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627478445;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lCc5x9urEAZbNeY9OEDsNeOQwSlhy+n+fY25TCQ64aM=;
        b=clUl68gl0bspZvvru0CFeBx5YvDxB/xb2ax14ZghSBarl6DajMQRrAG4/LdYJz4UmHtb7j
        iHOxDh1tcESJBiCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id EF25CA3B85;
        Wed, 28 Jul 2021 13:20:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B6C641E1321; Wed, 28 Jul 2021 15:20:44 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:20:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] filesystems/locking: fix Malformed table warning
Message-ID: <20210728132044.GH29619@quack2.suse.cz>
References: <20210727232212.12510-1-rdunlap@infradead.org>
 <20210728000409.GE559142@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728000409.GE559142@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-07-21 17:04:09, Darrick J. Wong wrote:
> On Tue, Jul 27, 2021 at 04:22:12PM -0700, Randy Dunlap wrote:
> > Update the bottom border to be the same as the top border.
> > 
> > Documentation/filesystems/locking.rst:274: WARNING: Malformed table.
> > Bottom/header table border does not match top border.
> > 
> > Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-fsdevel@vger.kernel.org
> 
> Looks ugly but probably correct
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks for the fix and for review! I've added the patch to my branch with
hole punch fixes.

								Honza
> > ---
> >  Documentation/filesystems/locking.rst |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linext-20210727.orig/Documentation/filesystems/locking.rst
> > +++ linext-20210727/Documentation/filesystems/locking.rst
> > @@ -295,7 +295,7 @@ is_partially_uptodate:	yes
> >  error_remove_page:	yes
> >  swap_activate:		no
> >  swap_deactivate:	no
> > -======================	======================== =========
> > +======================	======================== =========	===============
> >  
> >  ->write_begin(), ->write_end() and ->readpage() may be called from
> >  the request handler (/dev/loop).
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
