Return-Path: <linux-fsdevel+bounces-78649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBSmN+G/oGk1mQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:49:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A262A1B00FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 022B83031F05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF147AF53;
	Thu, 26 Feb 2026 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcjIXeLg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B046AF20
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142541; cv=none; b=jgnn+OthpxVWFLxUA0tpdaTPfP9uXYdCxnI12+M9ClZhFrCxKRU/LfpAh1icgaNTj3kJeOGxKSbLv9MYZCsnmh/UP8ngotNUaJq6DzRslxDWWr7WrW1AzKp8F/hOmwTgY2wUJ1HdNhZTevEJ+n+Nxj/im7dfjgF81I/7crr0SzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142541; c=relaxed/simple;
	bh=LF4bwcYv1+PfMspbbpqO2VzfLK8CTRaCpOj6mQJxZGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atLVP4ANF5ST/J8hjtsU0QYvPJsXgEXb/XKfwV0hYZKKM9PNckMiU4vAeuntD/Zg6Omp63oQLJZiOXJmjBLjfS/ICGbIg0wMJV5Au4oDOHAl0gPQVY6SBlDlqi1HOlMm6cufYJnB0Q+2n/Qnn9H8TRDr1jt9vV0ifq4Wss6RMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcjIXeLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942A3C2BCB9
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 21:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772142540;
	bh=LF4bwcYv1+PfMspbbpqO2VzfLK8CTRaCpOj6mQJxZGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DcjIXeLgrxqUYwwv+2hZCBu8T09MVdaj4sSw8in+d9ikwiv6jPM/YXPBL00H8vz+L
	 ThBlz0nE8Lf5ETYcNtggwxUpTaTtpxvJzo6zuFsbRb8XoqlA9Fh9yjWBh0hxolp6uP
	 F4RBlPeM6zLgUqIIeXrHHNM23II286EyJloqnQZQDeWWJH6pSFZ/PCtkdKVacnfQjO
	 j39CTWgFGDhh9HZ9An7My+BGm7MDURWMkjqHI10HW8SaosV01xNYbdS9uJSRV+fDJ+
	 jhAZOaOllUvBy/kqKwJuum3OskFoy2GeMvvV0xHQSbc+35MVaFPFbyqJ1+b6Gwa1RP
	 ewnbRhbSJ1htQ==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64c9a6d68e5so968399d50.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:49:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwejm1lDKse6ukokZ/zgUYZQOfKtle41lCtfPfXYxbCpMlFp9NvxpEYLabqXvM5ElYAb1ZkVoSnQA6IEaJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzew3j0ICPOp/S8KVyjVWb6oT8jYBpeKQIO7oSfX8aTtc+2a896
	5wF1YkK0zJY2RYqXdXgcpMaHlRPspKamC7nWpIhQ1pF/AITkFlSykjiC5OelkbGPyezt/uILJN7
	IX7Jx8jv3U4l213vS2k/nWbiY+zwQs5c135ca51Q46A==
X-Received: by 2002:a53:e8c9:0:b0:64c:a81e:f2b2 with SMTP id
 956f58d0204a3-64cc211f150mr699646d50.27.1772142538704; Thu, 26 Feb 2026
 13:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu> <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
In-Reply-To: <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 26 Feb 2026 13:48:47 -0800
X-Gmail-Original-Message-ID: <CACePvbX5Qm+kQLtCWynvO-2YtoW0mdR+V6rfq=buR6tfR1A9FQ@mail.gmail.com>
X-Gm-Features: AaiRm50fP40RQkljlPLX-PI1NSM3iQnOuQQEi7r5tKbV7kaWVe_vUmPk2uGLYLk
Message-ID: <CACePvbX5Qm+kQLtCWynvO-2YtoW0mdR+V6rfq=buR6tfR1A9FQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fs: Remove unncessary pagevec.h includes
To: Tal Zussman <tz2294@columbia.edu>
Cc: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Paulo Alcantara <pc@manguebit.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
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
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-ext4@vger.kernel.org, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu,dilger.ca,manguebit.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,ursulin.net,fb.com,dubeyko.com,linux.dev,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78649-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,columbia.edu:email]
X-Rspamd-Queue-Id: A262A1B00FA
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 3:44=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> Remove unused pagevec.h includes from .c files. These were found with
> the following command:
>
>   grep -rl '#include.*pagevec\.h' --include=3D'*.c' | while read f; do
>         grep -qE 'PAGEVEC_SIZE|folio_batch' "$f" || echo "$f"
>   done
>
> There are probably more removal candidates in .h files, but those are
> more complex to analyze.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

