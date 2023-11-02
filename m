Return-Path: <linux-fsdevel+bounces-1780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE27B7DE9E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 02:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88648B21176
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887B110A;
	Thu,  2 Nov 2023 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uhT0YA0o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7910F6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 01:09:59 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747CC138
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 18:09:55 -0700 (PDT)
Date: Wed, 1 Nov 2023 21:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698887393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hvc87rLyNSuk6U47xv+ZrAEvJPwfJlWofcSTDHhl/cc=;
	b=uhT0YA0oJvl2v+shgvGl5NJKYfiqpHKRvoNoTvXm45MDRu2GouriFBC3ltFiriatDH7mOZ
	NpDOUF00eA4q0YmeE7qF+dCLnxmn1GhC2/OfuxOP06K8OZ8CmTRTZR0p6D+wBYpaJEcxl3
	0ZFHVLBAWihfsdWyIb2bneqz4H/krcg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 1/7] bcachefs: Convert to bdev_open_by_path()
Message-ID: <20231102010950.no2byim4ttu6csmy@moria.home.lan>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101174325.10596-1-jack@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 01, 2023 at 06:43:06PM +0100, Jan Kara wrote:
> Convert bcachefs to use bdev_open_by_path() and pass the handle around.
> 
> CC: Kent Overstreet <kent.overstreet@linux.dev>
> CC: Brian Foster <bfoster@redhat.com>
> CC: linux-bcachefs@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

