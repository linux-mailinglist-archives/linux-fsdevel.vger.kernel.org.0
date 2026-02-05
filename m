Return-Path: <linux-fsdevel+bounces-76464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IvjFdjIhGk45QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:44:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1FF5654
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBEE7302E0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A7439017;
	Thu,  5 Feb 2026 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keRh4j1A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473223EDAC9
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309818; cv=pass; b=S70QUOH8HqsAZ7SwSHUilzJvz1DQWbQgm/Ij3w/ZuTww5NA3bBdRFC3pLXjWVcn3nSF1biVZGomk39cuG8yLf2L+zD8P464+yLtF0aBXifXz97iYvR8bPGWNeDyjC61XfehlUspWSl/o4Jo/UsFFkbX2MAYfJu/xrxQlLf3CbGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309818; c=relaxed/simple;
	bh=gTr98O/DYzbyUlRuEsGi1UGtuGUdlDO/0L6WtpJZlQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrqGis3prkbUE4fbDHwkcEoK6pogBS5wULnNViMCqgI+slOwmikuiTTsdrwxZff1D3BB74S5aYQp1TXfk4gWF+iU/gB7WFOLneW+RGbeUTgPg+1ZXGMPzw012MK7nLKCmHiM1KftjXKST+w+HFMeX6JriNWyPc/QCQw2p+PFMY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keRh4j1A; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so1246839f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 08:43:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770309817; cv=none;
        d=google.com; s=arc-20240605;
        b=QWucUeiLc/+oM/ZEOISgnxD6+M7qnYDiLzaLoqjLcRs3xrlPXz6BmutbGEwYyrfNC1
         M+a22BRCDYekcls34FBeHPncmzGHZ+ODz9FTeHgdcH1q059fMH0xEnHZjph6MK34OuTQ
         o+4SDw1EPfmpaPQOfcPwk1m5TzrGhSiUtgZ+wYL6PPPBfGljk8WvJs/zf9Sjb8NRZzBM
         hIvPNi3WBLOY1VkE9X2ISHQNjvw7QLeHtSD54tL+5wo4xYi+TObIUm8M6uqfJuD11Teb
         j8t3bmzIqK+wK2JN0c6DCw1Xj1b4vzu2eMpUlbUwBFaaqPbRaI1MtIuE+GtegpygE+9O
         Aa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UgbA8L5X3UGyVPXB+Do1ZNMkWOmroS+AR1xUyGD8l3Y=;
        fh=qQDEEANl/IoKCtcnxMc1hO176Gpnk2/tA/3PwN/2JXE=;
        b=J9D2gJdflKnX/YJfUuVIl/3atQBkWSPelqg/E8xlOAxF8upddbZfmq2XtEQn9C23dh
         xw9/shGmWmw7Mk+6ym/UWUdqdsvz+FRs7SkVhtyil5U7uhQzxs6AjaCOw0Aalzbt3aIw
         bNx25A4E88XcdFXL0YWdmkXGBMx9Hj+md40RpEuT7u1mM5EB+u9FxmtCV1JOq4OXG1Nq
         5Dat4xmL9Sb49/y64ipyjH3iHDsRVVozm13TCAJ0zo0NgnG/amt/3Pzr1iPp5g81giZI
         2elTJ930+BYSRngQsapBVV8s9nfIHhHoNZ96bd+x6Wyo6gtJLh6LUQAVRbxTX8ao6WE7
         1aJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770309817; x=1770914617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgbA8L5X3UGyVPXB+Do1ZNMkWOmroS+AR1xUyGD8l3Y=;
        b=keRh4j1A/2sSPssu0N5iEK85lBjEnmPpr4qnUXVP+jpQ5uIHwwstNGXKeTSY0LO0ec
         lt4r2dTZt9wf97oHVg51WybBVbaPvv1cxcIOThZH1vNH09ubsEXirX8Y6Irjgb2b9+TG
         Igz7ffSUGte9ifDtjnjyhn9C0D82Tbs1/CfDE9o09R/8EXypB9tnspiyayj0hrqqjIQG
         XiPp+qdcrt0/EPADXkPV8yW8EGeh3quuzKxaHRisQUAkXvZ0J26jxk+48DsyFSaoa8xs
         kXNjLQpQlT5pdc4qSEEotZJ0dXZ4mb6l+ei3NhcO6sdowDNLeUV5JzKHNEqNw+cPuRr3
         NF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770309817; x=1770914617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UgbA8L5X3UGyVPXB+Do1ZNMkWOmroS+AR1xUyGD8l3Y=;
        b=IoqtVfVyax1SHMAkUumRMZuHgA+rYayWYt9mGrUbmrSdnT+KVph2V0MKxNGW5fw1rA
         3BsPrVn7QfCQZ4JT44jtpGc7paH7TCJWBAqOrrJJTwFwqM4H/zO2GbxHNoVyYhta5Vgc
         D4YLWDuHJerkfK0BUKlmJU2C6AWj5fOBPGRIT2uAriVXlHqpXb3vn3EeARSxdMYKuCag
         opBvboyD0yvtucEnWlX/5VfRI8yjlqwB3WImdXIDMCI+lMAqnWr0OThzdtSQAmmDny4I
         o2qK5oHtHgwXLyH73jDKlF8P7uvfPS+Ppvz6wNFoW1sKU9qagK/Gd2NOnKojVsCxZCm0
         PdXg==
X-Forwarded-Encrypted: i=1; AJvYcCX8WfaJmUNNyCLAHkJ4ajG7rcIOjmHObNxeWYNr92itMmBhHQivRePvHie/k0VUsS7NpSs5q+030cJL/t3q@vger.kernel.org
X-Gm-Message-State: AOJu0YxETx0yBzpYs0pT5PLkJaUixAqFHe6Q9K3pQFE+2uVJ2/hU7AKK
	vXe4ysrzE99rqv3LTy30xI39jLrbiU31uBEdVge/xTthLkSOTSkNyegBkEcpb6pwOETY57Ojghc
	MSgi0fqRIopfiV9DDVOuffi5jlPkTvio=
X-Gm-Gg: AZuq6aKadzYkF0t0ensy9hB6gYe5+sLx5iVflPyOkZ59ofbaDv4/0oFhHwvqNpVdJZN
	/Shtjmzwsbqnr7vtDImzFVI4fi5zk2d6iz7kWW4JG33wtEQIEUW02TX/4mUI7hzReEszcN+8FZs
	SGsnECeJxUiNV3MxzTwrEaQG22/vV5iUO9Z6YI4DAYxU2nPjQqrJubbmjrQhxRiT4cYfaEfV3ex
	ZAnjWzkS3mU17mRdm3RP9K6ThK3AlCTXZOWBxAEp/v8WKqf7oQ6w/ommsSuul9qPg6/AbUkFlCE
	OyJtYEqXaMadpOpx133VWhZDRFWze3aDfPzPpbOsKVR0NZsbDVfd6ozjSLTHgJBGQ+4T2HDc91Z
	PNrvRpAs=
X-Received: by 2002:a5d:64e9:0:b0:430:fc0f:8fb3 with SMTP id
 ffacd0b85a97d-4361805108amr11435730f8f.38.1770309816579; Thu, 05 Feb 2026
 08:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
In-Reply-To: <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 08:43:25 -0800
X-Gm-Features: AZwV_Qjb6S-iktO4Dnfz_v9yb534efgmChlpNeMneF3ap-F0hPrqSmgKQJpJcKA
Message-ID: <CAADnVQJqL0FUKZ5Vo4thH1Xk-O6d4BSO2M6kPNRZP0V=opEMNg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76464-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mihalicyn.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAA1FF5654
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 3:27=E2=80=AFAM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> >
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 005ea3a2c..c350857b2 100644
> >
> > [ ... ]
> >
> > > @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type =3D =
{
> > >       .init_fs_context =3D bpf_init_fs_context,
> > >       .parameters     =3D bpf_fs_parameters,
> > >       .kill_sb        =3D bpf_kill_super,
> > > -     .fs_flags       =3D FS_USERNS_MOUNT,
> > > +     .fs_flags       =3D FS_USERNS_DELEGATABLE,
> > >  };
> >
> > FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the ker=
nel
> > tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defi=
ned
> > (at line 2268), not FS_USERNS_DELEGATABLE.
> >
> > The commit message states this flag was "recently introduced", but it i=
s not
> > present in this codebase. Will this cause a build failure due to an und=
efined
> > identifier?
>
> Yeah, this should be applied on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs-7.0.misc&id=3D269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> in vfs/vfs-7.0.misc I think.

I think it's better to go via bpf-next this after the merge window
to make sure it goes through full CI run with AI review, etc.

