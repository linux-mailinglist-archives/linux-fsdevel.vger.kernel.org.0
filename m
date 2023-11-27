Return-Path: <linux-fsdevel+bounces-3913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FE07F9B6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 09:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B398B20B74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 08:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27A111B4;
	Mon, 27 Nov 2023 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47DA138;
	Mon, 27 Nov 2023 00:13:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F18AA67373; Mon, 27 Nov 2023 09:13:43 +0100 (CET)
Date: Mon, 27 Nov 2023 09:13:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/13] iomap: clean up the iomap_new_ioend calling
 convention
Message-ID: <20231127081343.GA30160@lst.de>
References: <20231126124720.1249310-8-hch@lst.de> <87ttp7r68u.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttp7r68u.fsf@doe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 01:13:29PM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Switch to the same argument order as iomap_writepage_map and remove the
> > ifs argument that can be trivially recalculated.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/buffered-io.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> Straight forward change. Looks good to me. Please feel free to add - 

Also the subject should be changed now that I'm reading your reply.
I dropped the rename of this function that I had in earlier versions.

