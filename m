Return-Path: <linux-fsdevel+bounces-78473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDLtKutIoGkuhwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:21:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F03921A6570
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BB5F3091912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE63218DD;
	Thu, 26 Feb 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGr+5vEt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="69XqZjby";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F9/qrZcg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uMdyIKIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74231A568
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111579; cv=none; b=cYGGyCOmykfW/3i6Fn8W+Rw59srvPMhfXYFm1ClNXUfxn+M4NpL8SHBd8Cw1wYu+8r2jWVYxtA6aktRIkzQoObOpkNypuU3Ldx7aYjKG0Ts/1HdmAn2nShj8JFREOBLROyEdhoHIxGiWS/zci5ybc1tr1g1qw6WEbG2mtCnwFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111579; c=relaxed/simple;
	bh=vegVhIJhcUiP5X8JHJRDRq8HeUl3UwDpwhcfSI9tT2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzObTxN1vwKKy3qGHevSSE+/FIzOhYHR7/ff+U096B0o//xQ2KLadBC5AmqDGTTX31VICkGyyyx9mjywcnosPLhXPLVapiCYV0Vp4fzDEgaEs0iPQY7X0eAr2qznPk0zip1NjMZlS04HyT0fCItr3bMcIHMQOK2v9pbISjh1VvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGr+5vEt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=69XqZjby; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F9/qrZcg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uMdyIKIf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA9EC1FA54;
	Thu, 26 Feb 2026 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772111576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=;
	b=VGr+5vEttV5KSq8KiEHuA26h/lUE7LlTpKXuEPlZT6DHY8M0THqc8Wu4WiiN1rMKTDa6OR
	5Zwq7W2zP5J9H2ZZtsgp7HFYiY7A5pTLtjNy0TniXfJ1K1ZfjtmltW1AfqY66XIH5dEDdF
	VeWG6x2cAMoVE/5vHhJrUfeSClIjrGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772111576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=;
	b=69XqZjby1BkpPQKJs37ti4jhyJiLv1OPj8pDlz96Ez+SqXyH4PTF7HJvtJR1jjG+ILIaff
	xw7ztXeG0NlBlDCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772111575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=;
	b=F9/qrZcgGN/hgxgLb3qI//qiHnxBKsB5Ntd3IGQuMTlxZWdr2ZN0mP/0xmZRIkCuKafDWW
	+xk6zJK7T/iYLhGjEM5isA7Eem1B8k1QXrKcyY15lvatrlOTH99iXwpZ6R10io+b8DM7zy
	RLtfnL1PTllGjvJOTHiKeaQnegihWz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772111575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t9pIdsXl9YcbrN7MEcIZiwr5nHNouAJ8lo4fxykwpls=;
	b=uMdyIKIfyG5+TXpjkra12NBuPmWqX7KgZp3+we3ktt8NePQQXrpbFT4ToI2DhSA7MGpiSM
	FOl4NQaT3QPKQJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA6F53EA62;
	Thu, 26 Feb 2026 13:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1O9nMddGoGkmSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 13:12:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8CCF6A0A27; Thu, 26 Feb 2026 14:12:51 +0100 (CET)
Date: Thu, 26 Feb 2026 14:12:51 +0100
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Paulo Alcantara <pc@manguebit.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org, netfs@lists.linux.dev, 
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, linux-xfs@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/4] fs: Remove unncessary pagevec.h includes
Message-ID: <hulhfdnrv4bbm6nvy3x4xbuxmc5ypmhpwdpt3jurfkibq5t2pu@6dcvs2uzzr46>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
 <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78473-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,columbia.edu:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu,dilger.ca,manguebit.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,ursulin.net,fb.com,dubeyko.com,linux.dev,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[97];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F03921A6570
X-Rspamd-Action: no action

On Wed 25-02-26 18:44:26, Tal Zussman wrote:
> Remove unused pagevec.h includes from .c files. These were found with
> the following command:
> 
>   grep -rl '#include.*pagevec\.h' --include='*.c' | while read f; do
>   	grep -qE 'PAGEVEC_SIZE|folio_batch' "$f" || echo "$f"
>   done
> 
> There are probably more removal candidates in .h files, but those are
> more complex to analyze.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

If it compiles than it's nice to get rid of. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/afs/write.c                   | 1 -
>  fs/dax.c                         | 1 -
>  fs/ext4/file.c                   | 1 -
>  fs/ext4/page-io.c                | 1 -
>  fs/ext4/readpage.c               | 1 -
>  fs/f2fs/file.c                   | 1 -
>  fs/mpage.c                       | 1 -
>  fs/netfs/buffered_write.c        | 1 -
>  fs/nfs/blocklayout/blocklayout.c | 1 -
>  fs/nfs/dir.c                     | 1 -
>  fs/ocfs2/refcounttree.c          | 1 -
>  fs/smb/client/connect.c          | 1 -
>  fs/smb/client/file.c             | 1 -
>  13 files changed, 13 deletions(-)
> 
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 93ad86ff3345..fcfed9d24e0a 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -10,7 +10,6 @@
>  #include <linux/fs.h>
>  #include <linux/pagemap.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
>  #include <linux/netfs.h>
>  #include <trace/events/netfs.h>
>  #include "internal.h"
> diff --git a/fs/dax.c b/fs/dax.c
> index b78cff9c91b3..a5237169b467 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -15,7 +15,6 @@
>  #include <linux/memcontrol.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
> -#include <linux/pagevec.h>
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/uio.h>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f1dc5ce791a7..5e02f6cf653e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -27,7 +27,6 @@
>  #include <linux/dax.h>
>  #include <linux/filelock.h>
>  #include <linux/quotaops.h>
> -#include <linux/pagevec.h>
>  #include <linux/uio.h>
>  #include <linux/mman.h>
>  #include <linux/backing-dev.h>
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index a8c95eee91b7..98da200d11c8 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -16,7 +16,6 @@
>  #include <linux/string.h>
>  #include <linux/buffer_head.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
>  #include <linux/mpage.h>
>  #include <linux/namei.h>
>  #include <linux/uio.h>
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 830f3b8a321f..3c7aabde719c 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -43,7 +43,6 @@
>  #include <linux/mpage.h>
>  #include <linux/writeback.h>
>  #include <linux/backing-dev.h>
> -#include <linux/pagevec.h>
>  
>  #include "ext4.h"
>  #include <trace/events/ext4.h>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c8a2f17a8f11..c6b6a1465d08 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -17,7 +17,6 @@
>  #include <linux/compat.h>
>  #include <linux/uaccess.h>
>  #include <linux/mount.h>
> -#include <linux/pagevec.h>
>  #include <linux/uio.h>
>  #include <linux/uuid.h>
>  #include <linux/file.h>
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 7dae5afc2b9e..e5285fbfcf09 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -28,7 +28,6 @@
>  #include <linux/mm_inline.h>
>  #include <linux/writeback.h>
>  #include <linux/backing-dev.h>
> -#include <linux/pagevec.h>
>  #include "internal.h"
>  
>  /*
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 22a4d61631c9..05ea5b0cc0e8 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -10,7 +10,6 @@
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
> -#include <linux/pagevec.h>
>  #include "internal.h"
>  
>  static void __netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> index cb0a645aeb50..11f9f69cde61 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -36,7 +36,6 @@
>  #include <linux/namei.h>
>  #include <linux/bio.h>		/* struct bio */
>  #include <linux/prefetch.h>
> -#include <linux/pagevec.h>
>  
>  #include "../pnfs.h"
>  #include "../nfs4session.h"
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 2402f57c8e7d..0d276441206b 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -32,7 +32,6 @@
>  #include <linux/nfs_fs.h>
>  #include <linux/nfs_mount.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
>  #include <linux/namei.h>
>  #include <linux/mount.h>
>  #include <linux/swap.h>
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index c1cdececdfa4..b4acd081bbc4 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -31,7 +31,6 @@
>  #include <linux/blkdev.h>
>  #include <linux/slab.h>
>  #include <linux/writeback.h>
> -#include <linux/pagevec.h>
>  #include <linux/swap.h>
>  #include <linux/security.h>
>  #include <linux/string.h>
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 33dfe116ca52..9e57812b7b95 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -20,7 +20,6 @@
>  #include <linux/delay.h>
>  #include <linux/completion.h>
>  #include <linux/kthread.h>
> -#include <linux/pagevec.h>
>  #include <linux/freezer.h>
>  #include <linux/namei.h>
>  #include <linux/uuid.h>
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 18f31d4eb98d..853ce1817810 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -15,7 +15,6 @@
>  #include <linux/stat.h>
>  #include <linux/fcntl.h>
>  #include <linux/pagemap.h>
> -#include <linux/pagevec.h>
>  #include <linux/writeback.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/delay.h>
> 
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

