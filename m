Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB6A521C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfIBIqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 04:46:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:43326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729524AbfIBIqj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:46:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AC9BB674;
        Mon,  2 Sep 2019 08:46:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1EAC21E406C; Mon,  2 Sep 2019 10:46:34 +0200 (CEST)
Date:   Mon, 2 Sep 2019 10:46:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 04/10] tracefs: call fsnotify_{unlink,rmdir}() hooks
Message-ID: <20190902084634.GB14207@quack2.suse.cz>
References: <20190526143411.11244-1-amir73il@gmail.com>
 <20190526143411.11244-5-amir73il@gmail.com>
 <CAOQ4uxg5e4zJ+GVCXs1X55TTBdNKHVASkA1Q-Xz_pyLnD8UDpA@mail.gmail.com>
 <20190830154804.1f51bf89@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830154804.1f51bf89@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 30-08-19 15:48:04, Steven Rostedt wrote:
> On Thu, 13 Jun 2019 19:53:25 +0300
> Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > On Sun, May 26, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > This will allow generating fsnotify delete events after the
> > > fsnotify_nameremove() hook is removed from d_delete().
> > >
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>  
> > 
> > Hi Steven,
> > 
> > Would you be able to provide an ACK on this patch?
> > We need to add those explicit fsnotify hooks to match the existing
> > fsnotify_create/mkdir hooks in tracefs, because
> > the hook embedded inside d_delete() is going away [1].
> > 
> > Thanks,
> > Amir.
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/20190526143411.11244-1-amir73il@gmail.com/
> > 
> 
> Sorry, this got lost in my INBOX. I see it was already merged, but I
> would have acked it ;-)

Thanks for the dealayed ack. I've used my best judgement and decided that
you probably would not object when pushing the patch :).
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
