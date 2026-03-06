Return-Path: <linux-fsdevel+bounces-79588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG5SBGK+qmlXWQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 12:45:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F8121FD5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 12:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A569330F8339
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905EE387376;
	Fri,  6 Mar 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoTL4X7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF834D4E9;
	Fri,  6 Mar 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797416; cv=none; b=SjUqUsGfK8T5m3qn5kMyRYyCn2esk7ntEn+iwQjKtgax9d4dpVxh3wR7KN3xBQLNA3ivNld6H7jvnZpNmKGzszVVi4eyJFCLInQCpu/ODOanD1tN2/cCvBKZ2GFiqXOSGWGAZ+kIoXwmfVosUfaEinebbxErZ9oACjrsa3LT9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797416; c=relaxed/simple;
	bh=GowoyTsR4CI3ewxQ0f2lHFy7dHsKMkcXOPtOrZuLkR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0J0gfkKMZNMmJoCf5UxYLykpfaRjVj5DVIGMv2hWZzxCrSYXrA+MNPcY50u6av9/NkXisiyePIamCPBNzoN+Ok5G9XMC2Qi2T68T2W4ABD9l6hBvyfzBYWgUtYPjNE/2Us1Afkp6CfXSnyQKfNlnSccbQ6csiBfOx/4MvfIYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoTL4X7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB45CC4CEF7;
	Fri,  6 Mar 2026 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772797415;
	bh=GowoyTsR4CI3ewxQ0f2lHFy7dHsKMkcXOPtOrZuLkR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AoTL4X7fkCCo0RpTHoieQY0AotRrEjVyuQ02wvcgh1owSajcJbmcQEtWizAtCSsK/
	 X+mc0JnVWTe165uGDV9E7WpAYYzGMULmVtno4EZukM7QoACh09oHoPUhdwygslZKvl
	 UA8JGFtIK2G8zIIAmjqKqpT+tyil+49Wti7f3MPsrXYEUnfS45na2IEnXoSRELDO6M
	 ZL6z80bBwk4W9VVHCHJBf7g9N26hSrTQ1VOPLG5slPyq9X33Zeti35mCcJQiMAS9Er
	 ddlmGUcS+LRPdDZ43n2TXxhXjJ5UL+qfVn18k94Sk3SHS399+2vt6KziT54vb18xV4
	 c6KUFHbeprQ4w==
Date: Fri, 6 Mar 2026 11:43:32 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
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
Message-ID: <b5c861d6-6875-432a-8ae0-33030f4571ae@lucifer.local>
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
X-Rspamd-Queue-Id: 67F8121FD5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu,dilger.ca,manguebit.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,ursulin.net,fb.com,dubeyko.com,linux.dev,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-79588-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[97];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,columbia.edu:email,lucifer.local:mid]
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:44:26PM -0500, Tal Zussman wrote:
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

Nice, LGTM so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

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

