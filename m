Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139E659C97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 22:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiL3V7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 16:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiL3V7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:59:46 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BC1CFF6
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 13:59:45 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id a64so18954061vsc.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 13:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ojCvjpUwmQcpqlhAqAXahIQg5LmJzJtnHdnov88yJMs=;
        b=ZlXVJI2uLZhNL3WGmXGzQbeJ+Y9BZcsePf40pR3SW0CbR6qoB+Ce9wZvSMjvacx3TK
         VR5gqxU9e5BtU360p9T8tGR3aNMt1abiiG2Jos2ghZFmXEx9eNiH0NPr7FFwacW5i3f8
         xhBbOGNegv3yvGegSG6BZ3za7+mvKWD4+06557JEYa7qjgszntkNt+84dhY/IVM6mvU2
         r40JZJrBvzdHysFXwtHNOfp6D6MKTqhP9bdDEegX21uONIX6QXjLNSuMXlchC/xHRCkK
         6EgsbOyze+/xSUh7Wz7F+op/f7aIKl09JEg1qD5+llHkHvYUHWTQYEJe/OjXIbaQ1ynR
         sjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojCvjpUwmQcpqlhAqAXahIQg5LmJzJtnHdnov88yJMs=;
        b=IPQuIZXnPQz8vDGZiGyLzfQrc103gO+rtx9bnk9s4P7E76wKp477AjoVLSuib+n0OP
         DVmB1uKA8djBqBcwpU+OBCPFyzW2wrG+3goiyb4AghUcGoiRjMFz2LEkO+0rfo74BQB6
         z89bH5dJ1AruySLO6CklOqThOa+nBSRYw7dwZXedUUq1C341DTUAUPvO5Uk0duTEkY0o
         I4mSvaw5xtLAIgAeUAJBjNMewBBfx/GzzQi48L6AdTHS4mUTaS39Sk2Or0iA+VblJo8l
         wW+0zDtN663g9FsoSzWtICy4Nv3cz76gnvo2eJvlOF/q51SmXJeopnmPmxIwiuWn0qXr
         DcgA==
X-Gm-Message-State: AFqh2koLpjTpod0iykiXPuR3fC5rrpbbxfj+hKcRt3XDPNDIYcChj7Pe
        DDUkQ707r5hcHYKglMZV2NoIR5BBozUUd+aNrulSjg==
X-Google-Smtp-Source: AMrXdXsMbDKNYMIrLNNEHL37FFgKk2+piZDk5e8JDw1OEPqIetTy7RlBmJ1yAcxxST6OWGS2se4bKXJHEFqLA2nsLdU=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr2914595vsv.9.1672437584212; Fri, 30 Dec
 2022 13:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20221222061341.381903-1-yuanchu@google.com> <20221222104937.795d2a134ac59c8244d9912c@linux-foundation.org>
 <CAOUHufZpbfTCeqteEZt5k-kFZh3-++Gm0Wnc0-O=RFT-K9kzkw@mail.gmail.com> <20221222122937.06b9e9f3765e287b91b14954@linux-foundation.org>
In-Reply-To: <20221222122937.06b9e9f3765e287b91b14954@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 30 Dec 2022 14:59:08 -0700
Message-ID: <CAOUHufYYoJJmDE3Y0r8p_BqGG5Cgig=Ntuz9ThEnfvkxqL_ZLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add vma_has_locality()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 1:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 22 Dec 2022 12:44:35 -0700 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Thu, Dec 22, 2022 at 11:49 AM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 21 Dec 2022 22:13:40 -0800 Yuanchu Xie <yuanchu@google.com> wrote:
> > >
> > > > From: Yu Zhao <yuzhao@google.com>
> >
> > This works; suggested-by probably works even better, since I didn't do
> > the follow-up work.
> >
> > > > Currently in vm_flags in vm_area_struct, both VM_SEQ_READ and
> > > > VM_RAND_READ indicate a lack of locality in accesses to the vma. Some
> > > > places that check for locality are missing one of them. We add
> > > > vma_has_locality to replace the existing locality checks for clarity.
> > >
> > > I'm all confused.  Surely VM_SEQ_READ implies locality and VM_RAND_READ
> > > indicates no-locality?
> >
> > Spatially, yes. But we focus more on the temporal criteria here, i.e.,
> > the reuse of an area within a relatively small duration. Both the
> > active/inactive LRU and MGLRU rely on this.
>
> Oh.  Why didn't it say that ;)
>
> How about s/locality/recency/g?

Thanks. I've done this, and posted the v2 which includes much better
commit messages.
