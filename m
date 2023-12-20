Return-Path: <linux-fsdevel+bounces-6586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D94D819FC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 14:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FA3286073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7E134CD6;
	Wed, 20 Dec 2023 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXTLzOXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0652D61A;
	Wed, 20 Dec 2023 13:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69AFC433C8;
	Wed, 20 Dec 2023 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703078770;
	bh=OGDFupW/lrJ4In3Ae6A2r5TchkKyHnaqzc41395ls0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXTLzOXEK4YxbwzzbwJkVxUDiunCKJ8geO0vL45tzk2Dm59xQ+a5u/N0nI9TbepRI
	 e2lFT8vxSf5+h9gXtdmT/0tQnjzn9DqjFAxYSbXe+efImEgqdyzElr8azPk5erWORF
	 amI/iOrk0bBTZWbwHdtaU6RugKi4SasZF09nwa7nIpGBZysntJReLOZuWvIBuT8Gst
	 zlPcgklGGRT7wZ88sfiu7xGfjc2y/po+9ewYgJqJMje+0q4toXqPKHS6VcA4ji+r+x
	 SnZVNRKZSNz8P1WQcihDJD9aI2Dp4GYowWZRPDdAX1rSwMP/trbIWuZys6v0Y1P/Ld
	 PGkubzZpcx06Q==
Date: Wed, 20 Dec 2023 14:26:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/39] netfs, afs, 9p: Delegate high-level I/O to
 netfslib
Message-ID: <20231220-abgepfiffen-realisieren-5aa54fba2453@brauner>
References: <ZXxUx_nh4HNTaDJx@codewreck.org>
 <20231213152350.431591-1-dhowells@redhat.com>
 <20231215-einziehen-landen-94a63dd17637@brauner>
 <1384979.1703066666@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1384979.1703066666@warthog.procyon.org.uk>

On Wed, Dec 20, 2023 at 10:04:26AM +0000, David Howells wrote:
> Dominique Martinet <asmadeus@codewreck.org> wrote:
> 
> > I'll go back to dhowell's tree to finally test 9p a bit,
> > sorry for lack of involvement just low on time all around.
> 
> I've rebased my tree on -rc6 rather than linux-next for Christian to pull.

Pulled. Thank you, David. It's on vfs.netfs.

