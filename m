Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB9154662
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBFOnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 09:43:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:54532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgBFOnk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:43:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1614AC44;
        Thu,  6 Feb 2020 14:43:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5E4861E0DEB; Thu,  6 Feb 2020 15:43:38 +0100 (CET)
Date:   Thu, 6 Feb 2020 15:43:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, dan.j.williams@intel.com,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        willy@infradead.org
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
Message-ID: <20200206144338.GB26114@quack2.suse.cz>
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
 <20200206084740.GE14001@quack2.suse.cz>
 <x49tv43lr98.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49tv43lr98.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-02-20 09:33:39, Jeff Moyer wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Wed 05-02-20 14:15:58, Jeff Moyer wrote:
> >> fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
> >> dax".  The reason is that the initial pwrite to an empty file with the
> >> RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
> >> dax_iomap_rw doesn't pass that flag through to iomap_apply.
> >> 
> >> With this patch applied, generic/471 passes for me.
> >> 
> >> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> >
> > The patch looks good to me. You can add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > BTW, I've just noticed ext4 seems to be buggy in this regard and even this
> > patch doesn't fix it. So I guess you've been using XFS for testing this?
> 
> That's right, sorry I didn't mention that.  Will you send a patch for
> ext4, or do you want me to look into it?

I've taken down a note in todo list to eventually look into that but if you
can have a look, I'm more than happy to remove that entry :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
