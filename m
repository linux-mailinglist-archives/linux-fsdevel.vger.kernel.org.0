Return-Path: <linux-fsdevel+bounces-4775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0562803705
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00441C20BD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374A28E08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621D83
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 06:02:12 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4220C227A8E; Mon,  4 Dec 2023 15:02:06 +0100 (CET)
Date: Mon, 4 Dec 2023 15:02:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fs: use do_splice_direct() for nfsd/ksmbd
 server-side-copy
Message-ID: <20231204140205.GA27396@lst.de>
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-4-amir73il@gmail.com> <20231204083952.GD32438@lst.de> <CAOQ4uxgUiC+TW9aCArHvvC3ODKGBoaTyM22pspdYsEaauP_ofg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgUiC+TW9aCArHvvC3ODKGBoaTyM22pspdYsEaauP_ofg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 04, 2023 at 03:19:26PM +0200, Amir Goldstein wrote:
> I tried very hard in this series to add a little bit of consistency
> for function names and indication of what it may be responsible for.
> 
> After this cleanup series, many of the file permission hooks and
> moved from do_XXX() helpers to vfs_XXX() helpers, so I cannot in
> good conscience rename do_splice_direct(), which does not have
> file permission hooks to vfs_splice_direct().
> 
> I can rename it to splice_direct() as several other splice_XXX()
> exported helpers in this file.

Let's keep the name for now.  do_ prefixes are not great, especially
for exported functions, but no prefix at all isn't great either.
So let's get your work done and then we can look into introducing
a consistent naming scheme eventually.


