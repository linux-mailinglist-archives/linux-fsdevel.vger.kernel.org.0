Return-Path: <linux-fsdevel+bounces-5738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E4A80F6C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3191C20D7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2081E5C;
	Tue, 12 Dec 2023 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TErN9J6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD236E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 11:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702409887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IuPeLZWXHE618u58SYZuwlY/nbyijM369pAi7qe4tc=;
	b=TErN9J6wBBWeXWGVnSvnlWF8MwY6G5r9LWtymLiiwq+YlfWC4IyvdkXRacl0soTLCJbguW
	e1u6DcAqeNGDe0T/n9+60dNcf1xNplzNLtdwU2KC+ftHQjTjHDU4BCS5kaNWnBJQxG5fk/
	tS6juAT+d1GsvKPH6Bpt6F51h9R2qv0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-E1jZzw8gOGKbnnz9Vo2RtA-1; Tue, 12 Dec 2023 14:38:06 -0500
X-MC-Unique: E1jZzw8gOGKbnnz9Vo2RtA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c641d55e27so3788261a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 11:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409885; x=1703014685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IuPeLZWXHE618u58SYZuwlY/nbyijM369pAi7qe4tc=;
        b=cJKJu+Zf+s13vVb9Rt4h9O65yqsqaLL/r1muKgec8gtd9xj47wXFyCZTWBdDbRazW7
         ZY15pi3KxzwvXH5ZMEpw6AhgFeVJrElyz/cJ9SivdSmvSDrpRO09X4hrXu1M1/QIwMjB
         W6/9pVO6U2Tatcwv60S3l3dfbSei+eSOu4WIMfoCrZmbm6GQkjt0XQ250lAfYJ69Kz8J
         cIsp5MEAvzr3fnX1V2/EKijhwe4RXOaj/dZcX5+ZZZsW4S36mfmpKmVo8KOPyNE1TDf4
         hPTsGq2RrmaKIXn23IjZozcNzgx8zjVIW7ITYAQABs6jAwAqMoB1s7Lsn6hJJAiz/kiB
         +OZw==
X-Gm-Message-State: AOJu0YxXtMyAbNAjnDIrwRqAVdV8Qb0NTRmEFuvh8gyv1+LITnN8m2Ak
	bkdoKIkHv45M7f5cRrRHhuFNPh61x3WQ/ExlnEBluGSdKI8uscvsSEwR2f4i+KGEzQ9I7mSJomV
	uwGM8M7jUDk5CChQVc5BASbj2Rqyw0h91WdpRGX9V1A==
X-Received: by 2002:a05:6a20:8e14:b0:190:23b2:cf1a with SMTP id y20-20020a056a208e1400b0019023b2cf1amr8374157pzj.22.1702409885421;
        Tue, 12 Dec 2023 11:38:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+xGISr5WA3vtBh1oLpeAPWxlRJLMhZYbs8WjSt+jRJh3aqZk+WkaQSNeow/CJnj8A0Z8u1z+KDKAxLqOe2Ig=
X-Received: by 2002:a05:6a20:8e14:b0:190:23b2:cf1a with SMTP id
 y20-20020a056a208e1400b0019023b2cf1amr8374144pzj.22.1702409885088; Tue, 12
 Dec 2023 11:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109190844.2044940-1-agruenba@redhat.com> <20231109220018.GI1957730@ZenIV>
 <CAHpGcMJfNNRDAvGhH-1Fs79uTks10XhLXBLeCqABoxufZeLGzw@mail.gmail.com> <20231109222254.GK1957730@ZenIV>
In-Reply-To: <20231109222254.GK1957730@ZenIV>
From: Abhi Das <adas@redhat.com>
Date: Tue, 12 Dec 2023 13:37:54 -0600
Message-ID: <CACrDRjhqrcDivT=gtYA_qMAzXEvBWg0LEnDSwSxYVvkuaT2fVw@mail.gmail.com>
Subject: Re: [PATCH] fs: RESOLVE_CACHED final path component fix
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

Did you get a chance to look into the RCU pathwalk stuff a bit more?
Any ideas on how to allow may_open() to indicate to inode_permission()
that it's part of a RESOLVE_CACHED lookup?

Cheers!
--Abhi


On Thu, Nov 9, 2023 at 4:23=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Nov 09, 2023 at 11:12:32PM +0100, Andreas Gr=C3=BCnbacher wrote:
> > Am Do., 9. Nov. 2023 um 23:00 Uhr schrieb Al Viro <viro@zeniv.linux.org=
.uk>:
> > > On Thu, Nov 09, 2023 at 08:08:44PM +0100, Andreas Gruenbacher wrote:
> > > > Jens,
> > > >
> > > > since your commit 99668f618062, applications can request cached loo=
kups
> > > > with the RESOLVE_CACHED openat2() flag.  When adding support for th=
at in
> > > > gfs2, we found that this causes the ->permission inode operation to=
 be
> > > > called with the MAY_NOT_BLOCK flag set for directories along the pa=
th,
> > > > which is good, but the ->permission check on the final path compone=
nt is
> > > > missing that flag.  The filesystem will then sleep when it needs to=
 read
> > > > in the ACL, for example.
> > > >
> > > > This doesn't look like the intended RESOLVE_CACHED behavior.
> > > >
> > > > The file permission checks in path_openat() happen as follows:
> > > >
> > > > (1) link_path_walk() -> may_lookup() -> inode_permission() is calle=
d for
> > > > each but the final path component. If the LOOKUP_RCU nameidata flag=
 is
> > > > set, may_lookup() passes the MAY_NOT_BLOCK flag on to
> > > > inode_permission(), which passes it on to the permission inode
> > > > operation.
> > > >
> > > > (2) do_open() -> may_open() -> inode_permission() is called for the
> > > > final path component. The MAY_* flags passed to inode_permission() =
are
> > > > computed by build_open_flags(), outside of do_open(), and passed do=
wn
> > > > from there. The MAY_NOT_BLOCK flag doesn't get set.
> > > >
> > > > I think we can fix this in build_open_flags(), by setting the
> > > > MAY_NOT_BLOCK flag when a RESOLVE_CACHED lookup is requested, right
> > > > where RESOLVE_CACHED is mapped to LOOKUP_CACHED as well.
> > >
> > > No.  This will expose ->permission() instances to previously impossib=
le
> > > cases of MAY_NOT_BLOCK lookups, and we already have enough trouble
> > > in that area.
> >
> > True, lockdep wouldn't be happy.
> >
> > >  See RCU pathwalk patches I posted last cycle;
> >
> > Do you have a pointer? Thanks.
>
> Thread starting with Message-ID: <20231002022815.GQ800259@ZenIV>
> I don't remember if I posted the audit notes into it; I'll get around
> to resurrecting that stuff this weekend, when the mainline settles down
> enough to bother with that.
>


