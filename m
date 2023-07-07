Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC80374B821
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 22:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjGGUj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGGUj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:39:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE461210C
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 13:38:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9923833737eso268468766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688762333; x=1691354333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5GzoeG98fEPpoz1Cl1g4Qg71twRkm1tM+omwnJ1Pnk=;
        b=WH7E9lv9EnTxKkw+kdIYBI9TKdORaKmjvGgb3pPV847969g1QlrNpJzaggCcNI2bbg
         h+aTRRezJFDZNa2ZALyMVsdt2NvoXYZGyWbcku/1E36NYHjSECN46W7AD+0oz1803eA4
         lzdBpVev9ZPerFAPGyWWO/aHlqgZl1OgHopnYcusk3HaKmwHFdBjqlJcsIoNJzycsTn1
         kfnhJVTTNJRQ2wO1kfChdtz/wWwRdt88CkvoYcHmynwgWZRDLPCqtSlJvsAVO5fi2LMu
         NHRdL3HXNn9cKscccOT7hsBazJ5f0Fua/tERjXEy/liWWxehP1UtUX7sQbJENxFBTTsl
         H3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762333; x=1691354333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5GzoeG98fEPpoz1Cl1g4Qg71twRkm1tM+omwnJ1Pnk=;
        b=OnIzR5xhJxRAdliJYIr67gCe+deztVc+48j7KWnFyEl5nrxQnqQEBw5PW7fHqDAt7b
         kGF/QPISB4qAOfjVD6mtLZ4avZer2RCgfZNJabGsUfCtbAMHGWUzgzpoMDivZOzRg+Ea
         OAYf8YzTSqdTtx/xUpY5PwHOKe6VbZ20AZoOdhrqFmVVIb1yXBP72LB/ZdtuD5yg1bIV
         79swfNqzfJKIjxGZ6BWFhZk7j8Bm/bcoKgz2yqRrK0Khqin6YX5ofUPAbK5vhx7Ivu4h
         JPa1rCVCXyDFz4n3rWSyTc+ABIpL15WUO28E51NrsPxzJQkpiyCcBcRVBksI6rgtnp1s
         gbCQ==
X-Gm-Message-State: ABy/qLb+tgKIJI/fhRCSNBemE+XhCsQAFnf+yjrAT0Hb52bUSTpP15kM
        ZlnnUhoDSQhqI0K8FmV2tGfdZ/FSbsxkveSFOFuxjA==
X-Google-Smtp-Source: APBJJlGvHGSDao1yQTFp/8AttfmOyAketz902pkJlwD7mID8tlI+W7elLQoXUGZjItFKxk9cWhaH/7FWxQqXJBHz7a0=
X-Received: by 2002:a17:906:1001:b0:962:46d7:c8fc with SMTP id
 1-20020a170906100100b0096246d7c8fcmr5864601ejm.21.1688762333216; Fri, 07 Jul
 2023 13:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-8-axelrasmussen@google.com> <ZKgWOYuIdqa25Qcs@x1n> <CAJHvVcj-3gUC3dx4LAVnNr-zgo8+cwjGNafQ480EhDifojrcRA@mail.gmail.com>
In-Reply-To: <CAJHvVcj-3gUC3dx4LAVnNr-zgo8+cwjGNafQ480EhDifojrcRA@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 7 Jul 2023 13:38:16 -0700
Message-ID: <CAJHvVci6qCv+d7Hz0QkqeuEZze0OFJt0P9qnWgA_cgDeaLmptQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
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

On Fri, Jul 7, 2023 at 10:03=E2=80=AFAM Axel Rasmussen <axelrasmussen@googl=
e.com> wrote:
>
> On Fri, Jul 7, 2023 at 6:42=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Thu, Jul 06, 2023 at 03:50:35PM -0700, Axel Rasmussen wrote:
> > > @@ -247,9 +245,13 @@ static int userfaultfd_stress(void)
> > >  {
> > >       void *area;
> > >       unsigned long nr;
> > > -     struct uffd_args args[nr_cpus];
> > > +     struct uffd_args *args;
> > >       uint64_t mem_size =3D nr_pages * page_size;
> > >
> > > +     args =3D calloc(nr_cpus, sizeof(struct uffd_args));
> > > +     if (!args)
> > > +             err("allocating args array failed");
> >
> > This is trivial, but I think I requested a "free" (or keep it allocate =
on
> > stack) in previous version but it didn't get a response on why we canno=
t
> > and it kept going..  could you help explain?
>
> Oh, sorry! I had meant to change this after our discussion, and simply
> overlooked it while reworking the patches.
>
> I'll include this change in a v4 which also addresses e.g. the
> comments on commit 1.

Ah, so I tried switching back to the {0} initializer, and was reminded
why I didn't do that in v1. :) Ignoring the missing braces warning I
talked about before, using {0} here is actually an error
("variable-sized object may not be initialized") because this is a
variable sized array (nr_cpus isn't constant). So, that option is out.

I'm not a huge fan of adding the free() cleanup and dealing with all
of the err() calls this function has.

Originally I switched to calloc() because I'm not a big fan of VLAs
anyway. But, as a compromise in v4 I'll leave it a VLA, and switch to
memset() for initializing it.

>
> >
> > --
> > Peter Xu
> >
