Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C381D1989
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgEMPfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 11:35:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:52082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389255AbgEMPfc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 11:35:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA8F4AC7F;
        Wed, 13 May 2020 15:35:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 646381E12AE; Wed, 13 May 2020 17:35:30 +0200 (CEST)
Date:   Wed, 13 May 2020 17:35:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Fabian Frederick <fabf@skynet.be>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 0/6 linux-next] fs/notify: cleanup
Message-ID: <20200513153530.GA9569@quack2.suse.cz>
References: <20200512181608.405682-1-fabf@skynet.be>
 <CAOQ4uxgr7gXBEYPDSPS+ga0+dXY_xDtae_ZQqg5_Bed3PtJMZA@mail.gmail.com>
 <20200513110817.GC27709@quack2.suse.cz>
 <CAOQ4uxiUXgW7HyMaHoqFH6kZnrTPNd=Rgfj6duO8aKc87mhCCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiUXgW7HyMaHoqFH6kZnrTPNd=Rgfj6duO8aKc87mhCCw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-05-20 14:10:54, Amir Goldstein wrote:
> On Wed, May 13, 2020 at 2:08 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 12-05-20 21:32:10, Amir Goldstein wrote:
> > > On Tue, May 12, 2020 at 9:16 PM Fabian Frederick <fabf@skynet.be> wrote:
> > > >
> > > > This small patchset does some cleanup in fs/notify branch
> > > > especially in fanotify.
> > >
> > > Patches look fine to me.
> > > I would just change the subject of patches from notify: to fsnotify:.
> > > The patch "explicit shutdown initialization" is border line unneeded
> > > and its subject is not very descriptive.
> > > Let's wait and see what Jan has to say before you post another round.
> >
> > Yeah, I think patch 2 doesn't make sence but the rest looks good. Can I add
> > your Reviewed-by Amir when merging them?
> 
> Yes.

Thanks. Fabian, I've merged the cleanups to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
