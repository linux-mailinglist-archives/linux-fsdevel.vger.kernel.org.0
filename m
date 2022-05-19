Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4302852CB56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 06:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiESE4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 00:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiESE4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 00:56:39 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437FD69719
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 21:56:38 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id m6so4633827iob.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 21:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NJKw1vXIfSvk5yIua8czIA2YZGQXmQIGPUgORc3STc=;
        b=eif8pcDcaXqW+IJm5Y1LXcE3XQZQDQtcfAzjTD50zbQyb5DWzwv6ulI6dLRJqMWEiW
         1ZzBrTtGrjz69sLLSO8kLeGRUqGCgJCMXhw3WvcW3S4uZIIIS87P9ws4/yLtbCNRPXzH
         OROPHByULsIppZcUTYdG18PTW3y7RfpLL5k1nN2k3ykhSdOm5IK0Ujaj0LeXyjKgo6Vt
         Qc2a7x1+oAGQDsP10yJnqQi4Y619vRm5OjFWYcSAgMigfrp3Dsk3ABVWblfdJOorHQyZ
         iiVTLnRldntB7LBxG3FDqT34z3ZitUlG3JAKFx8qZdBLzCZ6u0AWBM3daP9cLglcy0up
         70rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NJKw1vXIfSvk5yIua8czIA2YZGQXmQIGPUgORc3STc=;
        b=10IrPLLDIFjK9JkelFuFAa6oDTFydfhzeuW3q2mNgHzRqKniuYFG25IxEVSKVF/BsA
         ZyZ6fhAS6ggDFEeDWPnOe24NTiujAitVwkmaXspFibmb4I93JWTu9oDSSA4hu1rQdZoD
         G7bWQVE/YIo/a+cFjrSw/HlvMTDOvXAkKj9O+hpjAS519x26+UKDNO5Dlw4HwsH2Jawn
         U0rgqnMYLtPkR3kF1LOlhMrNZ5cwjzajB4h1sEYIsp4lmtibNxOPu1kb4nunLhShEzga
         5kVeSlmEH2CeJW/hGg4r2ZDvZeFKdax/K6ohU+gF7Jr/N8YrHGGMQS9JyninHYblH4WO
         wqRQ==
X-Gm-Message-State: AOAM533tNY2/Luj9PA9VxqY8xEw/ygGubM74VDKzj7Jly4LFjvvysL9U
        /DihjHthLsP+aWpxRdlTLrJ8GEmMGPB8KT8QqQQ=
X-Google-Smtp-Source: ABdhPJyhFpMlwWXONr5AYpuQ6EWE7ugECp4nQGV65hDjsdKg3ONfiS7E0dWnt0cuA7Y3cjIqkOFHxOieEK8tz8Jfck8=
X-Received: by 2002:a05:6602:2acd:b0:65a:9f9d:23dc with SMTP id
 m13-20020a0566022acd00b0065a9f9d23dcmr1512621iov.154.1652936197595; Wed, 18
 May 2022 21:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein> <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
 <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
 <d6f632bc-c321-488d-f50e-749d641786d6@fb.com> <20220518112229.s5nalbyd523nxxru@wittgenstein>
 <CAJfpegtNKbOzu0F=-k_ovxrAOYsOBk91e3v6GPgpfYYjsAM5xw@mail.gmail.com>
In-Reply-To: <CAJfpegtNKbOzu0F=-k_ovxrAOYsOBk91e3v6GPgpfYYjsAM5xw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 18 May 2022 21:56:26 -0700
Message-ID: <CAEf4BzaNjPMgBWuRH_me=+Gp6_nmuwyY7L-wiGFs6G=5A=fQ4g@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, clm@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 4:26 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 18 May 2022 at 13:22, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, May 17, 2022 at 12:50:32PM -0400, Dave Marchevsky wrote:
>
> > > Sorry to ressurect this old thread. My proposed alternate approach of "special
> > > ioctl to grant exception to descendant userns check" proved unnecessarily
> > > complex: ioctls also go through fuse_allow_current_process check, so a special
> > > carve-out would be necessary for in both ioctl and fuse_permission check in
> > > order to make it possible for non-descendant-userns user to opt in to exception.
> > >
> > > How about a version of this patch with CAP_DAC_READ_SEARCH check? This way
> > > there's more of a clear opt-in vs CAP_SYS_ADMIN.
> >
> > I still think this isn't needed given that especially for the use-cases
> > listed here you have a workable userspace solution to this problem.

Unfortunately such userspace solution isn't that great in practice.
It's both very cumbersome to implement and integrate into existing
profiling solutions and causes undesired inefficiencies when
processing (typically for stack trace symbolization) lots of profiled
processes.

> >
> > If the CAP_SYS_ADMIN/CAP_DAC_READ_SEARCH check were really just about
> > giving a privileged task access then it'd be fine imho. But given that
> > this means the privileged task is open to a DoS attack it seems we're
> > building a trap into the fuse code.

Running under root presumably means that the application knows what
it's doing (and it can do a lot of dangerous and harmful things
outside of FUSE already), so why should there be any more opt in for
it to access file contents? CAP_SYS_ADMIN can do pretty much anything
in the system, it seems a bit asymmetric to have extra FUSE-specific
restrictions for it.

> >
> > The setns() model has the advantage that this forces the task to assume
> > the correct privileges and also serves as an explicit opt-in. Just my 2
> > cents here.
>
> Fully agreed.  Using CAP_DAC_READ_SEARCH instead of CAP_SYS_ADMIN
> doesn't make this any better, since root has all caps including
> CAP_DAC_READ_SEARCH.
>
> Thanks,
> Miklos
