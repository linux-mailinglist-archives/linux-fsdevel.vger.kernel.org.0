Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00C436B543
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 16:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhDZOyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhDZOyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:54:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9460C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 07:53:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r186so28893995oif.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibJTobElv1XvOGB4d1xVrpvY8M7dbu7eY2KcbAZ9aWU=;
        b=zzWDVhCEklNBcUHpsLkRApBJ/vmIkebI4esQ9VpZmMismdzZR/ti4dJpyOgjyC91bD
         8PJdjzvFS1DxKscY++kwRoxZQAyRmE+XxLZ92dAvlvOrFI03Kd9rv+8X9qQa3n/yx6eM
         9JfTwjDpR1kS5O/YmyEWxK0CTL8yrqb8VdVyAvfE1Xb62UeMlkfD736jeaEc0K7XWWt9
         Cx/6rmNK/ZYnjIG15QwruiEGd3k/ntauzI8KNyd1U0LP4O0we2TSFCyJjoblatPZe7u4
         cCYo1YkkkRJGISGR5L3kOmwAUNk1YVvs+BFvPprghfUnQZosnltaYP3fP66yK2UiaP5W
         RAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibJTobElv1XvOGB4d1xVrpvY8M7dbu7eY2KcbAZ9aWU=;
        b=G+u+3rAN2CoDBQjP9L7Tm0LxuWYbud6X/dv8MOmxIVF8hdVlisDFfe98B9fbRQVJfP
         o6VMHhBRA6nvP+KSBWv1pQp4SQAaK8jgDey/KcYpOyxp9PohgrVKSqtUcUXudc2vWisU
         8miWlQG0svb09HCnvtk7rTgtuelEmSJI4oP2k3RrH4RpO4xYIa9WmgAw+fwcF/JCzWlE
         oCpq6T9sQj/g6Yofi+j/HMlCK9WZ9AIPN/Qo5Tfa8sv/TbwaYS9PK1oiou4xonxWMB3n
         WIXzUIDHeXDEqTDqZGO1tD5GQtydXKy7mhAD/dpwqyvQSA3BRl7ZM0J4ofYqrHk4hpbL
         4k6g==
X-Gm-Message-State: AOAM530Y5OMPih6if7n8DNCcv2PyAc3qwT7D1C3iAnUvVvVqZkRsjTUf
        rM9yHVmZ8Q/tctiN9nshqKFMbxJGjYO+xrxiis2HJg==
X-Google-Smtp-Source: ABdhPJzAljarv4jICE12iIE12//03vtnWZauPrhnt/jP0rWbBwY+RXviEK1TV+GLqZJmd09qxq9VOhwKcN/bqYCcFiA=
X-Received: by 2002:aca:ea06:: with SMTP id i6mr12453712oih.82.1619448835023;
 Mon, 26 Apr 2021 07:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
 <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
 <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com>
 <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com>
 <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com>
 <1612829.1618587694@warthog.procyon.org.uk> <CAOg9mSTwNKPdRMwr_F87YCeUyxT775pBd5WcewGpcwSZFVz5=w@mail.gmail.com>
 <3365453.1619336991@warthog.procyon.org.uk>
In-Reply-To: <3365453.1619336991@warthog.procyon.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 26 Apr 2021 10:53:44 -0400
Message-ID: <CAOg9mSSCFJ2FgQ2TAeaz6CLf010wbsBws6h6ou0NW8SPNBzwSg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Is it easy to set up an orangefs client and server?

I think it is easy to set up a test system on a single VM,
but I do it all the time. I souped up the build details in
Documentation/filesystems/orangefs.rst not too long
ago, I hope it is useful.

Your VM would need to be a "developer" VM,
with all the autotools stuff and such if you build
from source. I also worked on the configure stuff
so that you would learn about any packages you
lack at configure time, I hope that is also still good.

I read your message about trying again with the
"Four fixes for ITER_XARRAY" patch, I'll report
on how that goes...

-Mike

On Sun, Apr 25, 2021 at 3:49 AM David Howells <dhowells@redhat.com> wrote:
>
> Mike Marshall <hubcap@omnibond.com> wrote:
>
> > >> I wonder if you should use iov_length(&iter)
> >
> > iov_length has two arguments. The first one would maybe be iter.iov and
> > the second one would be... ?
>
> Sorry, I meant iov_iter_count(&iter).
>
> I'll look at the other things next week.  Is it easy to set up an orangefs
> client and server?
>
> David
>
