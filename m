Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1981A539937
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348277AbiEaWBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 18:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348273AbiEaWBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 18:01:04 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7AE54005;
        Tue, 31 May 2022 15:01:03 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso10478654oto.10;
        Tue, 31 May 2022 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1kcpHZfon90bWFf3C0opWYOsOsDgVYWIWfKF1sbIHOg=;
        b=PzDb+I+odIVJv+v3SJAjJiieVhfK9TLxSG7HEepT0URrxw1QQp7kRmiwJBPWRRavIc
         4OMfjNbouVwJ9QQpQgLBXk6+QrfrsPci7ETu9MqS7ke/cmB5AaDwyt0mTTrETEI0nla8
         ZoLP0cqrGh6Dw6Q5ps0yJtVdbye1Xjh4O23j3NOeVtWJfStBz4VKNrCPsD2YUn78wnbi
         Ukl+m69RJ4e1Q6zPLsNeTDpLPDG05ZQrka2NfxXfSb0vOdwt0Bvb0jIKeCOCB3zfJalh
         4mvF/uQXHPN8cAyYKnxmvof/pxdnJb1AtX2kW5llJ/84g0tUGQEq+0RBuVEWhFw0MnUm
         /27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1kcpHZfon90bWFf3C0opWYOsOsDgVYWIWfKF1sbIHOg=;
        b=4K5uBr0uKC5fMJU8tMKYQaSj83q774YtxcwlIR9PmrdFIuHy0oCE4jQzQERuxW9UYX
         vatFnLMgawLC1Zor/J9p1609FF3XVglekoyxBMGyzhY7Lzs5DkRN4WHBizTm2ohoatuh
         AR8kt9KZOgnaXc5bMS1lFBsCr+MjDIo287c7iQizP3B6mGT+1ptt28bSovbkS5ztfA6d
         3dgQGSdZBhgP/SfBm2BPAkold6vn4aFibRBDN34u5BSVXWLf33Uw8Pon9nU00gJMte6i
         qjcy1BvCmMwpoN2pXP7Z+N8z74CqIrkC226e9LVOlERUE2NQWyHL3kgCLxZWoSgMctkx
         NgMg==
X-Gm-Message-State: AOAM530XF7ncc/WMnz5BiD/PJA6+y2TUy7ljfYIxy9U62zk5VwRg0i4H
        kxZLqnToe8IldBDKbUWs66FPz411TL1LiJMaKyk=
X-Google-Smtp-Source: ABdhPJyKVYOkJ1d9Y7SW5ELtHTlhTKMcjbccQa1ILmaqZpJll1OzACOy0Pf6i7ZX6i42bY3GxbQOusF+tYcIkZKsQbg=
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id
 b24-20020a9d6b98000000b0060b0c54e22bmr18226057otq.357.1654034462389; Tue, 31
 May 2022 15:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220531100007.174649-1-christian.koenig@amd.com>
In-Reply-To: <20220531100007.174649-1-christian.koenig@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 May 2022 18:00:51 -0400
Message-ID: <CADnq5_Ng7oe_NMSb6GdL=_T_zw22Gk0B6ePDXRiU7Ljind6Gww@mail.gmail.com>
Subject: Re: Per file OOM badness
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Cc:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Hugh Dickens <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+ dri-devel

On Tue, May 31, 2022 at 6:00 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hello everyone,
>
> To summarize the issue I'm trying to address here: Processes can allocate
> resources through a file descriptor without being held responsible for it=
.
>
> Especially for the DRM graphics driver subsystem this is rather
> problematic. Modern games tend to allocate huge amounts of system memory
> through the DRM drivers to make it accessible to GPU rendering.
>
> But even outside of the DRM subsystem this problem exists and it is
> trivial to exploit. See the following simple example of
> using memfd_create():
>
>          fd =3D memfd_create("test", 0);
>          while (1)
>                  write(fd, page, 4096);
>
> Compile this and you can bring down any standard desktop system within
> seconds.
>
> The background is that the OOM killer will kill every processes in the
> system, but just not the one which holds the only reference to the memory
> allocated by the memfd.
>
> Those problems where brought up on the mailing list multiple times now
> [1][2][3], but without any final conclusion how to address them. Since
> file descriptors are considered shared the process can not directly held
> accountable for allocations made through them. Additional to that file
> descriptors can also easily move between processes as well.
>
> So what this patch set does is to instead of trying to account the
> allocated memory to a specific process it adds a callback to struct
> file_operations which the OOM killer can use to query the specific OOM
> badness of this file reference. This badness is then divided by the
> file_count, so that every process using a shmem file, DMA-buf or DRM
> driver will get it's equal amount of OOM badness.
>
> Callbacks are then implemented for the two core users (memfd and DMA-buf)
> as well as 72 DRM based graphics drivers.
>
> The result is that the OOM killer can now much better judge if a process
> is worth killing to free up memory. Resulting a quite a bit better system
> stability in OOM situations, especially while running games.
>
> The only other possibility I can see would be to change the accounting of
> resources whenever references to the file structure change, but this woul=
d
> mean quite some additional overhead for a rather common operation.
>
> Additionally I think trying to limit device driver allocations using
> cgroups is orthogonal to this effort. While cgroups is very useful, it
> works on per process limits and tries to enforce a collaborative model on
> memory management while the OOM killer enforces a competitive model.
>
> Please comment and/or review, we have that problem flying around for year=
s
> now and are not at a point where we finally need to find a solution for
> this.
>
> Regards,
> Christian.
>
> [1] https://lists.freedesktop.org/archives/dri-devel/2015-September/08977=
8.html
> [2] https://lkml.org/lkml/2018/1/18/543
> [3] https://lkml.org/lkml/2021/2/4/799
>
>
