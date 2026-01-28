Return-Path: <linux-fsdevel+bounces-75714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFo1EDP4eWkE1QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:51:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD514A0D79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83CA23041BFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC79314D15;
	Wed, 28 Jan 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR8mdWDW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9F32C92B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601001; cv=pass; b=uIlXFoDRCne5L9CPS2WbkQFgw/exHFdR5Y9XZq0QpCFtRBbjd0i7EZjvCXG26UMy0o3qg0vniQJkKtxuHZ5Icmyvci4n12oXC1pPqwfQBbfT5Rl7oPk3CHi+/5z1phz4qvUBlREcSNceMTXBG80AoMESmNs1p3EZR/LQy1DHcU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601001; c=relaxed/simple;
	bh=hSMXOh0Oo+nPWIXGNy6Xy2ffhiMjw7bfObWyXyyTRFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p98cJlynBQFcnBzEo/t2uZC6OcO0rLhBQrXwKxpzfHBocq3dfCsHLHxuYr8lvP3t7kiEr7oO3O3ffPV4UgkbcPUwy7CpFbeJIz11Ze08TxyY5R2hURyyM1+ifBYBnB94XvEiKAwsItqls37EaJw/ZvUOXjbAFHcj8zEmO+M3rDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR8mdWDW; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so12263551a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 03:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769600998; cv=none;
        d=google.com; s=arc-20240605;
        b=LlJ8GZl1Gn+7AmwlbP3PXUQ823SafOA37Ilrv7UPCDtMoaoXmIRw1UaNOz+y+QoQOS
         Ich8Ym0sXK9Eu9TcMzyySJGcrzAfuUYBeof6bsPcw75YkKRG9VuPQX0Io7detgX9QyVa
         xwRxSLi0hJqY3a5cMdWKHHpEWc51TjSEx17UmfuXxZ+pfj5vsHrqV0ZtHM3hihJRwQ5E
         69bgvFvsMFzAV3RyTTzm/OAxOdJRXhS5CXOhkRfb+CLNJkeywiI6XQJ1n5TsPZH9pmZg
         0H9lZVH7ezWR+ql0uNefMkfh/A0cS8Iek9JpZgPYweQXpkbhX7G8rkFpyn5z2To43er9
         SD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        fh=OQMX+IIwIBS0KsrFoUcuZcA0wRRkZgJMEgXe7dk587s=;
        b=kRsKgoWSrBXXTzPhCl5zwmNt5w/rcHu64PxSCacJjBGA9smcfVn8VwBbAyERliYsFl
         Kv0w7pCkuEVesNEjr+LyXSXNEObtQKrpUR7fVS/IRLdH8mVOPaBqF+lKTv8e/qiKe1Gd
         2ZRwqyM0hcE7RbpgGfsETjo31L6tl1JwDYULnsiumsWBv75Odalg7qVl7/PVj4YKkhpW
         yniULFtfZNR/JDxmb+RWUpipujAknocgxQHSMUmd6nwdBwEI1U/wxLcoV8YF0InaO42r
         quHNxHcmzkK4jBy2rOlNuCsVWfvuvtYljEYwUFB99ZayKlLnlp1XvVs+6QhKP3vJRfH8
         A4rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769600998; x=1770205798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        b=FR8mdWDWBW61A+py/5HoKRuev9mIZIpSmqKtTdkiRzhJx4yurwTyHJqiayDAei1JJV
         D8rE15bAbp4yruitOxN9ghocp5wUSHwvtzUpipos6frHL91+9nHe4nsGR8VxAuGxJkQY
         tnIovD3EuXHOfvTUV81DwMwIcNnJFeO2rPKJTX5gK5nMutc6lAxKlRsr0kF9eQb13l1F
         xQMfKXrVAS1lxlIvk+4hGHrRSlVu7uUqk3G2YfvExfFWKiyZE0qMJQgnaSXieYTrDUCR
         0hHT05bTTVJeGqZ/a5iyA5Rp/Ex6gwYwk1F7BGNNHEbliXytUdSPaj5GtEEG8G+yy+Bx
         714w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600998; x=1770205798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        b=jfBNA5DTqDjwC0dWH7JMQtGoCxR1eJ+kXnbA+r5KH7wvUaV7Q3+d/OnSfzjZnRhMT2
         Gsqv4u+C/kmz4YGXie49fAmoyv+/AFoNL6/1vcLw1HqsMyuJjljgsslHLhYrg1pdIWzo
         ogYjsKFywcOEoOcTpb2bJzSIKQFElGxZDg+LfIBn7fj1k3yxhmgK80+XsFkuNBSZhCU1
         bJHHPA/q2KLpMmyayUlNkIO10smTX5dyN6FJmGfxzFOk0CZZqT4wr9/PxHF/RSNWxe4X
         n/Ia7/aNUz3gFyNQx8mHzdGw9ND8Db/xsoU7KiydbdPxGwixqASfgxH/clMhQzJzVQzd
         zrBw==
X-Forwarded-Encrypted: i=1; AJvYcCULykyrOUDaqSb/eq19CUwg8SPjZE8M332G7onIOXBegKdBuTqrfwu11RPY/DZbkMWdGI9auF7C34xpvyRM@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlYzZUEobtUxgmpoMFOfDf9RXhrmB4jPp6nBB2fYLOeKLa8Qz
	SRDlPYZBnxVINtoa1dQm1CLOe2uvRAfPSKRPQJ4FrMXF3ZQyVz/JXTrkNcG9+StcED6EwWy/eyo
	dgKeRh8srYp0sMDoZszp1EDXM0gKt49s=
X-Gm-Gg: AZuq6aJwZxwDols94Yu8FXXFDddsN9f0XfqIAfdQY9P+orVt69rsjcP+DRSNx4EflnK
	g1TTVmEhzGFW0WUMvTd8KFYMQqa1Q29nlx/mbdkwKdIwaL7SbtusbRB68lKX+br9QVnOiKCQ9Bk
	0Wo1kCyHll/ZDusVRYkjiI9RaqTqU5qepNz++P8/+0eAbl7tHxJdPqjc3m6w1J1RUjluX4QMHdC
	kZCxXiC1rk6mtZsQHDluPBRT1zGZ4rV34pS0VJVIB1wpHzyMEF9dnqdNFzNleMWoLbjMpJVGxK1
	TpztRjMneO1F8KAa9rWqm/EEnBR6nA==
X-Received: by 2002:a05:6402:35c1:b0:658:2fd1:b0ab with SMTP id
 4fb4d7f45d1cf-658a60b78d2mr2846925a12.29.1769600997470; Wed, 28 Jan 2026
 03:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com> <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
 <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
 <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com> <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
 <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Jan 2026 12:49:45 +0100
X-Gm-Features: AZwV_QiAes4F6-nhL9J4dFPbEOm7D7xrxYRKJxjry6rXeIbQy7RViH-qtuWr0fQ
Message-ID: <CAOQ4uxhHFvYNAgES9wpM_C-7GvfwXC2xet1ensfeQOyPJRAuNQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com, vivek@collabora.com, 
	Ludovico de Nittis <ludovico.denittis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75714-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: AD514A0D79
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 11:45=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, Jan 23, 2026 at 9:08=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
> > Em 23/01/2026 10:24, Andr=C3=A9 Almeida escreveu:
> > >
> > > Em 22/01/2026 17:07, Amir Goldstein escreveu:
> > >> On Tue, Jan 20, 2026 at 4:12=E2=80=AFPM Amir Goldstein <amir73il@gma=
il.com>
> > >> wrote:
> > >>>
> > >>> On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida
> > >>> <andrealmeid@igalia.com> wrote:
> > >>>>
> > >> ...
> > >>>> Actually they are not in the same fs, upper and lower are coming f=
rom
> > >>>> different fs', so when trying to mount I get the fallback to
> > >>>> `uuid=3Dnull`. A quick hack circumventing this check makes the mou=
nt
> > >>>> work.
> > >>>>
> > >>>> If you think this is the best way to solve this issue (rather than
> > >>>> following the VFS helper path for instance),
> > >>>
> > >>> That's up to you if you want to solve the "all lower layers on same=
 fs"
> > >>> or want to also allow lower layers on different fs.
> > >>> The former could be solved by relaxing the ovl rules.
> > >>>
> > >>>> please let me know how can
> > >>>> I safely lift this restriction, like maybe adding a new flag for t=
his?
> > >>>
> > >>> I think the attached patch should work for you and should not
> > >>> break anything.
> > >>>
> > >>> It's only sanity tested and will need to write tests to verify it.
> > >>>
> > >>
> > >> Andre,
> > >>
> > >> I tested the patch and it looks good on my side.
> > >> If you want me to queue this patch for 7.0,
> > >> please let me know if it addresses your use case.
> > >>
> > >
> > > Hi Amir,
> > >
> > > I'm still testing it to make sure it works my case, I will return to =
you
> > > ASAP. Thanks for the help!
> > >
> >
> > So, your patch wasn't initially working in my setup here, and after som=
e
> > debugging it turns out that on ovl_verify_fh() *fh would have a NULL
> > UUID, but *ofh would have a valid UUID, so the compare would then fail.
> >
> > Adding this line at ovl_get_fh() fixed the issue for me and made the
> > patch work as I was expecting:
> >
> > +       if (!ovl_origin_uuid(ofs))
> > +               fh->fb.uuid =3D uuid_null;
> > +
> >          return fh;
> >
> > Please let me know if that makes sense to you.
>
> It does not make sense to me.
> I think you may be using the uuid=3Doff feature in the wrong way.
> What you did was to change the stored UUID, but this NOT the
> purpose of uuid=3Doff.
>
> The purpose of uuid=3Doff is NOT to allow mounting an overlayfs
> that was previously using a different lower UUID.
> The purpose is to mount overlayfs the from the FIRST time with
> uuid=3Doff so that ovl_verify_origin_fh() gets null uuid from the
> first call that sets the ORIGIN xattr.
>
> IOW, if user want to be able to change underlying later UUID
> user needs to declare from the first overlayfs mount that this
> is expected to happen, otherwise, overlayfs will assume that
> an unintentional wrong configuration was used.
>
> I updated the documentation to try to explain this better:
>
> Is my understanding of the problems you had correct?
> Is my solution understood and applicable to your use case?
>

Hi Andre,

Sorry to nag you, but if you'd like me to queue the suggested change to 7.0=
,
I would need your feedback soon.

FWIW, I think that this change of restrictions for uuid=3Dnull could be bac=
kported
to stable kernels, but I am not going to mark it for auto select, because
I'd rather see if anyone shouts with upstream kernel first when (if) we mak=
e
this change and manually backport later per demand.

Thanks,
Amir.

