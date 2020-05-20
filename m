Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE92E1DA892
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 05:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgETD2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 23:28:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54939 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726352AbgETD2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 23:28:51 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04K3Sbv3011992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 23:28:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6DE82420304; Tue, 19 May 2020 23:28:37 -0400 (EDT)
Date:   Tue, 19 May 2020 23:28:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        adilger@dilger.ca, riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fix fiemap for ext4 bitmap files (+ cleanups) v3
Message-ID: <20200520032837.GA2744481@mit.edu>
References: <20200505154324.3226743-1-hch@lst.de>
 <20200507062419.GA5766@lst.de>
 <20200507144947.GJ404484@mit.edu>
 <20200519080459.GA26074@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519080459.GA26074@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 10:04:59AM +0200, Christoph Hellwig wrote:
> On Thu, May 07, 2020 at 10:49:47AM -0400, Theodore Y. Ts'o wrote:
> > > Folks, I think the first two patches should go into 5.7 to fix the
> > > ext4 vs overlay problem.  Ted, are you going to pick this up, or Al?
> > 
> > I'll pick up the two fixes, thanks.  Which tree are the rest of the
> > patches going to go through?
> 
> When are you going to send the first two to Linus?  This fixes a 5.7
> regression and I'd like to see it fixed before the release, nevermind
> have the rest of the series queued up for 5.8 one way or another.

I'll send it to Linus this week; I just need to finish some testing
and investigate a potential regression (which is probably a flaky
test, but I just want to be sure).

      	        	    	      	 - Ted
			 
