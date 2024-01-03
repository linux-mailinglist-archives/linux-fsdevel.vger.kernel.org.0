Return-Path: <linux-fsdevel+bounces-7252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472B8235BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F51B287504
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3129B1D528;
	Wed,  3 Jan 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="VSrUyOj1";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="LWwj+WDn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D391CF81;
	Wed,  3 Jan 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 82E5BC029; Wed,  3 Jan 2024 20:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704310975; bh=vmsIH42o366lLCEtX1AOBPqwGBCA85i22kuEmfl/pd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSrUyOj1qK/l/eFf/XzNdKkgcBSVhkVUlfm+O8VfUWxl5YGw1O98A0g/8wm0CJiFs
	 qi6JHNWLaTGaPp14YTfeCaQXkH5+RL6bwNXFjCQsyvFb+cw1VQF1qA3//JvTx8sBZO
	 s6GviFkWCB2OvJsDDnDGnv64iBDIEyaBPSCGtlXKt2OrlUk54XnleIYyGtaTQwh8dg
	 ANr3qLQlJnI+UTvy7nPUOA03QkZ+ntbCkZUufI/u591ZPQJhwXuYv9pBxyE3ivykpG
	 eHaGxGSSdjeNhqzwuKDW0iDIGpwt4kdtqaxn4f4lh6BtlWSBpUxAcAfMG5Epms5Zyu
	 wNeVtF6txco2Q==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id C491EC009;
	Wed,  3 Jan 2024 20:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704310974; bh=vmsIH42o366lLCEtX1AOBPqwGBCA85i22kuEmfl/pd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWwj+WDnHlGIP8EddYD3ijwsipowZRszG5+7mmCFYhPYcMYSgYc5OJWYKs/tWPFHN
	 rrohSgHE3FDw1Mz8MzqKaodyJNeoI6TPLLL1d9Q1NJ66DkBG1MToMhqviNGVurzibK
	 1v22R0jso4fpbQJhRwbvPhzlAx+wgUiIT1fhTsxbUlHcy+LZCp5AuuEDVpHZvdvm4Q
	 tz/qGu7pt38R1ENarIYiaSDSKJWDhbYJ3ITsB+lf+1WGa1O/YU+Zn72WKAxHgI36F7
	 R0VGRHPjU7EG0v4NoM3+uFtkJeOVM0NL97kSEtIGAUuzOaFEK4U+GXIQ0jdzOpRbY9
	 awVfqCK9ksGxA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id bdfe584f;
	Wed, 3 Jan 2024 19:42:39 +0000 (UTC)
Date: Thu, 4 Jan 2024 04:42:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 4/5] 9p: Always update remote_i_size in stat2inode
Message-ID: <ZZW4oEuzCx-7AYpo@codewreck.org>
References: <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-5-dhowells@redhat.com>

David Howells wrote on Wed, Jan 03, 2024 at 02:59:28PM +0000:
> Always update remote_i_size in v9fs_stat2inode*() if the size is available,
> even if we are asked not to update i_isize

Sorry -- hold on for this patch, let's drop it for now and take it more
slowly through next cycle.

I had mostly forgotten about V9FS_STAT2INODE_KEEP_ISIZE and not paying
enough attention yesterday evening, but it's not innocent -- I assume
netfs will do the right thing if we update the *remote* i_size when
there is cached data, but the inode's i_size cannot be updated as
easily.

It's hard to notice because the comment got split in 5e3cc1ee1405a7
("9p: use inode->i_lock to protect i_size_write() under 32-bit"), but
v9fs_refresh_inode* still have it:
        /*      
         * We don't want to refresh inode->i_size,
         * because we may have cached data
         */

I assume refreshing i_size at a bad time would act like a truncation
of cached memory.

(To answer the other thread's comment that v9fs_i_size_write is useless;
it's far from obvious enough but I'm afraid it is needed:
- include/linux/fs.h has a comment saying i_size_write does need locking
around it for 32bit to avoid breaking i_size_seqcount; that's still true
in today's tree.
- we could use any lock as long as it's coherent within the 9p
subsystem, but we don't need a whole mutex so i_lock it is.)
-- 
Dominique Martinet | Asmadeus

