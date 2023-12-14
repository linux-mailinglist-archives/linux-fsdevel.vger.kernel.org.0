Return-Path: <linux-fsdevel+bounces-6085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD478135DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B76281AB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CEC5F1E4;
	Thu, 14 Dec 2023 16:12:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F8310E;
	Thu, 14 Dec 2023 08:12:27 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F71968AFE; Thu, 14 Dec 2023 17:12:23 +0100 (CET)
Date: Thu, 14 Dec 2023 17:12:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	jaswin@linux.ibm.com, bvanassche@acm.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <20231214161223.GA12810@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212110844.19698-2-john.g.garry@oracle.com> <ZXkIEnQld577uHqu@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXkIEnQld577uHqu@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 13, 2023 at 09:25:38AM +0800, Ming Lei wrote:

<full quote deleted, please only quote what is relevant.


> >  	lim->dma_alignment = 511;
> > +	lim->atomic_write_unit_min_sectors = 0;
> > +	lim->atomic_write_unit_max_sectors = 0;
> > +	lim->atomic_write_max_sectors = 0;
> > +	lim->atomic_write_boundary_sectors = 0;
> 
> Can we move the four into single structure and setup them in single
> API? Then cross-validation can be done in this API.

Please don't be arbitrarily different from all the other limits.  What
we really should be doing is an API that updates all limits at the
same time, and I actually have code for that, I'll just need to finish
it.  I do not want to block this series for it, though.


