Return-Path: <linux-fsdevel+bounces-790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3F7D02F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 22:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC652820FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 20:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F9A3DFF6;
	Thu, 19 Oct 2023 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1amRd0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE13DFE5
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 20:02:55 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B711B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 13:02:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7ad24b3aaso147297b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697745773; x=1698350573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4h8OXoW9StQ+YypbHzqEhLaogqFHJKP7focuWdzzM0=;
        b=S1amRd0jkq46pRcJ2e/14i54hzTaQJleZciB+WPwdRgLuzop7cnogb5i04mcnGcZQQ
         iqhw4RGsUIvrgJGfXws0LtfFt9v1cRijiYMRa9YTSZco17T6zpUhM3JsgybzN+ViQksp
         X0eZYqibFFw+7YrIE7M2gQk2MSFxQjVeLrvPvlsf7bKseO3pptG8+9BzFOeASvgv6Uuf
         fr5dvFYrAViQIjeV7heHu5zS6yocfx2ANHMVqSMsgqZ2Eww9b4a7hdXixHY1Cpvp/bxb
         uoYJ+sXx6ZDSpwm43ysN8r5tLek8lD57aA+AbF2j+S+j7bDDswFYIpUARaGpOmAY92Rn
         pVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745773; x=1698350573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4h8OXoW9StQ+YypbHzqEhLaogqFHJKP7focuWdzzM0=;
        b=X6katsxTnjkxXDhkxAWMSmgcYLaMK4gf4wSwZ5VJ97PjG364mnk8lsvWecVSzh1PsG
         mEekyXfql05J1JubkEqlNwOCzmKAx7j7U180hlrWMcUzg/7M36qHAFuKgdZv9KTmAb/v
         atIZfoSA0C8+YIZnB3bYsZGC8IuM6R/0nnNguXRll3gakfE+H6bmsr/MiO8vMuUOpU9y
         iWLxiyWSvu2A6azQT9TlJtdxBJgXMP9CovwvLnOuJHBE3i2CjbTZ/zNGl02XmJJk6F4q
         C+L8kjxaNPeTQNAlazgZs/dEHLg85Mn6/Mw+AGJQZJ1TjnY5jYZr3XdI3UwDUVEF5+y5
         Uing==
X-Gm-Message-State: AOJu0YwAnK2SXJhVjiw9f0BMhwDA91Xd59IRdsF4JLoMl/Do02y35+2s
	GoW2xSp1IGN6poSWhJbMc1kfAC3xbEVLAN3HCdMzaA==
X-Google-Smtp-Source: AGHT+IFpMZ2iRVo3MJ/6b0SYAOb/GvPEGfec2JTMINMBnMybc9wPakvZR4d3FtbutJYe9Xvp6xxVYZOi+t9uQ2RUYpQ=
X-Received: by 2002:a0d:cbc1:0:b0:5a7:fbd5:8c1 with SMTP id
 n184-20020a0dcbc1000000b005a7fbd508c1mr3222768ywd.17.1697745773027; Thu, 19
 Oct 2023 13:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n> <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n> <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n> <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com> <ZTGJHesvkV84c+l6@x1n>
In-Reply-To: <ZTGJHesvkV84c+l6@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 19 Oct 2023 13:02:39 -0700
Message-ID: <CAJuCfpEVgLtc3iS_huxbr86bNwEix+M4iEqWeQYUbsP6KcxfQQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:53=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Oct 19, 2023 at 05:41:01PM +0200, David Hildenbrand wrote:
> > That's not my main point. It can easily become a maintenance burden wit=
hout
> > any real use cases yet that we are willing to support.
>
> That's why I requested a few times that we can discuss the complexity of
> cross-mm support already here, and I'm all ears if I missed something on
> the "maintenance burden" part..
>
> I started by listing what I think might be different, and we can easily
> speedup single-mm with things like "if (ctx->mm !=3D mm)" checks with
> e.g. memcg, just like what this patch already did with pgtable deposition=
s.
>
> We keep saying "maintenance burden" but we refuse to discuss what is that=
..
>
> I'll leave that to Suren and Lokesh to decide.  For me the worst case is
> one more flag which might be confusing, which is not the end of the world=
..
> Suren, you may need to work more thoroughly to remove cross-mm implicatio=
ns
> if so, just like when renaming REMAP to MOVE.

Hi Folks,
Sorry, I'm just catching up on all the comments in this thread after a
week-long absence. Will be addressing other questions separately but
for cross-mm one, I think the best way forward would be for me to
split this patch into two with the second one adding cross-mm support.
That will clearly show how much additional code that requires and will
make it easier for us to decide whether to support it or not.
TBH, I don't see the need for an additional flag even if the initial
version will be merged without cross-mm support. Once it's added the
manpage can mention that starting with a specific Linux version
cross-mm is supported, no?
Also from my quick read, it sounds like we want to prevent movements
of pinned pages regardless of cross-mm support. Is my understanding
correct?
Thanks,
Suren.


>
> Thanks,
>
> --
> Peter Xu
>

