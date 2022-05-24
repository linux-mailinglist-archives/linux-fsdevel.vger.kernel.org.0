Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476C3532233
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 06:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiEXEht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 00:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiEXEgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 00:36:11 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01AC4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 21:36:09 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a8so1927567ilh.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 21:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXmaedrKbmO4bO52TeHEWw01ZWg6LruLg54dJBFlKS4=;
        b=XJIwu5h7PBJyTaqWUfuGpewVnV/40xafniveGp5KxppGnq/ZAEdrl872GfW4rOPFsx
         +kc4Nxdbi5ArdEc6EuDsWjdZMOzKrktCSQo3rQm+f1zQU306HxERng5hvKkjkLlbx5bz
         RoUfr9E49JPXQ5bMTpOxAxnL/R6lA5zO3lB2OxpBD1hV0+7jLuQZWqfA4gFv8vDNCqqc
         AGY2GeGl0dB0KXSgH9wAGANbxBmZ1PVdVD2Dd62WqlcokEOM23Ongd0Q4y5WgQkZrALr
         4MDlFCjux4jXVTXpfCpXaa6KHrmwvi3ztZEiNTIjiAmGdaGI1LSHlOzWjyLDmfMUKQXE
         toCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXmaedrKbmO4bO52TeHEWw01ZWg6LruLg54dJBFlKS4=;
        b=aaiEwBl1gQsPNk8JGvHTmTVQoV9pGsu2EgAOLa0aeT2cuT6Z4KQ0+qdNrwWqIjJcPO
         Vuz25HixNAOCmjEbGMM59uVj6Z90NkoBq+NirawIxe3OgsApLXPvn87s8ckAQACgFyNH
         sKF98MRO5ZrwVffiP4Yo0Q1bmZvumVoDQDTvf5WTklnhdDcEQgO4p5DT6TNFKak5tH4r
         gcduOz/unGovAiSTOdXbX5Cq0t+KBCSeLSukbTqi499E+x1SVOAUN/bYaU8/0fDNrtc/
         USOtvTVaK+mRl9MBRpf5EJiloexsJHpqLik/fvgvRPuSLB0PeL6cBW+jcxFMTaWnEjij
         c//Q==
X-Gm-Message-State: AOAM531a+iMI9CgEwy5bb1qx/osBBFiWOFTGOfDorDQWhakvl41BIEGe
        KiyRxb1ANn4Fii6U1t0g4oUx3197SQqoA2UbEGw=
X-Google-Smtp-Source: ABdhPJzDJCBSGVM/bmQdQaawOF9g0UiBVk4P+2ed3FtuSBRNMa6/pG9LzF4BxSor2OayZfavNivy/MPni9DJj9/ODQg=
X-Received: by 2002:a05:6e02:4c5:b0:2d1:c12b:b4bc with SMTP id
 f5-20020a056e0204c500b002d1c12bb4bcmr1156168ils.252.1653366969206; Mon, 23
 May 2022 21:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein> <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
 <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
 <d6f632bc-c321-488d-f50e-749d641786d6@fb.com> <20220518112229.s5nalbyd523nxxru@wittgenstein>
 <CAJfpegtNKbOzu0F=-k_ovxrAOYsOBk91e3v6GPgpfYYjsAM5xw@mail.gmail.com>
 <CAEf4BzaNjPMgBWuRH_me=+Gp6_nmuwyY7L-wiGFs6G=5A=fQ4g@mail.gmail.com> <20220519085919.yqj2hvlzg7gpzby3@wittgenstein>
In-Reply-To: <20220519085919.yqj2hvlzg7gpzby3@wittgenstein>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 May 2022 21:35:58 -0700
Message-ID: <CAEf4BzY5en_O9NtKUB=1uHkGdHLSo_FqddUkokh7pcEWAQ2omw@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, clm@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Thu, May 19, 2022 at 1:59 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, May 18, 2022 at 09:56:26PM -0700, Andrii Nakryiko wrote:
> > On Wed, May 18, 2022 at 4:26 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Wed, 18 May 2022 at 13:22, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Tue, May 17, 2022 at 12:50:32PM -0400, Dave Marchevsky wrote:
> > >
> > > > > Sorry to ressurect this old thread. My proposed alternate approach of "special
> > > > > ioctl to grant exception to descendant userns check" proved unnecessarily
> > > > > complex: ioctls also go through fuse_allow_current_process check, so a special
> > > > > carve-out would be necessary for in both ioctl and fuse_permission check in
> > > > > order to make it possible for non-descendant-userns user to opt in to exception.
> > > > >
> > > > > How about a version of this patch with CAP_DAC_READ_SEARCH check? This way
> > > > > there's more of a clear opt-in vs CAP_SYS_ADMIN.
> > > >
> > > > I still think this isn't needed given that especially for the use-cases
> > > > listed here you have a workable userspace solution to this problem.
> >
> > Unfortunately such userspace solution isn't that great in practice.
> > It's both very cumbersome to implement and integrate into existing
> > profiling solutions and causes undesired inefficiencies when
> > processing (typically for stack trace symbolization) lots of profiled
> > processes.
> >
> > > >
> > > > If the CAP_SYS_ADMIN/CAP_DAC_READ_SEARCH check were really just about
> > > > giving a privileged task access then it'd be fine imho. But given that
> > > > this means the privileged task is open to a DoS attack it seems we're
> > > > building a trap into the fuse code.
> >
> > Running under root presumably means that the application knows what
> > it's doing (and it can do a lot of dangerous and harmful things
> > outside of FUSE already), so why should there be any more opt in for
> > it to access file contents? CAP_SYS_ADMIN can do pretty much anything
> > in the system, it seems a bit asymmetric to have extra FUSE-specific
> > restrictions for it.
>
> Processes trying to access a fuse filesystem that is not in the same
> userns or a descendant userns are open to DoS attacks. This specifically
> includes processes capable in the initial userns.

Sure, but by DoS attack here you mean that a capable (I'll just say
"root" for simplicity) process might get stuck. While not great, it's
not as horrible as crashing the kernel or something along those lines.
So let's keep this perspective in mind, because here we are talking
about disabling very useful functionality (it's not a hypothetical
problem, it's a real production problem that users are struggling with
right now) while trying to prevent root process (which has to be
careful anyways as it's a root process after all) from shooting itself
in the foot.

>
> If it suddenly becomes possible that an initial userns capable process
> can access fuse filesystems in any userns than any such process
> accessing a fuse filesystem unintentionally will be susceptible to DoS
> attacks.
>
> Iow, the problem isn't that an initial userns capable process is doing
> something harmful and we're overly careful trying to prevent this and
> thereby going against standard CAP_SYS_ADMIN assumptions; it's that an
> initial userns capable process can unintentionally have something
> harmful done to it simply by accessing a fuse filesystem.
>
> This is even more concerning since rn this isn't possible so this patch
> is removing a protection/security mechanism. The performance argument
> isn't enough to justify this imho.

Performance is a big deal in the fleet of many thousands of servers,
so let's not just dismiss this argument so easily. Also, in a lot of
cases (production systems, properly audited, monitored, secured, etc)
the workloads can be trusted, so the DoS attack by an unprivileged
process is not a huge concern. On the other hand, though, inability to
read FUSE-backed files by root process is a huge blocker for stack
symbolization, as one specific use case. And spinning threads for
hundreds of target processes is not a viable solution in production,
unfortunately.

But given for some situations it might be better to be safe than
sorry, can we let users building kernels decide on this? How about
adding Kconfig value that would allow such access for CAP_SYS_ADMIN
(or whichever capability makes most sense). E.g.,
CONFIG_FUSE_ALLOW_OTHER_PERMISSIVE would allow reads, but otherwise
reject them? Would something like this be a good compromise here?

I still think that tools like perf being able to provide good tracing
data is going to hurt due to this cautious rejection of access, but
with Kconfig we at least give an option for users to opt out of it.
WDYT?
