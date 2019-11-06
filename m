Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D11F0B55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 01:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfKFA7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 19:59:32 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56570 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728810AbfKFA7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:59:32 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA60xLbU019786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Nov 2019 19:59:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 31551420311; Tue,  5 Nov 2019 19:59:19 -0500 (EST)
Date:   Tue, 5 Nov 2019 19:59:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v7 11/11] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191106005919.GE26959@mit.edu>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <e55db6f12ae6ff017f36774135e79f3e7b0333da.1572949325.git.mbobrowski@mbobrowski.org>
 <20191105135932.GN22379@quack2.suse.cz>
 <20191105203158.GA1739@bobrowski>
 <20191105205303.GA26959@mit.edu>
 <20191105210043.GC1739@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105210043.GC1739@bobrowski>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 08:00:44AM +1100, Matthew Bobrowski wrote:
> On Tue, Nov 05, 2019 at 03:53:03PM -0500, Theodore Y. Ts'o wrote:
> > On Wed, Nov 06, 2019 at 07:32:00AM +1100, Matthew Bobrowski wrote:
> > > > Otherwise you would write out and invalidate too much AFAICT - the 'offset'
> > > > is position just before we fall back to buffered IO. Otherwise this hunk
> > > > looks good to me.
> > > 
> > > Er, yes. That's right, it should rather be 'err' instead or else we
> > > would write/invalidate too much. I actually had this originally, but I
> > > must've muddled it up while rewriting this patch on my other computer.
> > > 
> > > Thanks for picking that up!
> > 
> > I can fix that up in my tree, unless there are any other changes that
> > we need to make.
> 
> If you could, that would be super awesome as I don't really see
> anything else changing in this series. I'll probably send through some
> minor optimisations/refactoring cleanups after this series lands, but
> that can come at a later point.

Done.  I've just pushed out the ext4.git tree, with both the master
branch (which should never rewind) and the dev branch (which can
rewind) advanced to include this patch series.

Many thanks for your work on this patch series!

     	    	     	     	  	- Ted
