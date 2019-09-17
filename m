Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B3B487C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404465AbfIQHqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 03:46:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42172 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfIQHqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:46:31 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so5269857iod.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r390VayBj/3xi39RJHDAEzLS1ApSogHRMpyEDeFIW8U=;
        b=d69BRr0xyCV3c6m95lJoLGl50d5Ex2yqBOKw46rMtzmuV+Rwa2hW6rI6MP3zGZWCPJ
         PqIuE8ISWyF/nAilyQbnrrZCdoF2Wp/tzdsqdPKrpeMPGuLtcmuDTUONwR1pCJh5iggB
         P4e+ZNnTSwRYWzLJdcoe3g7iiH8ekCwtPMrto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r390VayBj/3xi39RJHDAEzLS1ApSogHRMpyEDeFIW8U=;
        b=dar8p8RCZK5u9zmWFThvLkEyJdCTXa/9IPsjBWg7DA5xVxDZaRkflE+b5J72GTIpAV
         p5ob0TjR+7m1i2vrCgxTuv+OKLgePTEVGGo3gTD0mLBBU5UivFnsnoRMoQTJIDcvrM3A
         rasXuC0R4cgt6ooTPKJZEq7Cdk/YGw9aIQXUOIuS4gNZfb8VP3hpeLxeMiJgmWrfN2CY
         7fo4dPARvZOiYTws4j3Jcpbv4jWQZl56JsZOvaEhlQQpDaG+ImXyb7kMPnLjQBoZPzKx
         D/RsE/llYriRUk2+2N+0sPaUgYeLiq0vwkzS9JBHGovyNlMDlywSm2jGv/BLxaPU4g/D
         VSog==
X-Gm-Message-State: APjAAAWi9ZLj8vGlbgPOlf8qW5Q0L8Ann2i70ho+/8SykIrzI0x7q9YK
        +RFj7xbqMG8ctoeAyt3c0R9POTy3T1qBQBrA13YsaVpc
X-Google-Smtp-Source: APXvYqzThDNp3uLhZD6yQ/WCujicMU9B0P8cMPS1zdRMUKzEUMRMi+zP6x28grxRopNvWCakybIIt5ptAYCVqLRZcYg=
X-Received: by 2002:a02:b388:: with SMTP id p8mr2684640jan.77.1568706390957;
 Tue, 17 Sep 2019 00:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190916235642.167583-1-khazhy@google.com>
In-Reply-To: <20190916235642.167583-1-khazhy@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Sep 2019 09:46:19 +0200
Message-ID: <CAJfpeguRPTRyb9eaEsKXmv2xsfJfy4vrNp05RNiL8AuqbDwkcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: on 64-bit store time in d_fsdata directly
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel B <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 1:56 AM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> Implements the optimization noted in f75fdf22b0a8 ("fuse: don't use
> ->d_time"), as the additional memory can be significant. (In particular,
> on SLAB configurations this 8-byte alloc becomes 32 bytes). Per-dentry,
> this can consume significant memory.

Applied, thanks.

Miklos
