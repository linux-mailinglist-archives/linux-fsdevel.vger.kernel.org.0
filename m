Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50D0A5C05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 20:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfIBSF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 14:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfIBSF1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 14:05:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF5FBC057F31
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2019 18:05:26 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id i2so14236464iof.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2019 11:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkgUaL8VzlklW86uya8kYZjjavCTUDQ8aI35FGVFq8s=;
        b=aRFA0HxZd6sSX5uiMYtvK/gJ9+GxrC5qEYzhFDbXJEXvqQTASsPq2wOp/3Ggq6ERmq
         Z07HCF1pFfOrrIulMZPMtdn164+l7hSKQ1nN14m4gGBf0rm9ypKBLttZ7W0BgyMX1WN7
         TR6ahLawIlYH0+CwP19k18o8rft6fyGpenxCkad7xsv6LpMgRY/xNmqwzq4rIJYKWnXt
         4y3ex3IwKkleEchOKIyX429qLJS8kEyhEGCNSt4yl4Rgb1Mye3RLfWmH/iB0lzAfu4/l
         kAzp7IZMKCR2fJzDCXOdTcLEr0ooB8igGIJmvNRvvI+e+yyIi6AGdQLBvQrhoMNcVrmU
         4xcQ==
X-Gm-Message-State: APjAAAUWZSP1QZYwr5squ1UcBIRiB+8WxetN6LVIIqh9l/jeJy9RSy86
        w5SYZt5UAwEDaHkuJj7xnM2UbkSAYgibtZWdB1xVkd376ZAAROvRvR3V3ZQ1NlvWGK+xddV9H5I
        Piky5ZRmhScJKR9MsCkDpTPzD/lRQYJSScHPjXSfhUQ==
X-Received: by 2002:a02:9a12:: with SMTP id b18mr26263193jal.70.1567447526342;
        Mon, 02 Sep 2019 11:05:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnLzafJ6PcT24LmpFEMVCZaodz/wkINz7GVGLbos75Tlsx/zjDptZUOJTEX5bD3/97D/+Tpax1FDlAP1hMiDE=
X-Received: by 2002:a02:9a12:: with SMTP id b18mr26263171jal.70.1567447526101;
 Mon, 02 Sep 2019 11:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190902143915.20576-1-yuehaibing@huawei.com>
In-Reply-To: <20190902143915.20576-1-yuehaibing@huawei.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 2 Sep 2019 20:05:15 +0200
Message-ID: <CAOssrKdfyd0=Vod6DC9AiN=wNnPaT2nN5MY8tSq73m80BLoANg@mail.gmail.com>
Subject: Re: [PATCH -next] virtio-fs: Add missing include file
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 2, 2019 at 4:43 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> fs/fuse/virtio_fs.c: In function virtio_fs_requests_done_work:
> fs/fuse/virtio_fs.c:348:6: error: implicit declaration of function zero_user_segment;
>  did you mean get_user_pages? [-Werror=implicit-function-declaration]
>       zero_user_segment(page, len, thislen);
>       ^~~~~~~~~~~~~~~~~
>       get_user_pages
>
> Add missing include file <linux/highmem.h>

Thanks, folded.

Miklos
