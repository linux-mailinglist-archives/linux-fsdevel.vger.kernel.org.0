Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442E16C551C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 20:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCVToL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCVTn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:43:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A912366A
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 12:43:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id le6so20236270plb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679514235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azcxcDWGfZ5KxgvpNnRWk6jgJ8R50ScCGC8BUKh0BEM=;
        b=ft7PgkVgx4Uv3WAl38+A5yWy7xXMu+PEjQ39VUAsnkspho+xToRopd2pY5GokCFoIu
         8BhiizY+SmT4U8UgC8slF9Eu1Pbwy3QX6qOWiJsVQ22X1vmrduQH7mUPLhT7GtBoBE5L
         V4nO/YMFTLh76JSH4q/HxFpysBQH8v/H/W09PHZi4bjGyc6E/T/xHpcc+QMk9j2DxDR1
         vzNtGnPkkBKXzIkMR0kNdqnm/DIr1a4HNoXPqoDynuaF/5Z8ZW0ynugiLK174S2Wtryd
         ZhqHWBGfh2CzeDYcnCyJYiPGz/FNqeeVTZmBAzsaVQPJsShVMxVc7zO9DEzjLsxZznRn
         tLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679514235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azcxcDWGfZ5KxgvpNnRWk6jgJ8R50ScCGC8BUKh0BEM=;
        b=4oOIMGeMhmlclaephPV/BzlECp0P7UNAO6vVE6+zPww8ZgtGr7mlvbnv9EQi6I57bY
         E9buTGYg7qOU1te/D54ykMYACZFQ8sNl8LZIveCBkiAg7iuv4ezuF5IcjUlviOT7IKP/
         KuK/o+P/ub3KYE9/6ib6lvp6SS6GUYjLv4Tw1XB/Ri2HzPkSAW/IlAypsJf1pvII1WY1
         GsRv2r5+EtXX+CwGGaedGOE7+z62is5tpG35QbpYIM3EOChPJWM7O1ukyfgRT6CmUg6P
         p8zUkVKDnO5R9mBkC5ygzJC+BbDTsR0WbBZtOeNmG5lehdh6AqCzbP1BbeVRFwnlHEZJ
         k7hQ==
X-Gm-Message-State: AO0yUKUPAl8JO6ak0ASsO6sEkpTTQ/gXMHD+aOCJfonoKauP391hffwk
        FP5W53KqQYYgLwBnzyPZN8V/jYFBpnmeBhUa5WI=
X-Google-Smtp-Source: AK7set+OfoSVaFs4hLN/8TO8mxTG40Frvxc9ptFvA0ffP6o6cm6O5jMfuWOHa1DgVL67l/GQK1cAGrurjWkBtOsUEXw=
X-Received: by 2002:a17:902:b7c8:b0:19f:2c5a:5786 with SMTP id
 v8-20020a170902b7c800b0019f2c5a5786mr1524466plz.8.1679514235168; Wed, 22 Mar
 2023 12:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
 <CAOQ4uxjF=oTm8wTJvVd0swfcDP0bRUmHSwq5GATYLzvUOsQfXg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjF=oTm8wTJvVd0swfcDP0bRUmHSwq5GATYLzvUOsQfXg@mail.gmail.com>
From:   Amol Dixit <amoldd@gmail.com>
Date:   Wed, 22 Mar 2023 12:43:44 -0700
Message-ID: <CADNhMOvp3k7fuodMiSzaP-mpf5j1Z7g-_wB5gpJc9p2en6szoA@mail.gmail.com>
Subject: Re: inotify on mmap writes
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:16=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Wed, Mar 22, 2023 at 4:13=E2=80=AFAM Amol Dixit <amoldd@gmail.com> wro=
te:
> >
> > Hello,
> > Apologies if this has been discussed or clarified in the past.
> >
> > The lack of file modification notification events (inotify, fanotify)
> > for mmap() regions is a big hole to anybody watching file changes from
> > userspace. I can imagine atleast 2 reasons why that support may be
> > lacking, perhaps there are more:
> >
> > 1. mmap() writeback is async (unless msync/fsync triggered) driven by
> > file IO and page cache writeback mechanims, unlike write system calls
> > that get funneled via the vfs layer, whih is a convenient common place
> > to issue notifications. Now mm code would have to find a common ground
> > with filesystem/vfs, which is messy.
> >
> > 2. writepages, being an address-space op is treated by each file
> > system independently. If mm did not want to get involved, onus would
> > be on each filesystem to make their .writepages handlers notification
> > aware. This is probably also considered not worth the trouble.
> >
> > So my question is, notwithstanding minor hurdles (like lost events,
> > hardlinks etc.), would the community like to extend inotify support
> > for mmap'ed writes to files? Under configs options, would a fix on a
> > per filesystem basis be an acceptable solution (I can start with say
> > ext4 writepages linking back to inode/dentry and firing a
> > notification)?
> >
> > Eventually we will have larger support across the board and
> > inotify/fanotify can be a reliable tracking mechanism for
> > modifications to files.
> >
>
> What is the use case?
> Would it be sufficient if you had an OPEN_WRITE event?
> or if OPEN event had the O_ flags as an extra info to the event?
> I have a patch for the above and I personally find this information
> missing from OPEN events.
>
> Are you trying to monitor mmap() calls? write to an mmaped area?
> because writepages() will get you neither of these.

OPEN events are not useful to track file modifications in real time,
although I can do see the usefulness of OPEN_WRITE events to track
files that can change.

I am trying to track writes to mmaped area (as these are not notified
using inotify events). I wanted to ask the community of the
feasibility and usefulness of this. I had some design ideas of
tracking writes (using jbd commit callbacks for instance) in the
kernel, but to make it generic sprucing up the inotify interface is a
much better approach.

Hope that provides some context.
Thanks,
Amol
