Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB476E2CBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 01:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDNXMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDNXMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:12:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448846A5A
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 16:12:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id jg21so49095813ejc.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 16:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681513939; x=1684105939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQD1oso+8ADTrmZywcy5/ZWb5KiX0kq22/9gdYr2fT0=;
        b=rqz6hoGlruHKPc5t2bxSsCjJ0q8fLUfCjDlhl4Z5UjfIBNLVoqdHRwpUspz3jYAZNl
         f2vofoEu2tP1aZLwxjiF8wqjCmLPyk2fhSgT6bIqpEi5T7lKgWxLmMIvDyPKYYPdytt4
         0nzGQ667jAg9GOBlcF6dDnqE+apDZpaXthStELBKtqOKxcyoTD2j9OXN3rWM9uHm2XUe
         N1V7S4e4JntnuWAJxmosdJjiIoC0YQPvFtLV84JtHYBi/kBrs4jYzueDnngMYASwCDZy
         WtYQLvayq7pTuprvd4phPV8N3kXKSN0VwNR/SuNsTRnEjL4i8iN6/xkGqGgGY6QAAvn2
         cSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681513939; x=1684105939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQD1oso+8ADTrmZywcy5/ZWb5KiX0kq22/9gdYr2fT0=;
        b=NetNA63Zcx/AA1g2cIc/vsIS/fIWaWGDukew/o7VkbyRzxVbrrzFi1qV40txtQOG12
         0l3wSK8fwM6Y8WC87vMrzXKwKAaSOtCkUpFd3C+78/n1CfZ7wg7Z0TqvYL8CRot2W3P4
         wBkdvOfdmKKsrXWRU2cdLzXXsZZnHbtS87/gdRkPrXs4h5uEDezPHg5bE97zZKQPGuwy
         QHv9fEueLUPP8JOSm2RDSYGOT6YsU98YhM1sFCSXrxp7OdtwqU+G0EMtwZExW+Mfy7E2
         C4Z+FRFkvdLBDsZDU8z5/+dgopBqjSwN0ztNLYtU80tw4Ev8BLfauYDndUG3bEx/vfNZ
         pYow==
X-Gm-Message-State: AAQBX9edD9dBYWi3JKzNwOfUXvZtSuN+qiETeQrIHYEMyxUpU3AX9xYI
        b/pBlWEu6Sgv0AFbBJXLafHNxCUTrTQEMaaM7eL45w==
X-Google-Smtp-Source: AKy350ZVW/SeKKN7bQaip/vQ/ZivEBvqqS/RV2NR13bc/DeeXMLJdi7ZYfPWAWzE33zqe1KsI8fspxB3C5u2WkZCZxI=
X-Received: by 2002:a17:906:4c49:b0:94b:d619:e773 with SMTP id
 d9-20020a1709064c4900b0094bd619e773mr320456ejw.15.1681513938572; Fri, 14 Apr
 2023 16:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-4-yosryahmed@google.com> <b7fe839d-d914-80f7-6b96-f5f3a9d0c9b0@redhat.com>
 <CAJD7tkae0uDuRG77nQEtzkV1abGstjF-1jfsCguR3jLNW=Cg5w@mail.gmail.com>
 <20230413210051.GO3223426@dread.disaster.area> <CAJD7tkbzQb+gem-49xo8=1EfeOttiHZpD4X-iiWvHuO9rrHuog@mail.gmail.com>
 <20230414144704.2e411d40887c8e9e25ab2864@linux-foundation.org>
In-Reply-To: <20230414144704.2e411d40887c8e9e25ab2864@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 14 Apr 2023 16:11:42 -0700
Message-ID: <CAJD7tkZOkd17UubA5FwrphEFTx+ZhXikFVEEXpVt6159QSC4og@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mm: vmscan: refactor updating current->reclaim_state
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 14, 2023 at 2:47=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 13 Apr 2023 14:38:03 -0700 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > > > I suck at naming things. If you think "reclaimed_non_lru" is better=
,
> > > > then we can do that. FWIW mm_account_reclaimed_pages() was taken fr=
om
> > > > a suggestion from Dave Chinner. My initial version had a terrible
> > > > name: report_freed_pages(), so I am happy with whatever you see fit=
.
> > > >
> > > > Should I re-spin for this or can we change it in place?
> > >
> > > I don't care for the noise all the bikeshed painting has generated
> > > for a simple change like this.  If it's a fix for a bug, and the
> > > naming is good enough, just merge it already, ok?
> >
> > Sorry for all the noise. I think this version is in good enough shape.
> >
> > Andrew, could you please replace v4 with this v6 without patch 2 as
> > multiple people pointed out that it is unneeded? Sorry for the hassle.
>
> I like patch 2!
>
> mm.git presently has the v6 series.  All of it ;)

Thanks Andrew :)
