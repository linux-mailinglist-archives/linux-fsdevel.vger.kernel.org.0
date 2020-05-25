Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1671E074B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbgEYGwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 02:52:37 -0400
Received: from verein.lst.de ([213.95.11.211]:39448 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGwh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 02:52:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8BF7968C4E; Mon, 25 May 2020 08:52:34 +0200 (CEST)
Date:   Mon, 25 May 2020 08:52:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-ext4@vger.kernel.org, jack@suse.cz, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: fiemap cleanups v4
Message-ID: <20200525065234.GB25599@lst.de>
References: <20200523073016.2944131-1-hch@lst.de> <20200523155216.GZ23230@ZenIV.linux.org.uk> <20200524191713.GA228632@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524191713.GA228632@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 24, 2020 at 03:17:13PM -0400, Theodore Y. Ts'o wrote:
> > Hmmm...  I can do an immutable shared branch, no problem.  What would
> > you prefer for a branchpoint for that one?
> 
> I thought we had already agreed to run these patches through the ext4
> git tree, since most of the changes affect the ext4 tree (and there
> aren't any other iomap fiemap changes pending as far as I know).
> 
> The v3 versions of these patches have been part of the ext4 dev tree
> since May 19th.  Since the ext4 dev tree is rewinding, I can easily
> update it fiemap-fixes patch to be on top of the first two patches
> which Linus has already accepted, and then merge it into the ext4 dev
> branch.

I think we're all fine and set, unless Al really needs a shared
branch.  Based on what is in linux-next and out on the lists I don't
see any real need, though.
