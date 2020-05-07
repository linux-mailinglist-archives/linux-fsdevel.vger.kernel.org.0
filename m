Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7618D1C92D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGO72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 10:59:28 -0400
Received: from verein.lst.de ([213.95.11.211]:47188 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgEGO72 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 10:59:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA04A68BFE; Thu,  7 May 2020 16:59:24 +0200 (CEST)
Date:   Thu, 7 May 2020 16:59:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: fix fiemap for ext4 bitmap files (+ cleanups) v3
Message-ID: <20200507145924.GA28854@lst.de>
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
> On Thu, May 07, 2020 at 08:24:19AM +0200, Christoph Hellwig wrote:
> > On Tue, May 05, 2020 at 05:43:13PM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > the first two patches should fix the issue where ext4 doesn't
> > > properly check the max file size for bitmap files in fiemap.
> > > 
> > > The rest cleans up the fiemap support in ext4 and in general.
> > 
> > Folks, I think the first two patches should go into 5.7 to fix the
> > ext4 vs overlay problem.  Ted, are you going to pick this up, or Al?
> 
> I'll pick up the two fixes, thanks.  Which tree are the rest of the
> patches going to go through?

vfs.git would be most logic if Al agrees.  OTOH there is a fair amount
of ext4 patches, so if you want to pick the series up I wouldn't mind
either.
