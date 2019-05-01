Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43C10468
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 06:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbfEAEAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 00:00:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56156 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfEAEAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 00:00:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLgQ2-0006Tg-M1; Wed, 01 May 2019 04:00:30 +0000
Date:   Wed, 1 May 2019 05:00:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH 0/4] vfs: update ->get_link() related documentation
Message-ID: <20190501040030.GS23075@ZenIV.linux.org.uk>
References: <20190411231630.50177-1-ebiggers@kernel.org>
 <20190422180346.GA22674@gmail.com>
 <20190501002517.GF48973@gmail.com>
 <20190501013649.GO23075@ZenIV.linux.org.uk>
 <20190430194943.4a7916be@lwn.net>
 <20190501021423.GQ23075@ZenIV.linux.org.uk>
 <20190430201741.2ffc48b2@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430201741.2ffc48b2@lwn.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 08:17:41PM -0600, Jonathan Corbet wrote:
> On Wed, 1 May 2019 03:14:23 +0100
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > I do have problems with vfs.txt approach in general and I hope we end up
> > with per object type documents; however, that's completely orthogonal to
> > format conversion.  IOW, I have no objections whatsoever to format switch
> > done first; any migration of e.g. dentry-related parts into a separate
> > document, with lifecycle explicitly documented and descriptions of
> > methods tied to that can just as well go on top of that.
> 
> OK, great.  
> 
> That said, let's hold the format conversion for 5.3 (or *maybe*
> late-merge-window 5.2).  It's a big set of patches to shovel in at this
> point, and while it's good work, it's not screamingly urgent.  My
> suggestion would be to take Eric's stuff, it shouldn't be a problem to
> adjust to it.

OK, it's in vfs.git#work.misc; will be in #for-next when I sort the
work.icache mess out...
