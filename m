Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02574FDC17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349613AbiDLKM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384707AbiDLImQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:42:16 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F22517C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 01:07:58 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id y19so3627932qvk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcenjX9tAXnXNfP/D6XLFmq5WW6wP81T0TtyvCaebvo=;
        b=jy+ObHKPLPv0MteREhr/gpTyrKMC4EiE1u4ppSkwNgIWZr0fFeV513jYKItfq/es7h
         hxKEWl/v8fMzFYp743i/PAPOTZBP1eULHIpaE7fs6pPOuTgEw/V1x5XQZ6o2N8vLLSuU
         +Lee6JS2IgohV2vjZFtD5BFN2Pb++0tiSnb0q+J/K3udGqQoDpe3Id+SBBaKY8zrYQ3N
         dKTZ+6/CHRc0dCwT1RhMAzT5LtYciztJpdQ+i48DPVBU6UPZK/U7WhAHKVvCSTClKXhF
         33Ql9PtaIVuc0BQdgdMu2zN1+8Uw/oMpG/58XgnyZJPNdbmx8S2oTI5MbDuxq757hsYI
         hg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcenjX9tAXnXNfP/D6XLFmq5WW6wP81T0TtyvCaebvo=;
        b=RWKxMxwrWxk91wTGCEs3nmqXh6EU8LxSf2U3Xoj1IKgSZ7VxdRua7B45v1FeDOpUFq
         Nzc8zqIBvvUtvMc7OEmeYjXoLdJAWBuV3ceiPb9G9uC5HWJ7UuyndP5uhMIvWmjvDyoN
         j6Xo1/eLqUmXZhOgdk/PVBwNmbfLSzVbMRB5cAKDVeIwNGbfxc6cXzpK8bX3XwW5/HTH
         mwF2+59at48PF5R0v5UF7Wn4iCLM039DjB5s6iLQikYB/8BlUkwm32GNPZEow/L8rvUR
         YnSocHsVLacOsB7RtX8zuxcxrpP0JN//fpc5McJg/hZOEBUNGM3wZ0MVD689w0Z95YYw
         8/Cw==
X-Gm-Message-State: AOAM532SDZZBAHFlteE4cE/d7AU4W5C6O3ty8yrRPB2Z0kH1RY49914F
        Zb001IIaZAiTbcHdUU/JaWaj1+dJNy7KjQ2ILVPAhTdr
X-Google-Smtp-Source: ABdhPJy6gpXgTNY1HtayyRfo2WmyeRJgNYA1T0xczhsXhXMF1ChABg4IIV0lhoY8M2BNWgBHbRe7DorMRVZFi80MrnA=
X-Received: by 2002:a05:6214:1c83:b0:443:6749:51f8 with SMTP id
 ib3-20020a0562141c8300b00443674951f8mr29479155qvb.74.1649750877546; Tue, 12
 Apr 2022 01:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com> <20220329074904.2980320-14-amir73il@gmail.com>
 <20220411114752.jpn7kkxnqobriep3@quack3.lan> <CAOQ4uxjuYChExjsqPmczM9SzXapUR0bT8RTEbxaQsSacNOMV4A@mail.gmail.com>
 <20220411141912.ery2uhg3gqyt32oa@quack3.lan>
In-Reply-To: <20220411141912.ery2uhg3gqyt32oa@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Apr 2022 11:07:46 +0300
Message-ID: <CAOQ4uxiEe3SY2NaDw30OWaEonb=wP6SbEjMx0GJ_TS0xZvVwCA@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] fanotify: implement "evictable" inode marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 5:19 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 11-04-22 15:57:30, Amir Goldstein wrote:
> > On Mon, Apr 11, 2022 at 2:47 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 29-03-22 10:49:01, Amir Goldstein wrote:
> > > > When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
> > > > pin the marked inode to inode cache, so when inode is evicted from cache
> > > > due to memory pressure, the mark will be lost.
> > > >
> > > > When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
> > > > this flag, the marked inode is pinned to inode cache.
> > > >
> > > > When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
> > > > existing mark already has the inode pinned, the mark update fails with
> > > > error EEXIST.
> > >
> > > I was thinking about this. FAN_MARK_EVICTABLE is effectively a hint to the
> > > kernel - you can drop this if you wish. So does it make sense to return
> > > error when we cannot follow the hint? Doesn't this just add unnecessary
> > > work (determining whether the mark should be evictable or not) to the
> > > userspace application using FAN_MARK_EVICTABLE?
> >
> > I do not fully agree about your definition of  "hint to the kernel".
> > Yes, for a single inode it may be a hint, but for a million inodes it is pretty
> > much a directive that setting a very large number of evictable marks
> > CANNOT be used to choke the system.
> >
> > It's true that the application should be able to avoid shooting its own
> > foot and we do not need to be the ones providing this protection, but
> > I rather prefer to keep the API more strict and safe than being sorry later.
> > After all, I don't think this complicates the implementation nor documentation
> > too much. Is it? see:
> >
> > https://github.com/amir73il/man-pages/commit/b52eb7d1a8478cbd1456f4d9463902bbc4e80f0d
>
> No, it is not complicating things too much and you're probably right that
> having things stricter now may pay off in the future. I was just thinking
> that app adding ignore mark now needs to remember whether it has already
> added something else for the inode or not to know whether it can use
> FAN_MARK_EVICTABLE. Which seemed like unnecessary complication.
>

Well the way my app does it, it has a hardcoded list of "must exclude" dirs
which is sets on startup and then evictable ignore masks are added lazily
when events in non-interesting path show up.

If app would somehow get an event with path that was in the "must exclude"
set, then adding evictable mark would fail and nothing to it because it is
an optimization anyway. There is no tracking involved.

Anyway, I see there is a bug in EEXIST case, the error is returned *after*
updating the mask - I will fix it and re-post v3 with the rest of the fixes.

Thanks,
Amir.
