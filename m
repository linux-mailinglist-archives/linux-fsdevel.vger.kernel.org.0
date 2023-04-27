Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4356F08CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjD0Py6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244271AbjD0Pyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:54:49 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4F4233;
        Thu, 27 Apr 2023 08:54:48 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-77215852592so2649782241.2;
        Thu, 27 Apr 2023 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682610887; x=1685202887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV7JI9NWw5gwyZash9keIwJWQlbo+m8kULyKQQrJ6j4=;
        b=sDuIRQuG3oQsLiMxcE6mvkRy+Kq6MH/vvQIFc+WbyMCtVtn+wVACKO41cbX0J2oFUG
         zClz/PLK8CBoHLJ4BpG6YCgs0T520cHhH1rnH09A3TBhlZJoWHmoLdH95Pl21k0tXuAN
         Ak9Hwgd2hCA7pk+OLRSaKmyZSeOzxv+6PGAeUgbzHIyqqctUzgKOlOEpCEkDbb2IIRgR
         vEO/QCzMhdTd6zK3obafxNT3KRB1kPKLz9w30R4uGnvAHtjsavzNSkaScFSJ3Vapdi97
         Vh4RIt2OyVCzsr6pUbgCg8mcjwE6uHBQPXicrF25xSmxHiscPfQvpjajCvtTzDRC+WAT
         bcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682610887; x=1685202887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eV7JI9NWw5gwyZash9keIwJWQlbo+m8kULyKQQrJ6j4=;
        b=U7bBWHdXiXU+8HomitPejGBkFsSYUtMqcBErk8fQQ3VoygBFWkY+MjbTlhCkrlvWq7
         cNAahJpxdRMJ25JmsseQKz4v3OEDKPgeKUATgYNPRWSM5PjnROK0D567l4KojXak68eE
         q9zMa/8s/ywMPEzjBYHz1zKhDOx9i4jdtVgralDRdPWIg0unWfK6wCiESxeOANa4E2iz
         fgJn/GRKyiNKPZuED69t5VQI8ysoPlgKz+jG7DmajT6jfY6KXWVn6NlZsmgz8t2XoIpy
         p8HTXyBTVarL5AQzlYj0529ulcwXAKn7Uh0PLY4P4xcjfD8OIi4bqAl+Ojhn6Ugd/CNk
         B2tA==
X-Gm-Message-State: AC+VfDxNmq0H7zh4EJddLr6A/wv6EgDI2fMZmbD1VKIy/XuWwcL5PQCM
        zZkcqjb729nOQyd+7xRL1kb2vTVL+JnHki8jtFM=
X-Google-Smtp-Source: ACHHUZ7y8Oy/KK09D/ZCEsXztAtL9JgRz8YOrAaR/fvAs8bUY/HXQhaFilb90ib8CHfbsCW1nWFAPRjSVz58xKgvbMQ=
X-Received: by 2002:a67:f646:0:b0:430:16c1:4d8 with SMTP id
 u6-20020a67f646000000b0043016c104d8mr1119990vso.25.1682610887150; Thu, 27 Apr
 2023 08:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com>
 <CAOQ4uxggt_je51t0MWSfRS0o7UFSYj7GDHSJd026kMfF9TvLiA@mail.gmail.com> <a1e5d6e0-4772-f42a-96b8-eccefdb6127e@huaweicloud.com>
In-Reply-To: <a1e5d6e0-4772-f42a-96b8-eccefdb6127e@huaweicloud.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 18:54:36 +0300
Message-ID: <CAOQ4uxhjST45GCHF8ZeHN1-71pV=VaO1GrO1MV23uWFgu3W9Zw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] bpf iterator for file-system
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     lsf-pc@lists.linux-foundation.org, Nhat Pham <nphamcs@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>
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

On Mon, Apr 24, 2023 at 9:45=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 4/16/2023 3:55 PM, Amir Goldstein wrote:
> > On Tue, Feb 28, 2023 at 5:47=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From time to time, new syscalls have been proposed to gain more observ=
ability
> >> for file-system:
> >>
> >> (1) getvalues() [0]. It uses a hierarchical namespace API to gather an=
d return
> >> multiple values in single syscall.
> >> (2) cachestat() [1].  It returns the cache status (e.g., number of dir=
ty pages)
> >> of a given file in a scalable way.
> >>
> >> All these proposals requires adding a new syscall. Here I would like t=
o propose
> >> another solution for file system observability: bpf iterator for file =
system
> >> object. The initial idea came when I was trying to implement a filefra=
g-like
> >> page cache tool with support for multi-order folio, so that we can kno=
w the
> >> number of multi-order folios and the orders of those folios in page ca=
che. After
> >> developing a demo for it, I realized that we could use it to provide m=
ore
> >> observability for file system objects. e.g., dumping the per-cpu iosta=
t for a
> >> super block [2],  iterating all inodes in a super-block to dump info f=
or
> >> specific inodes (e.g., unlinked but pinned inode), or displaying the f=
lags of a
> >> specific mount.
> >>
> >> The BPF iterator was introduced in v5.8 [3] to support flexible conten=
t dumping
> >> for kernel objects. It works by creating bpf iterator file [4], which =
is a
> >> seq-like read-only file, and the content of the bpf iterator file is d=
etermined
> >> by a previously loaded bpf program, so userspace can read the bpf iter=
ator file
> >> to get the information it needs. However there are some unresolved iss=
ues:
> >> (1) The privilege.
> >> Loading the bpf program requires CAP_ADMIN or CAP_BPF. This means that=
 the
> >> observability will be available to the privileged process. Maybe we ca=
n load the
> >> bpf program through a privileged process and make the bpf iterator fil=
e being
> >> readable for normal users.
> >> (2) Prevent pinning the super-block
> >> In the current naive implementation, the bpf iterator simply pins the
> >> super-block of the passed fd and prevents the super-block from being d=
estroyed.
> >> Perhaps fs-pin is a better choice, so the bpf iterator can be deactiva=
ted after
> >> the filesystem is umounted.
> >>
> >> I hope to send out an RFC soon before LSF/MM/BPF for further discussio=
n.
> > Hi Hou,
> >
> > IIUC, there is not much value in making this a cross track session.
> > Seems like an FS track session that has not much to do with BPF
> > development.
> >
> > Am I understanding correctly or are there any cross subsystem
> > interactions that need to be discussed?
> Yes. Although the patchset for file-system iterator is still not ready, b=
ut I
> think the BPF mechanisms for file-system iterator is ready, so a cross tr=
ack
> session maybe unnecessary.
> >
> > Perhaps we can join you as co-speaker for Miklos' traditional
> > "fsinfo" session?
> Thanks. I am glad to be a co-speaker for fsinfo session.

All right. I put you down as a co-speaker with Miklos on the fsinfo session=
.

Thanks,
Amir.
