Return-Path: <linux-fsdevel+bounces-8585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D83839201
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16A1283A0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB08604BC;
	Tue, 23 Jan 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT+M63By"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C14604B4;
	Tue, 23 Jan 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022207; cv=none; b=smo7uUoxnfhU9ZOeEu/1k5zZW2V2UGGVRdiB/tP6oQ1Swg/9Hk2J3HK0C8fEt5ABo5Po89UXzzQFNqcmQy021PQc3b8+Oo2pwYfHKn/lOFvpOi2Po1YtQbVYUpmxn58EVErL/yflXQBxCAn7Z7yO2EyVxEyixlwPYcAhW/YQN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022207; c=relaxed/simple;
	bh=q1ehO0VlSRjlEkZix2Yv8UwXgVbsdNerufMonTt1Rvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tclm3PQBJ+ZrKMw+OQGz/I6oZ7NE/05hp0Lc4mix8MNGJES2hU9ov0AjbAaMKOMmtS33ubcS7ozWeEWQFjQASJ21amqPEKGEza6DfvF3zoxeRlLNP3b+ugUvdprzlBhePslWHbOk3UlYmj0llqFTP7UJLDWfzR24PeOdipjTY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT+M63By; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA8EC433F1;
	Tue, 23 Jan 2024 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022207;
	bh=q1ehO0VlSRjlEkZix2Yv8UwXgVbsdNerufMonTt1Rvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NT+M63By3JOLNSB6AfRX73VOAsajcGYOLYmUwI6BJW9eea/qDVp8ui4HATBCbLqta
	 aJQRALleSXScyEPXdbsBTanNjgZhs5cuisIvevP5qQSUpcJMMvxkf5B1QIdLZrx7sn
	 dhwfse1OScXIKVs1lftoY+0nBQuSgIuJX/0pusRP9AfbsTwOWd8h9S2PB0/FYX4yLu
	 qPqYiuCqQSUwKWgbhwu7L+RW3btUfwvRYmIwNtTw1dnRXIrCsaTFVOeCpzVxZE665K
	 xPr1coTGmxKiax9/xI02gl6qO/vbiH9Z8bjog6KaunCNC0RlXaVp87Q9mb8c3l0amc
	 5MpTdGsFq5EjQ==
Date: Tue, 23 Jan 2024 16:03:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] netfs, afs, cifs, cachefiles, erofs: Miscellaneous
 fixes
Message-ID: <20240123-malheur-fahrrad-9d7c2ce2e757@brauner>
References: <20240122123845.3822570-1-dhowells@redhat.com>
 <20240122-bezwingen-kanister-b56f5bc1bc84@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122-bezwingen-kanister-b56f5bc1bc84@brauner>

On Mon, Jan 22, 2024 at 04:18:08PM +0100, Christian Brauner wrote:
> On Mon, Jan 22, 2024 at 12:38:33PM +0000, David Howells wrote:
> > Hi Christian,
> > 
> > Here are some miscellaneous fixes for netfslib and a number of filesystems:
> > 
> >  (1) Replace folio_index() with folio->index in netfs, afs and cifs.
> > 
> >  (2) Fix an oops in fscache_put_cache().
> > 
> >  (3) Fix error handling in netfs_perform_write().
> > 
> >  (4) Fix an oops in cachefiles when not using erofs ondemand mode.
> > 
> >  (5) In afs, hide silly-rename files from getdents() to avoid problems with
> >      tar and suchlike.
> > 
> >  (6) In afs, fix error handling in lookup with a bulk status fetch.
> > 
> >  (7) In afs, afs_dynroot_d_revalidate() is redundant, so remove it.
> > 
> >  (8) In afs, fix the RCU unlocking in afs_proc_addr_prefs_show().
> > 
> > The patches can also be found here:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes
> 
> Thank you! I can pull this in right and will send a pr together with the
> other changes around Wednesday/Thursday for -rc2. So reviews before that
> would be nice.

Pulled and pushed:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

Timeline still the same.

