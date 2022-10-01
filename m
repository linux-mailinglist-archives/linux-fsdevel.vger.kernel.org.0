Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E855F1AAA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJAHrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 03:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJAHrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:47:24 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84FC15C5B1;
        Sat,  1 Oct 2022 00:47:23 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id b81so3323538vkf.1;
        Sat, 01 Oct 2022 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=H3TOWeVgVyWiMYemhr0oaEGTrrOobuW0CwAgeK0coAk=;
        b=IjyOPoh7oeUxStr7xXBo7jmczZvW75tFnLUQ4979Cs5OOiZfvEHAYy1Zg0dT4hi2jj
         FY3wGCXHhmvefm0JQFhOi8I6Grp4d9yEP1JeTVG1H6LkFUX2LNHQ4hlPWqmaVFRovk+k
         Z65tleQ4bu+dnziW3gGCM/rcmPBTByDr8ZH6x9wNlsLu+YHp7S5XiXINy9znqSi3JXxa
         vk9VOOzTmYImT5SHDCWJmcVltSj4K5rXArcqRrbmZoCyqeIMMD0XRG95lGEW1nnEplC6
         02FR9EKb73o/GBsnTFZXpagUXsdXuATf2SZG1tBgkmC7I3wzUpjWhTzxIDZztsWukBqM
         D/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=H3TOWeVgVyWiMYemhr0oaEGTrrOobuW0CwAgeK0coAk=;
        b=KBzjFvhdjXSwB8+iwLVIHiROc5Xk8lljB6Mt04IGV7xa/iSxyURsrgG9N3kJexDqlt
         +WPZHROta6JTf7IXOmIxUjdoYVzvMFsjRchmpIl3Ps+dO/psvd6KWIT+lgF4lCf68PaG
         Hcle6v9z8+x7/hmXoXynphk9SF7go7F3hXb540Ov3tozyy2IwuHDioGuoKzhdbeU0H4P
         F0sM7WNA2dnHrzYYD1GPbXEvdEgBnucm8Y8yHuIgnaX/EJwOSsifxxkU7QknwqHzALEX
         3DbWl8MKLCpPSlLcMadcJc9DTmKPVI53sYEDiYY/+IDlKfu1LpukeF2zYdbFViOzXMSW
         Gpew==
X-Gm-Message-State: ACrzQf3955JWqCs2lxAWJdzeIYiW6ZOpuq09TSvnaTuq5SxGYdr7ctpm
        xJt9YUVHbf+qhN1xkbRJzXU2REnrxpAQcnACYB0=
X-Google-Smtp-Source: AMsMyM4h9CVZvuyr8vMxovX1lCgKWqqW6uXN7HnJX01Y4UcfSyI12rAxqAFd7C1RrWct3cqCtJcL5xI6gihhXpNaNfA=
X-Received: by 2002:a1f:9e44:0:b0:39e:e4ff:1622 with SMTP id
 h65-20020a1f9e44000000b0039ee4ff1622mr5883013vke.15.1664610442718; Sat, 01
 Oct 2022 00:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com> <20220926231822.994383-4-drosen@google.com>
 <CAJfpegsC6=HhYALdU_4vSEmxPCxNNPS4NkcDyU6E1y7N_rqhJw@mail.gmail.com> <CAL=UVf4iWQvwawYpPWeTn1eWy-1s1wrGQORLxKH9wmw=vCfVVg@mail.gmail.com>
In-Reply-To: <CAL=UVf4iWQvwawYpPWeTn1eWy-1s1wrGQORLxKH9wmw=vCfVVg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Oct 2022 10:47:11 +0300
Message-ID: <CAOQ4uxhsxOSmRY-s2vdoCRziGT9UhxSvPR0B=x9NXEfhNGM=+w@mail.gmail.com>
Subject: Re: [PATCH 03/26] fuse-bpf: Update uapi for fuse-bpf
To:     Paul Lawrence <paullawrence@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Rosenberg <drosen@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 1, 2022 at 1:03 AM Paul Lawrence <paullawrence@google.com> wrote:
>
> On Tue, Sep 27, 2022 at 11:19 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 27 Sept 2022 at 01:18, Daniel Rosenberg <drosen@google.com> wrote:
> >
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index d6ccee961891..8c80c146e69b 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -572,6 +572,17 @@ struct fuse_entry_out {
> > >         struct fuse_attr attr;
> > >  };
> > >
> > > +#define FUSE_ACTION_KEEP       0
> > > +#define FUSE_ACTION_REMOVE     1
> > > +#define FUSE_ACTION_REPLACE    2
> > > +
> > > +struct fuse_entry_bpf_out {
> > > +       uint64_t        backing_action;
> > > +       uint64_t        backing_fd;
> >
> > This is a security issue.   See this post from Jann:
> >
> > https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com/
> >
> > The fuse-passthrough series solved this by pre-registering the
> > passthrogh fd with an ioctl. Since this requires an expicit syscall on
> > the server side the attack is thwarted.
> >
> > It would be nice if this mechanism was agreed between these projects.
> >
> > BTW, does fuse-bpf provide a superset of fuse-passthrough?  I mean
> > could fuse-bpf work with a NULL bpf program as a simple passthrough?
> >
> > Thanks,
> > Miklos
>
> To deal with the easy part. Yes, fuse-bpf can take a null bpf program, and
> if you install that on files, it should behave exactly like bpf passthrough.
>
> Our intent is that all accesses to the backing files go through the normal
> vfs layer checks, so even once a backing file is installed, it can only be
> accessed if the client already has sufficient rights. However, the same
> statement seems to be true for the fuse passthrough code so I assume
> that is not sufficient. I would be interested in further understanding the
> remaining security issue (or is it defense in depth?) We understand that
> the solution in fuse passthrough was to change the response to a fuse open
> to be an ioctl? This would seem straightforward in fuse-bpf as well if it is
> needed, though of course it would be in the lookup.

Not only in lookup.
In lookup userspace can install an O_PATH fd for backing_path,
but userspace will also need to install readable/writeable fds
as backing_file to be used by open to match the open mode.

When talking about the server-less passthrough mode, some
security model like overlayfs mounter creds model will need to be
employed, although in the private case of one-to-one passthrough
I guess using the caller creds should be good enough, as long as
the security model is spelled out and implementation is audited.

Thanks,
Amir.
