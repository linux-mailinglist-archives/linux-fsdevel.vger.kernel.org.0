Return-Path: <linux-fsdevel+bounces-2659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D527E743F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 23:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222B91F20978
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C8438FA6;
	Thu,  9 Nov 2023 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAL79UOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC138F97
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:12:50 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FC11FF6;
	Thu,  9 Nov 2023 14:12:50 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507cee17b00so1732136e87.2;
        Thu, 09 Nov 2023 14:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699567968; x=1700172768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ErSSnH0S1Xj2jE9RUtTyqAkvj8TW/A5aFNdk+aawSQ=;
        b=CAL79UODWCj5r7UJd9nzMWaPDpLbcdxb/HV/Gzyr7m8RcTQDOc96dmwhsLOmsgzbDz
         39SI35wWLIlKaZiVWw+cclSkBaJb+C5NC51sCd84mEhr8e/dbFzIkbAY8FtgWeGqRutE
         mGfP8yt9rCOFvxBzDY2msGT4PF0gWd0ATPzEGu7Ox5Cx1oxcli8FrdDRTX4JhN7JJrwi
         81m3bGD9QvrmoG5mKgT9UJG3SZ+f30LdyJshG6oiPRaEOjeaVhoRIWYEF4wlAlY/Ymm6
         E0yYSfBlBp6/UovHLwXD1B08C+3SQcSCKH6IZ2Y5yxiuongwIpr0QhKA19ag2plrEwCB
         DmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699567968; x=1700172768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ErSSnH0S1Xj2jE9RUtTyqAkvj8TW/A5aFNdk+aawSQ=;
        b=ID4U26wZImlA00MGIo50W3RX3nj0/IN5uZVVZD30tW94Nf037kld6+qgJpFE86tDip
         ZP5bUbo4ZbJOJEPasnjkxCloTn11ugVs5NRChXxgq6eUVk5o2vbqSivHDmZJEXyTnGZm
         P3nYKw4MRwH5VukctCGf/L03l6+mu2krPuB6u314zC7ZPS81mBnc6YTrwBrmtUqm+fyR
         czgHxy91HYb1gYrEBYS3BzX7zy/KU0QQM4t/ub5MWGHp9sZVfpwq/IlFPhFAKqG1f4wP
         vXO5ZbtELGDO8B99jpDjgx/GRBWlsgZXMs8cRh+TNc9cnCv5//ydgZd5pcF1v1uZd4ie
         zyAw==
X-Gm-Message-State: AOJu0YxCeOt9ObAchf5LDyYyhqwbR0Fsj6wE6TGMnMkhc3eQEvtUew6+
	omBPLjBmjvmFT26XXplwuxte//tj1IW3rp4NSLXKDiBwwso=
X-Google-Smtp-Source: AGHT+IFENjPRz+phpNIeKifN88fidVJ1QEJx4kYn2V6vYjDh6X5WShqeRrw3UHUavIvNs/tdjK1H7V4QMoK2XqqQZvM=
X-Received: by 2002:ac2:4884:0:b0:507:a40e:d8bf with SMTP id
 x4-20020ac24884000000b00507a40ed8bfmr2433670lfc.7.1699567968314; Thu, 09 Nov
 2023 14:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109190844.2044940-1-agruenba@redhat.com> <20231109220018.GI1957730@ZenIV>
In-Reply-To: <20231109220018.GI1957730@ZenIV>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Thu, 9 Nov 2023 23:12:32 +0100
Message-ID: <CAHpGcMJfNNRDAvGhH-1Fs79uTks10XhLXBLeCqABoxufZeLGzw@mail.gmail.com>
Subject: Re: [PATCH] fs: RESOLVE_CACHED final path component fix
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Abhi Das <adas@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 9. Nov. 2023 um 23:00 Uhr schrieb Al Viro <viro@zeniv.linux.org.uk>:
> On Thu, Nov 09, 2023 at 08:08:44PM +0100, Andreas Gruenbacher wrote:
> > Jens,
> >
> > since your commit 99668f618062, applications can request cached lookups
> > with the RESOLVE_CACHED openat2() flag.  When adding support for that in
> > gfs2, we found that this causes the ->permission inode operation to be
> > called with the MAY_NOT_BLOCK flag set for directories along the path,
> > which is good, but the ->permission check on the final path component is
> > missing that flag.  The filesystem will then sleep when it needs to read
> > in the ACL, for example.
> >
> > This doesn't look like the intended RESOLVE_CACHED behavior.
> >
> > The file permission checks in path_openat() happen as follows:
> >
> > (1) link_path_walk() -> may_lookup() -> inode_permission() is called for
> > each but the final path component. If the LOOKUP_RCU nameidata flag is
> > set, may_lookup() passes the MAY_NOT_BLOCK flag on to
> > inode_permission(), which passes it on to the permission inode
> > operation.
> >
> > (2) do_open() -> may_open() -> inode_permission() is called for the
> > final path component. The MAY_* flags passed to inode_permission() are
> > computed by build_open_flags(), outside of do_open(), and passed down
> > from there. The MAY_NOT_BLOCK flag doesn't get set.
> >
> > I think we can fix this in build_open_flags(), by setting the
> > MAY_NOT_BLOCK flag when a RESOLVE_CACHED lookup is requested, right
> > where RESOLVE_CACHED is mapped to LOOKUP_CACHED as well.
>
> No.  This will expose ->permission() instances to previously impossible
> cases of MAY_NOT_BLOCK lookups, and we already have enough trouble
> in that area.

True, lockdep wouldn't be happy.

>  See RCU pathwalk patches I posted last cycle;

Do you have a pointer? Thanks.

> I'm
> planning to rebase what still needs to be rebased and feed the
> fixes into mainline, but that won't happen until the end of this
> week *AND* ->permission()-related part of code audit will need
> to be repeated and extended.
>
> Until then - no, with the side of fuck, no.
>

