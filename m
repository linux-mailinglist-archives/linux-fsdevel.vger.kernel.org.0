Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB9738515
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjFUN3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 09:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjFUN3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:29:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522819B7
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 06:29:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9b4b286aaso127535e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687354172; x=1689946172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdD6cJh6qu5svt4tCCc88YcqEs1pBBrW5+aY8WHVANw=;
        b=FVWCzeaws/zcBjOjUu1n3j7WTelwG9JXw5CEnSXuVyoExnw46Vm7mXMycj7Ey0QchI
         UVjgVZ4W3h5G5DyoOoZIhV8s+QLEGIuDiv7FHV5vIOU910wUI0T7BqJIL3hiUULNn3pB
         VdLBj/gmBNQfPFQVDSrnzVcXK2S0UMtK8OtAgvQT4uoauo/jz+/SpPUkkiLkSsQxZd2z
         AEO/hNolEPFpBTzv4Bg80pQfyL3BI9NXzGgzGhDMGTnQxEUxqfg/L5oCp96E0x9VwNVo
         gpzHx1Oy1YyVpGtZNzIKXvRaHqC7XKKGAEWWjdzzHQPIo3iS6lSAwNv8U3KzzfxEcpnE
         heFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354172; x=1689946172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdD6cJh6qu5svt4tCCc88YcqEs1pBBrW5+aY8WHVANw=;
        b=OwMZfKNHi3fccrkxXDeu5zE8mjOk8t2D5LUTls+lOyf0SHSCE7hdAYzcD9MNRLanpT
         yUJKHIdHhou0TQ+zWSZRHh/1w/1HyYe/4gUmvgC5XiN3SOeQ7t2YIMQpKcLUWwT9pmS3
         vU51aklCMkZwLfWJDEcyyN8pRFyB7XEheAndutzr5SFMIzBMRk3kCDArWGH1yUz69USQ
         cW3QriZTYShJ+3VXeTDTJTtPOMno5IibWUYfw/d3WQ7UZZ5r7r2HumxnjYyH/gVfHluV
         P0I30nwgzeasd8zRpvRxWksl/IH0DjBCuzT4n+t+08Aqm9h6VeZpWQNosH0jE1zLpFjx
         fCJw==
X-Gm-Message-State: AC+VfDyHLZ6ynDFpBRuMfeelI5Vx061jAsPzAMOQZopC8LVPjDut+ibk
        nVUhxMJL2RdUUJzjA0VE7L0q7a2iICD5KZ4Hlf09NQ==
X-Google-Smtp-Source: ACHHUZ5oAZ9+8akmbC5AZy2U+cfa4H8NZ/OYc/GWPMsKsUpaTNBCrKI6BrBopugvdCFxO09eZzJcDuVKBMM6NPG7gzE=
X-Received: by 2002:a05:600c:3ac9:b0:3f7:3e85:36a with SMTP id
 d9-20020a05600c3ac900b003f73e85036amr1128926wms.7.1687354172487; Wed, 21 Jun
 2023 06:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230615141144.665148-1-usama.anjum@collabora.com>
 <20230615141144.665148-3-usama.anjum@collabora.com> <ZJHp6hSeS6lMo7qx@gmail.com>
 <1c1beeda-ceed-fdab-bbf5-1881e0a8b102@collabora.com>
In-Reply-To: <1c1beeda-ceed-fdab-bbf5-1881e0a8b102@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 21 Jun 2023 15:29:20 +0200
Message-ID: <CABb0KFHpE+jJH0MmxZTFaQ9FNFNUnJcnnv7sSGDYqDqqB_FRqw@mail.gmail.com>
Subject: Re: [PATCH v19 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
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

On Wed, 21 Jun 2023 at 08:35, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 6/20/23 11:03=E2=80=AFPM, Andrei Vagin wrote:
> ...
> >> +struct pagemap_scan_private {
> >> +    struct page_region *vec_buf, cur_buf;
> >> +    unsigned long long vec_buf_len, vec_buf_index, max_pages, found_p=
ages, flags;
> >
> > should it be just unsigned long?
> These internal values are storing data coming from user in struct
> pm_scan_arg in which all variables are 64 bit(__u64) explicitly. This is
> why we have unsigned long long here. It is absolutely necessary.

vec_buf_len and vec_buf_index can only have values in 0..512 range.
flags has only a few lower bits defined (this is checked on ioctl
entry) and max_pages can be limited to ULONG_MAX. Actually putting `if
(!max_pages || max_pages > ULONG_MAX) max_pages =3D ULONG_MAX` would
avoid having to check !max_pages during the walk.

Best Regards
Micha=C5=82 Miros=C5=82aw
