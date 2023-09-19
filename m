Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6347A6D63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjISVw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISVw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:52:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB638BA
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:52:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso818147766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695160337; x=1695765137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eliXjlnUj0/AODOfq0lfgn0v2M8TIN1LeS+hCeHav/U=;
        b=OqQcER9JyvuM3qJo1DI8aXd0lwL7//5LwyYR1Yul8THHQFKEDFCK4yMfMN3eJzl0hQ
         gnt9CSN/ob0M1v6MHpDZAIUK4Alr+RdxRShioyRHONzszT6OFK+gPH0HVhUu6Xm5yNiF
         SbtadUf9grV2X4kPLM71ljgOuy0lvMo7/DoCOmVW8QRDt0sXBzP2qSiyeOOnEjiJYhPJ
         itsBMVhncsnYmdY/jixCJ8dTfL93YB2HLoJXJm2tEEtQoYmnuYbXlBlet9TdvrZ8s2o+
         /kkZnpGWr9NCunsQ5bYZl31NMKKtwIt7aj9U2+TOx4lvGsPLtblPRxZTGZ68MJ/IkhZJ
         a/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695160337; x=1695765137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eliXjlnUj0/AODOfq0lfgn0v2M8TIN1LeS+hCeHav/U=;
        b=rqPQmTBONdmLx84V36hlK4X/URiB7AFWEc6CoLloh6q3d0xdCZCJ5oSepQcg6o9QTy
         QwO8wSjq9JVvgbdhNwEaidGsp6dRuF2IpgOVAc38fu1ZxwsulP3z65K6F8qrixwOrfhX
         5liCSgDPDCuap7lH++XNOGJYbcDp1G2YBjo9U3XTOrJRUyLONvnKNKf8oGZOt2qP+4xz
         Brnhyhm1qS7D1aAAsWp0Cgp2UTi5cTbKnX6/OB58w2JyvWnhorJpshz/90wp01lM65sB
         btuwXpyAx/pX/BjYhZaw3rgRTkOl9C/fu2MYvdKpAf2rg9FOFGOj9xMWeDmsSFmXuZi4
         PIYg==
X-Gm-Message-State: AOJu0Yy5qW848bZg/7o68XO6fC0/99q5ZLSkRtXRWInfRUe789BUPSkX
        +1RmQ3JNzrDpUFlIS/DkLE5vpfm+CsF39vdffAaZUg==
X-Google-Smtp-Source: AGHT+IEOBCWtLBMbM1AT0iqkM9hwo/7Pa2mMpNubzxGfRPNpEhB/75Pmmss4LVXbiittngA9ae8ICig1bNEo/UbeVZM=
X-Received: by 2002:a17:906:18b1:b0:9a1:f3a6:b906 with SMTP id
 c17-20020a17090618b100b009a1f3a6b906mr437320ejf.36.1695160337022; Tue, 19 Sep
 2023 14:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com> <20230915095042.1320180-7-da.gomez@samsung.com>
 <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com>
 <20230918075758.vlufrhq22es2dhuu@sarkhan> <CAJD7tkZSST8Kc6duUWt6a9igrsn=ucUPSVPWWGDWEUxBs3b4bg@mail.gmail.com>
 <20230919132633.v2mvuaxp2w76zoed@sarkhan> <CAJD7tkaELyZXsUP+c=DKg9k-FeFTTRS+_9diK5fyTNdfDAykmQ@mail.gmail.com>
 <ZQoW0MVh/esJkU6H@bombadil.infradead.org>
In-Reply-To: <ZQoW0MVh/esJkU6H@bombadil.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 19 Sep 2023 14:51:40 -0700
Message-ID: <CAJD7tkZjpYh=n4UrYmpMUVz2OvBX9PVzK+aP1gKsNoycnkzRag@mail.gmail.com>
Subject: Re: [PATCH 6/6] shmem: add large folios support to the write path
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 2:47=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Tue, Sep 19, 2023 at 09:00:16AM -0700, Yosry Ahmed wrote:
> > On Tue, Sep 19, 2023 at 6:27=E2=80=AFAM Daniel Gomez <da.gomez@samsung.=
com> wrote:
> > >
> > > On Mon, Sep 18, 2023 at 11:55:34AM -0700, Yosry Ahmed wrote:
> > > > On Mon, Sep 18, 2023 at 1:00=E2=80=AFAM Daniel Gomez <da.gomez@sams=
ung.com> wrote:
> > > > >
> > > > > On Fri, Sep 15, 2023 at 11:26:37AM -0700, Yosry Ahmed wrote:
> > > > > > On Fri, Sep 15, 2023 at 2:51=E2=80=AFAM Daniel Gomez <da.gomez@=
samsung.com> wrote:
> > > > > > >
> > > > > > > Add large folio support for shmem write path matching the sam=
e high
> > > > > > > order preference mechanism used for iomap buffered IO path as=
 used in
> > > > > > > __filemap_get_folio().
> > > > > > >
> > > > > > > Use the __folio_get_max_order to get a hint for the order of =
the folio
> > > > > > > based on file size which takes care of the mapping requiremen=
ts.
> > > > > > >
> > > > > > > Swap does not support high order folios for now, so make it o=
rder 0 in
> > > > > > > case swap is enabled.
> > > > > >
> > > > > > I didn't take a close look at the series, but I am not sure I
> > > > > > understand the rationale here. Reclaim will split high order sh=
mem
> > > > > > folios anyway, right?
> > > > >
> > > > > For context, this is part of the enablement of large block sizes =
(LBS)
> > > > > effort [1][2][3], so the assumption here is that the kernel will
> > > > > reclaim memory with the same (large) block sizes that were writte=
n to
> > > > > the device.
> > > > >
> > > > > I'll add more context in the V2.
> > > > >
> > > > > [1] https://protect2.fireeye.com/v1/url?k=3Da80aab33-c981be05-a80=
b207c-000babff9b5d-b656d8860b04562f&q=3D1&e=3D46666acf-d70d-4e8d-8d00-b0278=
08ae400&u=3Dhttps%3A%2F%2Fkernelnewbies.org%2FKernelProjects%2Flarge-block-=
size
> > > > > [2] https://protect2.fireeye.com/v1/url?k=3D3f753ca2-5efe2994-3f7=
4b7ed-000babff9b5d-e678f885471555e3&q=3D1&e=3D46666acf-d70d-4e8d-8d00-b0278=
08ae400&u=3Dhttps%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1v=
S7sQfw90S00l2rfOKm83Jlg0px8KxMQE4HHp_DKRGbAGcAV-xu6LITHBEc4xzVh9wLH6WM2lR0c=
ZS8%2Fpubhtml%23
> > > > > [3] https://lore.kernel.org/all/ZQfbHloBUpDh+zCg@dread.disaster.a=
rea/
> > > > > >
> > > > > > It seems like we only enable high order folios if the "noswap" =
mount
> > > > > > option is used, which is fairly recent. I doubt it is widely us=
ed.
> > > > >
> > > > > For now, I skipped the swap path as it currently lacks support fo=
r
> > > > > high order folios. But I'm currently looking into it as part of t=
he LBS
> > > > > effort (please check spreadsheet at [2] for that).
> > > >
> > > > Thanks for the context, but I am not sure I understand.
> > > >
> > > > IIUC we are skipping allocating large folios in shmem if swap is
> > > > enabled in this patch. Swap does not support swapping out large fol=
ios
> > > > as a whole (except THPs), but page reclaim will split those large
> > > > folios and swap them out as order-0 pages anyway. So I am not sure =
I
> > > > understand why we need to skip allocating large folios if swap is
> > > > enabled.
> > >
> > > I lifted noswap condition and retested it again on top of 230918 and
> > > there is some regression. So, based on the results I guess the initia=
l
> > > requirement may be the way to go. But what do you think?
> > >
> > > Here the logs:
> > > * shmem-large-folios-swap: https://gitlab.com/-/snippets/3600360
> > > * shmem-baseline-swap : https://gitlab.com/-/snippets/3600362
> > >
> > > -Failures: generic/080 generic/126 generic/193 generic/633 generic/68=
9
> > > -Failed 5 of 730 tests
> > > \ No newline at end of file
> > > +Failures: generic/080 generic/103 generic/126 generic/193 generic/28=
5 generic/436 generic/619 generic/633 generic/689
> > > +Failed 9 of 730 tests
> > > \ No newline at end of file
> > > >
> >
> > I am not really familiar with these tests so I cannot really tell
> > what's going on. I can see "swapfiles are not supported" in the logs
> > though, so it seems like we are seeing extra failures by just lifting
> > "noswap" even without actually swapping. I am curious if this is just
> > hiding a different issue, I would at least try to understand what's
> > happening.
> >
> > Anyway, I don't have enough context here to be useful. I was just
> > making an observation about reclaim splitting shmem folios to swap
> > them out as order-0 pages, and asking why this is needed based on
> > that. I will leave it up to you and the reviewers to decide if there's
> > anything interesting here.
>
> The tests which are failing seem be related to permissions, I could not
> immediate decipher why, because as you suggest we'd just be doing the
> silly thing of splitting large folios on writepage.
>
> I'd prefer we don't require swap until those regressions would be fixed.
>
> Note that part of the rationale to enable this work is to eventually
> also extend swap code to support large order folios, so it is not like
> this would be left as-is. It is just that it may take time to resolve
> the kinks with swap.
>
> So I'd stick to nowap for now.
>
> The above tests also don't stress swap too, and if we do that I would
> imagine we might see some other undesirable failures.
>
>  Luis

I thought we already have some notion of exercising swap with large
shmem folios from THPs, so this shouldn't be new, but perhaps I am
missing something.
