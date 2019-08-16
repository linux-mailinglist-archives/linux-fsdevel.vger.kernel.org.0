Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7E904B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfHPPbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 11:31:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727352AbfHPPbw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:31:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55429AF90;
        Fri, 16 Aug 2019 15:31:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 892F91E4009; Fri, 16 Aug 2019 17:31:49 +0200 (CEST)
Date:   Fri, 16 Aug 2019 17:31:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: Deprecated mandatory file locking
Message-ID: <20190816153149.GD3041@quack2.suse.cz>
References: <20190814173345.GB10843@quack2.suse.cz>
 <20190814174604.GC10843@quack2.suse.cz>
 <01b6620186a18b167ca1bab1fadb2dbaffdd8379.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b6620186a18b167ca1bab1fadb2dbaffdd8379.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-08-19 15:18:45, Jeff Layton wrote:
> On Wed, 2019-08-14 at 19:46 +0200, Jan Kara wrote:
> > Resending to proper Jeff's address...
> > 
> > On Wed 14-08-19 19:33:45, Jan Kara wrote:
> > > Hello Jeff,
> > > 
> > > we've got a report from user
> > > (https://bugzilla.suse.com/show_bug.cgi?id=1145007) wondering why his fstab
> > > entry (for root filesystem!) using 'mand' mount option stopped working.
> > > Now I understand your rationale in 9e8925b67a "locks: Allow disabling
> > > mandatory locking at compile time" but I guess there's some work to do wrt
> > > documentation. At least mount(8) manpage could mention that mandatory
> > > locking is broken and may be disabled referencing the rationale in fcntl
> > > manpage? Or the kernel could mention something in the log about failing
> > > mount because of 'mand' mount option?  What do you think? Because it took
> > > me some code searching to understand why the mount is actually failing
> > > which we can hardly expect from a normal sysadmin...
> > > 
> > > 								Honza
> 
> Wow, I think this is the first actual user fallout we've ever had from
> that change! Why was he setting that option? Does he actually use
> mandatory locking?

Yeah, reportedly they had an application that required mandatory locking.
But they don't use it anymore so they just removed the mount option.

> I think a pr_notice() or pr_warn() at mount time when someone tries to
> use it sounds like a very reasonable thing to do. Perhaps we can just
> stick one in may_mandlock()?

Yeah, sounds reasonable to me.

> I'll draft up a patch, and also update
> Documentation/filesystems/mandatory-locking.txt with the current
> situation.

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
