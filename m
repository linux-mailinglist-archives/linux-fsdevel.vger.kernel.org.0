Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678841D91A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 10:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgESIFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 04:05:03 -0400
Received: from verein.lst.de ([213.95.11.211]:42862 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgESIFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 04:05:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 789C768B05; Tue, 19 May 2020 10:04:59 +0200 (CEST)
Date:   Tue, 19 May 2020 10:04:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fix fiemap for ext4 bitmap files (+ cleanups) v3
Message-ID: <20200519080459.GA26074@lst.de>
References: <20200505154324.3226743-1-hch@lst.de> <20200507062419.GA5766@lst.de> <20200507144947.GJ404484@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507144947.GJ404484@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 10:49:47AM -0400, Theodore Y. Ts'o wrote:
> > Folks, I think the first two patches should go into 5.7 to fix the
> > ext4 vs overlay problem.  Ted, are you going to pick this up, or Al?
> 
> I'll pick up the two fixes, thanks.  Which tree are the rest of the
> patches going to go through?

When are you going to send the first two to Linus?  This fixes a 5.7
regression and I'd like to see it fixed before the release, nevermind
have the rest of the series queued up for 5.8 one way or another.
