Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49023A3EA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3TsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 15:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3TsH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:48:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEEC023430;
        Fri, 30 Aug 2019 19:48:05 +0000 (UTC)
Date:   Fri, 30 Aug 2019 15:48:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 04/10] tracefs: call fsnotify_{unlink,rmdir}() hooks
Message-ID: <20190830154804.1f51bf89@gandalf.local.home>
In-Reply-To: <CAOQ4uxg5e4zJ+GVCXs1X55TTBdNKHVASkA1Q-Xz_pyLnD8UDpA@mail.gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
        <20190526143411.11244-5-amir73il@gmail.com>
        <CAOQ4uxg5e4zJ+GVCXs1X55TTBdNKHVASkA1Q-Xz_pyLnD8UDpA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Jun 2019 19:53:25 +0300
Amir Goldstein <amir73il@gmail.com> wrote:

> On Sun, May 26, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > This will allow generating fsnotify delete events after the
> > fsnotify_nameremove() hook is removed from d_delete().
> >
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>  
> 
> Hi Steven,
> 
> Would you be able to provide an ACK on this patch?
> We need to add those explicit fsnotify hooks to match the existing
> fsnotify_create/mkdir hooks in tracefs, because
> the hook embedded inside d_delete() is going away [1].
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20190526143411.11244-1-amir73il@gmail.com/
> 

Sorry, this got lost in my INBOX. I see it was already merged, but I
would have acked it ;-)

-- Steve
