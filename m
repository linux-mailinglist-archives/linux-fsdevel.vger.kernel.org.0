Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001706F0FC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 02:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjD1As0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjD1AsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:48:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A9213A
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 17:48:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24b29812c42so6606213a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 17:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642903; x=1685234903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYJ9Gq0jRLdthT3KT6+pUq4WeVXKnPD2vRhwxoOwfLM=;
        b=VAXP1WEMBqFyWeIoabfqwWglRbZ4HdOWER+eOB5RWEer/jpI0svg/f4iWi3c8Cg+Pt
         by2DSZbfQZ5DKECFJtxEVAvZP00YYuj8SzpYP5frO7HeB/evzIiSXJiYt3uP1AgW6Z/o
         t4C/VnCsfpRqyoXAvRlPeT9bKt0XI3Ilupw3Lpt0+ypUfNvaXw70RtwacEi3QW5bC93A
         LD8UutIlcg+pO1Nr1Edae+tN1Cff+2S7B+/D+zIIHdM0zzUfcdgfJeIwzJVmI36PVyU/
         HkzP2LpUvgBQhHOexE8LxayxI4ASWaOUCXe+UEfkHJxLKREaLYRvtUXxfqKXe00TIYH9
         TjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642903; x=1685234903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYJ9Gq0jRLdthT3KT6+pUq4WeVXKnPD2vRhwxoOwfLM=;
        b=iKIlLvDckXTdEk/dlEWORJEYUOy1KAySD4yxw/jdKdFNNLmrtU586NatoeqyfBF4cX
         1TvTARkoMxVKg5R+PC3OruLJPgXvAjkPR/8tv6bu5F5Z3mSvQtE+cYuWYDlvUrP3tPGx
         Ha65pgky1dAy6r+C6/VfSy6J3BEafkj9YIBdT6SQulgXrjpyVGm7cerGnpMv7+gLWwxU
         5dSpK0Db/4yz8zink2BlbkP1TFYQ//wnoDymWqMT3bkTDCM2XIeMuQDqEbqpAssp/jJf
         ast1JSHOwhMy4KVkhercIGyjvr4C3ih5byIc9v/rUf7G9tny6oRNSCB2lgKuxw7XBh69
         v+fA==
X-Gm-Message-State: AC+VfDz4WgifYFPP90q4YFHT/EYauGLDYOV1k5Vpv/mOxfoDoaiA8CDL
        wfoq8vV3HnEI4a6Dq/Mb1elDKOmA10RzCgHRco5eCQ==
X-Google-Smtp-Source: ACHHUZ5+QBvCC7Me3S+WJPhYrRFCfX62qwqHhmjQ8Bf88BjxgWf2Db/JCe7VvvvRDD68Vv7dGvnWJGtUagXHQXv5kDQ=
X-Received: by 2002:a17:90a:fc82:b0:247:25d6:b849 with SMTP id
 ci2-20020a17090afc8200b0024725d6b849mr3639718pjb.8.1682642903149; Thu, 27 Apr
 2023 17:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <20230418014037.2412394-36-drosen@google.com>
 <CAEf4BzYD9P+1aP+q77i7RJPJW=iSS6-iTw+rfPuCz=FFB2MiZw@mail.gmail.com>
In-Reply-To: <CAEf4BzYD9P+1aP+q77i7RJPJW=iSS6-iTw+rfPuCz=FFB2MiZw@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 27 Apr 2023 17:48:11 -0700
Message-ID: <CA+PiJmQ6_P7WcgKHaFrpb8hyWA549+JMB0Wa25-m0G2FLfw+gQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 35/37] tools: Add FUSE, update bpf includes
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com
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

On Wed, Apr 26, 2023 at 9:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 17, 2023 at 6:42=E2=80=AFPM Daniel Rosenberg <drosen@google.c=
om> wrote:
> >
> > +/* Return Codes for Fuse BPF struct_op programs */
> > +#define BPF_FUSE_CONTINUE              0
> > +#define BPF_FUSE_USER                  1
> > +#define BPF_FUSE_USER_PREFILTER                2
> > +#define BPF_FUSE_POSTFILTER            3
> > +#define BPF_FUSE_USER_POSTFILTER       4
>
> nit: can this be an enum instead? It would be more self-documenting,
> IMO. At given it's FUSE BPF-specific, why is it not in
> uapi/linux/fuse.h?
>

An enum would be nicer. And I'm sure there are plenty of things that
are probably in the wrong place right now. I'll be moving most of the
changes in bpf specific areas over to fuse specific areas when
struct_ops can handle modules. This particular one can move now
though.
