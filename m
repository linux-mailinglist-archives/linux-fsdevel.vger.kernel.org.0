Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DAE445888
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 18:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhKDRil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 13:38:41 -0400
Received: from verein.lst.de ([213.95.11.211]:36185 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhKDRij (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:38:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACAA76732D; Thu,  4 Nov 2021 18:35:59 +0100 (CET)
Date:   Thu, 4 Nov 2021 18:35:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Eric Sandeen <sandeen@sandeen.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211104173559.GB31740@lst.de>
References: <20211018044054.1779424-1-hch@lst.de> <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net> <20211104081740.GA23111@lst.de> <20211104173417.GJ2237511@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104173417.GJ2237511@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 10:34:17AM -0700, Darrick J. Wong wrote:
> /me wonders, are block devices going away?  Will mkfs.xfs have to learn
> how to talk to certain chardevs?  I guess jffs2 and others already do
> that kind of thing... but I suppose I can wait for the real draft to
> show up to ramble further. ;)

Right now I've mostly been looking into the kernel side.  An no, I
do not expect /dev/pmem* to go away as you'll still need it for a
not DAX aware file system and/or application (such as mkfs initially).

But yes, just pointing mkfs to the chardev should be doable with very
little work.  We can point it to a regular file after all.
