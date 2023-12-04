Return-Path: <linux-fsdevel+bounces-4750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD1580309F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E534B20955
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C40224E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F57C9B
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 00:38:14 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E639A68AFE; Mon,  4 Dec 2023 09:38:10 +0100 (CET)
Date: Mon, 4 Dec 2023 09:38:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fs: move file_start_write() into
 direct_splice_actor()
Message-ID: <20231204083810.GB32438@lst.de>
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130141624.3338942-3-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

