Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321EB32279F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 10:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhBWJPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 04:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhBWJPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:15:03 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F48C061786;
        Tue, 23 Feb 2021 01:14:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id g5so33476335ejt.2;
        Tue, 23 Feb 2021 01:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5MtT/ZdRPwH3IHGkszx0Ejluf/ndHyk503G2Rm9ils=;
        b=GpmmQZlnXzGD1kHuc6Kv9xigy1sJuXWH3dZqg5Vs99WFBxoTWCU3/K2DIiXLQsBorm
         ULOdBhuPEWDqrfccYAmsLtGjShSlT2/jstrlSPytLEjFi9HQZyjGdZuEDSinUPb+5vJI
         HkBA1eC5zA1OJUnBCMMn/pM+N1kKZesZh2Rnca8nG11WiF7WKycWDgBdL7NRxbnc2WZ6
         uf/QXhrDcViYI9wwlB+U2qXnfped8ad53tAqxuE4VBCYre+hx181ANfb8L7B7vMI3ABL
         MHQUAezy7X8WjIH/kMEDknmITMqhlj4Ej93MbWOQLMYU5NLjTWNAL6xX07PzRWaCbakk
         6R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5MtT/ZdRPwH3IHGkszx0Ejluf/ndHyk503G2Rm9ils=;
        b=WMjjO9+CJZR4JQBZ5aVkrhSW0d8HlEzwh1Yjh5vLKxGXodF2aR8+f3aozG0GL6y8+h
         3gOFnVUmJNyUPlf7CZ5GPn4VZZAcA5D3HhyeIbnQn4HrBUujmrZ+VITPk65qjA4cBKer
         KvdWHMX5J3+lTjaEbA43Fjq4qeMACOrduShDUJFuODh6V05zhHeKD5+3cfnC0X+jcN51
         8guYSiRr48lN2iaIZAYNw/bUV4AkpDVKFPz17Ed5v6QJIYVVP1KZCYzM71qIOvqHWkj1
         fu1MAWFWSH+zUmN6XEcFPqm/pEx2FxYVaTBvEHFp8L9/pj4guqJAHGjfcmilZilia6T2
         zh8Q==
X-Gm-Message-State: AOAM532J05RamEIesmGYD9joDDGsB0S9aIUFYPZ27zvaI9ztU/XKS2mS
        +PiWbFHCDUEEjolviDR2Uyh0mvkflLKexXz7MC8=
X-Google-Smtp-Source: ABdhPJz4R4ZgmznPz2GNNWvnywZAr4uBgUpJfEA7xJHHLpa6gxqaLqhgwSOdWYHkRTdp4nIUPMj6SIo3LCG1a0yXTfY=
X-Received: by 2002:a17:906:2a06:: with SMTP id j6mr23964456eje.164.1614071662110;
 Tue, 23 Feb 2021 01:14:22 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com> <20210221235248.GZ4626@dread.disaster.area>
In-Reply-To: <20210221235248.GZ4626@dread.disaster.area>
From:   Selva Jove <selvajove@gmail.com>
Date:   Tue, 23 Feb 2021 14:44:08 +0530
Message-ID: <CAHqX9vbG-cB0h25y4OhcdOEegn-_E=HwHJtkPFGaurEF9-KXPw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
To:     Dave Chinner <david@fromorbit.com>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, joshiiitr@gmail.com, nj.shetty@samsung.com,
        joshi.k@samsung.com, javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave,

copy_file_range() is work under progress.  FALLOC_FL_UNSHARE of fallocate()
use case sounds interesting. I will try to address both of them in the
next series.

Adding SCSI_XCOPY() support is not in the scope of this patchset. However
blkdev_issue_copy() interface is made generic so that it is possible to extend
to cross device XCOPY in future.


Thanks,
Selva
