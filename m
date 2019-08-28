Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9C9FC24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1Hpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 03:45:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44812 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH1Hpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:45:40 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so3945121iog.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2019 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqkmpot9s6gPML1W2+U08e8kxWH1kqOpgIslvJ6ETaY=;
        b=dhNnulrZXhgiY7H6M+oJdiiIwYTeim61SHJlStKeam/O6Txv6bzIsCPGf1aTvCiGGC
         TX4oGm3mf/6F7uOsTWqquRw/W1VoA3P0uDRu7tmP2WSvzGWA/XKlTEvFiY+1asbMoW5T
         GOEa9uhLbKi979xcEOROpziFYXdhp8Wq1Mgow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqkmpot9s6gPML1W2+U08e8kxWH1kqOpgIslvJ6ETaY=;
        b=aIQHnUEnVUSDb/rIh8JJTw75zAXkJ/h5SUsb1RzFxuvVNzvitLtNY3zF707iQeX4DR
         ofzGahaZSqnrgmSUQuenqKUGdbasjCWktOZSWN1MqmxzFb9HVkO1A7DWzyFzvxPw6LYo
         CEepY4Xj/9yZIZF0lkO5xhZp8L043mITY4rBDPShxf4yT2lXc/7UqqZRzD41xUX+Iz0F
         O75D8HyqkxEs60r1ay8C9DLQ+bAT7BAfRjH7YV9u/Z9VN3RONx0uW5QbqBZvBG2rn0C9
         KDsqlVzqdTxqHOs4keA4KiERP5D9Y+I+mGpBwJ9poLOBwu6mEERv6eNZEtCgAoX47Zco
         A06Q==
X-Gm-Message-State: APjAAAX60nnCqbgTdvWHhLe1Cf+jz/9eTirZqib1WUBtVD/b/tXwZ0Or
        ySggkgecO8KLDr5KqqYp/ltX8EU6IXqzZdvoiYL4Lg==
X-Google-Smtp-Source: APXvYqwvcgiWD5jnYj6W7sjF0Z06MFIOGVfOgyU6g+WXl4ZvJZBSr7UCmhcfmcV09SKbgqMIBLz+K7UVbXQPXD0ih5w=
X-Received: by 2002:a6b:6f17:: with SMTP id k23mr2169967ioc.25.1566978339324;
 Wed, 28 Aug 2019 00:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <20190821173742.24574-3-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-3-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 28 Aug 2019 09:45:28 +0200
Message-ID: <CAJfpegu41FYEBfniEBPtujgLW4nC+w6_6VG2EmNi=kC8ZeNFtA@mail.gmail.com>
Subject: Re: [PATCH 02/13] fuse: Use default_file_splice_read for direct IO
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>

Nice patch, except I have no idea why I did this.  Splice with
FOPEN_DIRECT_IO  seems to work fine without it.

Anyway, I'll just drop this, unless someone has an idea why it is
actually needed.

Thanks,
Miklos
