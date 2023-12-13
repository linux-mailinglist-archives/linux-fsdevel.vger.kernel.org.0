Return-Path: <linux-fsdevel+bounces-5972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1B81189C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C197FB21068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48ED3306B;
	Wed, 13 Dec 2023 16:04:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C7BD;
	Wed, 13 Dec 2023 08:04:02 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDB9E68B05; Wed, 13 Dec 2023 17:03:57 +0100 (CET)
Date: Wed, 13 Dec 2023 17:03:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com,
	jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
Message-ID: <20231213160357.GA9804@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212110844.19698-5-john.g.garry@oracle.com> <20231213-gurte-beeren-e71ff21c3c03@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-gurte-beeren-e71ff21c3c03@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 13, 2023 at 02:02:31PM +0100, Christian Brauner wrote:
> >  typedef unsigned int __bitwise gfp_t;
> >  typedef unsigned int __bitwise slab_flags_t;
> > -typedef unsigned int __bitwise fmode_t;
> > +typedef unsigned long __bitwise fmode_t;
> 
> As Jan said, that's likely a bad idea. There's a bunch of places that
> assume fmode_t is 32bit. So not really a change we want to make if we
> can avoid it.

Oh well, let me dust of my series to move the fairly static flags out
of it.  But even without that do we even need to increase it?  There's
still quite a lot of space after FMODE_EXEC for example.

