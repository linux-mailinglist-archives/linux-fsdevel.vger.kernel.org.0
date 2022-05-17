Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A32529B42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 09:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbiEQHmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241921AbiEQHkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 03:40:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3C049913;
        Tue, 17 May 2022 00:40:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x12so16239286pgj.7;
        Tue, 17 May 2022 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JIi35a05HlwmtXgYjoMMqH3apQkJy16BsSKQ0IeZYY=;
        b=YvVF6GN/oHRONG4pG0tHKxAIsMk4nySfZa1PV8UOY6QlMDsnoDE0nMKIk0oaqY+rBp
         wJiEf9VZRVuvoSTt9elAqAYS6vd9eX8war5g36Xy5i3lYoboWRmzYXsuxKs3Qy5H/vqS
         Q48bPei2UuqOnG4oC2+uwlQXnNc9XveUvkuE6eW5KMVu4UnzOQZn9FPxgR6HGIulvgkR
         OpQZgsvdTiivT0PuPk1SPcCk5fgAGagONYvVtpZuuDY5HSFXc2ENCnHYYxNbRH3H5nhe
         r3kbMvrNDqxJhBba5Kfrx0xf1SdU518y8dadLIT5yP1gA6ZcvQB+lQwul9RCqjJWuguG
         8ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JIi35a05HlwmtXgYjoMMqH3apQkJy16BsSKQ0IeZYY=;
        b=Xd1CiYhIYJsXbDwDbvVEY19ekZ9OcgwAKxNCsSsQ4v6pIMyWTJGVtAhCQxYBN7K8RN
         P0/WOHIbRSaAk6NHcT49X4T6OKoQIrcpblKThUvuZ3PlfUCsjKJaQVK4NI1QAg4AZJlm
         rArstK6Yau0YaVULZTXiFh7U5C8ZM9g61OyHkI2B9rLIOlPTWU2kAzNTnki0NH2aWYQk
         87zQKeCcMFxDDUQfyTyb+40N3sf50Bf/Audh8bInfaf7gO5FwsmACv2iRkIzsQiythxp
         PCdf6EFu1ddz8ErjI40TAQsvrF8qLcKqYIgqQ60SXjVfJMhfhO8d8PlOsaMzAUZsKS9L
         YL+w==
X-Gm-Message-State: AOAM5338yCfBNs8TzfyHosrnF/Pa7KOArRU8ajO1ZCm+scpMkp3F7Czs
        L/PPP2HPPc20Uoo85o3xoQk4T7UwyvdllYP+SAk=
X-Google-Smtp-Source: ABdhPJw2vMxovqHxTbBNACfTJTqTQvVubPVnhdiksMpuJRdbeCueW4xNdxf72xlu0K7Q66DpvSpBz2mG2nhObYdpM3A=
X-Received: by 2002:a63:2c4a:0:b0:3c1:df82:cf0e with SMTP id
 s71-20020a632c4a000000b003c1df82cf0emr18770299pgs.474.1652773217490; Tue, 17
 May 2022 00:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220509105847.8238-1-dharamhans87@gmail.com>
In-Reply-To: <20220509105847.8238-1-dharamhans87@gmail.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Tue, 17 May 2022 13:10:05 +0530
Message-ID: <CACUYsyE-83unRZvFLC+FQ1260+u3A2i5=JtuRC5cj44yvpYLMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] FUSE: Allow non-extending parallel direct writes
To:     Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 9, 2022 at 4:29 PM Dharmendra Singh <dharamhans87@gmail.com> wrote:
>
> It is observed that currently in Fuse, for direct writes, we hold
> inode lock for the full duration of the request. As a result,
> only one direct write request can proceed on the same file. This,
> I think is due to various reasons such as serialization needed by
> USER space fuse implementations/file size issues/write failures.
>
> This patch allows parallel writes to proceed on the same file by
> by holding shared lock on the non-extending writes and exlusive
> lock on extending writes.
>
> For measuring performance, I carried out test on these
> changes over example/passthrough.c (part of libfuse) by setting
> direct-io and parallel_direct_writes flags on the file.
>
> Note that we disabled write to underlying file system from passthrough
> as we wanted to check gain for Fuse only. Fio was used to test
> the impact of these changes on File-per-job and Single shared File.
> CPU binding was performed on passthrough process only.
>
> Job file for SSF:
> [global]
> directory=/tmp/dest
> filename=ssf
> size=100g
> blocksize=1m
> ioengine=sync
> group_reporting=1
> fallocate=none
> runtime=60
> stonewall
>
> [write]
> rw=randwrite:256
> rw_sequencer=sequential
> fsync_on_close=1
>
>
> Job file for file-per-job:
> [sequential-write]
> rw=write
> size=100G
> directory=/tmp/dest/
> group_reporting
> name=sequential-write-direct
> bs=1M
> runtime=60
>
>
> Results:
>
> unpatched=================
>
> File  per job
>
>
> Fri May  6 09:36:52 EDT 2022
> numjobs: 1  WRITE: bw=3441MiB/s (3608MB/s), 3441MiB/s-3441MiB/s (3608MB/s-3608MB/s), io=100GiB (107GB), run=29762-29762msec
> numjobs: 2  WRITE: bw=8174MiB/s (8571MB/s), 8174MiB/s-8174MiB/s (8571MB/s-8571MB/s), io=200GiB (215GB), run=25054-25054msec
> numjobs: 4  WRITE: bw=14.9GiB/s (15.0GB/s), 14.9GiB/s-14.9GiB/s (15.0GB/s-15.0GB/s), io=400GiB (429GB), run=26900-26900msec
> numjobs: 8  WRITE: bw=23.4GiB/s (25.2GB/s), 23.4GiB/s-23.4GiB/s (25.2GB/s-25.2GB/s), io=800GiB (859GB), run=34115-34115msec
> numjobs: 16  WRITE: bw=24.5GiB/s (26.3GB/s), 24.5GiB/s-24.5GiB/s (26.3GB/s-26.3GB/s), io=1469GiB (1577GB), run=60001-60001msec
> numjobs: 32  WRITE: bw=20.5GiB/s (21.0GB/s), 20.5GiB/s-20.5GiB/s (21.0GB/s-21.0GB/s), io=1229GiB (1320GB), run=60003-60003msec
>
>
> SSF
>
> Fri May  6 09:46:38 EDT 2022
> numjobs: 1  WRITE: bw=3624MiB/s (3800MB/s), 3624MiB/s-3624MiB/s (3800MB/s-3800MB/s), io=100GiB (107GB), run=28258-28258msec
> numjobs: 2  WRITE: bw=5801MiB/s (6083MB/s), 5801MiB/s-5801MiB/s (6083MB/s-6083MB/s), io=200GiB (215GB), run=35302-35302msec
> numjobs: 4  WRITE: bw=4794MiB/s (5027MB/s), 4794MiB/s-4794MiB/s (5027MB/s-5027MB/s), io=281GiB (302GB), run=60001-60001msec
> numjobs: 8  WRITE: bw=3946MiB/s (4137MB/s), 3946MiB/s-3946MiB/s (4137MB/s-4137MB/s), io=231GiB (248GB), run=60003-60003msec
> numjobs: 16  WRITE: bw=4040MiB/s (4236MB/s), 4040MiB/s-4040MiB/s (4236MB/s-4236MB/s), io=237GiB (254GB), run=60006-60006msec
> numjobs: 32  WRITE: bw=2822MiB/s (2959MB/s), 2822MiB/s-2822MiB/s (2959MB/s-2959MB/s), io=165GiB (178GB), run=60013-60013msec
>
>
> Patched=====
>
> File per job
>
> Fri May  6 10:05:46 EDT 2022
> numjobs: 1  WRITE: bw=3193MiB/s (3348MB/s), 3193MiB/s-3193MiB/s (3348MB/s-3348MB/s), io=100GiB (107GB), run=32068-32068msec
> numjobs: 2  WRITE: bw=9084MiB/s (9525MB/s), 9084MiB/s-9084MiB/s (9525MB/s-9525MB/s), io=200GiB (215GB), run=22545-22545msec
> numjobs: 4  WRITE: bw=14.8GiB/s (15.9GB/s), 14.8GiB/s-14.8GiB/s (15.9GB/s-15.9GB/s), io=400GiB (429GB), run=26986-26986msec
> numjobs: 8  WRITE: bw=24.5GiB/s (26.3GB/s), 24.5GiB/s-24.5GiB/s (26.3GB/s-26.3GB/s), io=800GiB (859GB), run=32624-32624msec
> numjobs: 16  WRITE: bw=24.2GiB/s (25.0GB/s), 24.2GiB/s-24.2GiB/s (25.0GB/s-25.0GB/s), io=1451GiB (1558GB), run=60001-60001msec
> numjobs: 32  WRITE: bw=19.3GiB/s (20.8GB/s), 19.3GiB/s-19.3GiB/s (20.8GB/s-20.8GB/s), io=1160GiB (1245GB), run=60002-60002msec
>
>
> SSF
>
> Fri May  6 09:58:33 EDT 2022
> numjobs: 1  WRITE: bw=3137MiB/s (3289MB/s), 3137MiB/s-3137MiB/s (3289MB/s-3289MB/s), io=100GiB (107GB), run=32646-32646msec
> numjobs: 2  WRITE: bw=7736MiB/s (8111MB/s), 7736MiB/s-7736MiB/s (8111MB/s-8111MB/s), io=200GiB (215GB), run=26475-26475msec
> numjobs: 4  WRITE: bw=14.4GiB/s (15.4GB/s), 14.4GiB/s-14.4GiB/s (15.4GB/s-15.4GB/s), io=400GiB (429GB), run=27869-27869msec
> numjobs: 8  WRITE: bw=22.6GiB/s (24.3GB/s), 22.6GiB/s-22.6GiB/s (24.3GB/s-24.3GB/s), io=800GiB (859GB), run=35340-35340msec
> numjobs: 16  WRITE: bw=25.6GiB/s (27.5GB/s), 25.6GiB/s-25.6GiB/s (27.5GB/s-27.5GB/s), io=1535GiB (1648GB), run=60001-60001msec
> numjobs: 32  WRITE: bw=20.2GiB/s (21.7GB/s), 20.2GiB/s-20.2GiB/s (21.7GB/s-21.7GB/s), io=1211GiB (1300GB), run=60003-60003msec
>
>
>
> SSF gain in percentage:-
> For 1 fio thread: +0%
> For 2 fio threads: +0%
> For 4 fio threads: +42%
> For 8 fio threads: +246.8%
> For 16 fio threads: +549%
> For 32 fio threads: +630.33%

A gentle reminder to look into the suggested changes.


Thanks,
Dharmendra
