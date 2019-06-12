Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E402841E22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408349AbfFLHpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 03:45:01 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:43489 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406905AbfFLHpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:45:01 -0400
Received: by mail-io1-f51.google.com with SMTP id k20so12143866ios.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 00:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l36l6rgXJjBp7WT8DoKnKddflMVkAl9NPX+tIDTsP7M=;
        b=NyIRuepvVwEhfpbweh/9CAqg7jfi15wkAGC1Hg6ZfQk9ZsH25Q5u6bkSe2WZZeeS0b
         N+Bqh+7rYGJZFcCzwt88V9UX/haEirXEHYi69Ore/VOD0z+vktfySUgZLkhfnyi+A2GP
         dDAK5Rxd//hiFWARA+L8cVm0k2T+YqYb+DdRWB/GrGgmTH2v1ciU8Qnk1qDM9hx4dK9k
         PRiwcGAFHr22yeNunqiR5GrHeehwy5QH6p8VyuXaYJEiZson5qnDum1cuLPkYuTnpcy9
         hSIpMzFZCiKlqC3x3EUq3esk3KzqXQxeu7p0Jt4g7uO+Kt2rPfYwtHAa5wvIrh0glp74
         B2Bw==
X-Gm-Message-State: APjAAAU5IqS4MeGzHymGjozTO04kJ7gvdLVtqr8DlN7X/oOoDhLvB8Qc
        ghGIXZIGlCWUrjausd48qgY79aD3QMsJWtOUEC7yuA==
X-Google-Smtp-Source: APXvYqwwaZWfePLYFsCiLtb7oYBD6kiahVJodU8/jNzkVTzP70DSAzO+zjV8pQUTTo5nxDK+A4PLeeWqYL2eCMCE8sI=
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr17892965iog.255.1560325500724;
 Wed, 12 Jun 2019 00:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
 <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com> <20190611202738.GA22556@deco.navytux.spb.ru>
In-Reply-To: <20190611202738.GA22556@deco.navytux.spb.ru>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 12 Jun 2019 09:44:49 +0200
Message-ID: <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com>
Subject: Re: Linux 5.2-RC regression bisected, mounting glusterfs volumes
 fails after commit: fuse: require /dev/fuse reads to have enough buffer capacity
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Sander Eikelenboom <linux@eikelenboom.it>,
        Miklos Szeredi <miklos@szeredi.hu>, gluster-devel@gluster.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:28 PM Kirill Smelkov <kirr@nexedi.com> wrote:

> Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)` for
> header room change be accepted?

Yes, next cycle.   For 4.2 I'll just push the revert.

Thanks,
Miklos
