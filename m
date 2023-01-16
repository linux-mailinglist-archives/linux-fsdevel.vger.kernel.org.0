Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BE66B5AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 03:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjAPCnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 21:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjAPCnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:43:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912927298;
        Sun, 15 Jan 2023 18:43:16 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id cf42so40887166lfb.1;
        Sun, 15 Jan 2023 18:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cItREHD7dVSseoE084li5wt4URU48z08MkE8TxU0Osk=;
        b=PI8bMPcmyWx7vIVkmXy+TlkqTf4D/WEIlv9AiKmf9Zt2mgEL1QU/acE3CgEjDO/FfZ
         qj8cJX890M9+NS0AjiSDhVxrzFDfj3G3HmnVIn/2AvZArMpkW0Twq6yVCWZw8XEAl3lA
         31YPk+mwrqo5J9WJ3r2/fLQ5kZbyL26TdzFigd53D/xHfEYiQB5macnEmy6EK+eqf8Kn
         F82+VOJa8oukQTHSrz3s3O81rYdGvNL4Pfam4/nwBKCp0/Kh/s5b+bfFlEpYMljlAeyo
         TkRpo6y/GvVS0WRphibxgLOpPM6Vt6fSDexwUn2RG+C6IOVUrnuP6lbXlNHYbK+7XYtx
         zFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cItREHD7dVSseoE084li5wt4URU48z08MkE8TxU0Osk=;
        b=8OnZhGr9xbQf+4cJYyD2i3orENzHjyWE7J2V6z0SMYPIVSOc4lTakBgDqstNU0iLyk
         zxIHs1MGapQ9RVTZCFgbQJ9hHiAeLsfa5iVakBWrStlZcvMSqH8XVHLZT270cg7Y46lH
         T2pVevFpAqz37hA2fUnvQ1xj96VJiRyltvRa7MbUtkx/eY6CO58TQK/X3CwiqsVA/yEM
         tJLWIkiyhVGm/CfoBGQHcaGZE11nQ/LPJ72ym+66xSISrTgf86DgBXn3ffAiEzL6XlHu
         E3FuxMdE2WumVAGxYTw1xRzv2SxUjFN0hZc7blrkVLlnwEPhZ7gQT8vhbsJzF5CHafxF
         q6gQ==
X-Gm-Message-State: AFqh2kq1AL+vvttD6CKgHZZZCUqGrJsNT219UP9H3Xm9uZAKQeGIND5d
        2gWQ5PALVmXpN2v2IFaBNjs40JGKg5EOAsoNKSA=
X-Google-Smtp-Source: AMrXdXsvqPHqa2uKarhLXQbf4gS/CzmsSOIa2tHdFEImXsDMQ3w3b9vgfzqn7NNAYsVbcN2hzQBNXtRdMqotUIQSqb4=
X-Received: by 2002:a05:6512:3e12:b0:4ca:6c11:d3e5 with SMTP id
 i18-20020a0565123e1200b004ca6c11d3e5mr4166570lfv.224.1673836994503; Sun, 15
 Jan 2023 18:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
 <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn> <CA+icZUU3-t0+NhdMQ39OeuwR13eMVOKVhLwS31WTHQ1ksaWgNg@mail.gmail.com>
 <CA+icZUXWAu_+KT9wYfdn7uSp1=ikO5ZdhM2VFokRi_JfhL455Q@mail.gmail.com> <c896b0f8-e172-625c-59f2-a78c745c92f6@loongson.cn>
In-Reply-To: <c896b0f8-e172-625c-59f2-a78c745c92f6@loongson.cn>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 16 Jan 2023 03:42:37 +0100
Message-ID: <CA+icZUUQFOmm8s=AOBGPcr5OFWmo71ROdcunHQecrTyV1jMvXw@mail.gmail.com>
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jan 16, 2023 at 3:16 AM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> Hi sedat,
>
>
> On 2023/1/16 am9:52, Sedat Dilek wrote:
> > On Fri, Jan 13, 2023 at 10:32 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>
> >> On Fri, Jan 13, 2023 at 4:19 AM Hongchen Zhang
> >> <zhanghongchen@loongson.cn> wrote:
> >>>
> >>> Hi All,
> >>> any question about this patch, can it be merged?
> >>>
> >>> Thanks
> >>> On 2023/1/7 am 9:23, Hongchen Zhang wrote:
> >>>> Use spinlock in pipe_read/write cost too much time,IMO
> >>>> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> >>>> On the other hand, we can use __pipe_{lock,unlock} to protect
> >>>> the pipe->{head,tail} in pipe_resize_ring and
> >>>> post_one_notification.
> >>>>
> >>>> Reminded by Matthew, I tested this patch using UnixBench's pipe
> >>>> test case on a x86_64 machine,and get the following data:
> >>>> 1) before this patch
> >>>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> >>>> Pipe Throughput                   12440.0     493023.3    396.3
> >>>>                                                           ========
> >>>> System Benchmarks Index Score (Partial Only)              396.3
> >>>>
> >>>> 2) after this patch
> >>>> System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> >>>> Pipe Throughput                   12440.0     507551.4    408.0
> >>>>                                                           ========
> >>>> System Benchmarks Index Score (Partial Only)              408.0
> >>>>
> >>>> so we get ~3% speedup.
> >>>>
> >>>> Reminded by Andrew, I tested this patch with the test code in
> >>>> Linus's 0ddad21d3e99 add get following result:
> >>
> >> Happy new 2023 Hongchen Zhang,
> >>
> >> Thanks for the update and sorry for the late response.
> >>
> >> Should be "...s/add/and get following result:"
> >>
> >> I cannot say much about the patch itself or tested it in my build-environment.
> >>
> >> Best regards,
> >> -Sedat-
> >>
> >
> > I have applied v3 on top of Linux v6.2-rc4.
> >
> > Used pipebench for a quick testing.
> >
> > # fdisk -l /dev/sdb
> > Disk /dev/sdb: 14,91 GiB, 16013942784 bytes, 31277232 sectors
> > Disk model: SanDisk iSSD P4
> > Units: sectors of 1 * 512 = 512 bytes
> > Sector size (logical/physical): 512 bytes / 512 bytes
> > I/O size (minimum/optimal): 512 bytes / 512 bytes
> > Disklabel type: dos
> > Disk identifier: 0x74f02dea
> >
> > Device     Boot Start      End  Sectors  Size Id Type
> > /dev/sdb1        2048 31277231 31275184 14,9G 83 Linux
> >
> > # cat /dev/sdb | pipebench > /dev/null
> > Summary:
> > Piped   14.91 GB in 00h01m34.20s:  162.12 MB/second
> >
> > Not tested/benchmarked with the kernel w/o your patch.
> >
> > -Sedat-
> >
> OK, If there is any problem, let's continue to discuss it
> and hope it can be merged into the main line.
>

Can you give me a hand on the perf stat line?

I tried with:

$ /usr/bin/perf stat --repeat=1 ./0ddad21d3e99

But that gives in both cases no context-switches and cpu-migrations values.

-Sedat-
