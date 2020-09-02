Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2B25A547
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 08:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBGAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 02:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgIBGAG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:00:06 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2C02087E;
        Wed,  2 Sep 2020 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599026406;
        bh=qB+hJ64dFeZRc55gn05GV3vmMdd4XqXGRfV9RvpoPjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JqU9YnsiEoVREgjZ71Q/lL0R6o0EvweniYCjQHmZvalUDy3rvHQkm4LnV7xm516+5
         i44auPRkW5t9zHw3YFDMX19Y5N+9rzXm6bs4PkFlebDybJZjXbsCNTY5eGBV0puiMy
         sNpdFMjzaKtGyGvelhK6a9BVR4FwsrpX1LzGiNrc=
Received: by mail-lj1-f182.google.com with SMTP id a15so4414528ljk.2;
        Tue, 01 Sep 2020 23:00:05 -0700 (PDT)
X-Gm-Message-State: AOAM531bVAVA21EgyfFZ2F0YXnyAilIZkSylt5ZyrDrWVXFnOSNNCwJz
        /xVvVJOeTVOM13pbmsgYgEewvwkgSlr9lBPvIHs=
X-Google-Smtp-Source: ABdhPJwf3HULiufgbpwKVoPwmf+LkIKFmte7J3KnU2uOXqQt3v5M5F/QoyNcLdziLtm9PrTb/1L0NAY4kWOOlCFV810=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr2427127lji.41.1599026403505;
 Tue, 01 Sep 2020 23:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200901155748.2884-1-hch@lst.de> <20200901155748.2884-10-hch@lst.de>
In-Reply-To: <20200901155748.2884-10-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 1 Sep 2020 22:59:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7YKTHsWnqv22gq6VEz29=abYk7ADsxcQr9q3_kGZuiXw@mail.gmail.com>
Message-ID: <CAPhsuW7YKTHsWnqv22gq6VEz29=abYk7ADsxcQr9q3_kGZuiXw@mail.gmail.com>
Subject: Re: [PATCH 9/9] block: remove revalidate_disk()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 1, 2020 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Remove the now unused helper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>
