Return-Path: <linux-fsdevel+bounces-76465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFIYCTzRhGk45QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 18:19:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3513BF5D0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 18:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1EC7300C7D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383442FD1B3;
	Thu,  5 Feb 2026 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="LMIRvyXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945921A453
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311883; cv=pass; b=Crc/MTjCEC0FSmLo/bakn3SeRpT2EJFIGVK/V6GiuRwCNcOytnmH5v0xVNqXIQFHxEQg1Ek1rDByl9VRr15Pa69WIIh0bN/LoMLizVckmyGttQrgg08TTzEWc3xhD+TEauEX20y+Ip0yaQAJSiqu4HveeioHbfm2szZR07ZYGRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311883; c=relaxed/simple;
	bh=4c1kqkyjLe676ojBxo1iOioWKN+q6h1zbdknWAvo6xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgfZD5bUJbGl3udOSsX9M9oSluroJVXmr8g6FrkA/7Q1JXczMRFPxQ5VF3Vxsa/+edtqxWynlbLCoSRkG4+XAbWSbFoi+6f7GCSMushBWgyFfGRH5fazjpKDoWuIUeReyzgWATvbny8W2rveH9GyAG8D1gg2WVUmKl8PL/4oQmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=LMIRvyXB; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e17afd2d5so1622266e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 09:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770311881; cv=none;
        d=google.com; s=arc-20240605;
        b=PT52Nb72WphE/jorK9NoY2nHeYjlt4qTVtsz8AWJOAqLsLZpPYl480i6Zx7kw3ZyNh
         LyZ8R9QTrxnngVrByZXt44/Uqb19Jf/GAxs70fNyFb6Sd9r9rtPk1bty/Q5lw0HFbU1x
         o8ydc6PRpkdefzeJjI4bnxMKso12SK/YCjiLH7kyUTlQ5knnx9ihSpdP/9vK8lRGXH/z
         WY4Zkhf0phzozzRfkMOPoNaHkbqplYvLrX7qPmJ8a8ClPRYAskpoO9rhqbB2vCj9lds+
         IrZ2b5gs4j+NygBmevmFsKu0C1eEeAZAA7Wd5jWPL9N5kGZgvDvYA/2zsHjA1NadZGsj
         K5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qA/hEZpuGKjpxaEvxb4OyM/ccaGMhGqw5+mS4IYoYlU=;
        fh=7s1vauzfq0cvpv/feW7IiHJZeyw2B7Qe7In2KcTX3e0=;
        b=T6aB+wlH36sxcFqWyC/w/FeNkFQbhldjOUUgGbkW0dyo2WM81ET6X2Qr4qq+atMnBZ
         vQdiLc4d84RWMhc2pqAqXfdT/sOZneHMiahOxI70+Z6++F0FcCKqKoFMKg59GcTpqf8T
         dv3HGb5bl2I3m4qY72o5cLr4axXoR3pV0zajE7jfyOHYYOy/18pXq70IGSXwpHy9zcIz
         8hc7l73cJVy0ZhS3VdBh9mT9dUiC98hJ7Rru3dyqpHnYZHjgY8E+TkRDD3o05i6FzfbF
         cRvIFIMJFAlPHhEXFutHYLmxxUpFgGh75DMuLsx6QnFPeiDnVb9Kj6lPevVhypAO6DyZ
         SdKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770311881; x=1770916681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA/hEZpuGKjpxaEvxb4OyM/ccaGMhGqw5+mS4IYoYlU=;
        b=LMIRvyXBCp7x64wOwtSrXIzJWsqhqrR5VAoRuRioHTFv+QPiWuA5HMAWQ6Zoig5qle
         TFpNrrd5vKOEAsWWB3/0xTCVyJ5fPO1BYkiDPwiFpCgSXHiQB3FS6enljNRYtVHN0T9K
         IXTjaJk/F7A4Zb/PdsZQt1lWPbM4eMyYe9ad0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770311881; x=1770916681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qA/hEZpuGKjpxaEvxb4OyM/ccaGMhGqw5+mS4IYoYlU=;
        b=Baz4JrYIamRkHoZUC4LnZ1BaeW9jvlfPy/7+tRGjeaRfiNPNwlZc26kbpnBQykr7Np
         ZUHqQjN+64dIX16nW9BfNpmpymMyKgZVl2eW+LbKhIeYtj7vfZqIpJbq86YRYtzOhRGf
         BlyZWANok2ny4K38KCebUjm3TGQ5O+ELIe4B3tSV916fRZK8WFxnq6oSAahCcDbkwkz/
         E7OjAGZSKobhDinh17VTGKWldxsx8gORmJYupt1kdab+nV5gB0EysPaSJE1OWEsbEGeg
         569Ezsn2hF86gky6Aq7zWWY4Vl2GMhDKPpuMslV54hBJqvR+AX3Y9UCUjZ2MH/kzDdBN
         Dovw==
X-Forwarded-Encrypted: i=1; AJvYcCUkDSXDMhk3DcxbJi74Qe+m3rUMOqfSRgmWqhg7SIAR9/Tyf4W6UYK/TIGmVrD8xEHw+m9WthWt9aNiU7Bk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9uIiJZ00vAFvFerkyhRk4oeuJM6+4YDvjsxvhLCgGwy8UEZHG
	cvNFdY6OgI1SFdD78CXtMCGygb5Q+CF6qlH5Sg2SVi259Jn8zuTIPcCE+y2jbn4BL+ryFOWvf3Z
	Hmijef8cXmhKSZgqa8Lwv2k5+YF7SMmsUC7ITSF63CA==
X-Gm-Gg: AZuq6aJQBz4BLumf4JnbZlnIK2XDUui6RLOcCFOxA383F958N7H//vC1hvMVeePpwyg
	1NsUFc/VyP0MCXvc9JIk2mosybN+lKlUile24pFiGnoFhS3hoWCRtNWPC9oQtmyS1KKs7DwDqwN
	uo9MZIlWi5xGobaM12QzHbFcTDzK08pNWi/crNJHGVkI8jmLBLLak7+woA+QKSF6KkxGvv+UjFr
	qGCAcJ8ydHXgb0mqfxhUZalMKwAM1J/loxm87GqOGip0xwBbtPDnd04ocBscJGjNMYIFXov8Ywy
	r0HAPXvyT09jDVBt0kqbungiog==
X-Received: by 2002:a05:6512:4001:b0:59e:479:917c with SMTP id
 2adb3069b0e04-59e38c359b3mr2629269e87.39.1770311881298; Thu, 05 Feb 2026
 09:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com> <CAADnVQJqL0FUKZ5Vo4thH1Xk-O6d4BSO2M6kPNRZP0V=opEMNg@mail.gmail.com>
In-Reply-To: <CAADnVQJqL0FUKZ5Vo4thH1Xk-O6d4BSO2M6kPNRZP0V=opEMNg@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Feb 2026 18:17:49 +0100
X-Gm-Features: AZwV_QgC2HbXVe8BGI_t1Hbec_qoVnGkULZZYVElG6i057xj0OEUbx9EQoStGYw
Message-ID: <CAJqdLrpOGmCC2TpUGisBYQCHpjd6L+LQ40UiuNqWS3pOHFkcFQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76465-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io,meta.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,bpf-ci];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mihalicyn.com:email,mihalicyn.com:dkim]
X-Rspamd-Queue-Id: 3513BF5D0E
X-Rspamd-Action: no action

Am Do., 5. Feb. 2026 um 17:43 Uhr schrieb Alexei Starovoitov
<alexei.starovoitov@gmail.com>:
>
> On Thu, Feb 5, 2026 at 3:27=E2=80=AFAM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> > >
> > > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > > index 005ea3a2c..c350857b2 100644
> > >
> > > [ ... ]
> > >
> > > > @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type =
=3D {
> > > >       .init_fs_context =3D bpf_init_fs_context,
> > > >       .parameters     =3D bpf_fs_parameters,
> > > >       .kill_sb        =3D bpf_kill_super,
> > > > -     .fs_flags       =3D FS_USERNS_MOUNT,
> > > > +     .fs_flags       =3D FS_USERNS_DELEGATABLE,
> > > >  };
> > >
> > > FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the k=
ernel
> > > tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is de=
fined
> > > (at line 2268), not FS_USERNS_DELEGATABLE.
> > >
> > > The commit message states this flag was "recently introduced", but it=
 is not
> > > present in this codebase. Will this cause a build failure due to an u=
ndefined
> > > identifier?
> >
> > Yeah, this should be applied on top of
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-7.0.misc&id=3D269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> > in vfs/vfs-7.0.misc I think.

Hi Alexei,

>
> I think it's better to go via bpf-next this after the merge window
> to make sure it goes through full CI run with AI review, etc.

Yeah, thanks to Daniel's suggestion it went through full CI already.
Please, see https://github.com/kernel-patches/bpf/pull/10970#issue-39014101=
45

Kind regards,
Alex

