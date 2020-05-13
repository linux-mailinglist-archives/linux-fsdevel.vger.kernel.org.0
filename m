Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9471D10A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgEMLIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 07:08:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:49918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgEMLIS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 07:08:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33FF9AC44;
        Wed, 13 May 2020 11:08:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 075231E12AE; Wed, 13 May 2020 13:08:17 +0200 (CEST)
Date:   Wed, 13 May 2020 13:08:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Fabian Frederick <fabf@skynet.be>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 0/6 linux-next] fs/notify: cleanup
Message-ID: <20200513110817.GC27709@quack2.suse.cz>
References: <20200512181608.405682-1-fabf@skynet.be>
 <CAOQ4uxgr7gXBEYPDSPS+ga0+dXY_xDtae_ZQqg5_Bed3PtJMZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgr7gXBEYPDSPS+ga0+dXY_xDtae_ZQqg5_Bed3PtJMZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-05-20 21:32:10, Amir Goldstein wrote:
> On Tue, May 12, 2020 at 9:16 PM Fabian Frederick <fabf@skynet.be> wrote:
> >
> > This small patchset does some cleanup in fs/notify branch
> > especially in fanotify.
> 
> Patches look fine to me.
> I would just change the subject of patches from notify: to fsnotify:.
> The patch "explicit shutdown initialization" is border line unneeded
> and its subject is not very descriptive.
> Let's wait and see what Jan has to say before you post another round.

Yeah, I think patch 2 doesn't make sence but the rest looks good. Can I add
your Reviewed-by Amir when merging them?

								Honza

> > V2:
> > Apply Amir Goldstein suggestions:
> > -Remove patch 2, 7 and 9
> > -Patch "fanotify: don't write with zero size" ->
> > "fanotify: don't write with size under sizeof(response)"
> >
> > Fabian Frederick (6):
> >   fanotify: prefix should_merge()
> >   notify: explicit shutdown initialization
> >   notify: add mutex destroy
> >   fanotify: remove reference to fill_event_metadata()
> >   fsnotify/fdinfo: remove proc_fs.h inclusion
> >   fanotify: don't write with size under sizeof(response)
> >
> >  fs/notify/fanotify/fanotify.c      | 4 ++--
> >  fs/notify/fanotify/fanotify_user.c | 8 +++++---
> >  fs/notify/fdinfo.c                 | 1 -
> >  fs/notify/group.c                  | 2 ++
> >  4 files changed, 9 insertions(+), 6 deletions(-)
> >
> > --
> > 2.26.2
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
