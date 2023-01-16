Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003E566B553
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 02:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjAPBxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 20:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjAPBxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:53:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C574493;
        Sun, 15 Jan 2023 17:53:11 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s25so28618886lji.2;
        Sun, 15 Jan 2023 17:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zN3vKPOooFIqs+n+/r4j1b6xyKulBfxLx9wgI9OLmYI=;
        b=YmRtgFIeIhBrbBTdNYg8vHpbF1XgNHsBx/hianTKlZwDEHm2fWPwF/cPNoRd319Nct
         nDDvN/SWf1wf1GHV3TYZlOVQyIpl6TzEGivGXJAoyu5tKsz0vMxoaY1KT5f+NzXpcdlY
         /Wx9wqF/wBM2SjgQx//z0LJFXwMo5XJ9kWX/zKz5cty9Fm0P8J89OSklJxF3+y0VW2cJ
         wRGTMxZjWryT8sEZUBho9YUURqIAG2DNOl7atPzHda6WUBcCtrEWZHK3ka1lmfVLL6dY
         eZIgLXvfDmoyRdZtGwDv96vkuLiYVEYm0N2as5vM3Z7Hi3wXKAlEbi9AHLsI+juMVgYr
         TWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN3vKPOooFIqs+n+/r4j1b6xyKulBfxLx9wgI9OLmYI=;
        b=LRE81RmhipsAqvMgQFu38eC9fVlDTGDUZkDZ8SRCCQCf/vhoIWkalv086yUM1bkSU4
         /+MTgsAOyjjyJ8mi4PKuHdh9voQ9oP/WeEA4n2QfbW/tpUAN9DNFoJeXku9koZ1Vo9zQ
         AS+qs35pc86wO9pAN9oxgkN+VeZVHcRzYZe+MAngymlbQK4yKzykP2O4BmrcipnkhNe7
         f5xuze9hjpKDlAjYEKiLHLtE9+YjMn9HIcFS9u3P6ryWmNzlE9/GWP+0/3PLExsJ/+jO
         kB+1ux5w+kw/+Wep3rqhJxneFE9t4ctlqPE+cGB4p1CiUXUEEDqYW9PVEI/XoBqEIps6
         VzYg==
X-Gm-Message-State: AFqh2kq5FgW3PwOI31W+0ZsDRCZ4TSBCQbgNrR7/RqDtSpXoBML8Acgz
        Ftd6rR17Em1JQViKNzYb1G0b5Q1r1ZYN4nDXANI=
X-Google-Smtp-Source: AMrXdXv6KEGRyuXodwkBAbGpchhrASJ1S80h8xhQ6fI4bLEMbOHycJ0Mb/xIOv0qNvD00OzHQOHI5D4rjCvYh2xxqho=
X-Received: by 2002:a2e:9188:0:b0:289:81a4:3a7b with SMTP id
 f8-20020a2e9188000000b0028981a43a7bmr967681ljg.487.1673833990003; Sun, 15 Jan
 2023 17:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20230107012324.30698-1-zhanghongchen@loongson.cn>
 <9fcb3f80-cb55-9a72-0e74-03ace2408d21@loongson.cn> <CA+icZUU3-t0+NhdMQ39OeuwR13eMVOKVhLwS31WTHQ1ksaWgNg@mail.gmail.com>
In-Reply-To: <CA+icZUU3-t0+NhdMQ39OeuwR13eMVOKVhLwS31WTHQ1ksaWgNg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 16 Jan 2023 02:52:32 +0100
Message-ID: <CA+icZUXWAu_+KT9wYfdn7uSp1=ikO5ZdhM2VFokRi_JfhL455Q@mail.gmail.com>
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

On Fri, Jan 13, 2023 at 10:32 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 4:19 AM Hongchen Zhang
> <zhanghongchen@loongson.cn> wrote:
> >
> > Hi All,
> > any question about this patch, can it be merged?
> >
> > Thanks
> > On 2023/1/7 am 9:23, Hongchen Zhang wrote:
> > > Use spinlock in pipe_read/write cost too much time,IMO
> > > pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> > > On the other hand, we can use __pipe_{lock,unlock} to protect
> > > the pipe->{head,tail} in pipe_resize_ring and
> > > post_one_notification.
> > >
> > > Reminded by Matthew, I tested this patch using UnixBench's pipe
> > > test case on a x86_64 machine,and get the following data:
> > > 1) before this patch
> > > System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> > > Pipe Throughput                   12440.0     493023.3    396.3
> > >                                                          ========
> > > System Benchmarks Index Score (Partial Only)              396.3
> > >
> > > 2) after this patch
> > > System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> > > Pipe Throughput                   12440.0     507551.4    408.0
> > >                                                          ========
> > > System Benchmarks Index Score (Partial Only)              408.0
> > >
> > > so we get ~3% speedup.
> > >
> > > Reminded by Andrew, I tested this patch with the test code in
> > > Linus's 0ddad21d3e99 add get following result:
>
> Happy new 2023 Hongchen Zhang,
>
> Thanks for the update and sorry for the late response.
>
> Should be "...s/add/and get following result:"
>
> I cannot say much about the patch itself or tested it in my build-environment.
>
> Best regards,
> -Sedat-
>

I have applied v3 on top of Linux v6.2-rc4.

Used pipebench for a quick testing.

# fdisk -l /dev/sdb
Disk /dev/sdb: 14,91 GiB, 16013942784 bytes, 31277232 sectors
Disk model: SanDisk iSSD P4
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x74f02dea

Device     Boot Start      End  Sectors  Size Id Type
/dev/sdb1        2048 31277231 31275184 14,9G 83 Linux

# cat /dev/sdb | pipebench > /dev/null
Summary:
Piped   14.91 GB in 00h01m34.20s:  162.12 MB/second

Not tested/benchmarked with the kernel w/o your patch.

-Sedat-
