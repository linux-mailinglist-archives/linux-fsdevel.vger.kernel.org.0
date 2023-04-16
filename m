Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE56E35EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDPHzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPHzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:55:43 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F626B1;
        Sun, 16 Apr 2023 00:55:42 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id s13so2651965uaq.4;
        Sun, 16 Apr 2023 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681631741; x=1684223741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6yHpJ4jaMGEPIy6bk8FlRfObSil1/mr8YSnxaCB3mM=;
        b=P3M7PUM51WK4DwJkB83IJpbLq/H+tQCdn9chTw7zPNS5Q6Msgva5FU0NL6+zBoV5KJ
         EvhEozUl4m44IeWKHAYEzJOdUwg5MqRadD1d7XgwrO0kY1cu7nMQ0U7ISI8nOHAb97z9
         ju47CIkwQZjfb/6WuXUelEjGb6Bo1nOsnGwpl1buJUBKB/ksfFyH0lZ0qFCv7OI2iyts
         YSAgG3Ne2Zgx4Q46i3dA32flqbihZ9+1+p+zjVxPe7Uywf1hE6E+B0HRhfCLov3nvyIz
         GN7GRW45R2ZpHOylLNvR/cbjskjSYtBgorh4LRiBG3hZeyO/sPDt8qgus9HL6nrFOBqv
         ByZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681631741; x=1684223741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6yHpJ4jaMGEPIy6bk8FlRfObSil1/mr8YSnxaCB3mM=;
        b=DvxdXrxIbqukOth6R6sgBAFBy9jk9mp3m6tT7pKz6m+BMzDnfIzR4E/MBvWIAIPWMJ
         1txxDTwybb81SWbYfHPaEe5nyXF9oY1pM9pJKGdVe/b9kXpMoHgf4FstXUtUm66Wh/lm
         09EerF5uMlN5Giq7pPoEU2UYMgt+JJ2EBuMhuAEBROzC8jqqHfLpxGp7fCrUrVh+ee4B
         5vxzRALz/aelH+UvG/zjdjelu4VHkKmL96aQbIrhDClxbs2Ak/0VKR3tjSP3WDyy9cuB
         jCKqTXU8C1snUEHdtqtkIzAOugVcCaKnf16mxXF4/LZ6LW1AaKXfzTjNzeiCUoN45xAw
         zFzw==
X-Gm-Message-State: AAQBX9dGXYo/WNharEZRPlSgnV9BufMgL2sGagaSDSVy7sqbwFAqTRsU
        i8tmaaN0ncgeFdqfq0DpSxtiPdSpE8QhkQeoz8vJHYqE
X-Google-Smtp-Source: AKy350YKj/uu52MaD3EXNZlHE9J9kE6KXs5FQ9HwemuDpykTYszRQS4zw8EP7InFFWfjG0A4PDbqbazvepRRDSmB9+c=
X-Received: by 2002:ab0:100c:0:b0:68e:33d7:7e6b with SMTP id
 f12-20020ab0100c000000b0068e33d77e6bmr6356362uab.1.1681631741395; Sun, 16 Apr
 2023 00:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com>
In-Reply-To: <0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 16 Apr 2023 10:55:30 +0300
Message-ID: <CAOQ4uxggt_je51t0MWSfRS0o7UFSYj7GDHSJd026kMfF9TvLiA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 5:47=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From time to time, new syscalls have been proposed to gain more observabi=
lity
> for file-system:
>
> (1) getvalues() [0]. It uses a hierarchical namespace API to gather and r=
eturn
> multiple values in single syscall.
> (2) cachestat() [1].  It returns the cache status (e.g., number of dirty =
pages)
> of a given file in a scalable way.
>
> All these proposals requires adding a new syscall. Here I would like to p=
ropose
> another solution for file system observability: bpf iterator for file sys=
tem
> object. The initial idea came when I was trying to implement a filefrag-l=
ike
> page cache tool with support for multi-order folio, so that we can know t=
he
> number of multi-order folios and the orders of those folios in page cache=
. After
> developing a demo for it, I realized that we could use it to provide more
> observability for file system objects. e.g., dumping the per-cpu iostat f=
or a
> super block [2],  iterating all inodes in a super-block to dump info for
> specific inodes (e.g., unlinked but pinned inode), or displaying the flag=
s of a
> specific mount.
>
> The BPF iterator was introduced in v5.8 [3] to support flexible content d=
umping
> for kernel objects. It works by creating bpf iterator file [4], which is =
a
> seq-like read-only file, and the content of the bpf iterator file is dete=
rmined
> by a previously loaded bpf program, so userspace can read the bpf iterato=
r file
> to get the information it needs. However there are some unresolved issues=
:
> (1) The privilege.
> Loading the bpf program requires CAP_ADMIN or CAP_BPF. This means that th=
e
> observability will be available to the privileged process. Maybe we can l=
oad the
> bpf program through a privileged process and make the bpf iterator file b=
eing
> readable for normal users.
> (2) Prevent pinning the super-block
> In the current naive implementation, the bpf iterator simply pins the
> super-block of the passed fd and prevents the super-block from being dest=
royed.
> Perhaps fs-pin is a better choice, so the bpf iterator can be deactivated=
 after
> the filesystem is umounted.
>
> I hope to send out an RFC soon before LSF/MM/BPF for further discussion.

Hi Hou,

IIUC, there is not much value in making this a cross track session.
Seems like an FS track session that has not much to do with BPF
development.

Am I understanding correctly or are there any cross subsystem
interactions that need to be discussed?

Perhaps we can join you as co-speaker for Miklos' traditional
"fsinfo" session?

Thanks,
Amir.

>
> [0]:
> https://lore.kernel.org/linux-fsdevel/YnEeuw6fd1A8usjj@miu.piliscsaba.red=
hat.com/
> [1]: https://lore.kernel.org/linux-mm/20230219073318.366189-1-nphamcs@gma=
il.com/
> [2]:
> https://lore.kernel.org/linux-fsdevel/CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8ig=
A0DT66GFH2ZanspA@mail.gmail.com/
> [3]: https://lore.kernel.org/bpf/20200509175859.2474608-1-yhs@fb.com/
> [4]: https://docs.kernel.org/bpf/bpf_iterators.html
>
> _______________________________________________
> Lsf-pc mailing list
> Lsf-pc@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
