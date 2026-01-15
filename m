Return-Path: <linux-fsdevel+bounces-73995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F727D27FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15E5303C5A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651D3B8BA5;
	Thu, 15 Jan 2026 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDvYdYL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F82D780C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504466; cv=pass; b=DICNN1Gu+4actkrzF9MDXsnvBady7iunO+VexqhHXtdMd7g1Zk1cgemZ70cuK42agTqeh6dSp12ggQ4seXcD9cB1lPncS8d5wOoniK6i0QaS5BnEPaES00miVmRKVWcxPIxnd5YaSvwY8ey8CHYuCaoXuUlSKG8y///UhSWbIEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504466; c=relaxed/simple;
	bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxOEhny+hRMC0056HQF0St8g1N7UB73ixqd7cDGNEI0u5RsGzDIHUzjcaO+uRblsFUdTh7K7kBkwVq6v5EFDo2NTzmm08DKh+46Gjbp+INVEcrg+VHZNfOMV2YvkznmHe5KT72gN+ZJYOCbsDPfS/ulKAM7h9FljD2zjOLKySwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDvYdYL0; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee974e230so11957225e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 11:14:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768504461; cv=none;
        d=google.com; s=arc-20240605;
        b=FaAl6H1XhdX5VNWVdeVsdGU72hnkyZL0mZov1we7CTCzLRIMFum6UH6Yx48QzJw7kT
         jPQvB+8dgqAZgebF+3hOCEjK79o92OwWK/VRFu6+BxOjvCs8VxZK0una5Q9BkUHWpzD9
         C6yNFgS/F0FrpJfiInMAr4qiPxWYq4GLqI6gWLNngbiQXcjGClbaLkeV85DibGb1Gii+
         nsrfok6wKqvNcR2R5Wukpnl+S5OsB10QG2iXoFoBmeQAjKPUwqkSQun2JSmXwjmJC96M
         XhyYLeb30XBYmgtDLf/QYzECN2Ct9IERnfcCJlPjMHjUF7nu4uCxmDRZYFe5I9q6S+zz
         c+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        fh=+K0zebP8/KkOXRthTaeKJDmktobEBc8ZRPQSoub+mM4=;
        b=Ke4y3PgltuxzVZB+7kLCGWvuze4UuzSvBSohV0UC2gqFt4UnrrN6iKM4+xOofKxjR4
         /ZNJfK2AfBU9cIIkOxuINNA7uij1Zm+jkJMEobyJDmjXYxFlJLptTpP3JfEhGIWWQqiD
         gN7/IcE0IB6p50+K7YltB6/hgGrqGXpzAlkgvIRM0+jaBF0l14Bly+asO0mOJnKEnBCh
         RhnFO7Nkeu/3bRsGTQEOItpfB6qtiAiExzXuoQmJqIPYb/Fwx1BQjXJbp6zDrGxf23B7
         gGTwGGiZyu8ReR94MXqmJV1buX7I+riqpYrIllr1CyXBXnl9s4D9nsnN1OvQDtlfWsBX
         890Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768504461; x=1769109261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        b=eDvYdYL0yZ6SV5I85cBjsgP/sNA1X8xt4pIFzkPf14WQU8PWsnFTZbFP0w7gvj2vKR
         su7k/MnvLCToRHyNtBK2Ctyl74xxKbrSK0oilR42ZtVbwVIidcOzpn6LGa+m0L219bov
         LPfgSseqpVZriPFbBElJW4XsMxajo2fDIMAOwj69wq2QZXSx760mtGmSS7iSQT2OVYn3
         nHlQxi2/qPexhK3NToOklsvBJV74vyrx0cnd0+iL4bB9t8TovQ8oOPh4KgdANp7Ff4FW
         lIM5A0H6dpndNCHyHgWetB48LZIZV1yGHzsBBYn5Vz8YNJFWL/CrTlVVBJyKHRkqqpd9
         IUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768504461; x=1769109261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        b=RENJTe50RfU1+cAS2kEl9FmDcHBDyPNWuk4+hIduchT9ZsVBijbwWjje/j0GXA4OFW
         a5dLHyHV4GOh8JKIi71VryVo1KnYDnW4ddU40TgAfZyWA/CuRusyLdU5HLHHaDvh8hhJ
         7MNTp70oO/824ErhVM7qLbPiV3K7qGZAhpx/d2JIAeZ4msyAhzBncdyOzT6Yjza5Q2Lm
         fbCa7voPGUC2HXtEDLMq1s3V0L0uzk8whsgZzvZweTQ0clM1Cx5PoPxLRYP8CzjrD+qS
         okdGNnRUcBFR+zzLs8zCGmsJ5p5PgPHyGCNY0Yj5IDo3qsz55MNWYod4nk2tTqQJMaPL
         aK4g==
X-Forwarded-Encrypted: i=1; AJvYcCUa3yhP+9oskusv4Grjk0uiHIUU4HObsS67El/el6kKxepFbpJ5VEatDETeLJHchciaNBOQgi2PvVnuLg92@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHKzJEh/X7l9Jaga0gMTocNipynIfVjWYp6nB/ngE5GzVYpqG
	ihLicexQN+5nAIh1PhJ9RD/2PaJORqqN9/IIAMf61UjZy1GwlJAztB5cTWvs9PX06DfLwl6jNHG
	oL9fHblV0gbTfl+ypDxVbRHSgPm4LcUg=
X-Gm-Gg: AY/fxX4Xv/xRQgj1bmvis3wD/K31ItrOktwXZW1p7AY/eHfT4oyEGB5Za5szVH8xlmv
	wRip/t/0h9yBYpRurtTJOAa60iwvlpwXQh2ehoKSn6m5NU9dzHinlv1nJ3wqtj703L5gzwMWn/w
	642J19IRzq2fQnaW/VLFQcoVuX7E6a9+e/JnE0iO6s0klrlRulnuK75SmehKiSGLdp2QXj+ow80
	/dJ9zVMxqzJ+v0VoscZVjnrd4PnFs8vfi7efRpKkZ2fIQ/3cjGZOdDBwpTYi3D1CJQjmwl+ZmA1
	X+AH9bWCneupApcA8pASwLP0FgK1wg==
X-Received: by 2002:a05:600c:5487:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-4801e30d482mr9929055e9.13.1768504460920; Thu, 15 Jan 2026
 11:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com> <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
In-Reply-To: <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:14:09 +0100
X-Gm-Features: AZwV_QgZJLcC_-bQ-_VIrtnGFnLgmiVjy_ytBB44u2cGVyBOwKNqVyWt_Jfm7Ds
Message-ID: <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Theodore Tso <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> >>
> >> In recent years, a number of filesystems that can't present stable
> >> filehandles have grown struct export_operations. They've mostly done
> >> this for local use-cases (enabling open_by_handle_at() and the like).
> >> Unfortunately, having export_operations is generally sufficient to mak=
e
> >> a filesystem be considered exportable via nfsd, but that requires that
> >> the server present stable filehandles.
> >
> > Where does the term "stable file handles" come from? and what does it m=
ean?
> > Why not "persistent handles", which is described in NFS and SMB specs?
> >
> > Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> > by both Christoph and Christian:
> >
> > https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e=
93c00c@brauner/
> >
> > Am I missing anything?
>
> PERSISTENT generally implies that the file handle is saved on
> persistent storage. This is not true of tmpfs.

That's one way of interpreting "persistent".
Another way is "continuing to exist or occur over a prolonged period."
which works well for tmpfs that is mounted for a long time.

But I am confused, because I went looking for where Jeff said that
you suggested stable file handles and this is what I found that you wrote:

"tmpfs filehandles align quite well with the traditional definition
 of persistent filehandles. tmpfs filehandles live as long as tmpfs files d=
o,
 and that is all that is required to be considered "persistent".

>
> The use of "stable" means that the file handle is stable for
> the life of the file. This /is/ true of tmpfs.

I can live with STABLE_HANDLES I don't mind as much,
I understand what it means, but the definition above is invented,
whereas the term persistent handles is well known and well defined.

Thanks,
Amir.

