Return-Path: <linux-fsdevel+bounces-7493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBF825C56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 23:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520C21C23AB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281FF2E855;
	Fri,  5 Jan 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeFDryb8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06506225CF;
	Fri,  5 Jan 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e3a67ca9fso409975e9.0;
        Fri, 05 Jan 2024 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704492357; x=1705097157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yX4SAu6pYw6za7F39utAvXrCmkEA66HbLQUw67wq6Y=;
        b=AeFDryb8WMnYMwjcbgIv+fs5Lroq7jPxvsXrqkQspYoqQimojIBGz+w50ydcdin4rf
         KLdqzScbX9HGV33/yybqBTkZJUKh9lIBT2oQOYYfq3gFd3RW850i+ZazoddBhx2Ul+zM
         Oz6rcQi3gm+C9I2W3InphIVQ2/ro9KBPYUh32LNUmbEJQwgif0vyZxB6IkWwFckePWPA
         aW6rP5ujtwLHmi13uJdzfbTO2YScedcTkKhSvNFjHst/Q8M2eOtzyGk7IM0844zU03vn
         IrbP18PNzKfsTOMA+DfS+Nh0pww83JA8GuRGmqgkKYJ9VheitiN7qCyS+QnmMxGqibiK
         gQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704492357; x=1705097157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yX4SAu6pYw6za7F39utAvXrCmkEA66HbLQUw67wq6Y=;
        b=crkFHwiRr63YurV1tJ3V+32Z/PP0xfum0lcz2ArrrEjagLVyq7nComUV4Q8oM138uR
         3IkkDTUXcUakMukemfGbBjHo3lpCmxxQHATrO3qOSzk7iSsH9AMmcomp+yWBALsgVjj8
         SR1xTCzZ/HrMSdHZ3MIzspbtAE3ie4C/232Xara/Afqnwnli16ZCad7A2xnmy3gcpP1E
         JCHrR408O8YnHyMfx8i53ugkL3gGWcfsMEteMXuJ05Tl02hh2B+BRK7+Nqgn3MD3p81J
         tLfUjUrBNr5g0suCGd6k3eeTMAX5FuqTYLrlcCrDBYtBur/EcejSzNCI43w3qOxADdqI
         HR2A==
X-Gm-Message-State: AOJu0YzxlS/msScLMuRC377yH6vpv0OuRTMOg22/8owHhuNbJ9OjCzHs
	nJJvALYyLPIMdUNauLAMzoTRiZyOufqz0PtHDbk=
X-Google-Smtp-Source: AGHT+IGhyWBhRouo7z2+Rz7T1t5Rzyhwn2oc3Rz7nxU4o9Uad12guCuKwvgvjczSOaOSI7UcIfN+8QXAPcM9kybrZVE=
X-Received: by 2002:a05:600c:1990:b0:40e:3655:590d with SMTP id
 t16-20020a05600c199000b0040e3655590dmr76051wmq.123.1704492356988; Fri, 05 Jan
 2024 14:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Jan 2024 14:05:44 -0800
Message-ID: <CAEf4Bzab84niHTdyAEkMKncNK2kXBPc7dUNpYHuXxubSM-2D4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 12:26=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> I'm still looking through the patches, but in the early parts I do
> note this oddity:
>
> On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > +struct bpf_token {
> > +       struct work_struct work;
> > +       atomic64_t refcnt;
> > +       struct user_namespace *userns;
> > +       u64 allowed_cmds;
> > +};
>
> Ok, not huge, and makes sense, although I wonder if that
>
>         atomic64_t refcnt;
>
> should just be 'atomic_long_t' since presumably on 32-bit
> architectures you can't create enough references for a 64-bit atomic
> to make much sense.
>
> Or are there references to tokens that might not use any memory?
>
> Not a big deal, but 'atomic64_t' is very expensive on 32-bit
> architectures, and doesn't seem to make much sense unless you really
> specifically need 64 bits for some reason.

I used atomic64_t for consistency with other BPF objects (program,
etc) and not to have to worry even about hypothetical overflows.
32-bit atomic performance doesn't seem to be a big concern as a token
is passed into a pretty heavy-weight operations that create new BPF
object (map, program, BTF object), no matter how slow refcounting is
it will be lost in the noise for those operations.

>
> But regardless, this is odd:
>
> > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > +
> > +static void bpf_token_free(struct bpf_token *token)
> > +{
> > +       put_user_ns(token->userns);
> > +       kvfree(token);
> > +}
>
> > +int bpf_token_create(union bpf_attr *attr)
> > +{
> > ....
> > +       token =3D kvzalloc(sizeof(*token), GFP_USER);
>
> Ok, so the kvzalloc() and kvfree() certainly line up, but why use them at=
 all?

No particular reason, kzalloc/kfree should totally work, it's a small
struct anyways. I will switch.

>
> kvmalloc() and friends are for "use kmalloc, and fall back on vmalloc
> for big allocations when that fails".
>
> For just a structure, a plain 'kzalloc()/kfree()' pair would seem to
> make much more sense.
>
> Neither of these issues are at all important, but I mention them
> because they made me go "What?" when reading through the patches.
>
>                   Linus

