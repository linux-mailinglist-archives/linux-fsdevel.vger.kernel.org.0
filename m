Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD16DB2B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDGSVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDGSVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:21:03 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C1BC
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 11:21:02 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-545cb3c9898so733958177b3.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680891662; x=1683483662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n9BCzd/cUBPMGsdmITGqlzt5wria1X+QmbZC4aBSvM=;
        b=NQ/Tb0DGafwLdqhgNp4K59kPcZ9/NRulY1cuqPgX3MVfr6KZ2HLzJyfgRGuh2m3MkU
         jA0YX1fC3BqUfCGCteuxT+hUR95Wa/hMay1OWFL92fIPHwP9IPyqEDIxN24fPY/2P6Hx
         u1EcdZCYNP4a+TO771XFd8MqbV+hxheDQau3ksrjRoFsAGn5hLYr982UPN03mVQkTqXL
         3otmuRM+T/KML8tOpcIfVpKJ+plwao/Lx72+ZyJNuIFgPMlQHrJRzjEMuNiP//Fwq4cG
         DKTmY6m9omYA9BnEboKtDaQewu5hhmUkqEGKLGkViGk4DSdMc8z0U3DSkfhvDW6jEScV
         zkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680891662; x=1683483662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n9BCzd/cUBPMGsdmITGqlzt5wria1X+QmbZC4aBSvM=;
        b=LUC/wW5tsU4dggFKxIk0yR5CY3R3h+p7licX8SoUKIQJ32SaIakmpeIjUDY18HnhnG
         zzoP0o97NdueDalzLq1v8r6n5Q6WCSEVURY/7VnRFITRdWxLqT9mQyxAGNlq//ji6xcJ
         gM+mOINzmgoLAX81yQEnp7OOBpedRFRn1Nu/uT83qkw0wNFXgq7BbDmaVigjrvsbjKzE
         x30B28EC4Rfwi/AtmjoiUZFuUSvhYvVXp21Uqd8ky8w8IlExHk7K/nbuheXRQ1YOgyhK
         zHhoFqHAwNzMZP3LHe9CtmATvBWgqsz/EeC2Geo66dzxHKMFK6mn0GIHWdvVJ2u/sDTS
         vorg==
X-Gm-Message-State: AAQBX9euvzC8DWeALQc7DAgS0CYxK4fE6Z1qgR3sq5quW2RJCUfPzidl
        DJz6bNklaLJaCF/tFoPf6CaFFpaNuiKzJSt5fZHGjebIDO6wiUZthwM=
X-Google-Smtp-Source: AKy350ZE8FrJxkUosn8R5uDKTKFqIuRyq3AFkT6sOWk5d5hsdOI6ajPdqGF2MxJSVLoE3YnUi8Mz0LcJ3AEfMVc2GSk=
X-Received: by 2002:a81:b620:0:b0:54c:88d:4052 with SMTP id
 u32-20020a81b620000000b0054c088d4052mr1531059ywh.1.1680891661895; Fri, 07 Apr
 2023 11:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230404135850.3673404-1-willy@infradead.org> <20230404135850.3673404-7-willy@infradead.org>
 <ZCxA+DYkzVWbLAod@casper.infradead.org>
In-Reply-To: <ZCxA+DYkzVWbLAod@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Apr 2023 11:20:51 -0700
Message-ID: <CAJuCfpHCW-2zVCHZxYWKVvUOZF4=jBaqEj3unRNpobdp-SM6kA@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm: Run the fault-around code under the VMA lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 4, 2023 at 8:23=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, Apr 04, 2023 at 02:58:50PM +0100, Matthew Wilcox (Oracle) wrote:
> > The map_pages fs method should be safe to run under the VMA lock instea=
d
> > of the mmap lock.  This should have a measurable reduction in contentio=
n
> > on the mmap lock.
>
> https://github.com/antonblanchard/will-it-scale/pull/37/files should
> be a good microbenchmark to report numbers from.  Obviously real-world
> benchmarks will be more compelling.

The series looks sane to me. I'll run some tests on a NUMA machine to
see if anything breaks. Thanks!
