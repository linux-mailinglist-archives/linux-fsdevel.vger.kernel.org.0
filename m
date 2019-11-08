Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541AEF44B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 11:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfKHKho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 05:37:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:55102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbfKHKho (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:37:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48E3DB273;
        Fri,  8 Nov 2019 10:37:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 12F0B1E4331; Fri,  8 Nov 2019 11:37:42 +0100 (CET)
Date:   Fri, 8 Nov 2019 11:37:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: Deprecated mandatory file locking
Message-ID: <20191108103742.GG20863@quack2.suse.cz>
References: <20190814173345.GB10843@quack2.suse.cz>
 <20190814174604.GC10843@quack2.suse.cz>
 <01b6620186a18b167ca1bab1fadb2dbaffdd8379.camel@kernel.org>
 <20190816153149.GD3041@quack2.suse.cz>
 <20191107161514.GA21965@quack2.suse.cz>
 <e9c46777ec0aaca768681eb144823f19185d9fa0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c46777ec0aaca768681eb144823f19185d9fa0.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-11-19 13:34:21, Jeff Layton wrote:
> On Thu, 2019-11-07 at 17:15 +0100, Jan Kara wrote:
> > Hi Jeff,
> > 
> > On Fri 16-08-19 17:31:49, Jan Kara wrote:
> > > On Thu 15-08-19 15:18:45, Jeff Layton wrote:
> > > > On Wed, 2019-08-14 at 19:46 +0200, Jan Kara wrote:
> > > > > Resending to proper Jeff's address...
> > > > > 
> > > > > On Wed 14-08-19 19:33:45, Jan Kara wrote:
> > > > > > Hello Jeff,
> > > > > > 
> > > > > > we've got a report from user
> > > > > > (https://bugzilla.suse.com/show_bug.cgi?id=1145007) wondering why his fstab
> > > > > > entry (for root filesystem!) using 'mand' mount option stopped working.
> > > > > > Now I understand your rationale in 9e8925b67a "locks: Allow disabling
> > > > > > mandatory locking at compile time" but I guess there's some work to do wrt
> > > > > > documentation. At least mount(8) manpage could mention that mandatory
> > > > > > locking is broken and may be disabled referencing the rationale in fcntl
> > > > > > manpage? Or the kernel could mention something in the log about failing
> > > > > > mount because of 'mand' mount option?  What do you think? Because it took
> > > > > > me some code searching to understand why the mount is actually failing
> > > > > > which we can hardly expect from a normal sysadmin...
> > > > > > 
> > > > > > 								Honza
> > > > 
> > > > Wow, I think this is the first actual user fallout we've ever had from
> > > > that change! Why was he setting that option? Does he actually use
> > > > mandatory locking?
> > > 
> > > Yeah, reportedly they had an application that required mandatory locking.
> > > But they don't use it anymore so they just removed the mount option.
> > > 
> > > > I think a pr_notice() or pr_warn() at mount time when someone tries to
> > > > use it sounds like a very reasonable thing to do. Perhaps we can just
> > > > stick one in may_mandlock()?
> > > 
> > > Yeah, sounds reasonable to me.
> > > 
> > > > I'll draft up a patch, and also update
> > > > Documentation/filesystems/mandatory-locking.txt with the current
> > > > situation.
> > > 
> > > Thanks!
> > 
> > Did you ever get to this?
> > 
> > 								Honza
> 
> Yes. It went into v5.4-rc1. You even reviewed it! ;)

Bah ;) I completely forgot and somehow didn't realize the section 7. in
Documentation/filesystems/mandatory-locking.txt is describing what I
wanted when I looked at it yesterday. Sorry for the noise!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
