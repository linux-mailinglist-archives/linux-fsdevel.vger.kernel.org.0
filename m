Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E61A426F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 07:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHaFqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 01:46:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40306 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfHaFqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 01:46:40 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so3129142iof.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 22:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOhpJr5tHKYGv4ZK0AZEodoAvczvxbwsxiG+g58CPSs=;
        b=AzNCUdOEXkVwKcnJjrrzdT8T9BXEGdnj5LnXTA3jsHKPVwhxRTS54L+zKAJfk1McCZ
         v2iSDmsKiPscsLnl1Q75W2eXy5q7fRUcnEG32yp0RRQ+huKkKuvGVbQGQT54TWd9O9JZ
         EGlVNMqeKOnWWUGl3SbbozlhVrqQ0d5tZ+dV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOhpJr5tHKYGv4ZK0AZEodoAvczvxbwsxiG+g58CPSs=;
        b=NDs//TmQz2Jf9OOlSY6u4xZxDQQg+IJ5bPAVLHUcbwPRsIEaFhEj8a6sLPp+utJAoR
         xjwFW6a+rZZfWT5pGq3/lsoreNi8qoddz2XujvvNSNEzIcs+/coxN6bbrcQc6naAvcP9
         Z6hBdxT/i7WvdWGZf9543uOimkZ40Co0itChK6ptpceK5v0wFJKqs/xm5g82QOp63j0B
         CApV9OK+A6igFQyS+yBByt+zijscC0aZDJUspFhlc+bAnSsrdsGXt+kCHSsr/VTWsf0D
         3rErc8p+zUgTY/q9PTVmqkGkb2Vs+FwK7I73Z9ilDuC0saslLI7LfCPnUigO/ayzpI1y
         W2QA==
X-Gm-Message-State: APjAAAWoxu/HmKyTZSFHbMcGrPkWvBCbvYVhK0Z5qZI5CoC3WyodJmoV
        apEIHdPDSMUtwyIV0paHdaY6ro3LaMlZCNlzuajVVw==
X-Google-Smtp-Source: APXvYqzTQ6X1gw8RVQ9UztzASzRQB9OfdUi4aEvgBDjMnNaXFg7p95/i1Qk3oGdVaCTySPWdW4nWnQQzC2V7P3kIS2c=
X-Received: by 2002:a5e:da48:: with SMTP id o8mr13245634iop.252.1567230399342;
 Fri, 30 Aug 2019 22:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
 <20190829160106.GC6744@redhat.com>
In-Reply-To: <20190829160106.GC6744@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 31 Aug 2019 07:46:28 +0200
Message-ID: <CAJfpegvnx=Na67367hAXNX17P6qv2nJ-OaL6FPSEa07qL4Jxgw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 6:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Aug 29, 2019 at 11:28:27AM +0200, Miklos Szeredi wrote:
>
> [..]
> > There are miscellaneous changes, so needs to be thoroughly tested.
>
> Hi Miklos,
>
> First round of tests passed. Ran pjdfstests, blogbench and bunch of fio
> jobs and everyting looks good.

fsx-linux with cache=always revealed a couple of bugs in the argpages
case.  Pushed fixes for those too.

Thanks,
Miklos
