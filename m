Return-Path: <linux-fsdevel+bounces-964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F6B7D3FC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668601C20401
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF3821A05;
	Mon, 23 Oct 2023 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhRwBvf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E03219F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 19:01:46 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C6102
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 12:01:45 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7af45084eso35111727b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698087704; x=1698692504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zqg2MrbwUBHop12bezxykXk1XkJASgD3Vjm9dX2RSP8=;
        b=nhRwBvf5B5dVVjrNs1IllqUTDPbpqQ2HLwbaDjehM4okzVtkSNbXs6CB3yjfNNnKyU
         T+VSaeTDQT1IigKk+2mPUvmzayOLYNoJsY5H4AwfanRQf85egQ3zUxgHcRVt+mrRRIuA
         2NceyG2QR+0kXSE0PgTuISBHzETzhFxFzgxc3nbA+6+XZ1R63ryySr8lnuHiXFqrxRLz
         KLp008cIeW+e53wHbLk2MY5rLtMjGrFIBuI4+4Pk3QO/BEuhK6M+aHnDkPKUVGCcvvY7
         F7bNHVg4FIo7B/f3xfHnF0Y3ipbrsumona9sJGhIgedO/pP98VLCd0pHIkkTnIZn1oIJ
         UnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087704; x=1698692504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqg2MrbwUBHop12bezxykXk1XkJASgD3Vjm9dX2RSP8=;
        b=SyBFMwezNXK1siYWWjMY78vRK6WlcqBvJKyk4TGvlKUyKfBAZWYO6beF/Tpha3/sG/
         jcjUCzKAHBgSZko9bUvtkQ/vjJ40q52WEB6d4H7zwsraXsDgk8/AcX5Shija/ohIHkJX
         0dp6DlamVhcXKsITg29Prp2AopKdOLv8kneBtCazUs9t1GMs4ZRVa5HOqvhfhCmIUZ+N
         pjrHwzlezKGqgd57dAJWr+ItA8fRsrZCMeoIw71L60UbWD395WCrVoVghSrGOprqxC0Q
         K5hb4wjbtGN9UXQwSLghL9x00umOnz19YDlbzBQAkQbIQT+FikWM0Omwkn+8/ApBO/wb
         jkwA==
X-Gm-Message-State: AOJu0YxMiWmIRgbjubAj1j53/ds+3nHz9rZUBuJNGxteWHc9h6DzFh/t
	l7zWuPpOsw2/W0TcaWkbS03KHjAWFhpOl4I83HmhHg==
X-Google-Smtp-Source: AGHT+IHoAt2gVqrgRoqwdRIpKxcUmNNTfbU5Vcl//A9wd9dXnzR/3ka7Iq0f7Tyi5EsdxWj3DjAV8pYMZpaDZxugx+M=
X-Received: by 2002:a81:65c2:0:b0:583:3c54:6d89 with SMTP id
 z185-20020a8165c2000000b005833c546d89mr8889708ywb.44.1698087703993; Mon, 23
 Oct 2023 12:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <ZShsQzKvQDZW+rRM@x1n> <CAJuCfpEtaLs=nQK=oPHe9Nyq1UoqLk1pt2k-5ddDks3Ni2d+cw@mail.gmail.com>
 <ZTVVhkq8uNoQUlQx@x1n> <CAJuCfpEDEXHVNYRaPsD3GVbcbZ-NuH0n3Cz-V0MDMhiJG_Esrg@mail.gmail.com>
 <ZTa9Y++/PCV7HRoM@x1n>
In-Reply-To: <ZTa9Y++/PCV7HRoM@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Oct 2023 12:01:32 -0700
Message-ID: <CAJuCfpF6rfrbT3Sk7+azUH9=CfERYnb84ztoCuA72AxtZ_1FLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 11:37=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Oct 23, 2023 at 10:43:49AM -0700, Suren Baghdasaryan wrote:
> > > Maybe we should follow what it does with mremap()?  Then your current=
 code
> > > is fine.  Maybe that's the better start.
> >
> > I think that was the original intention, basically treating remapping
> > as a write operation. Maybe I should add a comment here to make it
> > more clear?
>
> Please avoid mention "emulate as a write" - this is not a write, e.g., we
> move a swap entry over without faulting in the page.  We also keep the pa=
ge
> states, e.g. on hotness.  A write will change all of that.

Understood.

>
> Now rethinking with the recently merged WP_ASYNC: we ignore uffd-wp, whic=
h
> means dirty from uffd-wp async tracking POV, that matches with soft-dirty
> always set.  Looks all good.
>
> Perhaps something like "Follow mremap() behavior; ignore uffd-wp for now"
> should work?

Sounds good. Will add in the next version.
Thanks!

>
> --
> Peter Xu
>

