Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2758A119240
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 21:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLJUjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 15:39:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34296 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfLJUjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:39:43 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so20262967iof.1;
        Tue, 10 Dec 2019 12:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsqk4VJkWtF4RP8nPi1lbsDlBgE+mpnymQwD2RqlmNg=;
        b=S2u2O29jLqFmq7SzoyWAWbFrMwPV8AOmdG39L67/zuYibMBPOBHNwuHUx1bg7biMgs
         wU34ec6Dz6QUCNcnHXfWE3ohXarzmbiuycF6E7widu4Haaf0CqMv+m/ySf7pF+os+xC3
         1Iu9BZc+jpykhDPK7/u2N19ptt1zY06OYxlHxp3hA5pB9pKZ0jSEUcw9BLgi4Rd03agz
         yGjIWi0BY93LEUUc2cHYVOQTkddvE9Qoa1bw5iEHyaaQoqNKjnQKtHc8ZtPshmNWceFW
         ZLYof7uva9iHuM/fy+G/M0QYKVRimSBguQu0gyyeSKVxfImdHBsAOkhCQLaH8ANvSwuj
         oDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsqk4VJkWtF4RP8nPi1lbsDlBgE+mpnymQwD2RqlmNg=;
        b=OE/MGqeUIY88QmUay6MT9cmeDixwTtKWEGSZRwCK3l23efkB5BneZ4ANiJvQKdrzm3
         qoLC61zzNPGauYTJ6B/DYCkRlSoEpJ1lWJi0n0q/kDbBLEeU2wQ3/d+DutiltCohgoeY
         ekP0zjfAE7dDhQrLxNUyylf3a5N5i4HSEKSW0YjsOLrSLa9zuUxw673/ujrGD1UAih4U
         qlGHkugBsXiYfx7SngCbdkVsmf+r6PJZSy0Cb0G/5oNMbSISqsz/fQTdxi0ELwKYmX57
         RsVrcQp/9GYpahfHpNLtRLyFhDjwv4LPrpPRdk+1cD4jVZKVbtHHSa9ZygYEZ2M2O2PV
         VM8A==
X-Gm-Message-State: APjAAAWijpUC5Sl5bUboZ3CS4EMLXvgN7PT7ZNW1Seg+SA1ulH1EaxaN
        U4otL9dwx0L5E1CoWQM8LDSOLF25LLNH8VQM/g0mLw==
X-Google-Smtp-Source: APXvYqyP0umcK6/NGlARwhAvGSO8AShQiGPMBbXCr9EH0GjTecu2zkLYdTh2RN9j3nmbWNpI/jb3aYR7yoLzCRpaAMM=
X-Received: by 2002:a5e:c314:: with SMTP id a20mr27452642iok.300.1576010382879;
 Tue, 10 Dec 2019 12:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20191210102916.842-1-agruenba@redhat.com> <20191210203252.GA99875@magnolia>
In-Reply-To: <20191210203252.GA99875@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 10 Dec 2019 21:39:31 +0100
Message-ID: <CAHpGcMJMgttnXu48wHnP-WqdPkuXBaFd+COKV9XiRP6VrtRUVg@mail.gmail.com>
Subject: Re: [PATCH] iomap: Export iomap_page_create and iomap_set_range_uptodate
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 10. Dez. 2019 um 21:33 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> On Tue, Dec 10, 2019 at 11:29:16AM +0100, Andreas Gruenbacher wrote:
> > These two functions are needed by filesystems for converting inline
> > ("stuffed") inodes into non-inline inodes.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> Looks fine to me... this is a 5.6 change, correct?

Yes, so there's still plenty of time to get things in place until
then. I'd like to hear from Christoph if he has any objections. In any
case, this patch isn't going to break anything.

Thanks,
Andreas
