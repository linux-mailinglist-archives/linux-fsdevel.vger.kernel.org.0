Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4B3FC2B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 08:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhHaGXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 02:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhHaGXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:23:32 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB136C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 23:22:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id p38so36348519lfa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 23:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=DuxIG8sTbtBLyaPFMzb5TkAnpLmPvjtfwBU4PAc3pKgSKLe2jhCtfJT53FgM3uTqSy
         aIeMZ83jdMODLOrbnGbdQ7Uxv4WcA/9YiBVFnm248YaTDwa8CFhU4teeecrypNlUHOfD
         mkPnYCD/VM6wivzvWmkbpgd6dSfRcEX8BwBVmHhGS6r0GtokwmwsYSWyvxRx6CJWVP4K
         Nx2W03zUHZn+YGKhmLCfTrUuC91Gwrtj3Fsl8Q3u+NsiY2pHHBm+RK8wg0Lwi0rbEBrs
         hPT3j1A4v1LhRfM7KzgS/pRXdsDvjJu+Dr7+YxT8tIrGlGcslARafdxGRpPycW5+0J7I
         hy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=M1cw9VS3GW+vvzqLkwcyqaaUD2dF3vzRJCLemkwxN3+w2+GXPutzoUgQGZI/q/qpLo
         Buv1eWYAAl50lJY8evwp2cmZwmK5aEnRx4tOqhx0SuWF8EUQf5tqMTyXYO2U4dvhvxwy
         doUgxYcct8S+xocT5ZsbR0BuI59UVQKCpKp61eeIr+rOiPU0LqldWHFJlioDRRe7MVtc
         UzZbnXnxWFXGizKrlDZwagFrpcaT9MS9sJmy7NJq0/09Lx5RTtFjpXi5N+6oAk4xDpCQ
         mD/87gDJjJCaESG/NmroKmrKuDsij2SQRa/lEktC9uD6XG9i2cCaHCwdaGjlI6O2F+ZH
         VIRw==
X-Gm-Message-State: AOAM5316EIAplWNkkMQRDftOYwn3G0eMYlKabTRu2sYLZ70jZVYYIbBg
        Itrwj72Ew5U4dR6kRI4hr1A6DnGsOPoCMiHQvyk=
X-Google-Smtp-Source: ABdhPJywMA2/qyyyjMmmGvrLt2YdbKL3ZH1pRqivBRAHTS94cEyhTB+pRj3sq9wr86nd2Il9ixR3ImthkOV5d1Cvy9o=
X-Received: by 2002:a05:6512:10d3:: with SMTP id k19mr20109791lfg.481.1630390956046;
 Mon, 30 Aug 2021 23:22:36 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: anitaholdings1860@gmail.com
Received: by 2002:a9a:7407:0:b029:c8:dbb9:6b13 with HTTP; Mon, 30 Aug 2021
 23:22:35 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Tue, 31 Aug 2021 08:22:35 +0200
X-Google-Sender-Auth: cHIPnxQDQzwILo334ZylmXwsYWI
Message-ID: <CAJ9gDneatrX0CYsrcwRtLsatv2b4jmVou2tj7Q2w4MWCXLKetw@mail.gmail.com>
Subject: I just want to furnish you with this good news
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I just want to use this little opportunity to inform you about my
success towards the transfer. I'm currently out of the country for an
investment with part of my share, after completing the transfer with
an Indian business man. But i will visit your country, next year.
After the completion of my project. Please, contact my secretary to
send you the (ATM) card which I've already credited with the sum of
($500,000.00). Just contact her to help you in receiving the (ATM)
card. I've explained everything to her before my trip. This is what I
can do for you because, you couldn't help in the transfer, but for the
fact that you're the person whom I've contacted initially, for the
transfer. I decided to give this ($500,000.00) as a compensation for
being contacted initially for the transfer. I always try to make the
difference, in dealing with people any time I come in contact with
them. I'm also trying to show that I'm quite a different person from
others whose may have a different purpose within them. I believe that
you will render some help to me when I, will visit your country, for
another investment there. So contact my secretary for the card, Her
contact are as follows,

Full name: Mrs, Jovita Dumuije,
Country: Burkina Faso
Email: jovitadumuije@gmail.com

Thanks, and hope for a good corporation with you in future.

Godwin Peter,
