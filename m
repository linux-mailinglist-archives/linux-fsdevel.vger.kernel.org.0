Return-Path: <linux-fsdevel+bounces-3932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5347FA17C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5514F281776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478B73034E;
	Mon, 27 Nov 2023 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B91BB;
	Mon, 27 Nov 2023 05:54:06 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D308567373; Mon, 27 Nov 2023 14:54:02 +0100 (CET)
Date: Mon, 27 Nov 2023 14:54:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/13] iomap: move the iomap_sector sector calculation
 out of iomap_add_to_ioend
Message-ID: <20231127135402.GA23928@lst.de>
References: <20231126124720.1249310-9-hch@lst.de> <87plzvr05y.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plzvr05y.fsf@doe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 03:24:49PM +0530, Ritesh Harjani wrote:
> >  static bool
> > -iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
> > -		sector_t sector)
> > +iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset)
> 
> Not sure which style you would like to keep in fs/iomap/.
> Should the function name be in the same line as "static bool" or in the next line?
> For previous function you made the function name definition in the same
> line. Or is the naming style irrelevant for fs/iomap/?

The XFS style that iomap start out with has the separate line, and I
actually kinda like it.  But I think willy convinced us a while ago to
move the common line which is the normal kernel style, and most new code
seems to use this.  And yes, I should probably be consistent and I
should change it here as well.


