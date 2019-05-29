Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086D22DDD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfE2NPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 09:15:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43095 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfE2NO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 09:14:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id u27so2012606lfg.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zo8/tL88lhYZ8ZmjXhe5I0ivQ63AMHIIXfJiG0SngrI=;
        b=WcqJPV36GoYCJyCKWssunS/8jjCOcm7506dwRBLhvYgsNR0UdI2bR6S+PaChd3NF+e
         P+/GUrP8I1gxdIuXwHh6CxrPM6FsQK897PtueXW2sc688u6UEVtahdPaDHpbLdURczG/
         exuh5TP/Fn7NuWWJubwb5BOU06YIqB0/o8baMnCRHH/ihY5uaT1si7LXcC8p9MWXL18d
         oOzuzN3xy5AjXeHWyQmqeSM1pM2ZeR9RQEvA5xn86EDD7CpzITSwgBRLK8NSiZHIhZG2
         4dGKz3NjhIgq/QlLySTSs2ZLnXWGPjQaDD2AF5PW0kac6rHkp3GF9xtJmzZ2Gi7XnFzZ
         e6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zo8/tL88lhYZ8ZmjXhe5I0ivQ63AMHIIXfJiG0SngrI=;
        b=Lfv/eFj5fGFWsmOJ9BMszv5IYWuJ0n3g2Kb1SQMnLk1WG/UfpYuDjKIE5Afe2MIWGE
         5J3uHPQBHhwjGJjy9xusLyONvDemZR2XMH9KoKaRwce6qkXDYNOm3rHv7ZpbVH0uWEpq
         9CyYAgQ/qwFwvKK5mJ5fvC66VTCFAWmt6XnuKaHvo3+tV73n4Ti4Lt/T4QqLSGSNlLoO
         8Wd8UrR8LInMWk3fClhBLNqL+LKv5PGEqEp2VS3iulWQ+Y8QDi/q17NTMP7iqFjHEKR5
         naz0h66JN+WfHvim16wvATa2VXyjVzWv7VaLAXGfn2o7F9l3oJT6IvFMzYxUcJVN1CX3
         0o6w==
X-Gm-Message-State: APjAAAXvLm1EzwKSkmciTLsSuEvCXHGW4HJmVQUvev8LoebnEfuvhHjo
        Su9FJDffk+NlaGA6JLk6Y16RfvuBq5IXRlSNxzCJ
X-Google-Smtp-Source: APXvYqw1iYjVpziXjswrmlU2rI862bFdoZ/LKvGEmuAIzGxOxKMlkrc2fuaVbN9QOa1jFVN2h6hTKGffJR8WNirL26o=
X-Received: by 2002:ac2:4358:: with SMTP id o24mr5608001lfl.13.1559135695377;
 Wed, 29 May 2019 06:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554732921.git.rgb@redhat.com> <509ea6b0-1ac8-b809-98c2-37c34dd98ca3@redhat.com>
 <CAHC9VhRW9f6GbhvvfifbOzd9p=PgdB2gq1E7tACcaqvfb85Y8A@mail.gmail.com>
 <3299293.RYyUlNkVNy@x2> <20190529004352.vvicec7nnk6pvkwt@madcap2.tricolour.ca>
In-Reply-To: <20190529004352.vvicec7nnk6pvkwt@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 May 2019 09:14:44 -0400
Message-ID: <CAHC9VhScO5yfnM2tn=_6OKtuU5P_LukPfmnE06E0hVE-2e++uw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6 00/10] audit: implement container identifier
To:     Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Cc:     Dan Walsh <dwalsh@redhat.com>, Neil Horman <nhorman@tuxdriver.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        Mrunal Patel <mpatel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 8:44 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-05-28 19:00, Steve Grubb wrote:
> > On Tuesday, May 28, 2019 6:26:47 PM EDT Paul Moore wrote:
> > > On Tue, May 28, 2019 at 5:54 PM Daniel Walsh <dwalsh@redhat.com> wrote:

...

> > > > Mrunal Patel (maintainer of CRI-O) and I have reviewed the API, and
> > > > believe this is something we can work on in the container runtimes team
> > > > to implement the container auditing code in CRI-O and Podman.
> > >
> > > Thanks Dan.  If I pulled this into a branch and built you some test
> > > kernels to play with, any idea how long it might take to get a proof
> > > of concept working on the cri-o side?
> >
> > We'd need to merge user space patches and let them use that instead of the
> > raw interface. I'm not going to merge user space until we are pretty sure the
> > patch is going into the kernel.
>
> I have an f29 test rpm of the userspace bits if that helps for testing:
>         http://people.redhat.com/~rbriggs/ghak90/git-1db7e21/
>
> Here's what it contains (minus the last patch):
>         https://github.com/linux-audit/audit-userspace/compare/master...rgbriggs:ghau40-containerid-filter.v7.0

Yes, exactly.  Just as I plan to start making some test kernels for
people to play with (assuming v6 looks okay), I think it would be good
if Steve could make a test build of the latest audit userspace with
the audit container ID patches.  It really shouldn't be that hard, and
the benefits should far outweigh any time spent generating the
tree/builds.

-- 
paul moore
www.paul-moore.com
