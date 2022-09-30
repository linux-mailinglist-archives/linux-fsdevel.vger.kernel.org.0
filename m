Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7BC5F15A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 00:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiI3WDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 18:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiI3WDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:03:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1EA1D848A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 15:03:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k10so8830398lfm.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZD1e4IouC6xZV6twBLoGyLjDlY5MH17+pLThrTs5hxU=;
        b=IgGTuht6qmzj639nys69iXH147cFr27l/78a3+1JmDw3c59xTh2lOnKQFy58Q6+f4w
         CTSMpoa7FQQgRAcG2eaxDNPsPswPKfABDBU+d372PKJNXSLu0Hdlwwh/p3vIKeAHrrIR
         SXSdubWOS9A4sFtkj/9GuJe2K9kRelc/OoCcpAfUVDhu/JzIj7kYhD9jWTgx9S/OSBuK
         NwEMfQh/hjF6etaWUmUxxm2iWCp72o4TH7ePVyB7yrRZcfRywkXTUgiNpoi977mkqDh0
         SLvdubD089wadlLLpPPPDnOszN7SOwdXCJok9EO04kDkfFVErY8JHiyl/Es6rvFIRBYN
         etqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZD1e4IouC6xZV6twBLoGyLjDlY5MH17+pLThrTs5hxU=;
        b=ynJdQRwsNkRhsutb4EPuaSTDkTUympVL9j+nKg1EX/2c6lOkXc3S5Vq5p0I8O43OXU
         P4aTiY3AklnjKrWla6bJzSGFkWeStyDisJJXGYixrZMBbINh3QCUDbJByfb72qBxp8s7
         XY83tghu7dtD+kyDZmuFWeei3vNm5Oib4QkDetSdfF2tt9AnU/Eg/8YqX3/UYXzdlhQD
         EyYwlUxGNe8x4zpd3LKHShfOe3kOcnffGpD7m/gPfOHt4PGWxVIUmqAlWilPH7Me2ked
         ThWN5eCceARqGq0dH7GlbfCa3cPxJU5ty5WmZR7/dlCXXsCwttPAMJVWgioagEB2JS22
         GMhw==
X-Gm-Message-State: ACrzQf3+BLl5t6bXM4A5SYBN2UaMS2M85m+Qn0ClzMdwdVuOP1sHsP1G
        wIR5dsg2Bn2u6XkMQBikNfNj4O6KyB2naMzAKyLWYA==
X-Google-Smtp-Source: AMsMyM4saQttnwidDpD0nNfQCogl8JLm3ehIWmYpjAES4JO+d2uaD7H3nUWC34+cuSfRm6gvsBwMTMoFA9eO3GsbOWE=
X-Received: by 2002:a05:6512:12c7:b0:49b:755d:fde5 with SMTP id
 p7-20020a05651212c700b0049b755dfde5mr3676412lfg.182.1664575389925; Fri, 30
 Sep 2022 15:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com> <20220926231822.994383-4-drosen@google.com>
 <CAJfpegsC6=HhYALdU_4vSEmxPCxNNPS4NkcDyU6E1y7N_rqhJw@mail.gmail.com>
In-Reply-To: <CAJfpegsC6=HhYALdU_4vSEmxPCxNNPS4NkcDyU6E1y7N_rqhJw@mail.gmail.com>
From:   Paul Lawrence <paullawrence@google.com>
Date:   Fri, 30 Sep 2022 15:02:58 -0700
Message-ID: <CAL=UVf4iWQvwawYpPWeTn1eWy-1s1wrGQORLxKH9wmw=vCfVVg@mail.gmail.com>
Subject: Re: [PATCH 03/26] fuse-bpf: Update uapi for fuse-bpf
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
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
        kernel-team@android.com, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:19 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 27 Sept 2022 at 01:18, Daniel Rosenberg <drosen@google.com> wrote:
>
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index d6ccee961891..8c80c146e69b 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -572,6 +572,17 @@ struct fuse_entry_out {
> >         struct fuse_attr attr;
> >  };
> >
> > +#define FUSE_ACTION_KEEP       0
> > +#define FUSE_ACTION_REMOVE     1
> > +#define FUSE_ACTION_REPLACE    2
> > +
> > +struct fuse_entry_bpf_out {
> > +       uint64_t        backing_action;
> > +       uint64_t        backing_fd;
>
> This is a security issue.   See this post from Jann:
>
> https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com/
>
> The fuse-passthrough series solved this by pre-registering the
> passthrogh fd with an ioctl. Since this requires an expicit syscall on
> the server side the attack is thwarted.
>
> It would be nice if this mechanism was agreed between these projects.
>
> BTW, does fuse-bpf provide a superset of fuse-passthrough?  I mean
> could fuse-bpf work with a NULL bpf program as a simple passthrough?
>
> Thanks,
> Miklos

To deal with the easy part. Yes, fuse-bpf can take a null bpf program, and
if you install that on files, it should behave exactly like bpf passthrough.

Our intent is that all accesses to the backing files go through the normal
vfs layer checks, so even once a backing file is installed, it can only be
accessed if the client already has sufficient rights. However, the same
statement seems to be true for the fuse passthrough code so I assume
that is not sufficient. I would be interested in further understanding the
remaining security issue (or is it defense in depth?) We understand that
the solution in fuse passthrough was to change the response to a fuse open
to be an ioctl? This would seem straightforward in fuse-bpf as well if it is
needed, though of course it would be in the lookup.

Thank you for reminding us of this,

Paul
