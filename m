Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10B641EA01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 11:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353190AbhJAJq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353148AbhJAJq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:46:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61DC06177B
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Oct 2021 02:44:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v18so31964088edc.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Oct 2021 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n533ChCPVGBdnPyJS0mlfsYZvnJfbQbp16/eJTquzVw=;
        b=DsY1C6q3hGHHrhitH/3pS21hp9/THO/HsCU4MBik/CX1K+wbsQ2eW2oeUN1VN0vAY/
         x8uDYj8AolcEvGJR2rWRXYrBV+c8fE/ikCquEnXdTc2kw02dt8d3CGUimQFMgJE1Yn8A
         SsxFXmNh7U7m2WuDqZIWVJRieIFYF2OsP4vwdUU1VOTzqrmQX2aYqlJ8U7+HrmeZkD5g
         g1bAfCdq7jpf6xoJTQpEvOteMt+X85ICKmJk6lQrPacBV1tZ3EaSpJ/F4q3ZoUHVGH0f
         cyS2eEygNQO7COrQSKrl/vcZ/Gz+SD/BOoK4wMVCl1P2M6W67To6uKkiJBoHNilaVDrx
         /DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n533ChCPVGBdnPyJS0mlfsYZvnJfbQbp16/eJTquzVw=;
        b=cT8iRV4Ha0299aOGCp/a9mQTQJXDkD0daztTYnPquSl7ZW494UV0keCF5yMRbWLQ5a
         XMj+DqBei/yFlatNwlBb8FXElLkgKLV6wGp0S4WzMuambLoP5kpFOL9c9CPjEyhH2J3C
         DYULOW1mk3widGexJlO34wOe76LnkdjQ49yLyYuOqMR8QzRYYcfWTRVboi/iyHZnCFrP
         XyyKBKSpI20zXXH6hX9wt3sN50etmuoYAx8pnivxwciD1o0sEX31YTsk52smIRzfNNnL
         v15NvnE1O/H0yd9vcqWcOxvPYOb5vqxbvKgZ+J0LMhQJY2Jxjr9O5EnjMGDRrEi3VuzR
         v/MA==
X-Gm-Message-State: AOAM530X/0MtjdOriRYzhs/JUA1zEQoY+i5QStbVT84CZ8ZOCUOj+uo6
        ox4oWXa7IxLgjhYYIXJfZYGDPObLVwrq80va0ymxDi6wpic=
X-Google-Smtp-Source: ABdhPJw50DyfG079fXpSmMN5pr3chZ1Bcy9FjGp9x3LqEuj4x4lrj4aW09PbCUEHQYDn0Og2csZVcig+vRtR7LRsdWI=
X-Received: by 2002:a05:6402:54d:: with SMTP id i13mr13214126edx.389.1633081482659;
 Fri, 01 Oct 2021 02:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <CADYN=9KXWCA-pi8VCS5r_JScsuRyWBEKqtdBFCAGzg1vq4M5FQ@mail.gmail.com>
 <20210930143943.GA25714@lst.de>
In-Reply-To: <20210930143943.GA25714@lst.de>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 1 Oct 2021 11:44:32 +0200
Message-ID: <CADYN=9+1k8CM814kzMQe_neqRc_MQdtfVR+=QPV6zwawYzntgQ@mail.gmail.com>
Subject: Re: regression: kernel panic: 9pnet_virtio: no channels available for
 device root
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 30 Sept 2021 at 16:39, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Sep 30, 2021 at 11:25:45AM +0200, Anders Roxell wrote:
> > Hi Christoph,
> >
> > I've found a boot regression when ran my allmodconfig kernel on tag v5.15-rc1
> > I've bisected it down to commit f9259be6a9e7 ("init: allow mounting
> > arbitrary non-blockdevice filesystems as root"), see the bisect log
> > [1].
>
> Please try a kernel with:
>
> "init: don't panic if mount_nodev_root failed" included.

That worked for me.

Cheers,
Anders
