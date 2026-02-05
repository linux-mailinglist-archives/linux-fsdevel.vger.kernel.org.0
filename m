Return-Path: <linux-fsdevel+bounces-76466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMrFLAfThGlo5gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 18:27:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51892F5E5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 18:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0342830528B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4C43D4E4;
	Thu,  5 Feb 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfzH+NjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DC2E888C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312303; cv=pass; b=CRI2tKiJWkhEKIjVPlrdej8tvqrOj9tlZj2tNqKUv5hVUkzGi+CYNbcJXgbg4fHO2kWUNnpXwPis5Z5/kl37vooXADm7GFj71RrsznSW6NA3wplDQCo1UJugk4SlJ+kkTBnKjaN5SIBdrjwv8p0+wnqMsXigpKomtE6HYMKRTQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312303; c=relaxed/simple;
	bh=DMTb5B9qkJKFk7NxcxzA+QYfWF8VXD8biOcK5qjwuL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBp48HstqDNHEYs/ArjJGlLlYNmEKUMfjDRyaPmH60CJSf393/PkyryjhgkVy6wQ7jF1QWNpSNlrU437NsLHxzRFIcbR/k6vSP434qeNPzNW3Io3HHmYr22mDiQreSr1PyPE5l7PZ9wZE2ycp4ZIP5eQQPMG23icMWRvaLwlG8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfzH+NjV; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43622089851so818143f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 09:25:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770312301; cv=none;
        d=google.com; s=arc-20240605;
        b=REUK/Sct6lVV7q51ZAFF1757Yb9NgBOUp0MOMuI6q0Ihb01BffiTTxZaSkZBRkpxfM
         zjdXo5c6NH9tmjhr5b8i0+XUoiQLvXIpgoDCXHUcUazD8VyJnnTIQfSks3HhmDndH/+G
         chMHxt2A/i2aGsYNJKCpNpzgn/Bwlju0FXZ+SWgk5kwvSj4z3DzFsvKWr3uAS4UBLM4q
         VgaABsPrxr5yfewKdo3JGenVGC85Y1Mi0nYgHDPycxbh0SDfAwKaeSj1/aV4A1AzpOaO
         CK57SI+6h9qUfSRxzXn5UJovB2j0WvBcP1HmJrrJWIdZJ9EWGSf0KZ20vwXomHMys6/t
         ArCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qk4pZJZ2L+ZEgp09mij+ITzhn9MAtWKZuACbdw3VFPQ=;
        fh=uIhnS0P2YRryglNnmGszEPLvXhuIW/ivx7F6Bmb5RNY=;
        b=SVRmrlpYel9SJWlCa5GqIiw1GtjSBDmOiDHJowbVV6O3y9UgycKOTA2ZEiEI1VmqUs
         7S+SJaPEZbcsqrQlDu7NvCtV3qwqa2u6uGqtmsXVCW+D1tpq/5VEEynffyMnUqgyM06N
         pNy6IYKL2Lv9ilwqWMfiIoAU8pBe+x9zdDpoXwoC3Uz8Ui0s5s0V9p2g+YtOurC86/DD
         ucau0BaUcW1Ao7mNabejcCACGEXWMNLw0IKnxZ0qnMMfTY+sfwFUjIYQTqAIgUsmhNsz
         mj4Pak1z32CuVszr0UOMZ/ipCANuQxYlfCKnt9rxHmeQtBOltYg2croKWWdx1Ete11wV
         3lIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312301; x=1770917101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk4pZJZ2L+ZEgp09mij+ITzhn9MAtWKZuACbdw3VFPQ=;
        b=dfzH+NjVsPRTQaT+MI04BrLTzFdnFq849xrb7TqLra0ULaoWvqlm8eN1ivYBbxRDca
         g1brMQrkXIkcK6IClGfbOwwdtl3VsiHVIvQKoK9U/ADUL4AizFtq7I+NysB5V9AwSSid
         UMae1Nb2sz+Di7HEm73361xZpawzUheBWhGACeeno40zOCnUnHE1QTH4D3/z+CPG6Qtu
         h2poZko8w85SMn+cNpLnPmGv/LXhZc5+D5pZCCI6Ei7rg2eSMY0pWccjgdgz0Glm7Yvy
         LE6VhF3DhbCA9LNRQavF4KNlh4zpCbOnzFcZxcs/k0pSjWl66s7qS8HjvjnmrcUTBtTq
         xHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312301; x=1770917101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qk4pZJZ2L+ZEgp09mij+ITzhn9MAtWKZuACbdw3VFPQ=;
        b=IKiN15rfSeDlcXUKul0MVbZfxxqg5hznW4uNLOlJncDBHJPNO9+vhO9nVT8XMrZx0e
         U0TCQt1vX+4paf7g1Edc6p+ZMYLs2v4SmVAKuLEtpf8wJkwXJ3o8n43qqy0CyEWSdcwK
         7oVlWDQ4Y1AAENAekkAuyEzzfeNCwOJYUHsw5fNH7RI97zYYBfGhOjVD3nrQcVUMKRh/
         FY508/Imvicy1ysQZaiybV/3DXiwZWW3Q8o0jZMSfQWFVeEnSwCQipSdL+AWBTh3/D0v
         p7Zp8hN3okJ69dKYlDxnVZE/QB/rQCary7PmxKqkwfI4ika8ku7KGplMjTjHIZi3poKv
         SrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/sdEYgqw1nR6xnU2U88A0YAiRm6ZR270XYwcqUSGoGO5+A+6R+tLPdNsl6aYbEq9SfwdP6LhgkbFYnMo0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fjOX8Z3ThcCwY5ISxEM2WTALGSKSRn1m1zCTz247x0A2PrHh
	h7OAA1AKGOzRJRerQ5zkokQT9y94xtPRFSzo1jPj5PB899kk/IndVMF1x/YHf7IC0UWVxrlpPiT
	7d7tc5gRB3WHXWb3QbMjwrr6f/zTqwAg=
X-Gm-Gg: AZuq6aJ6MFnR9/waAsZBn0DTaZxUgL/4pR4dtuVTPZNlW9dyyZ5rolVWfYFCFKhYXUW
	RVIGRZtqqEjYNmvAWJwSDuEun1sy2MOYc0UG9JRUvIX+fspZHammN2vhD+Kv2/4L0mKh/c1eurs
	TYcFrBRdDMBSk+VHgb6zCHh9WGvcBAkbhmCPTfkNL0AmwXOKI9LfQM6/cClgcYtP65jkQMZFCUr
	q0pPWS2IJWo/GGU83KeHV4iLEl776jsSMnoqwEoolBVDKfCeB8HbAgAYPXe8tgZmwDZKBIor30j
	RTlqHoSBG8HWh/63j/elW+py+gvGZf6HUwbxEUEObDL3qKUD1BrZtOzu+uYrF3jdfKIB8M5O
X-Received: by 2002:a5d:5f49:0:b0:435:db6e:e3b3 with SMTP id
 ffacd0b85a97d-436180510b8mr11032357f8f.36.1770312300694; Thu, 05 Feb 2026
 09:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
 <CAADnVQJqL0FUKZ5Vo4thH1Xk-O6d4BSO2M6kPNRZP0V=opEMNg@mail.gmail.com> <CAJqdLrpOGmCC2TpUGisBYQCHpjd6L+LQ40UiuNqWS3pOHFkcFQ@mail.gmail.com>
In-Reply-To: <CAJqdLrpOGmCC2TpUGisBYQCHpjd6L+LQ40UiuNqWS3pOHFkcFQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 09:24:49 -0800
X-Gm-Features: AZwV_QhX8jNgLQecMVLNMt9XW360bpfLh21FFI_JxTtrSwJ4_tNSTUL9Po7oC3A
Message-ID: <CAADnVQK_nd0MSo2RZ7upNyPPkpUy5QhJHwA189Lbeo=5DptN4g@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	aleksandr.mikhalitsyn@futurfusion.io, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76466-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mihalicyn.com:email]
X-Rspamd-Queue-Id: 51892F5E5B
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 9:18=E2=80=AFAM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Do., 5. Feb. 2026 um 17:43 Uhr schrieb Alexei Starovoitov
> <alexei.starovoitov@gmail.com>:
> >
> > On Thu, Feb 5, 2026 at 3:27=E2=80=AFAM Alexander Mikhalitsyn
> > <alexander@mihalicyn.com> wrote:
> > >
> > > Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> > > >
> > > > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > > > index 005ea3a2c..c350857b2 100644
> > > >
> > > > [ ... ]
> > > >
> > > > > @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type =
=3D {
> > > > >       .init_fs_context =3D bpf_init_fs_context,
> > > > >       .parameters     =3D bpf_fs_parameters,
> > > > >       .kill_sb        =3D bpf_kill_super,
> > > > > -     .fs_flags       =3D FS_USERNS_MOUNT,
> > > > > +     .fs_flags       =3D FS_USERNS_DELEGATABLE,
> > > > >  };
> > > >
> > > > FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the=
 kernel
> > > > tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is =
defined
> > > > (at line 2268), not FS_USERNS_DELEGATABLE.
> > > >
> > > > The commit message states this flag was "recently introduced", but =
it is not
> > > > present in this codebase. Will this cause a build failure due to an=
 undefined
> > > > identifier?
> > >
> > > Yeah, this should be applied on top of
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-7.0.misc&id=3D269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> > > in vfs/vfs-7.0.misc I think.
>
> Hi Alexei,
>
> >
> > I think it's better to go via bpf-next this after the merge window
> > to make sure it goes through full CI run with AI review, etc.
>
> Yeah, thanks to Daniel's suggestion it went through full CI already.
> Please, see https://github.com/kernel-patches/bpf/pull/10970#issue-390141=
0145

No. It did not. AI was skipped and all of netdev tests too.

