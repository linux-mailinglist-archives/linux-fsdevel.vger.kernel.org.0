Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA204A7615
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 17:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345966AbiBBQjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 11:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbiBBQjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:39:43 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E6C06173E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 08:39:43 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z131so18721988pgz.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Feb 2022 08:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tY7gifojugJSD5p4YfWSz9NLQ3A3BS+rqgnzng9kvSw=;
        b=BDw1mjVM+280XSXCpS330TZurj8fGxBv+iO6moGSKQvKefM5AOP+UBihwh/pltBMNR
         gadkcufziPPtSNG/j1UEaBG5T16386R1jrR8/enqNPP0c4A0ZdHK8g+TVbaPvXFRB8Dz
         +t9cyrk2C4kswXaNLPfRJbU2CnC+o+g9YPvMt8AuWVnHL3qKlu7bgC2ydF3U113GUgrG
         eq+7hmuTqV537xt2U1us/MTANqzEYmFECDNQRQ+unKXlCYAKs3uM8+5Q83GxCeNKpSLk
         B6unFTv5JKltb2yLKuoUDd5c1/ByDyRtJBHfqm9nH29TUQf3UiVYgl2oFm0GtM8MfNab
         Zj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tY7gifojugJSD5p4YfWSz9NLQ3A3BS+rqgnzng9kvSw=;
        b=FHRtvnCYN8j26PJmvLSomscqCeBBCnBTKqf063iYvpAnFMdKUQ1FHpity5bvKglu/Z
         nHPJWQQFmsDsJ/tuVXXtxkk3G7h1GFsPVQbEX1YWgE1cUEXQ0BL+pOkFL92LNeICTtB/
         p+kh1RmyatcVq9nK7ugKK9smH6zpHc3Ihzfh2GSJQ6kIBHPeBdqQPupeawu1BxkBg79O
         31aHvPGTemPseSjoBe8R7p8muUQNQql9qvmEbm+nKuOrA8lqgQ7Iz5am7n5H1hKIpKFz
         bV3KyLL0JgDZiQ/hfynG3U1cYj86RiQydm0mAiIAZEjS7vORkLfWUrcXU3EBHRVDtHar
         b7Gw==
X-Gm-Message-State: AOAM530ZRHDN1k1nVWJ3nHSCXw7MlNKHQCx77Wi7kzEq6CnDUymqoWop
        xp4auOpFjBieSQunIDnn3O2vkeNDzRiIhZe84+qoKg==
X-Google-Smtp-Source: ABdhPJyTguLiL2diyFPk98mfUwfK8MI6kgRxK+9KfJJmXZoB0buNdO7m9XYTxFJhYAqKBZhxV38R/qAPe+/HPj9Dd4k=
X-Received: by 2002:a05:6a00:2343:: with SMTP id j3mr30022335pfj.7.1643819982134;
 Wed, 02 Feb 2022 08:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20220202000522.A3834C340EB@smtp.kernel.org> <46e56d44-bd7d-9239-a5db-099b6e285bee@infradead.org>
In-Reply-To: <46e56d44-bd7d-9239-a5db-099b6e285bee@infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 2 Feb 2022 08:39:06 -0800
Message-ID: <CAJD7tkYMhnf-Ph8tpC-E4Zudt53grP1SddUxScXsh76Acg2aTg@mail.gmail.com>
Subject: Re: mmotm 2022-02-01-16-04 uploaded (mm/memcontrol.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for pointing this out. The kernel test robot emailed me about
it and I am working on fixing it for v2.

On Tue, Feb 1, 2022 at 7:50 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 2/1/22 16:05, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2022-02-01-16-04 has been uploaded to
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
>
> on i386:
> (memcg-add-per-memcg-total-kernel-memory-stat.patch)
>
>
> ../mm/memcontrol.c: In function =E2=80=98uncharge_batch=E2=80=99:
> ../mm/memcontrol.c:6805:4: error: implicit declaration of function =E2=80=
=98mem_cgroup_kmem_record=E2=80=99; did you mean =E2=80=98mem_cgroup_id_rem=
ove=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>     mem_cgroup_kmem_record(ug->memcg, -ug->nr_kmem);
>     ^~~~~~~~~~~~~~~~~~~~~~
>     mem_cgroup_id_remove
>
>
> Full randconfig file is attached.
>
> --
> ~Randy
