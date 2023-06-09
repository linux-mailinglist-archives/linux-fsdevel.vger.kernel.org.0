Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB972A293
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 20:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFISuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjFISuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:50:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D632A35B3
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 11:50:43 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565ba6aee5fso19409217b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686336643; x=1688928643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls8ASbqVf+OxfQ28gdwv86E0CDvCxuQPRXvTmaU1qZ8=;
        b=BgYnhkcmYneC2cgdqH9vPsforrcVpoamZZpxmNymi1HhYM867JQFIqyJMfLNj1OA0o
         NQxhNdWVWw2kpK9b9QIWfhosCBBZ4B2bkqiX3unz2elF0Yd6Y71kqEXDGCrefkPDUai/
         dL+4UFs1CvOYimCjF5ECs0h3MPk89VlOj5i/TOhmz6QNh2pBmaW8i1UBqwlHkr5IGdwN
         ti//h4UPqPvcuA73LNPEPpM9GamOEJanilhV7k6zGc5LCLAMSpm82jA5I0MhGgYoXeyI
         y5wrk3ovnGstX9TU8PWz96LMy/xbUqzEGZhyp49j1fZNXcd0fWa/NJ5jwrkNQ28f/Jfd
         sWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686336643; x=1688928643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls8ASbqVf+OxfQ28gdwv86E0CDvCxuQPRXvTmaU1qZ8=;
        b=E4WO19vvYxv7aMzVcJUehbA8PhgQ/czEFwjh4p4duHRvlTxv3KtidmhgjFztqHt8hD
         ohQe9z01R2o5SH2O9IZYehmquqvyWnCpiDOIUmCheyI6RCjR40dLU99mium6YCklao4f
         7kCZgOd7R2WDkgLiwCf1Lrik20avtgSnaCr9IomkUhPH5xD7SEz0Pidfa3+oVHEkzZho
         5Uec0IdWFXA3ydAS78pXsB3oZ444qmlPcwx4Cwzs9kIWntf0oF9LURKFqAdlDMGYjURy
         1VMyocstG0Rsq4R73cR2UU9HsoanoAMgCHWsSVQB07L+cu0i2mUYNMT3hBX/6qaHX3MD
         78mg==
X-Gm-Message-State: AC+VfDx9bJgrAs+yBG9n2EuFHRDrPtg0T2aZCtImAQtDCr0cuCGuEMwP
        ZBkkSn355YVcRxq4h0WIJ0mIYduJsGSgGEW6EPEQrA==
X-Google-Smtp-Source: ACHHUZ5mlzEP6duFB2RPppaJytP0jp8FV90GwtBIyaVVZeY0WsEB4K2kSrmJb1pVmexp2PI1D8rfhTnQWfgDoQCZK5c=
X-Received: by 2002:a5b:712:0:b0:bac:a43e:88e9 with SMTP id
 g18-20020a5b0712000000b00baca43e88e9mr1736212ybq.44.1686336642462; Fri, 09
 Jun 2023 11:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-2-surenb@google.com>
 <877csdpfcq.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAFj5m9K-Kyu-NV1q3eGeA8MOcC1XYgYyENnti-Qd8Mj-A6=Q5Q@mail.gmail.com>
In-Reply-To: <CAFj5m9K-Kyu-NV1q3eGeA8MOcC1XYgYyENnti-Qd8Mj-A6=Q5Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 11:50:31 -0700
Message-ID: <CAJuCfpECOWgKx+PTsygNM9mryEf_So9QwCrPyBrS-tjbzCWjDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] swap: remove remnants of polling from read_swap_cache_async
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, david@redhat.com, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 8, 2023 at 8:14=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Fri, Jun 9, 2023 at 9:58=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
> > + Ming Lei for confirmation.
>
> Good catch, it isn't necessary to pass the polling parameter now.

Thanks folks for reviewing and confirming!

>
> Thanks,
>
