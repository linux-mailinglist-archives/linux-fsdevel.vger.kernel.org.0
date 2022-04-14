Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539945004BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 05:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiDNDqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 23:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbiDNDqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:46:46 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B74167E1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 20:44:22 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id g6so1293733uaw.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 20:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSfIlz8DUgM+uj4vQg8KHkhawk6SdG9Lz0hRbX4guE8=;
        b=Lo9h2T+uYh37ucLp1GfRnhXeiRN6mfPNF9PjYgJMep0n+Vs0d9at9bYg0SHIPnEpFs
         ENEa/w69jIkWNFZgcZELFTsoSWE7ckPvJleEv918kLowAgM3rSrAocuIvXE7oycEwBaf
         hdIJlxQ3apKJ3QCVQo+DIDfNmWTbyvFUDHa1hT4+8+5sQM7l3F9VgK0cot9G2GWQ/Qch
         Rnf9YYU9xK0nzU00/rsP8oHczzfxw2ADJ4X08by7WRbDdEgli9Sx1vV+UvnoOtGr/ljk
         C8z45FSj59harYuUDh0t1tUErMbCk/Pkv8tDo6aYPXNlpyb5jnGEIviF6LUx+XMTnv5Q
         GOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSfIlz8DUgM+uj4vQg8KHkhawk6SdG9Lz0hRbX4guE8=;
        b=3CxBEKVsENgkVD3/YRRapchhGsv4jB1b219K17WPmY4LoJECctnr05rt3CdE7YtH8h
         z7ds5dNLXoVhXMCTrLG0UgHvedtbhJyb0DkJKBEC5Z7OTPv8rOKGIA5WMBQfFTo17wIo
         adYajgIm/8w3372awZexJRIf/oTSbMYhoIMywzHq2Y/To15U/Gvlx3B7rOawPGL+rDcB
         uOChitPjBGw7SAXMDcTH4ERDQHWofOY0FGmbhiBOt3HJAhhXBR0LQmkyM1Yk5q1qq7Yc
         KALumafCkxVhjmLu/2bH23v/xkI/bCgiHkl3A8wqdhoWHkL9Utx4QbiQJMeYR5lvm9U+
         xz2w==
X-Gm-Message-State: AOAM532dNqadBwrZDoQTdfgBefFlappVebS2CE1yvtfvDVc/1Lw5g2mH
        PgRGMmYmSPSWOSYU418bTRSw+LSq8kXpWJ1SxvovDg==
X-Google-Smtp-Source: ABdhPJxEuB5nkxXLPnUZBpM95D8R0G8f+4XXtwtYRgW1ekNE9qaAsJV2yLUm2n9y3Op2j+ePMyBweJIMfqXcHsG49yg=
X-Received: by 2002:ab0:2695:0:b0:352:5fc9:4132 with SMTP id
 t21-20020ab02695000000b003525fc94132mr273324uao.29.1649907861646; Wed, 13 Apr
 2022 20:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220413040610.06AAAC385A4@smtp.kernel.org> <4ef4aa81-ed32-6c7f-2504-e7462bbaae2d@infradead.org>
In-Reply-To: <4ef4aa81-ed32-6c7f-2504-e7462bbaae2d@infradead.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 13 Apr 2022 21:43:45 -0600
Message-ID: <CAOUHufb8yn3PF9gm3ahne2GLs8SCpjjuz_DpS1aH75jeDT_J7A@mail.gmail.com>
Subject: Re: mmotm 2022-04-12-21-05 uploaded (ARCH_HAS_NONLEAF_PMD_YOUNG)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 9:39 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 4/12/22 21:06, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2022-04-12-21-05 has been uploaded to
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
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > https://ozlabs.org/~akpm/mmotm/series
>
> on i386:
>
> WARNING: unmet direct dependencies detected for ARCH_HAS_NONLEAF_PMD_YOUNG
>   Depends on [n]: PGTABLE_LEVELS [=2]>2
>   Selected by [y]:
>   - X86 [=y]

Thanks for the heads up. Please try the following fix if it gets in your way.

https://lore.kernel.org/mm-commits/20220414023214.40C14C385A6@smtp.kernel.org/
