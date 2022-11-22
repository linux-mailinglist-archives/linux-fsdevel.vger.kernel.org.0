Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A7633AFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 12:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKVLPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 06:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiKVLP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:15:27 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109425BD41;
        Tue, 22 Nov 2022 03:13:47 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id t14so14085767vsr.9;
        Tue, 22 Nov 2022 03:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ctwvpJ4WmLw8p9CFeleB7Pgd59LFpS1OykmA2+lU2U=;
        b=b6gPC3FpAAoIsTrR/GjtWKbzKFsmS3SYe7WsW32gCahQi1HxOvCju2+tL83BVRwwG0
         0nEFRgiiYSbd8tu4OiovxpIUT2VydWFiloCnps2GHxHiskGDzTcqJ+C7e6pjssUU4+4I
         45MlrD7dxprQUpOvpPH4w1obxKoJqsPIkxjHe85bMFuekTi5c6jJ3+wQ2I/mH9I7k+iZ
         5NV6LNcHggfuQcqEz/4CZM4pkh0EjvrysF98WHT5V56TOLx9EIiujHaDkR8TSZw4aQUX
         QItzPMSSeejDkdIiKGFq6CnnbXwBaSmUDuvzj3ktAPddAkBZJotJHooi4VwA6GXdBMdf
         WAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ctwvpJ4WmLw8p9CFeleB7Pgd59LFpS1OykmA2+lU2U=;
        b=I51GSTN5BZ2Ee6/kxYlTjwZQyegZPSHmFbbpJ5tv9CtamoVqaBPJ4n/ImIKURr0pgT
         8Ar2xoQ5KcPNEO1s1e3GQEXBvbdnDwvYyzWyK8mmR910EVt57tXsH+QRYg+EnRxNn6B6
         6XCt3/i52e8DUs4SwXZuT8LwSwxRZbSk7eY8zdszpEijEdE5knEPKvV0KvdT2/ajAcdq
         rN3L5x/SMrDnj344/56xJLNPkwvGkGz+qnMr/p77O7zEFD8/ou8wEk/pqA+u6PWWVHNC
         OlcxcPLm4BW5tZe1qKjWTcvqPZam8/1xjgfNJ7p/+Tm1zV37BqrNjSrvTnuRtuD0vQqR
         mtig==
X-Gm-Message-State: ANoB5pn1x/TUzNvlPi6akHNU8XdqQMbLHGydsNvMMF2TV/UczvA2z6q9
        arWjMy142bwG2em/ThBwI0bDJb2MDZ1UTDHsSWF1gpEhmCk=
X-Google-Smtp-Source: AA0mqf74RvZ9FOqf4Ak0ELFEqSpBYvkzZ3F8GxTEFa5nqLuTAn7Lk0xRxiTrgc/F38UyOU7gm4M4xAVNRxC0H2jJvW8=
X-Received: by 2002:a05:6102:3bc1:b0:3a7:9b8c:2e4c with SMTP id
 a1-20020a0561023bc100b003a79b8c2e4cmr1731318vsv.72.1669115626788; Tue, 22 Nov
 2022 03:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Nov 2022 13:13:35 +0200
Message-ID: <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com
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

On Tue, Nov 22, 2022 at 4:15 AM Daniel Rosenberg <drosen@google.com> wrote:
>
> These patches extend FUSE to be able to act as a stacked filesystem. This
> allows pure passthrough, where the fuse file system simply reflects the lower
> filesystem, and also allows optional pre and post filtering in BPF and/or the
> userspace daemon as needed. This can dramatically reduce or even eliminate
> transitions to and from userspace.
>
> For this patch set, I have removed the code related to the bpf side of things
> since that is undergoing some large reworks to get it in line with the more
> recent BPF developements. This set of patches implements direct passthrough to
> the lower filesystem with no alteration. Looking at the v1 code should give a
> pretty good idea of what the general shape of the bpf calls will look like.
> Without the bpf side, it's like a less efficient bind mount. Not very useful
> on its own, but still useful to get eyes on it since the backing calls will be
> larglely the same when bpf is in the mix.
>
> This changes the format of adding a backing file/bpf slightly from v1. It's now
> a bit more modular. You add a block of data at the end of a lookup response to
> give the bpf fd and backing id, but there is now a type header to both blocks,
> and a reserved value for future additions. In the future, we may allow for
> multiple bpfs or backing files, and this will allow us to extend it without any
> UAPI breaking changes. Multiple BPFs would be useful for combining fuse-bpf
> implementations without needing to manually combine bpf fragments. Multiple
> backing files would allow implementing things like a limited overlayfs.
> In this patch set, this is only a single block, with only backing supported,
> although I've left the definitions reflecting the BPF case as well.
> For bpf, the plan is to have two blocks, with the bpf one coming first.
> Any further extensions are currently just speculative.
>
> You can run this without needing to set up a userspace daemon by adding these
> mount options: root_dir=[fd],no_daemon where fd is an open file descriptor
> pointing to the folder you'd like to use as the root directory. The fd can be
> immediately closed after mounting. This is useful for running various fs tests.
>

Which tests did you run?

My recommendation (if you haven't done that already):
Add a variant to libfuse test_passthrough (test_examples.py):
@pytest.mark.parametrize("name", ('passthrough', 'passthrough_plus',
                           'passthrough_fh', 'passthrough_ll',
'passthrough_bpf'))

and compose the no_daemon cmdline for the 'passthrough_bpf' mount.

This gives pretty good basic test coverage for FUSE passthrough operations.

I've extended test_passthrough_hp() for my libfuse_passthrough patches [1],
but it's the same principle.

Thanks,
Amir.

[1] https://github.com/amir73il/libfuse/commits/fuse_passthrough
* 'passthrough_module' uses 'libfuse_passthrough' which enables
   Allesio's FUSE_DEV_IOC_PASSTHROUGH_OPEN by default.
