Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F36BDB5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCPWJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 18:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCPWIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:08:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69F07D0AA;
        Thu, 16 Mar 2023 15:08:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so13413029edd.5;
        Thu, 16 Mar 2023 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679004490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5LXKdwZVY7/inb8t48z8B3i1/iePyL38mhRLs5gLt0=;
        b=GSjZ3vaZj1K52logUvrDKxtFiPhB1GEUlUjRp/AME8Y1y2UtAvKXxHeraMD0oJxOPh
         D6q3c0K8eDDvtAh5s/m3WiTp+vhiVBJIU9PsKOWYA7ij97nKdYo2KudTKsa33qJkNGJe
         UzE2P20eGnJWitZZ48biMmvbe/rAZpUaQ2o/WWM5pi9jsC2eXO6g8YSaydPqqVDsJ5yX
         FXOQ0A2lKnxObgWFdO0rCHoWaNZR+QB3IWwv5u7AtBPT6FoMO3XeMf54zQXJk2CWtbax
         kGljhQrSX9RyFsyBGjh3sgCOJH7sHE5uwOdHE/QhXd/CtGMX6H98gAv468ncgr1fOxWH
         RXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679004490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5LXKdwZVY7/inb8t48z8B3i1/iePyL38mhRLs5gLt0=;
        b=mSDQW5NedeObCQVlTz9YFo9+E0lxONWnQjiMKD6NRH56yUSa6aLag1rDgmEW70J+Hi
         fYOx52RYtFo2PKOO8qaIUnLtzcM8MPz7hPnLC7ynS5JE9Le35qmwUJBbAo6zFjvgcce9
         qSOp/dvEAUPWyahVzyJjr3afnTRHrtsvQJyT2PinQCeADBaSe9zg90qPyDZAoKvD0UtT
         na3fnr6ZtZw0jIKJt2Ad7OXd8R310SpDqoajhDPN+tGz7jfOgHSlZqDGyX9KdDmhJTse
         Ycipcd5GfcrjV1RVoCzmyl+QJsWUYMCSj2N/OdYJXR3ZTeiqAsF8RX8c96u+2qRCd87e
         aIHA==
X-Gm-Message-State: AO0yUKXjsbDWXTIleE0ogX2UNiFMBJu4WJYniskXlLBohaakO9kQ4kOD
        zddaKA4x6AZ4tM9CwGZxjA4PefGBjdHd+8ilYAY=
X-Google-Smtp-Source: AK7set9ZtdbNPR2S12M9r+Ax3xhP8SEtTYQ6ithNo98VzEavregZQO16Z3YIpuoGmugpfmI1r3EeQTe3xFd1jdK4JlE=
X-Received: by 2002:a17:907:7094:b0:931:c1a:b526 with SMTP id
 yj20-20020a170907709400b009310c1ab526mr1126145ejb.5.1679004490483; Thu, 16
 Mar 2023 15:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <20230316170149.4106586-5-jolsa@kernel.org>
In-Reply-To: <20230316170149.4106586-5-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 15:07:58 -0700
Message-ID: <CAEf4Bza29CQzBusZ-x5QoJNjezBMx0FHdcj4p=Q+LM_qCtF=fg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 4/9] bpf: Switch BUILD_ID_SIZE_MAX to enum
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:02=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Switching BUILD_ID_SIZE_MAX to enum, so we expose it to BPF
> programs through vmlinux.h.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/buildid.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index b8b2e00420d6..316971c634fe 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -5,7 +5,9 @@
>  #include <linux/mm_types.h>
>  #include <linux/slab.h>
>
> -#define BUILD_ID_SIZE_MAX 20
> +enum {
> +       BUILD_ID_SIZE_MAX =3D 20
> +};
>
>  struct build_id {
>         u32 sz;
> --
> 2.39.2
>
