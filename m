Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A36A600F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 20:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjB1T7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 14:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjB1T7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:59:20 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAED2A6CA
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:59:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c3so7645298qtc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuSVlKpPF8gU3w0v8rtlpMjWgWDk2kvzccZhwHpR+eM=;
        b=YPZwN5+k6vm0UbGG6I9sOJ47jfD/Bl1ThzNCn3eEdbwoyq8mfB6d9njrHVa3GKfyFF
         V2rsTW281KaDPWUlw6xajiDF5Jjd+WI1pBnXlLqCoJgPSMs5iFrQtGYeS7Q0yC0DjGKg
         rQh26yA3WRyKqoOiYHZrfjuC3pSi4kkYRmeYMRJQqxp+YXgl1Us0mcJhXd8Ku93h5teB
         VpscW1HQNs/hsstk5vsGOqD2O3JqZXYtGT6Kdusz+9Cc7NBOlRDn36A3/TznPvJkKIWw
         7+VnskgZ2WiK+D2TxoAOn8qX1PcV1jv1JDB/5WWyRG8lcYrQ7fBe08VlrQyHvHT92G9n
         rv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuSVlKpPF8gU3w0v8rtlpMjWgWDk2kvzccZhwHpR+eM=;
        b=TNLBC/sz19QVPoEi4uhNHTbXp1ino+EjF34ObtvjKiYqblayICLRUeDzq8zoZ8hMPK
         tkF3dqPdtyuV2dvJl6Azje59wOD4WXaeab0OOFZ8N48DSbMfgwtS3O2A2OF8uhwq7EDa
         +4xkoxhBeuv8pmQDbMJ3x3QFnOxv5ZxogqXmI975BZgwgVMbIq5xXFGYBOc8LXv6l8wv
         SIG/qrrNzwsALRoeuEGAegz3hnwRLmukKEPYdAAI9F7sQFM9camTVvm/YCxbZD3E2ITP
         uPEjw+jn0xqhb7UuJUsS0lMO52DFa2YpXbrGJiuPPlehVUtAHWogfAudMGQFcTZb+KGn
         c3zg==
X-Gm-Message-State: AO0yUKU0B2WdBnHztcF5No8UkxTycxPBsC6zi9hAA1BQ6SUM5CWIfTV0
        /NmMW8mTbpKuyTNJCjBgXWE7IA==
X-Google-Smtp-Source: AK7set/npV9n3dF9Lu0temv+NFVqOnKpsEEb6ImmgJmBogTFZipMN0MDl8NCZOsGqazJQab4LmJvrw==
X-Received: by 2002:ac8:5b85:0:b0:3bf:b4c7:37d8 with SMTP id a5-20020ac85b85000000b003bfb4c737d8mr7262467qta.7.1677614358230;
        Tue, 28 Feb 2023 11:59:18 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id f67-20020a37d246000000b006f9ddaaf01esm670683qkj.102.2023.02.28.11.59.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2023 11:59:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [LSF/MM/BPF TOPIC] bpf iterator for file-system
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com>
Date:   Tue, 28 Feb 2023 11:59:14 -0800
Cc:     lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nhat Pham <nphamcs@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C33452AE-4697-476F-ADDB-DDC91FDBB237@dubeyko.com>
References: <0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 27, 2023, at 7:30 PM, Hou Tao <houtao@huaweicloud.com> wrote:
>=20
> =46rom time to time, new syscalls have been proposed to gain more =
observability
> for file-system:
>=20
> (1) getvalues() [0]. It uses a hierarchical namespace API to gather =
and return
> multiple values in single syscall.
> (2) cachestat() [1].  It returns the cache status (e.g., number of =
dirty pages)
> of a given file in a scalable way.
>=20
> All these proposals requires adding a new syscall. Here I would like =
to propose
> another solution for file system observability: bpf iterator for file =
system
> object. The initial idea came when I was trying to implement a =
filefrag-like
> page cache tool with support for multi-order folio, so that we can =
know the
> number of multi-order folios and the orders of those folios in page =
cache. After
> developing a demo for it, I realized that we could use it to provide =
more
> observability for file system objects. e.g., dumping the per-cpu =
iostat for a
> super block [2],  iterating all inodes in a super-block to dump info =
for
> specific inodes (e.g., unlinked but pinned inode), or displaying the =
flags of a
> specific mount.
>=20

Sounds like interesting suggestion to me. :) Potentially, it could have =
more
applications.

> The BPF iterator was introduced in v5.8 [3] to support flexible =
content dumping
> for kernel objects. It works by creating bpf iterator file [4], which =
is a
> seq-like read-only file, and the content of the bpf iterator file is =
determined
> by a previously loaded bpf program, so userspace can read the bpf =
iterator file
> to get the information it needs. However there are some unresolved =
issues:
> (1) The privilege.
> Loading the bpf program requires CAP_ADMIN or CAP_BPF. This means that =
the
> observability will be available to the privileged process. Maybe we =
can load the
> bpf program through a privileged process and make the bpf iterator =
file being
> readable for normal users.
> (2) Prevent pinning the super-block
> In the current naive implementation, the bpf iterator simply pins the
> super-block of the passed fd and prevents the super-block from being =
destroyed.
> Perhaps fs-pin is a better choice, so the bpf iterator can be =
deactivated after
> the filesystem is umounted.
>=20
> I hope to send out an RFC soon before LSF/MM/BPF for further =
discussion.
>=20

It will be good to see the patchset. :)

Thanks,
Slava.

> [0]:
> =
https://lore.kernel.org/linux-fsdevel/YnEeuw6fd1A8usjj@miu.piliscsaba.redh=
at.com/
> [1]: =
https://lore.kernel.org/linux-mm/20230219073318.366189-1-nphamcs@gmail.com=
/
> [2]:
> =
https://lore.kernel.org/linux-fsdevel/CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA=
0DT66GFH2ZanspA@mail.gmail.com/
> [3]: https://lore.kernel.org/bpf/20200509175859.2474608-1-yhs@fb.com/
> [4]: https://docs.kernel.org/bpf/bpf_iterators.html
>=20

