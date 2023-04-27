Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241876F002A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 06:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbjD0EZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 00:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbjD0EY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 00:24:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CAF30E0;
        Wed, 26 Apr 2023 21:24:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so13823569a12.3;
        Wed, 26 Apr 2023 21:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682569489; x=1685161489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9BPTABkCQ4wyIp6Wf2934lahb8sP4xbJb6UHZ9xVyw=;
        b=KHlh84VSsn4sm4nugwRFHAFauJyxzdBLWxqsCzWNBEmI9BY4yIKs4uOO9iO6Fsw6nD
         Knqhtuupm2OTXBhWjOAnrZnOVQAneDhXu1rAg9hViP5c1zQwQdmkjBCiTyPxx53YSsQE
         OG76ZPvfHdLkfzVj3vqMnhDFZYXovmkg6E95p2QGJHtxXzuit+OUCWqKZS2quzuKtxvM
         UznIIshU+4AT/2NUgjpbOzMWqDeZH9W8xQ8rUUsUwjd/2x/1GlHXPEcyF28gVUFxUYak
         Fp+JY6xesvcEHd2+lDZtToWvv5c4v3+lvlwRAGY99s+0HVlntZaFw+2FktD/Vgbdj5oQ
         wp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682569489; x=1685161489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9BPTABkCQ4wyIp6Wf2934lahb8sP4xbJb6UHZ9xVyw=;
        b=ObhC70V1A5C4bofjyhOseHdRFvY1bWXB1uoGTDiLx4ig3ebQnG3k80kNA9kYTiCGm+
         yxNDImALVTTR/V9EXw28UH2GgamSKBFChXDlsL115gw7ewxfhtW8wAd/Ol2cpcWP9PFo
         BsPp23qDYxYNRN52JdbpKJ2OOglMKkdVb8gvsFQ+GFPtcy/3hZ3RXn8SjAV/vnB2az5D
         5hkUsiXOHoWh0m5dDAbbs+WjGfHGyX8fTueuA1sXkQEOE5vqJhWoGrnFCU9R71jxSE1B
         PgKkRkXMyf3xJcjeiYvCWEblX0geNmDJlpBur+ibCSl2M7TOx+FlhT3EJDbGGC5AEBmB
         XB9g==
X-Gm-Message-State: AC+VfDw31a7siT7u/DOJna1qFBGld3bRucc5mOfoO9Hejpzle6Z1LEW1
        vv7XMRnPwsAJjBhnQYL11eYLZ7qC83nqFryurFo=
X-Google-Smtp-Source: ACHHUZ5fqfAwKjuAWSkAihFFHvEwlRfsA02iW3+avOLbRVhBPDOZ7ASIChRyDulgSARBNY1hKrj3N2Ty5GA1cdPmSDw=
X-Received: by 2002:aa7:d603:0:b0:506:bc29:2ce7 with SMTP id
 c3-20020aa7d603000000b00506bc292ce7mr444319edr.29.1682569489175; Wed, 26 Apr
 2023 21:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <20230418014037.2412394-36-drosen@google.com>
In-Reply-To: <20230418014037.2412394-36-drosen@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 21:24:37 -0700
Message-ID: <CAEf4BzYD9P+1aP+q77i7RJPJW=iSS6-iTw+rfPuCz=FFB2MiZw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 35/37] tools: Add FUSE, update bpf includes
To:     Daniel Rosenberg <drosen@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 6:42=E2=80=AFPM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> Updates the bpf includes under tools, and adds fuse
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  tools/include/uapi/linux/bpf.h  |   12 +
>  tools/include/uapi/linux/fuse.h | 1135 +++++++++++++++++++++++++++++++
>  2 files changed, 1147 insertions(+)
>  create mode 100644 tools/include/uapi/linux/fuse.h
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 4b20a7269bee..6521c40875c7 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7155,4 +7155,16 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +/* Return Codes for Fuse BPF struct_op programs */
> +#define BPF_FUSE_CONTINUE              0
> +#define BPF_FUSE_USER                  1
> +#define BPF_FUSE_USER_PREFILTER                2
> +#define BPF_FUSE_POSTFILTER            3
> +#define BPF_FUSE_USER_POSTFILTER       4

nit: can this be an enum instead? It would be more self-documenting,
IMO. At given it's FUSE BPF-specific, why is it not in
uapi/linux/fuse.h?

> +
> +/* Op Code Filter values for BPF Programs */
> +#define FUSE_OPCODE_FILTER     0x0ffff
> +#define FUSE_PREFILTER         0x10000
> +#define FUSE_POSTFILTER                0x20000
> +

[...]
