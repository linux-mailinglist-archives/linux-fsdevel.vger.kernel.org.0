Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F342FE76F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 23:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKOWK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 17:10:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41290 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfKOWK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:10:58 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVjnZ-0008GP-F9; Fri, 15 Nov 2019 22:10:37 +0000
Date:   Fri, 15 Nov 2019 22:10:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [RFC] simple_recursive_removal()
Message-ID: <20191115221037.GW26530@ZenIV.linux.org.uk>
References: <20191115131625.GO26530@ZenIV.linux.org.uk>
 <20191115083813.65f5523c@gandalf.local.home>
 <20191115134823.GQ26530@ZenIV.linux.org.uk>
 <20191115085805.008870cb@gandalf.local.home>
 <20191115141754.GR26530@ZenIV.linux.org.uk>
 <20191115175423.GS26530@ZenIV.linux.org.uk>
 <20191115184209.GT26530@ZenIV.linux.org.uk>
 <20191115194138.GU26530@ZenIV.linux.org.uk>
 <20191115211820.GV26530@ZenIV.linux.org.uk>
 <20191115162609.2d26d498@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115162609.2d26d498@gandalf.local.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 04:26:09PM -0500, Steven Rostedt wrote:
> On Fri, 15 Nov 2019 21:18:20 +0000
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > OK... debugfs and tracefs definitely convert to that; so do, AFAICS,
> > spufs and selinuxfs, and I wouldn't be surprised if it could be
> > used in a few more places...  securityfs, almost certainly qibfs,
> > gadgetfs looks like it could make use of that.  Maybe subrpc
> > as well, but I'll need to look in details.  configfs won't,
> > unfortunately...
> 
> Thanks Al for looking into this.
> 
> I'll try to test it in tracefs, and see if anything breaks. But
> probably wont get to it till next week.

I'll probably throw that into #next.dcache - if nothing else,
that cuts down on the size of patch converting d_subdirs/d_child
from list to hlist...

Need to get some sleep first, though - only 5 hours today, so
I want to take another look at that thing tomorrow morning -
I don't trust my ability to spot obvious bugs right now... ;-/

Oh, well - that at least might finally push the old "kernel-side
rm -rf done right" pile of half-baked patches into more useful
state, probably superseding most of them.
