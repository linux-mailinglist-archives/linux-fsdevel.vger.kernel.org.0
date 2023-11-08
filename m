Return-Path: <linux-fsdevel+bounces-2450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244197E60D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 00:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1063B20D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 23:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DA93715E;
	Wed,  8 Nov 2023 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E936AE6;
	Wed,  8 Nov 2023 23:02:42 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75682588;
	Wed,  8 Nov 2023 15:02:41 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso271027a12.1;
        Wed, 08 Nov 2023 15:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699484560; x=1700089360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QezIy+A1nnmgJWdCX5sdOM70b+QBHz1gPqNRkt6Z8Jw=;
        b=sd/iY0b+rOF29nlarpFaFGNj9e7eYdb2LBi2R7dbjgxasg/mq+yzpDWf4yU5Pc+gvN
         CM6UJjrnDBaja4cZP0BqlvLaPuS2dehL1XXO2QQpuNooKjCPCA197YIz/gbJ89iktYVK
         0I2YPNJJexGsD1o5Y0/4DBTi3A/cEt1jtYMALLveE92KkUojWveFDUd54kXEBbWW4C33
         +dIklWJEpEHu+h9MujvmYsEuNT8RR7WPQ9nwnYDteg+5ibaRmhOoBFg5Vm+1RbS9dGJr
         RGznhmaHbVB21ToW8G4Mjl7zbeCeErv14BJfhWeu+hIn+dErt5ATuoeYJfCy+WvKKfUa
         T4OA==
X-Gm-Message-State: AOJu0YycGfHcw8O7ApLq8/c77W+Wi5su7DJ+ulDxgbQM1Cl9HlbEhxwI
	eID9/LoY79/9jR1Qgd0k28RvhCTq5CNQ+zuQ
X-Google-Smtp-Source: AGHT+IG1MbqQprjN16fQanytc+0BidE5c4En4wrLj7NaaDmXjBeihEFRwZV5meVehfYt19PSr+vnBw==
X-Received: by 2002:a50:d083:0:b0:543:bdaa:b719 with SMTP id v3-20020a50d083000000b00543bdaab719mr2228798edd.42.1699484559740;
        Wed, 08 Nov 2023 15:02:39 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id j28-20020a508a9c000000b0053e3839fc79sm7470265edj.96.2023.11.08.15.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 15:02:39 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9dd3f4a0f5aso42700566b.1;
        Wed, 08 Nov 2023 15:02:39 -0800 (PST)
X-Received: by 2002:a17:907:6ea5:b0:9e1:43cb:9088 with SMTP id
 sh37-20020a1709076ea500b009e143cb9088mr3312221ejc.23.1699484558804; Wed, 08
 Nov 2023 15:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1699470345.git.josef@toxicpanda.com>
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 8 Nov 2023 18:02:02 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-wJbU6TPNmOXfx8KyBdQX++AFHG57o8s8U-Bq1jKTQ8Q@mail.gmail.com>
Message-ID: <CAEg-Je-wJbU6TPNmOXfx8KyBdQX++AFHG57o8s8U-Bq1jKTQ8Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] btrfs: convert to the new mount API
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 2:09=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> v1->v2:
> - Fixed up some nits and paste errors.
> - Fixed build failure with !ZONED.
> - Fixed accidentally dropping BINARY_MOUNTDATA flag.
> - Added Reviewed-by's collected up to this point.
>
> These have run through our CI a few times, they haven't introduced any
> regressions.
>
> --- Original email ---
> Hello,
>
> These patches convert us to use the new mount API.  Christian tried to do=
 this a
> few months ago, but ran afoul of our preference to have a bunch of small
> changes.  I started this series before I knew he had tried to convert us,=
 so
> there's a fair bit that's different, but I did copy his approach for the =
remount
> bit.  I've linked to the original patch where I took inspiration, Christi=
an let
> me know if you want some other annotation for credit, I wasn't really sur=
e the
> best way to do that.
>
> There are a few preparatory patches in the beginning, and then cleanups a=
t the
> end.  I took each call back one at a time to try and make it as small as
> possible.  The resulting code is less, but the diffstat shows more insert=
ions
> that deletions.  This is because there are some big comment blocks around=
 some
> of the more subtle things that we're doing to hopefully make it more clea=
r.
>
> This is currently running through our CI.  I thought it was fine last wee=
k but
> we had a bunch of new failures when I finished up the remount behavior.  =
However
> today I discovered this was a regression in btrfs-progs, and I'm re-runni=
ng the
> tests with the fixes.  If anything major breaks in the CI I'll resend wit=
h
> fixes, but I'm pretty sure these patches will pass without issue.
>
> I utilized __maybe_unused liberally to make sure everything compiled whil=
e
> applied.  The only "big" patch is where I went and removed the old API.  =
If
> requested I can break that up a bit more, but I didn't think it was neces=
sary.
> I did make sure to keep it in its own patch, so the switch to the new mou=
nt API
> path only has things we need to support the new mount API, and then the n=
ext
> patch removes the old code.  Thanks,
>
> Josef
>
> Christian Brauner (1):
>   fs: indicate request originates from old mount api
>
> Josef Bacik (17):
>   btrfs: split out the mount option validation code into its own helper
>   btrfs: set default compress type at btrfs_init_fs_info time
>   btrfs: move space cache settings into open_ctree
>   btrfs: do not allow free space tree rebuild on extent tree v2
>   btrfs: split out ro->rw and rw->ro helpers into their own functions
>   btrfs: add a NOSPACECACHE mount option flag
>   btrfs: add fs_parameter definitions
>   btrfs: add parse_param callback for the new mount api
>   btrfs: add fs context handling functions
>   btrfs: add reconfigure callback for fs_context
>   btrfs: add get_tree callback for new mount API
>   btrfs: handle the ro->rw transition for mounting different subovls
>   btrfs: switch to the new mount API
>   btrfs: move the device specific mount options to super.c
>   btrfs: remove old mount API code
>   btrfs: move one shot mount option clearing to super.c
>   btrfs: set clear_cache if we use usebackuproot
>
>  fs/btrfs/disk-io.c |   76 +-
>  fs/btrfs/disk-io.h |    1 -
>  fs/btrfs/fs.h      |   15 +-
>  fs/btrfs/super.c   | 2421 +++++++++++++++++++++++---------------------
>  fs/btrfs/super.h   |    5 +-
>  fs/btrfs/zoned.c   |   16 +-
>  fs/btrfs/zoned.h   |    6 +-
>  fs/namespace.c     |   11 +
>  8 files changed, 1317 insertions(+), 1234 deletions(-)
>
> --
> 2.41.0
>

The series looks reasonable to me. I do appreciate the extra effort in
the documents and references to give me context when looking through
it all.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

