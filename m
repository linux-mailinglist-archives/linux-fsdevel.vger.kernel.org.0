Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA947A5BD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjISICl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjISICi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:02:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E1711F
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:02:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bffc55af02so34814461fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695110549; x=1695715349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nWwOBXcgP9QHb+ZwLC4z/fad6HDujTXM9X3AXgFefao=;
        b=F3pgzF80ybykApF9N2exJ0huxmKEj/JwYyG9wZoIC+wUdSJA/bRF6YpfJc/mg/szkA
         OsImu0uqYiBUmx53o4mPonCr5nLtlyInVMv7EjTlXZBV/OW+jgLtaIHKQWItQCF9ulRs
         M+qXKlMomeIukmh0UgualD1oUS+FSCc1iTE1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110549; x=1695715349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWwOBXcgP9QHb+ZwLC4z/fad6HDujTXM9X3AXgFefao=;
        b=Kz0zftV6GeWBCzG3D10klh3h0a1wPU/VMGSEcyMTCVUAcSR7ERlV+39uL6JY7o9hjx
         ZeNGUnLKl35EbaoeEK8izdhvAVRTdGmYUW26Evxg/HAvZtwXgaVHyKBiATHlUkIid/U5
         2/UkreJnpq+1BZQ6gv8Fr92blri1xawZhlZWzd68jVL8ux3Bi0Lfxt2LaEKtXMKa0Hnx
         SbHOohqLfM1LVpga2t94IVyuNFWZnkUAOWpdmabwcZNol1xReqLOWbhOCXKVpkCLSLhS
         J8UPhdwbewqu7Y1Jrzztv5dUdH2zBJ6SsGT9xFn4PP8rmpVWu22sPQPNmRp7phOo6Gw9
         mZyg==
X-Gm-Message-State: AOJu0YynBKTMdTA03YUAgNUf2izMkcZE09wUJqwWRRGzCTWkBcmiqo8U
        iq+cRL/lPHcLkdInevtLWNw6wm6aiI8hxOgXYV+2cg==
X-Google-Smtp-Source: AGHT+IF39NIDgeU/oOTNvV5zRchTf9jdNdxeIj1xURpUADWsrOYnhsqNCpFqVeqIom7TB0F8lXRC41YrHzXHEQ7vZTE=
X-Received: by 2002:a2e:9f0a:0:b0:2bc:be3c:9080 with SMTP id
 u10-20020a2e9f0a000000b002bcbe3c9080mr9595518ljk.27.1695110548691; Tue, 19
 Sep 2023 01:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230919003800.93141-1-mattlloydhouse@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 19 Sep 2023 10:02:17 +0200
Message-ID: <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Sept 2023 at 02:38, Matthew House <mattlloydhouse@gmail.com> wrote:

> One natural solution is to set either of the two lengths to the expected
> size if the provided buffer are too small. That way, the caller learns both
> which of the buffers is too small, and how large they need to be. Replacing
> a provided size with an expected size in this way already has precedent in
> existing syscalls:

This is where the thread started.  Knowing the size of the buffer is
no good, since the needed buffer could change between calls.

We are trying to create a simple interface, no?  My proposal would
need a helper like this:

struct statmnt *statmount(uint64_t mnt_id, uint64_t mask, unsigned int flags)
{
        size_t bufsize = 1 << 15;
        void *buf;
        int ret;

        for (;;) {
                buf = malloc(bufsize <<= 1);
                if (!buf)
                        return NULL;
                ret = syscall(__NR_statmnt, mnt_id, mask, buf, bufsize, flags);
                if (!ret)
                        return buf;
                free(buf);
                if (errno != EOVERFLOW)
                        return NULL;
        }
}

Christian's would be (ignoring .fs_type for now):

int statmount(uint64_t mnt_id, uint64_t mask, struct statmnt *st,
unsigned int flags)
{
        int ret;

        st->mnt_root_size = 1 << 15;
        st->mountpoint_size = 1 << 15;
        for (;;) {
                st->mnt_root = malloc(st->mnt_root_size <<= 1);
                st->mountpoint = malloc(st->mountpoint <<= 1);
                if (!st->mnt_root || !st->mountpoint) {
                        free(st->mnt_root);
                        free(st->mountpoint);
                        return -1;
                }
                ret = syscall(__NR_statmnt, mnt_id, mask, st,
sizeof(*st), flags);
                if (!ret || errno != EOVERFLOW)
                        return ret;
                free(st->mnt_root);
                free(st->mountpoint);
        }
}

It's not hugely more complex, but more complex nonetheless.

Also having the helper allocate buffers inside the struct could easily
result in leaks since it's not obvious what the caller needs to free,
while in the first example it is.

Note that I'm not against having the prototype on the kernel interface
take a typed pointer.  If strings are not needed, both interfaces
would work in exactly the same way.

Thanks,
Miklos
