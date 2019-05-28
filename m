Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345802CB14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfE1QIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:08:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbfE1QIU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:08:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A8B0AF3B;
        Tue, 28 May 2019 16:08:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A62951E3F53; Tue, 28 May 2019 18:08:18 +0200 (CEST)
Date:   Tue, 28 May 2019 18:08:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] fanotify: Disallow permission events for proc
 filesystem
Message-ID: <20190528160818.GB27155@quack2.suse.cz>
References: <20190516115619.18926-1-jack@suse.cz>
 <20190528155430.GA27155@quack2.suse.cz>
 <CAOQ4uxi7LKSxcmmbgBpLJgHZFVa56oupQRQvabL4EGM7jfp1mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7LKSxcmmbgBpLJgHZFVa56oupQRQvabL4EGM7jfp1mQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-05-19 19:02:46, Amir Goldstein wrote:
> On Tue, May 28, 2019 at 6:54 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 16-05-19 13:56:19, Jan Kara wrote:
> > > Proc filesystem has special locking rules for various files. Thus
> > > fanotify which opens files on event delivery can easily deadlock
> > > against another process that waits for fanotify permission event to be
> > > handled. Since permission events on /proc have doubtful value anyway,
> > > just disallow them.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/20190320131642.GE9485@quack2.suse.cz/
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> >
> > Amir, ping? What do you think about this version of the patch?
> 
> Sorry, I reviewed but forgot to reply.
> You may add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks! I'll push it to my tree for the next merge window then.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
