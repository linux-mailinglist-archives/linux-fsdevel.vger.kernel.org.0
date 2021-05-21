Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0F738BC61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 04:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhEUCY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 22:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhEUCY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 22:24:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7339C061763
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 May 2021 19:23:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q15so13127652pgg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 May 2021 19:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YemI85O9bLI0m8MkylkyR0IUfS+oZy6kYsON+ubb8mg=;
        b=gEabH7HEBFV1nPdVQ6FrQc/idUFaL/V5OxiMA1LI2BpttADEiH2k7vALxIDizC3MSG
         gSgQMRLfRy3FJ0npyYj5LwrxlIvuF3MQ2h2kese9zmgcI9w+x8PEBOBOFIN9cqlmmWWs
         YWBG2iCbiuzEI6wasXPpTSOLeoZFizR2a0ZXlmZYIKoUvJOSg7zhgh+AuQK2q+EyhL0T
         bb4dzsW7mUgo878zXUzNcyoh419is9FMpDsZtuf1oO4z3uZlf9rBnv399PqOj2nK6UlG
         WPj4JZVo6Wsh9P3URTV0gh/fgI++wQETs2AIn3RAOzMk/RopmHAfBYy0i16WlbxpkMWG
         3UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YemI85O9bLI0m8MkylkyR0IUfS+oZy6kYsON+ubb8mg=;
        b=fyB1ICR9Jb97PnbVHMZkn+GTfEc1+3luTiAfA3ycnprIuVxDnfroZdyCSDJsXMrJuO
         5ejvrpYnkNVIRnpmhcFP5h869nnN0D2dEM9OaeCr+PcWs8ANaBIdW8rFKmlya6GIuI+r
         2vgQD/DXpxZJU+x+VuHiYOeHly1WiJVPDR2gpMWFw52PBREIHPGQyBVtTdRjwYjmd8P3
         duE482JbyZArBjmlJkgslUUnV2x0C7hFHYFPBPf6gsh5i3G6HwXN1qGJK9NcnzzPBh0e
         5vjmx8E6AXe1cYmgHelbbMdjJFeGCsegtbDIzMy3Bf8FmDKVDofwziCEogD0qYBquJ/0
         PsOg==
X-Gm-Message-State: AOAM530GnH6kHILSNn2BQgmThJ5VpXZ2czBNN1u44kEw65F1SWYHKxwT
        XF458GcJXAGqsg6r1TQQpTei0aizyVTuXGPoGT7uTg==
X-Google-Smtp-Source: ABdhPJz39htdi++DEibwiL3THTiqt0knG3d1uKGkXu73GOwwzQNM1rZ8VXwFKoMc7Y2smXEQir4jGlEcmlrwzsON4+A=
X-Received: by 2002:a05:6a00:2493:b029:2c4:b6dd:d389 with SMTP id
 c19-20020a056a002493b02902c4b6ddd389mr7694639pfv.2.1621563785247; Thu, 20 May
 2021 19:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210520065918.KsmugQp47%akpm@linux-foundation.org> <8e1de6c2-27af-f612-7467-a7d1f1a31bff@infradead.org>
In-Reply-To: <8e1de6c2-27af-f612-7467-a7d1f1a31bff@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 21 May 2021 10:22:28 +0800
Message-ID: <CAMZfGtW=jgjJPUNk4jxFXWZ91wuYEm4q3x7NUVSjGpu0Xjc7hA@mail.gmail.com>
Subject: Re: [External] Re: mmotm 2021-05-19-23-58 uploaded (mm/migrate.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 6:21 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/19/21 11:59 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2021-05-19-23-58 has been uploaded to
> >
> >    https://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > https://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release =
(5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated=
 in
> > https://ozlabs.org/~akpm/mmotm/series
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
> on x86_64:
>
> ../mm/migrate.c: In function =E2=80=98unmap_and_move_huge_page=E2=80=99:
> ../mm/migrate.c:1295:6: error: implicit declaration of function =E2=80=98=
hugetlb_page_subpool=E2=80=99; did you mean =E2=80=98hugetlb_count_sub=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
>   if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
>       ^~~~~~~~~~~~~~~~~~~~
>
> Full randconfig file is attached.

Thanks. I'll fix it in the next version.

>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>
