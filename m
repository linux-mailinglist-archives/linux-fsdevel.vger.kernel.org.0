Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B65A0A01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfH1Sxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 14:53:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41957 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1Sxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:53:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so838687wrr.8;
        Wed, 28 Aug 2019 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dNeCU+ZF1utHP7CMktWuXnRZpMmmVHfRi6Kx10bzzBE=;
        b=BA1KWLcFdAWrtBsaDuNr8g3j/SgOrTjFpsCuTY0hNWE9awNEoFniam51IU2VODgqUe
         tWSuDD2MmJ6bGKNakIDXno5bS/OvPqmMHwa9fNrX1dfs9gE7XldIToxleEEzi/ehOzO0
         MKCJAk19lRJbqJCa0+kg7t0a6maVuWyju3oiJA6+iDQmvwhgEJJZycLHj9ayfRmCQ3KC
         neRbMBVmZagmm9I9yR/9bxQPZx2VJ2Uqvztc/ziKBS9h+fT4z/vSOu5QJUM2DVnqTr/Y
         MhJj/HDKmHd/d9T+c/olDopKTALXtdiye+EwbIOXaPXRxT4MDLc6wsFk7ksDReqiG183
         ebbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dNeCU+ZF1utHP7CMktWuXnRZpMmmVHfRi6Kx10bzzBE=;
        b=rUra5E1d1houWussWPCClDgr8T7z4DORcin+XNTFO0/J2cKFxlyMNueAPKcxcsfX0v
         o+iojMlH59k8w9WB2yqYKMFhcSZq/oPozw9PlveZiCkTXJ1vDTHFntNb21hwEmRlxjOh
         8oAAwTazq5qHLHNhYOO0HXAThOYNkTn7gKwkxBk2jgJdEnv1bJQVpBD7NygslsPWTr8y
         n4WCu7YSRXsEoUnC7p7Uidl+ALGls4UABF8AXNfxi8VXodu5qHRhyFLEpkTPXuyHUyTZ
         v8scSjv+/2qeJLnLxwM/CarIORrlHXMTzLkh5E+6uNbCjGaUhpPteoxxvR0xoJzfhh6f
         F9zA==
X-Gm-Message-State: APjAAAVY6Y50uGElrh/hlhseVyy2+9gGLFw3OEJZ8VICqOUKjPtPraqp
        QURkHlazwLEc22LCxfoCi+BgBQeObq6sAachaeo=
X-Google-Smtp-Source: APXvYqweyMAnZ6yIhLJf6sFauZxV8VlmGh+lO4k0uF5jXv7BE29ZuBpN3aPxry2ik8FodDnqX68+X+75s0hzK6URnCM=
X-Received: by 2002:adf:e286:: with SMTP id v6mr5946246wri.4.1567018429532;
 Wed, 28 Aug 2019 11:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org> <3e4eba58-7d24-f811-baa1-b6e88334e5a2@infradead.org>
In-Reply-To: <3e4eba58-7d24-f811-baa1-b6e88334e5a2@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 28 Aug 2019 14:53:37 -0400
Message-ID: <CADnq5_PHNbSVUsM65sisfUwDxg_4-uEZWZMSQ=u78AWkaRdvtw@mail.gmail.com>
Subject: Re: mmotm 2019-08-27-20-39 uploaded (gpu/drm/amd/display/)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 2:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/27/19 8:40 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2019-08-27-20-39 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release =
(5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated=
 in
> > http://ozlabs.org/~akpm/mmotm/series
> >
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss=
,
> > followed by the base kernel version against which this patch series is =
to
> > be applied.
> >
> > This tree is partially included in linux-next.  To see which patches ar=
e
> > included in linux-next, consult the `series' file.  Only the patches
> > within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included i=
n
> > linux-next.
>
> on i386:
>
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: In funct=
ion =E2=80=98dcn20_hw_sequencer_construct=E2=80=99:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:2127:28: =
error: =E2=80=98dcn20_dsc_pg_control=E2=80=99 undeclared (first use in this=
 function); did you mean =E2=80=98dcn20_dpp_pg_control=E2=80=99?
>   dc->hwss.dsc_pg_control =3D dcn20_dsc_pg_control;
>                             ^~~~~~~~~~~~~~~~~~~~
>                             dcn20_dpp_pg_control
>
>
> Full randconfig file is attached.

Fixed here:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next&id=3Dda26ded=
3b2fff646d28559004195abe353bce49b

Alex

>
> --
> ~Randy
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
