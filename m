Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE04D500D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbiCJRRA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 12:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiCJRQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:16:59 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84C184B69;
        Thu, 10 Mar 2022 09:15:58 -0800 (PST)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MVubb-1ncZTj3dn3-00RsYH; Thu, 10 Mar 2022 18:10:50 +0100
Received: by mail-wm1-f42.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so3795999wmp.5;
        Thu, 10 Mar 2022 09:10:50 -0800 (PST)
X-Gm-Message-State: AOAM533Pva/6bc6aKl5NsMGMPWfBgB9p++ShzNiUPxMEGAXBCb4lmMad
        N8GKHnFe8nFPkZPHSy72vli44q0P5iV4TltTq94=
X-Google-Smtp-Source: ABdhPJxY8hGm9BEQKWwA3R6ukJGTZsnEU2TjUOjQUHCfOHpxv80mjDHnXeVwtelmj78dbQthb1oQ3YX63RkYL8slNoM=
X-Received: by 2002:a1c:f20b:0:b0:389:c99a:4360 with SMTP id
 s11-20020a1cf20b000000b00389c99a4360mr10282657wmc.174.1646932250447; Thu, 10
 Mar 2022 09:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20220310072924.0EF1EC340EC@smtp.kernel.org> <c0eb0b0f-1fdb-b653-fbf9-4b1bd7c26efa@infradead.org>
In-Reply-To: <c0eb0b0f-1fdb-b653-fbf9-4b1bd7c26efa@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 18:10:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a23aduadfJsSEFdXB3a0B_krC9LLEfa-erSsSXcqzVqtw@mail.gmail.com>
Message-ID: <CAK8P3a23aduadfJsSEFdXB3a0B_krC9LLEfa-erSsSXcqzVqtw@mail.gmail.com>
Subject: Re: mmotm 2022-03-09-23-28 uploaded (drivers/perf/marvell_cn10k_ddr_pmu.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Michal Hocko <mhocko@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mm-commits@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:M7v+Mq5EbLAcuH2nYt7VJxsI46M2PrCK7TQVAAoFnYFrbqEGMRu
 VogCi2EPJhfb9Swue5MgWnXjXk7ihfznZWshF5Ddt7LO9ZgIAitWKoTadRjOZBRXBsUJlYl
 leTGBxjRHR02d8ztcrmvo1IzNcWYtsvKYq8s6MUL+1gBPPsyOFrQ4ih0+yAIa4fRrLtEWNn
 nfoHGkcGiSHdlejkPronA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:flGkjSRsxfY=:JlmSqKh0OmsabBCaaJbMQo
 x7qE2+WsS7ewagHtXZDTMHju5uJ11Y9aoMNLn513CqCMDsoAQN7KTOaRGqBvpekPu0SOt8xEC
 H8jKQgieXTm7IKRRpiYFb+RPtcQBuAmRDa64oB+KdOjeYJHG12A8Q4NJ8qrdyzM5FOL9ak0fu
 +xmBZs6ph+FYdDIfQci8j8EVfNhtKJGI80HjwPoaWbCRyH6NLMzjnKi+rFwsKBUd/LLCn6PA7
 WhDAJPiCsZsCM7JHOpHN/kal7tsgzZ7tQ5fbfDdvQ91+Dibj6RmTsZoKgpF44+7t8xg9iba6j
 IdJjna8PgIaQnIbpyrZbv+5RAifMVd+4D8lmbxUIiGUtE1bxwUbfDQcoe/VOfPZCH7T8jkepF
 fQGQCtDMcQ5pswnia3UAPWL65V4NZFz769WMBJvGGYA0VPKUbL7IlY2+H5g05sT3EZ/klZU6P
 vFk+8w4MDG5EnAP6W2bk77Se/EDJZV+Y6J9qMrgpAAnqNKnK6VCfoI3jWUnG2ssedgcbAXXER
 hGu/AbEVeAklVcO+w2RFqMZJs8sut7NqlDN/lVERiAbdsufir4pDjV6HgdO7S33Klhr36Qejf
 bFdvw4UO9TiDzSDZN/U9KH9kNijFEhMCGpTZCTdSIfbu/Cv3bc4kvWr2TG6HEETMyzzZ4Aa2N
 T3ITkQ5Cbbwi30c6kJUPkcZExpQrf4fNzWl4vgYHPc9fBP0ixypucZVI58Kt6Ft3WGrg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 5:34 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 3/9/22 23:29, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2022-03-09-23-28 has been uploaded to
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
> on x86_64:
>
> ../drivers/perf/marvell_cn10k_ddr_pmu.c:723:21: error: ‘cn10k_ddr_pmu_of_match’ undeclared here (not in a function); did you mean ‘cn10k_ddr_pmu_driver’?
>    .of_match_table = cn10k_ddr_pmu_of_match,
>                      ^~~~~~~~~~~~~~~~~~~~~~
>
> Full randconfig file is attached.
>

I suppose this is caused by having two different fixes applied, one that removes
the of_match_ptr(), and one that adds an #ifdef. Either one would be correct,
but the combination is not.

       Arnd
