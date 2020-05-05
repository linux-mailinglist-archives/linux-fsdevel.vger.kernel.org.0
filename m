Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B9F1C5383
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgEEKoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:44:17 -0400
Received: from verein.lst.de ([213.95.11.211]:34604 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEEKoR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:44:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F60368C4E; Tue,  5 May 2020 12:44:14 +0200 (CEST)
Date:   Tue, 5 May 2020 12:44:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 10/11] fs: remove the access_ok() check in ioctl_fiemap
Message-ID: <20200505104414.GD15815@lst.de>
References: <20200427181957.1606257-1-hch@lst.de> <20200427181957.1606257-11-hch@lst.de> <20200428152124.GL6741@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428152124.GL6741@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 08:21:24AM -0700, Darrick J. Wong wrote:
> On Mon, Apr 27, 2020 at 08:19:56PM +0200, Christoph Hellwig wrote:
> > access_ok just checks we are fed a proper user pointer.  We also do that
> > in copy_to_user itself, so no need to do this early.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Hmm.  It's a minor behavioral change that we no longer require the
> entire extent array to be accessible at the start even if parts of it
> would never have gotten accessed, but I don't think that matters, so:

Note that access_ok only checks if the memory actually is in userspace,
so they only thing seeing a behavior difference would be an exploit of
some kind.
