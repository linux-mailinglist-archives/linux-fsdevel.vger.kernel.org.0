Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842222B4D8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbgKPRht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733098AbgKPRhs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:48 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B33E222EC;
        Mon, 16 Nov 2020 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605548267;
        bh=ftduAERcAIXDqH3TIoaKNDFMaog9lpKkHZKNbYpzPJA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wH0K96aiOcV3zWDXEfO4eGXrSbfel4fzpavvJrcvlGnm+IOvE6CCXcyPRZ9CDEpWQ
         ERyPgn3goZaj4Rjri8kCDsRD2QqVIDrl9bwMtmzAsZXelVyGcoi/J8IVVb6h9ki8ms
         Nt6zKSXy/JZjbcTnM2HNzH4y+CQMSryqUl+eemUA=
Received: by mail-wm1-f52.google.com with SMTP id p22so25432wmg.3;
        Mon, 16 Nov 2020 09:37:46 -0800 (PST)
X-Gm-Message-State: AOAM532+D7CgVwSiMMWS3UnCwBorA2v4LkI7ZN8sQJ8ZqWXcaPOmRLIQ
        WKg7/hX4Hr+f4oBq6+kb0J6ZN8cgd7LU/vzhKLk=
X-Google-Smtp-Source: ABdhPJwSJNXG5A+c75VC7fB+eg5ocrYD0cMopnWErnzA3/FY5Qe4JfgRdEHZElz1KxxX9qTRF1opV72EejXl51sD+G0=
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr17490114wmf.133.1605548265533;
 Mon, 16 Nov 2020 09:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20201116145809.410558-1-hch@lst.de> <20201116145809.410558-29-hch@lst.de>
In-Reply-To: <20201116145809.410558-29-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Mon, 16 Nov 2020 09:37:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5YeO0-Cb=avHu2osRKjz19Lvk4jWqaCdaqFnjbdPJtrw@mail.gmail.com>
Message-ID: <CAPhsuW5YeO0-Cb=avHu2osRKjz19Lvk4jWqaCdaqFnjbdPJtrw@mail.gmail.com>
Subject: Re: [PATCH 28/78] md: implement ->set_read_only to hook into BLKROSET processing
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 6:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Implement the ->set_read_only method instead of parsing the actual
> ioctl command.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

[...]
