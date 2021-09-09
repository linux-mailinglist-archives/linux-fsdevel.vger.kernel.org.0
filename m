Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A579405DB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 21:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbhIITuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 15:50:15 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:50698 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343904AbhIITuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:50:14 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOQ0b-002gdC-UW; Thu, 09 Sep 2021 19:46:54 +0000
Date:   Thu, 9 Sep 2021 19:46:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] gfs2 setattr patches
Message-ID: <YTpkrfaCF8aTRIon@zeniv-ca.linux.org.uk>
References: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
 <CAHk-=wjOch3=4Nh4tmiAO9UYJZVEeO0UUq8Hegh3JK+pnM9Upg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjOch3=4Nh4tmiAO9UYJZVEeO0UUq8Hegh3JK+pnM9Upg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:41:33PM -0700, Linus Torvalds wrote:
> On Wed, Sep 8, 2021 at 9:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.gfs2
> >
> > for you to fetch changes up to d75b9fa053e4cd278281386d860c26fdbfbe9d03:
> >
> >   gfs2: Switch to may_setattr in gfs2_setattr (2021-08-13 00:41:05 -0400)
> 
> Explanation for what this series actually does?
> 
> I can see the shortlog, I can look at the commits, but I really want a
> summary in the pull request.

Basically, gfs2 has redo the permission checks after it grabs a cluster lock,
and they want to have that doable by call of shared helper, rather than
open-coding those checks.  Looks reasonable to me...
