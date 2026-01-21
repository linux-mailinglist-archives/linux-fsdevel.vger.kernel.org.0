Return-Path: <linux-fsdevel+bounces-74774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHgDNkNPcGlvXQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:00:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B49D50BA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E85B501B03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98334313E36;
	Wed, 21 Jan 2026 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YYEr2VjW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4kSyYfn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C833D50C;
	Wed, 21 Jan 2026 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967944; cv=none; b=I23Syzi0ej0D3jBZBqNZ/ucl8HnU/f4IiUwD7gYFCMLvaHUYkoFXdexBx5SBm5AYhOz9fXHorIXnqiPqua3nJ/EUhoFqCJDyJg/Rf+8n40uEud/WiY7SLzihHzDMVzKB7Zb2KLtwLjyvKM3gNill0XtIX7r/Oy8QHOr5PXQn3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967944; c=relaxed/simple;
	bh=1DJQUEOUnj9KAwbZv2Hc+tLIGvXute4oJWQnX3cNwrY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HALgvbszliwKdW1S1peMfMZRqkAMwTsHf/WPCeOXOR1EB8QLrP3eZrUvmEhPs3Oi9JsK0UVtSHsV7VX5gUynery8lZX56Rp1mLEQMjXmIqg4RlTyIwLAl+tT+M400vC1KkQUNzoMBunL0DDfXP5fK2okok87kKczLmURvm4aMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YYEr2VjW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4kSyYfn; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 59F6C1380787;
	Tue, 20 Jan 2026 22:58:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 22:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768967931; x=1768975131; bh=HPgiNusZcZTF/ZTl66piD/9BsmWo5Gc2+jA
	KaL+zbjo=; b=YYEr2VjWIaKtDqIQ9vfEWExooQB7WdoWCHPbIyCUEJI6BAxeQcQ
	Lbk8vsbd4GXH0kYHJaGcChinGdfj9GfFjBP2dVOEb1g7c0vP40XWPDTq6qbmdX+f
	q8U4adtBeg5EFoL6E5HUF62j7hOUy4j8XFCT0i4fYg4se8kZH51qgrZqOSAUlTga
	rl7CFzO8J+PeDJ7M2JSUWHisN0sDH8S0NMXRz8qdtkwm9W98zD3C3gklDbkWIXrK
	vRegxtY4BxrRjprMIjBdoVNMCKrXQqfmvm/+rjsgzuPUZ23gzBTcc6UXYC33cLAY
	vFj8n0R7qJgD5zcyYlJT/0wZ8oNx4to8Sng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768967931; x=
	1768975131; bh=HPgiNusZcZTF/ZTl66piD/9BsmWo5Gc2+jAKaL+zbjo=; b=Y
	4kSyYfnUGNoNeVLU3ka40YnKW2sl+45SitUqyg7vTCZpQcxFqZev1sh8sHAo4DzB
	LJJuIPm7kr1a2T2O/jCPPqyfpx1RyAZnMeJxrzQuzh0MJ2v9HwC0x1U/ypjUALTY
	LkBS/sHDc8LkvX0vZjnTUcBNoleBEEaONsgjyNXSYbPCsyTNNhNqwnjeRYEYWhC0
	Keyf4hXJLJ2uIP8nM1JZTI64DK90fYZcMdZmLKhtCiDOLF6zK0pOuLIFL3efcAnh
	U7QNK8cCXtqL4iHqmwf38GI0o4feHmUs9gVmK1fgy3LCnOLy087fTAjf+2UjG0tL
	Zxk2nmIhddHGej/ASyZkw==
X-ME-Sender: <xms:9k5waa6xGMlhNWG7OiNFHfIpLvabWA1DAPtyEn94taKAb8B-mUoW7w>
    <xme:9k5waRR7ItrMgf6WBso9qWSvOzTjS1gqDa4US3nP2_YPOGpBhCwjdwQRddvH-EWFV
    V57p5_-4xzEl4CNusEssTAjoVs4ZFelbrYFxoXbJ50yHbQn>
X-ME-Received: <xmr:9k5waeoZsLXtAC9WGWMpKfuL6jcuFf0eBU9OKagBSlfpxrmBa-z1UpdKQRgAi22TvEjMRNRptGtFkHbPbhda8VF8Vv99_8wlEjUQv-qrj4y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepghhuohgthhhunhhhrghisehvihhvohdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9k5waUhf0LUODlL_PQYsCPf5h1Hz9YtKoS8AL4OAL0YUoX9vGv32rg>
    <xmx:905waSCsyLL7f6fuPyvb6LM-a8AMULf8pIsT5TNPUcN888plxn2vJQ>
    <xmx:905waT9XbBSmLAgfzGT6kRdfvn_ApgSn62i1cNhe3-zAYtSYAOgBDQ>
    <xmx:905waTEUm6W92v2m08NAsDI3Dm--lHbflm-x_CKDQ7Y36cOw-DiEBA>
    <xmx:-05waa7eNM5AFWgAvsYRXTN-gn5rTHGxvGEPMtNHM76v4SM6_x2afNUS>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 22:58:29 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>,
 "Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>,
 "Luis de Bethencourt" <luisbg@kernel.org>,
 "Salah Triki" <salah.triki@gmail.com>,
 "Phillip Lougher" <phillip@squashfs.org.uk>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp" <shaggy@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Richard Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
In-reply-to: <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>,
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>,
 <aW3SAKIr_QsnEE5Q@infradead.org>,
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>,
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>,
 <176885553525.16766.291581709413217562@noble.neil.brown.name>,
 <20260120-entmilitarisieren-wanken-afd04b910897@brauner>,
 <176890211061.16766.16354247063052030403@noble.neil.brown.name>,
 <20260120-hacken-revision-88209121ac2c@brauner>,
 <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
Date: Wed, 21 Jan 2026 14:58:25 +1100
Message-id: <176896790525.16766.11792073987699294594@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ownmail.net,none];
	TAGGED_FROM(0.00)[bounces-74774-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,messagingengine.com:dkim,brown.name:replyto,noble.neil.brown.name:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8B49D50BA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026, Jeff Layton wrote:
> On Tue, 2026-01-20 at 11:31 +0100, Christian Brauner wrote:
> > On Tue, Jan 20, 2026 at 08:41:50PM +1100, NeilBrown wrote:
> > > On Tue, 20 Jan 2026, Christian Brauner wrote:
> > > > On Tue, Jan 20, 2026 at 07:45:35AM +1100, NeilBrown wrote:
> > > > > On Mon, 19 Jan 2026, Christian Brauner wrote:
> > > > > > On Mon, Jan 19, 2026 at 06:22:42PM +1100, NeilBrown wrote:
> > > > > > > On Mon, 19 Jan 2026, Christoph Hellwig wrote:
> > > > > > > > On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > > > > > > > > > This was Chuck's suggested name. His point was that STABL=
E means that
> > > > > > > > > > the FH's don't change during the lifetime of the file.
> > > > > > > > > >=20
> > > > > > > > > > I don't much care about the flag name, so if everyone lik=
es PERSISTENT
> > > > > > > > > > better I'll roll with that.
> > > > > > > > >=20
> > > > > > > > > I don't like PERSISTENT.
> > > > > > > > > I'd rather call a spade a spade.
> > > > > > > > >=20
> > > > > > > > >   EXPORT_OP_SUPPORTS_NFS_EXPORT
> > > > > > > > > or
> > > > > > > > >   EXPORT_OP_NOT_NFS_COMPATIBLE
> > > > > > > > >=20
> > > > > > > > > The issue here is NFS export and indirection doesn't bring =
any benefits.
> > > > > > > >=20
> > > > > > > > No, it absolutely is not.  And the whole concept of calling s=
omething
> > > > > > > > after the initial or main use is a recipe for a mess.
> > > > > > >=20
> > > > > > > We are calling it for it's only use.  If there was ever another=
 use, we
> > > > > > > could change the name if that made sense.  It is not a public n=
ame, it
> > > > > > > is easy to change.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Pick a name that conveys what the flag is about, and document=
 those
> > > > > > > > semantics well.  This flag is about the fact that for a given=
 file,
> > > > > > > > as long as that file exists in the file system the handle is =
stable.
> > > > > > > > Both stable and persistent are suitable for that, nfs is ever=
ything
> > > > > > > > but.
> > > > > > >=20
> > > > > > > My understanding is that kernfs would not get the flag.
> > > > > > > kernfs filehandles do not change as long as the file exist.
> > > > > > > But this is not sufficient for the files to be usefully exporte=
d.
> > > > > > >=20
> > > > > > > I suspect kernfs does re-use filehandles relatively soon after =
the
> > > > > > > file/object has been destroyed.  Maybe that is the real problem=
 here:
> > > > > > > filehandle reuse, not filehandle stability.
> > > > > > >=20
> > > > > > > Jeff: could you please give details (and preserve them in futur=
e cover
> > > > > > > letters) of which filesystems are known to have problems and wh=
at
> > > > > > > exactly those problems are?
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Remember nfs also support volatile file handles, and other ap=
plications
> > > > > > > > might rely on this (I know of quite a few user space applicat=
ions that
> > > > > > > > do, but they are kinda hardwired to xfs anyway).
> > > > > > >=20
> > > > > > > The NFS protocol supports volatile file handles.  knfsd does no=
t.
> > > > > > > So maybe
> > > > > > >   EXPORT_OP_NOT_NFSD_COMPATIBLE
> > > > > > > might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
> > > > > > > (I prefer opt-out rather than opt-in because nfsd export was the
> > > > > > > original purpose of export_operations, but it isn't something
> > > > > > > I would fight for)
> > > > > >=20
> > > > > > I prefer one of the variants you proposed here but I don't partic=
ularly
> > > > > > care. It's not a hill worth dying on. So if Christoph insists on =
the
> > > > > > other name then I say let's just go with it.
> > > > > >=20
> > > > >=20
> > > > > This sounds like you are recommending that we give in to bullying.
> > > > > I would rather the decision be made based on the facts of the case,=
 not
> > > > > the opinions that are stated most bluntly.
> > > > >=20
> > > > > I actually think that what Christoph wants is actually quite differ=
ent
> > > > > from what Jeff wants, and maybe two flags are needed.  But I don't =
yet
> > > > > have a clear understanding of what Christoph wants, so I cannot be =
sure.
> > > >=20
> > > > I've tried to indirectly ask whether you would be willing to compromi=
se
> > > > here or whether you want to insist on your alternative name. Apparent=
ly
> > > > that didn't come through.
> > >=20
> > > This would be the "not a hill worthy dying on" part of your statement.
> > > I think I see that implication now.
> > > But no, I don't think compromise is relevant.  I think the problem
> > > statement as originally given by Jeff is misleading, and people have
> > > been misled to an incorrect name.
> > >=20
> > > >=20
> > > > I'm unclear what your goal is in suggesting that I recommend "we" give
> > > > into bullying. All it achieved was to further derail this thread.
> > > >=20
> > >=20
> > > The "We" is the same as the "us" in "let's just go with it".
> > >=20
> > >=20
> > > > I also think it's not very helpful at v6 of the discussion to start
> > > > figuring out what the actual key rift between Jeff's and Christoph's
> > > > position is. If you've figured it out and gotten an agreement and this
> > > > is already in, send a follow-up series.
> > >=20
> > > v6?  v2 was posted today.  But maybe you are referring the some other
> > > precursors.
> > >=20
> > > The introductory statement in v2 is
> > >=20
> > >    This patchset adds a flag that indicates whether the filesystem supp=
orts
> > >    stable filehandles (i.e. that they don't change over the life of the
> > >    file). It then makes any filesystem that doesn't set that flag
> > >    ineligible for nfsd export.
> > >=20
> > > Nobody else questioned the validity of that.  I do.
> > > No evidence was given that there are *any* filesystems that don't
> > > support stable filehandles.  The only filesystem mentioned is cgroups
> > > and it DOES provide stable filehandles.
> >=20
>=20
> Across reboot? Not really.

Across reboot all the files are deleted and then new ones are created.
So there is nothing that needs to be stable.

>=20
> It's quite possible that we may end up with the same "id" numbers in
> cgroupfs on a new incarnation of the filesystem after a reboot. The
> files in there are not the same ones as the ones before, but their
> filehandles may match because kernfs doesn't factor in an i_generation
> number.

That is is about filehandle re-use, not about filehandle stability.

>=20
> Could we fix it by adding a random i_generation value or something?
> Possibly, but there really isn't a good use-case that I can see for
> allowing cgroupfs to be exported via nfsd. Best to disallow it until
> someone comes up with one.

100% agree.

>=20
> > Oh yes we did. And this is a merry-go-round.
> >=20
> > It is very much fine for a filesystems to support file handles without
> > wanting to support exporting via NFS. That is especially true for
> > in-kernel pseudo filesystems.
> >=20
> > As I've said before multiple times I want a way to allow filesystems
> > such as pidfs and nsfs to use file handles without supporting export.
> > Whatever that fscking flag is called at this point I fundamentally don't
> > care. And we are reliving the same arguments over and over.
> >=20
> > I will _hard NAK_ anything that starts mandating that export of
> > filesystems must be allowed simply because their file handles fit export
> > criteria. I do not care whether pidfs or nsfs file handles fit the bill.
> > They will not be exported.
>=20
> I don't really care what we call the flag. I do care a little about
> what its semantics are, but the effect should be to ensure that fs
> maintainers make a conscious decision about whether nfsd export should
> be allowed on the filesystem.=C2=A0

Why do you need a conscious decision so much that you want to try to
force it.
Of course we want conscious decisions and hope they are always made, but
trying to manipulate people to doing things often fails.  How sure are
you that fs developers won't just copy-paste some other implementation
and not think about the implications of the flag?

What is the down side?  What is the harm from allowing export (should the
admin attempt it)?
If there were serious security concerns - then sure, make it harder to
do the dangerous thing.
But if it is just "it doesn't make sense", then there is no harm in
letting people get away with not reading the documentation, and fixing
things later as complaints arrive.  That is generally how the process
works.

But if you really really want to set this new flag on almost every
export_operations, can I ask that you please set it on EVERY export
operations, then allow maintainers to remove it as they see fit.
I think that approach would be much easier to review.

With your current series it is non-trivial to determine which
export_operations you have chosen not to set the flag on.  If you had
one patch that set it everywhere, then individual patches to remove it,
that would be a lot easier to review.

Thanks,
NeilBrown


>=20
> At this point, maybe we should just go with Neil's=20
> EXPORT_OP_SUPPORTS_NFS_EXPORT or something. It's much more arbitrary,
> than trying to base this on criteria about filehandle stability, but it
> would give us the effect we want.
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


