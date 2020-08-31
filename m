Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F327A2578B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaLve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 07:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaLve (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:51:34 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0DC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 04:51:32 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id x142so1236006vke.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaO2NVhKTszsRsewuxIPYfrFMWppxtP12KWF3h+AT/E=;
        b=U4NGJKAX4YM9pzKJhrm7MP5MSzPdYPkVxmVi8QQ1I7x5WKcZILp6gf6E5qiSpykL6p
         xLIoeFy1SJHM0tIZiTONUmBopAR7m0IZTmPYU/Q0TWqMwL835IRE4rEQewN83M6pJYzi
         rMCo1iHDTM19d0VqnmrMsRkJdFXkv0Ufjuj9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaO2NVhKTszsRsewuxIPYfrFMWppxtP12KWF3h+AT/E=;
        b=Do8yIw9dWBa1lK6yY2Xdvt62f59xk9b+z8teH2xSuEU3OUqGwqJkQNZ9c12rX3fVDG
         Smo+x2iKwiUZ5U2CXThnt20BX+aSgXtmeGNvOLz1A3r6+mLThl0eafr54qJcM8vPVwTe
         1RvBnkXwvlKOlQNRChBXGqRwmq8nf+BOrPW2t6aucqDiUUPEe9x9aLNd+rbla256Qx6R
         sdqTBkh7TQmTfTqRT5v03J44fp/Tei9+0RiP/BCMFK7qvAjSQ11+v+dbGQZHSvxXZbm9
         MQ3gM2xJ/TqTmfC1Di85k3sf1JYiD52kDES3flgTuWLnVSkSBs12vPHJdgfmop+WjDAT
         E54g==
X-Gm-Message-State: AOAM532VnNQwTH4d3RUy918muUN328Bqhy3P/OoynxZT2QKRkh7bmXGR
        WCJyAxf4uiQrnZbC5JNgg3ywiuFSbXsy+k2A55nmWA==
X-Google-Smtp-Source: ABdhPJyk95h8kjbt/e+9r5veUCUzCG++Uo4zKtENU7XcGtXnu1oSRlYuRc7RbFkXlULda/JAPAu/ci5g8Ukjh83u0SA=
X-Received: by 2002:a1f:bd15:: with SMTP id n21mr492215vkf.16.1598874691724;
 Mon, 31 Aug 2020 04:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200827222457.GB12096@dread.disaster.area> <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk> <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk> <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk> <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org> <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org>
In-Reply-To: <20200831113705.GA14765@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 31 Aug 2020 13:51:20 +0200
Message-ID: <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
Subject: Re: xattr names for unprivileged stacking?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 1:37 PM Matthew Wilcox <willy@infradead.org> wrote:

> As I said to Dave, you and I have a strong difference of opinion here.
> I think that what you are proposing is madness.  You're making it too
> flexible which comes with too much opportunity for abuse.

Such as?

>  I just want
> to see alternate data streams for the same filename in order to support
> existing use cases.  You seem to be able to want to create an entire
> new world inside a file, and that's just too confusing.

To whom?  I'm sure users of ancient systems with a flat directory
found directory trees very confusing.  Yet it turned out that the
hierarchical system beat the heck out of the flat one.

Thanks,
Miklos
