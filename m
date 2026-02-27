Return-Path: <linux-fsdevel+bounces-78793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAq0G0QHommEyQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:06:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C561BE129
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65B5C3073193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74C47A0D4;
	Fri, 27 Feb 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwUe8T+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB46410D10;
	Fri, 27 Feb 2026 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226345; cv=none; b=C999Mwyp2lUUqUGLPWcU1am96/SEznN82Pv4dYhGg2tkz2W3EcsO/8HvAFFIqeKJq4y6dD7gytFvTPAV4kNxFYYlhfuH4gTmQkNCcGjroXmx1TSU0hk0RE2TqUYmhInm6QZVEgS4lFAQZxS7EnkcgoUbLJYuWlEClwlVYQadh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226345; c=relaxed/simple;
	bh=sN76rLqXE0cK24sZufwHVodRKcdQtDVJ47IjByNqsBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyWM37uIOCyrEJvVkm3g+x68sieBcCHT+qwxk9Fc7UMilsCfFh/4ERdl4RcuLV7ckJIJCoefpQ4ErgnbFK31OyE+wD7CCg7EBqt6+/Kn0PUs3IDHlQWtUWJc2T3CIlv5ikYs4SqLkn8AZ2MoUEHuSdE2Dfh9YigLHWhwnQbohBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwUe8T+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F988C116C6;
	Fri, 27 Feb 2026 21:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772226345;
	bh=sN76rLqXE0cK24sZufwHVodRKcdQtDVJ47IjByNqsBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UwUe8T+b402Q2h2UJnif4zzLwpi6pIrKdkNQ9POisExC3E7JVkcKObMOK8flwBBiC
	 FUduAv0LTJYflzySzocQ9+6dXtNgsRXK/ndMe1RfkKP5D9Lg3ffLUSyA+NSfqpAffE
	 KCYzIzzksUwz1uY9GszuN7Cydt4OUQymxHY5jnL0/t/ATy90HlJfcFFQMzzx5IOwAx
	 RSGVc/vBEQ62JXP9pgyZaM9olEp+kLwfMaTJYp1ZNSE5AFzIg7GpWthwEAsb6hQq9F
	 b/thCjcYmhn3rUr9vGlrx58xVPnNE/VHSpOHFt0EjYCan8ZcQ52gkLKoyWSUXhtBxU
	 6sl2tm6HXAxVQ==
Message-ID: <4481598d13941191af0369bf204fe577d33f33bb.camel@kernel.org>
Subject: Re: [PATCH 03/61] trace: update VFS-layer trace events for u64 i_ino
From: Jeff Layton <jlayton@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Masami Hiramatsu	
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Eric Biggers	 <ebiggers@kernel.org>, "Theodore Y.
 Ts'o" <tytso@mit.edu>, Muchun Song	 <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, David Hildenbrand	 <david@kernel.org>, David Howells
 <dhowells@redhat.com>, Paulo Alcantara	 <pc@manguebit.org>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Jan Kara	 <jack@suse.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,  Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>,  NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,  Tom Talpey
 <tom@talpey.com>, Steve French <sfrench@samba.org>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>,  Shyam Prasad N <sprasad@microsoft.com>,
 Bharath SM <bharathsm@microsoft.com>, Alexander Aring	
 <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko	 <slava@dubeyko.com>, Eric Van Hensbergen
 <ericvh@kernel.org>, Latchesar Ionkov	 <lucho@ionkov.net>, Dominique
 Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, Marc Dionne	
 <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, Luis de
 Bethencourt	 <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian"	 <aivazian.tigran@gmail.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze	 <amarkuze@redhat.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,  Nicolas Pitre <nico@fluxnic.net>,
 Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
 Christoph Hellwig	 <hch@infradead.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>, Mikulas
 Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse	
 <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp	
 <shaggy@kernel.org>, Konstantin Komarov	
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Mike Marshall	 <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Miklos Szeredi	 <miklos@szeredi.hu>, Anders Larsen
 <al@alarsen.net>, Zhihao Cheng	 <chengzhihao1@huawei.com>, Damien Le Moal
 <dlemoal@kernel.org>, Naohiro Aota	 <naohiro.aota@wdc.com>, Johannes
 Thumshirn <jth@kernel.org>, John Johansen	 <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris	 <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Mimi Zohar	 <zohar@linux.ibm.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, Fan
 Wu	 <wufan@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler
 <casey@schaufler-ca.com>, Alex Deucher	 <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Eric Dumazet	 <edumazet@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni	 <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, "David S. Miller"	 <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman	 <horms@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra	 <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland	 <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>,  James Clark <james.clark@linaro.org>, "Darrick
 J. Wong" <djwong@kernel.org>, Martin Schiller <ms@dev.tdt.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 autofs@vger.kernel.org, 	ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 devel@lists.orangefs.org, 	linux-unionfs@vger.kernel.org,
 apparmor@lists.ubuntu.com, 	linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	selinux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, 	linaro-mm-sig@lists.linaro.org,
 netdev@vger.kernel.org, 	linux-perf-users@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, 	linux-xfs@vger.kernel.org,
 linux-hams@vger.kernel.org, linux-x25@vger.kernel.org
Date: Fri, 27 Feb 2026 16:05:30 -0500
In-Reply-To: <20260226124842.5593ed85@gandalf.local.home>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
		<20260226-iino-u64-v1-3-ccceff366db9@kernel.org>
	 <20260226124842.5593ed85@gandalf.local.home>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	TAGGED_FROM(0.00)[bounces-78793-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[145];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15C561BE129
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 12:48 -0500, Steven Rostedt wrote:
> On Thu, 26 Feb 2026 10:55:05 -0500
> Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > Update trace event definitions in VFS-layer trace headers to use u64
> > instead of ino_t/unsigned long for inode number fields, and change
> > format strings from %lu/%lx to %llu/%llx to match.
> >=20
> > This is needed because i_ino is now u64. Changing trace event field
> > types changes the binary trace format, but the self-describing format
> > metadata handles this transparently for modern trace-cmd and perf.
> >=20
> > Files updated:
> >   - cachefiles.h, filelock.h, filemap.h, fs_dax.h, fsverity.h,
> >     hugetlbfs.h, netfs.h, readahead.h, timestamp.h, writeback.h
> >=20
>=20
> Hmm, on 32 bit systems, this will likely cause "holes" in a lot of these
> events.
>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/trace/events/cachefiles.h |  18 ++---
> >  include/trace/events/filelock.h   |  16 ++---
> >  include/trace/events/filemap.h    |  20 +++---
> >  include/trace/events/fs_dax.h     |  20 +++---
> >  include/trace/events/fsverity.h   |  30 ++++----
> >  include/trace/events/hugetlbfs.h  |  28 ++++----
> >  include/trace/events/netfs.h      |   4 +-
> >  include/trace/events/readahead.h  |  12 ++--
> >  include/trace/events/timestamp.h  |  12 ++--
> >  include/trace/events/writeback.h  | 148 +++++++++++++++++++-----------=
--------
> >  10 files changed, 154 insertions(+), 154 deletions(-)
> >=20
> > diff --git a/include/trace/events/cachefiles.h b/include/trace/events/c=
achefiles.h
> > index a743b2a35ea7001447b3e05d41539cb88013bc7f..f967027711ee823f224abc1=
b8ab03f63da06ae6f 100644
> > --- a/include/trace/events/cachefiles.h
> > +++ b/include/trace/events/cachefiles.h
> > @@ -251,8 +251,8 @@ TRACE_EVENT(cachefiles_lookup,
> >  	    TP_STRUCT__entry(
> >  		    __field(unsigned int,		obj)
> >  		    __field(short,			error)
>=20
> There was already a 2 byte hole here, but that's not a big deal.
>=20
> > -		    __field(unsigned long,		dino)
> > -		    __field(unsigned long,		ino)
> > +		    __field(u64,			dino)
> > +		    __field(u64,			ino)
> >  			     ),
> > =20
> >  	    TP_fast_assign(
> > @@ -263,7 +263,7 @@ TRACE_EVENT(cachefiles_lookup,
> >  		    __entry->error	=3D IS_ERR(de) ? PTR_ERR(de) : 0;
> >  			   ),
> > =20
> > -	    TP_printk("o=3D%08x dB=3D%lx B=3D%lx e=3D%d",
> > +	    TP_printk("o=3D%08x dB=3D%llx B=3D%llx e=3D%d",
> >  		      __entry->obj, __entry->dino, __entry->ino, __entry->error)
> >  	    );
> > =20
> > @@ -579,7 +579,7 @@ TRACE_EVENT(cachefiles_mark_active,
> >  	    /* Note that obj may be NULL */
> >  	    TP_STRUCT__entry(
> >  		    __field(unsigned int,		obj)
> > -		    __field(ino_t,			inode)
> > +		    __field(u64,			inode)
>=20
> Might be better to reorder any of these that have int first.
>=20
> 		u64	inode;
> 		int	obj;
>=20
> Will be packed tighter than:
>=20
> 		int	obj
> 		u64	inode;
>=20
> Probably should have changed that before anyway.
>=20

Ok, I'll look at that. Given the number of places that need it though I
may do it in a separate patch.

> >  			     ),
> > =20
> >  	    TP_fast_assign(
> > @@ -587,7 +587,7 @@ TRACE_EVENT(cachefiles_mark_active,
> >  		    __entry->inode	=3D inode->i_ino;
> >  			   ),
> > =20
> > -	    TP_printk("o=3D%08x B=3D%lx",
> > +	    TP_printk("o=3D%08x B=3D%llx",
> >  		      __entry->obj, __entry->inode)
> >  	    );
> > =20
> > @@ -600,7 +600,7 @@ TRACE_EVENT(cachefiles_mark_failed,
> >  	    /* Note that obj may be NULL */
> >  	    TP_STRUCT__entry(
> >  		    __field(unsigned int,		obj)
> > -		    __field(ino_t,			inode)
> > +		    __field(u64,			inode)
>=20
> Is ino_t being changed? Why the update here?
>=20

No, ino_t isn't. That's part of the ABI and has to remain unsigned
long. The point of this series is to make inode->i_ino a u64. Any event
holding an ino_t today is going to need a 64-bit field to fully
describe it.

And to be clear, this should make things better for 32-bit boxes in the
long run. Once this change is done, i_ino should be a reliable source
of info regardless of machine's word size.

For the tracepoints, I think it's best to just extend them to 64-bit
fields outright rather than using the new (temporary) kino_t typedef
that I'm adding.

> >  			     ),
> > =20
> >  	    TP_fast_assign(
> > @@ -608,7 +608,7 @@ TRACE_EVENT(cachefiles_mark_failed,
> >  		    __entry->inode	=3D inode->i_ino;
> >  			   ),
> > =20
> > -	    TP_printk("o=3D%08x B=3D%lx",
> > +	    TP_printk("o=3D%08x B=3D%llx",
> >  		      __entry->obj, __entry->inode)
> >  	    );
> > =20
> > @@ -621,7 +621,7 @@ TRACE_EVENT(cachefiles_mark_inactive,
> >  	    /* Note that obj may be NULL */
> >  	    TP_STRUCT__entry(
> >  		    __field(unsigned int,		obj)
> > -		    __field(ino_t,			inode)
> > +		    __field(u64,			inode)
>=20
> Ditto.
>=20
> >  			     ),
> > =20
> >  	    TP_fast_assign(
> > @@ -629,7 +629,7 @@ TRACE_EVENT(cachefiles_mark_inactive,
> >  		    __entry->inode	=3D inode->i_ino;
> >  			   ),
> > =20
> > -	    TP_printk("o=3D%08x B=3D%lx",
> > +	    TP_printk("o=3D%08x B=3D%llx",
> >  		      __entry->obj, __entry->inode)
> >  	    );
> > =20
> > diff --git a/include/trace/events/filelock.h b/include/trace/events/fil=
elock.h
> > index 370016c38a5bbc07d5ba6c102030b49c9eb6424d..41bc752616b25d6cd795520=
3e2c604029d0b440c 100644
> > --- a/include/trace/events/filelock.h
> > +++ b/include/trace/events/filelock.h
> > @@ -42,7 +42,7 @@ TRACE_EVENT(locks_get_lock_context,
> >  	TP_ARGS(inode, type, ctx),
> > =20
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, i_ino)
> > +		__field(u64, i_ino)
> >  		__field(dev_t, s_dev)
> >  		__field(unsigned char, type)
> >  		__field(struct file_lock_context *, ctx)
> > @@ -55,7 +55,7 @@ TRACE_EVENT(locks_get_lock_context,
> >  		__entry->ctx =3D ctx;
> >  	),
> > =20
> > -	TP_printk("dev=3D0x%x:0x%x ino=3D0x%lx type=3D%s ctx=3D%p",
> > +	TP_printk("dev=3D0x%x:0x%x ino=3D0x%llx type=3D%s ctx=3D%p",
> >  		  MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
> >  		  __entry->i_ino, show_fl_type(__entry->type), __entry->ctx)
> >  );
> > @@ -67,7 +67,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
> > =20
> >  	TP_STRUCT__entry(
> >  		__field(struct file_lock *, fl)
> > -		__field(unsigned long, i_ino)
> > +		__field(u64, i_ino)
>=20
> Having u64 before a pointer would be tighter on 32 bit systems, and leave=
s
> out any holes in the trace.
>
> >  		__field(dev_t, s_dev)
> >  		__field(struct file_lock_core *, blocker)
> >  		__field(fl_owner_t, owner)
> > @@ -93,7 +93,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
> >  		__entry->ret =3D ret;
> >  	),
> > =20
> > -	TP_printk("fl=3D%p dev=3D0x%x:0x%x ino=3D0x%lx fl_blocker=3D%p fl_own=
er=3D%p fl_pid=3D%u fl_flags=3D%s fl_type=3D%s fl_start=3D%lld fl_end=3D%ll=
d ret=3D%d",
> > +	TP_printk("fl=3D%p dev=3D0x%x:0x%x ino=3D0x%llx fl_blocker=3D%p fl_ow=
ner=3D%p fl_pid=3D%u fl_flags=3D%s fl_type=3D%s fl_start=3D%lld fl_end=3D%l=
ld ret=3D%d",
> >  		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
> >  		__entry->i_ino, __entry->blocker, __entry->owner,
> >  		__entry->pid, show_fl_flags(__entry->flags),
> > @@ -124,7 +124,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
> > =20
> >  	TP_STRUCT__entry(
> >  		__field(struct file_lease *, fl)
> > -		__field(unsigned long, i_ino)
> > +		__field(u64, i_ino)
>=20
> Same here.
>=20
> >  		__field(dev_t, s_dev)
> >  		__field(struct file_lock_core *, blocker)
> >  		__field(fl_owner_t, owner)
> > @@ -146,7 +146,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
> >  		__entry->downgrade_time =3D fl ? fl->fl_downgrade_time : 0;
> >  	),
> > =20
> > -	TP_printk("fl=3D%p dev=3D0x%x:0x%x ino=3D0x%lx fl_blocker=3D%p fl_own=
er=3D%p fl_flags=3D%s fl_type=3D%s fl_break_time=3D%lu fl_downgrade_time=3D=
%lu",
> > +	TP_printk("fl=3D%p dev=3D0x%x:0x%x ino=3D0x%llx fl_blocker=3D%p fl_ow=
ner=3D%p fl_flags=3D%s fl_type=3D%s fl_break_time=3D%lu fl_downgrade_time=
=3D%lu",
> >  		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
> >  		__entry->i_ino, __entry->blocker, __entry->owner,
> >  		show_fl_flags(__entry->flags),
> > @@ -175,7 +175,7 @@ TRACE_EVENT(generic_add_lease,
> >  	TP_ARGS(inode, fl),
> > =20
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, i_ino)
> > +		__field(u64, i_ino)
> >  		__field(int, wcount)
> >  		__field(int, rcount)
> >  		__field(int, icount)
> > @@ -196,7 +196,7 @@ TRACE_EVENT(generic_add_lease,
> >  		__entry->type =3D fl->c.flc_type;
> >  	),
> > =20
> > -	TP_printk("dev=3D0x%x:0x%x ino=3D0x%lx wcount=3D%d rcount=3D%d icount=
=3D%d fl_owner=3D%p fl_flags=3D%s fl_type=3D%s",
> > +	TP_printk("dev=3D0x%x:0x%x ino=3D0x%llx wcount=3D%d rcount=3D%d icoun=
t=3D%d fl_owner=3D%p fl_flags=3D%s fl_type=3D%s",
> >  		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
> >  		__entry->i_ino, __entry->wcount, __entry->rcount,
> >  		__entry->icount, __entry->owner,
> > diff --git a/include/trace/events/filemap.h b/include/trace/events/file=
map.h
> > index f48fe637bfd25885dc6daaf09336ab60626b4944..153491e57cce6df73e30dde=
e60a52ed7d8923c24 100644
> > --- a/include/trace/events/filemap.h
> > +++ b/include/trace/events/filemap.h
> > @@ -21,7 +21,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
> > =20
> >  	TP_STRUCT__entry(
> >  		__field(unsigned long, pfn)
> > -		__field(unsigned long, i_ino)
> > +		__field(u64, i_ino)
>=20
> Again, this would cause a 32 bit hole.
>=20
> >  		__field(unsigned long, index)
> >  		__field(dev_t, s_dev)
> >  		__field(unsigned char, order)
> > @@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
> >  		__entry->order =3D folio_order(folio);
> >  	),
> > =20
> > -	TP_printk("dev %d:%d ino %lx pfn=3D0x%lx ofs=3D%lu order=3D%u",
> > +	TP_printk("dev %d:%d ino %llx pfn=3D0x%lx ofs=3D%lu order=3D%u",
> >  		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
> >  		__entry->i_ino,
> >  		__entry->pfn,
> > @@ -67,7 +67,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
> >  	TP_ARGS(mapping, index, last_index),
> > =20
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, i_ino)
> > +		__field(u64, i_ino)
> >  		__field(dev_t, s_dev)
> >  		__field(unsigned long, index)
> >  		__field(unsigned long, last_index)
> > @@ -85,7 +85,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
> >  	),
> > =20
> >  	TP_printk(
> > -		"dev=3D%d:%d ino=3D%lx ofs=3D%lld-%lld",
> > +		"dev=3D%d:%d ino=3D%llx ofs=3D%lld-%lld",
> >  		MAJOR(__entry->s_dev),
> >  		MINOR(__entry->s_dev), __entry->i_ino,
> >  		((loff_t)__entry->index) << PAGE_SHIFT,
> > @@ -117,7 +117,7 @@ TRACE_EVENT(mm_filemap_fault,
> >  	TP_ARGS(mapping, index),
> > =20
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, i_ino)
> > +		__field(u64, i_ino)
> >  		__field(dev_t, s_dev)
> >  		__field(unsigned long, index)
> >  	),
> > @@ -133,7 +133,7 @@ TRACE_EVENT(mm_filemap_fault,
> >  	),
> > =20
> >  	TP_printk(
> > -		"dev=3D%d:%d ino=3D%lx ofs=3D%lld",
> > +		"dev=3D%d:%d ino=3D%llx ofs=3D%lld",
> >  		MAJOR(__entry->s_dev),
> >  		MINOR(__entry->s_dev), __entry->i_ino,
> >  		((loff_t)__entry->index) << PAGE_SHIFT
> > @@ -146,7 +146,7 @@ TRACE_EVENT(filemap_set_wb_err,
> >  		TP_ARGS(mapping, eseq),
> > =20
> >  		TP_STRUCT__entry(
> > -			__field(unsigned long, i_ino)
> > +			__field(u64, i_ino)
> >  			__field(dev_t, s_dev)
> >  			__field(errseq_t, errseq)
> >  		),
> > @@ -160,7 +160,7 @@ TRACE_EVENT(filemap_set_wb_err,
> >  				__entry->s_dev =3D mapping->host->i_rdev;
> >  		),
> > =20
> > -		TP_printk("dev=3D%d:%d ino=3D0x%lx errseq=3D0x%x",
> > +		TP_printk("dev=3D%d:%d ino=3D0x%llx errseq=3D0x%x",
> >  			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
> >  			__entry->i_ino, __entry->errseq)
> >  );
> > @@ -172,7 +172,7 @@ TRACE_EVENT(file_check_and_advance_wb_err,
> > =20
> >  		TP_STRUCT__entry(
> >  			__field(struct file *, file)
> > -			__field(unsigned long, i_ino)
> > +			__field(u64, i_ino)
>=20
> Having a pointer after the u64 is better.
>=20
> >  			__field(dev_t, s_dev)
> >  			__field(errseq_t, old)
> >  			__field(errseq_t, new)
> > @@ -191,7 +191,7 @@ TRACE_EVENT(file_check_and_advance_wb_err,
> >  			__entry->new =3D file->f_wb_err;
> >  		),
> > =20
> > -		TP_printk("file=3D%p dev=3D%d:%d ino=3D0x%lx old=3D0x%x new=3D0x%x",
> > +		TP_printk("file=3D%p dev=3D%d:%d ino=3D0x%llx old=3D0x%x new=3D0x%x"=
,
> >  			__entry->file, MAJOR(__entry->s_dev),
> >  			MINOR(__entry->s_dev), __entry->i_ino, __entry->old,
> >  			__entry->new)
> > diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_da=
x.h
> > index 50ebc1290ab062a9c30ab00049fb96691f9a0f23..11121baa8ece7928c653b4f=
874fb10ffbdd02fd0 100644
> > --- a/include/trace/events/fs_dax.h
> > +++ b/include/trace/events/fs_dax.h
> > @@ -12,7 +12,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
> >  		pgoff_t max_pgoff, int result),
> >  	TP_ARGS(inode, vmf, max_pgoff, result),
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, ino)
> > +		__field(u64, ino)
> >  		__field(unsigned long, vm_start)
> >  		__field(unsigned long, vm_end)
> >  		__field(vm_flags_t, vm_flags)
> > @@ -35,7 +35,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
> >  		__entry->max_pgoff =3D max_pgoff;
> >  		__entry->result =3D result;
> >  	),
> > -	TP_printk("dev %d:%d ino %#lx %s %s address %#lx vm_start "
> > +	TP_printk("dev %d:%d ino %#llx %s %s address %#lx vm_start "
> >  			"%#lx vm_end %#lx pgoff %#lx max_pgoff %#lx %s",
> >  		MAJOR(__entry->dev),
> >  		MINOR(__entry->dev),
> > @@ -66,7 +66,7 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
> >  		void *radix_entry),
> >  	TP_ARGS(inode, vmf, zero_folio, radix_entry),
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, ino)
> > +		__field(u64, ino)
> >  		__field(vm_flags_t, vm_flags)
> >  		__field(unsigned long, address)
> >  		__field(struct folio *, zero_folio)
> > @@ -81,7 +81,7 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
> >  		__entry->zero_folio =3D zero_folio;
> >  		__entry->radix_entry =3D radix_entry;
> >  	),
> > -	TP_printk("dev %d:%d ino %#lx %s address %#lx zero_folio %p "
> > +	TP_printk("dev %d:%d ino %#llx %s address %#lx zero_folio %p "
> >  			"radix_entry %#lx",
> >  		MAJOR(__entry->dev),
> >  		MINOR(__entry->dev),
> > @@ -106,7 +106,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
> >  	TP_PROTO(struct inode *inode, struct vm_fault *vmf, int result),
> >  	TP_ARGS(inode, vmf, result),
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, ino)
> > +		__field(u64, ino)
> >  		__field(vm_flags_t, vm_flags)
> >  		__field(unsigned long, address)
> >  		__field(pgoff_t, pgoff)
> > @@ -123,7 +123,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
> >  		__entry->pgoff =3D vmf->pgoff;
> >  		__entry->result =3D result;
> >  	),
> > -	TP_printk("dev %d:%d ino %#lx %s %s address %#lx pgoff %#lx %s",
> > +	TP_printk("dev %d:%d ino %#llx %s %s address %#lx pgoff %#lx %s",
> >  		MAJOR(__entry->dev),
> >  		MINOR(__entry->dev),
> >  		__entry->ino,
> > @@ -150,7 +150,7 @@ DECLARE_EVENT_CLASS(dax_writeback_range_class,
> >  	TP_PROTO(struct inode *inode, pgoff_t start_index, pgoff_t end_index)=
,
> >  	TP_ARGS(inode, start_index, end_index),
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, ino)
> > +		__field(u64, ino)
> >  		__field(pgoff_t, start_index)
> >  		__field(pgoff_t, end_index)
> >  		__field(dev_t, dev)
> > @@ -161,7 +161,7 @@ DECLARE_EVENT_CLASS(dax_writeback_range_class,
> >  		__entry->start_index =3D start_index;
> >  		__entry->end_index =3D end_index;
> >  	),
> > -	TP_printk("dev %d:%d ino %#lx pgoff %#lx-%#lx",
> > +	TP_printk("dev %d:%d ino %#llx pgoff %#lx-%#lx",
> >  		MAJOR(__entry->dev),
> >  		MINOR(__entry->dev),
> >  		__entry->ino,
> > @@ -182,7 +182,7 @@ TRACE_EVENT(dax_writeback_one,
> >  	TP_PROTO(struct inode *inode, pgoff_t pgoff, pgoff_t pglen),
> >  	TP_ARGS(inode, pgoff, pglen),
> >  	TP_STRUCT__entry(
> > -		__field(unsigned long, ino)
> > +		__field(u64, ino)
> >  		__field(pgoff_t, pgoff)
> >  		__field(pgoff_t, pglen)
> >  		__field(dev_t, dev)
> > @@ -193,7 +193,7 @@ TRACE_EVENT(dax_writeback_one,
> >  		__entry->pgoff =3D pgoff;
> >  		__entry->pglen =3D pglen;
> >  	),
> > -	TP_printk("dev %d:%d ino %#lx pgoff %#lx pglen %#lx",
> > +	TP_printk("dev %d:%d ino %#llx pgoff %#lx pglen %#lx",
> >  		MAJOR(__entry->dev),
> >  		MINOR(__entry->dev),
> >  		__entry->ino,
> > diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsv=
erity.h
> > index a8c52f21cbd5eb010c7e7b2fdb8f9de49c8ea326..4477c17e05748360965c4e1=
840590efe96d6335e 100644
> > --- a/include/trace/events/fsverity.h
> > +++ b/include/trace/events/fsverity.h
> > @@ -16,7 +16,7 @@ TRACE_EVENT(fsverity_enable,
> >  		 const struct merkle_tree_params *params),
> >  	TP_ARGS(inode, params),
> >  	TP_STRUCT__entry(
> > -		__field(ino_t, ino)
> > +		__field(u64, ino)
>=20
> Do you need to convert all these ino_t's?
>=20
> >  		__field(u64, data_size)
> >  		__field(u64, tree_size)
> >  		__field(unsigned int, merkle_block)
> > @@ -29,8 +29,8 @@ TRACE_EVENT(fsverity_enable,
> >  		__entry->merkle_block =3D params->block_size;
> >  		__entry->num_levels =3D params->num_levels;
> >  	),
> > -	TP_printk("ino %lu data_size %llu tree_size %llu merkle_block %u leve=
ls %u",
> > -		(unsigned long) __entry->ino,
> > +	TP_printk("ino %llu data_size %llu tree_size %llu merkle_block %u lev=
els %u",
> > +		__entry->ino,
> >  		__entry->data_size,
> >  		__entry->tree_size,
> >  		__entry->merkle_block,
> > @@ -42,7 +42,7 @@ TRACE_EVENT(fsverity_tree_done,
> >  		 const struct merkle_tree_params *params),
> >  	TP_ARGS(inode, vi, params),
> >  	TP_STRUCT__entry(
> > -		__field(ino_t, ino)
> > +		__field(u64, ino)
> >  		__field(u64, data_size)
> >  		__field(u64, tree_size)
> >  		__field(unsigned int, merkle_block)
> > @@ -59,8 +59,8 @@ TRACE_EVENT(fsverity_tree_done,
> >  		memcpy(__get_dynamic_array(root_hash), vi->root_hash, __get_dynamic_=
array_len(root_hash));
> >  		memcpy(__get_dynamic_array(file_digest), vi->file_digest, __get_dyna=
mic_array_len(file_digest));
> >  	),
> > -	TP_printk("ino %lu data_size %llu tree_size %lld merkle_block %u leve=
ls %u root_hash %s digest %s",
> > -		(unsigned long) __entry->ino,
> > +	TP_printk("ino %llu data_size %llu tree_size %lld merkle_block %u lev=
els %u root_hash %s digest %s",
> > +		__entry->ino,
> >  		__entry->data_size,
> >  		__entry->tree_size,
> >  		__entry->merkle_block,
> > @@ -75,7 +75,7 @@ TRACE_EVENT(fsverity_verify_data_block,
> >  		 u64 data_pos),
> >  	TP_ARGS(inode, params, data_pos),
> >  	TP_STRUCT__entry(
> > -		__field(ino_t, ino)
> > +		__field(u64, ino)
> >  		__field(u64, data_pos)
> >  		__field(unsigned int, merkle_block)
> >  	),
> > @@ -84,8 +84,8 @@ TRACE_EVENT(fsverity_verify_data_block,
> >  		__entry->data_pos =3D data_pos;
> >  		__entry->merkle_block =3D params->block_size;
> >  	),
> > -	TP_printk("ino %lu data_pos %llu merkle_block %u",
> > -		(unsigned long) __entry->ino,
> > +	TP_printk("ino %llu data_pos %llu merkle_block %u",
> > +		__entry->ino,
> >  		__entry->data_pos,
> >  		__entry->merkle_block)
> >  );
> > @@ -96,7 +96,7 @@ TRACE_EVENT(fsverity_merkle_hit,
> >  		 unsigned int hidx),
> >  	TP_ARGS(inode, data_pos, hblock_idx, level, hidx),
> >  	TP_STRUCT__entry(
> > -		__field(ino_t, ino)
> > +		__field(u64, ino)
> >  		__field(u64, data_pos)
>=20
> Heh, this actually removed a hole, but again, why convert ino_t?
>=20
> Anyway, I stopped here. But you get the idea.
>
>=20
> >  		__field(unsigned long, hblock_idx)
> >  		__field(unsigned int, level)

Thanks for the review! I'll definitely look at reordering the
tracepoint fields for better packing since that has material
consequences.
--=20
Jeff Layton <jlayton@kernel.org>

