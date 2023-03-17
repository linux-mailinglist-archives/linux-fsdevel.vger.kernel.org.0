Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B146BE7E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 12:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCQLUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 07:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCQLUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:20:08 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D80B13534;
        Fri, 17 Mar 2023 04:19:41 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id t4so4190978vsq.1;
        Fri, 17 Mar 2023 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679051979;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cFGw0u2n8KUD7BLlUXmazMizht5nMVZl6kSY6hio1Q=;
        b=nxtxSikDDAG8XEtAosNM++fPa5RqD9NA4jqriO7+7M04XoME9Q8LiDk+9JC+w82cbY
         ZSnLEwsYWb41RRo788qjdcNs2WJPzMMxQkL+icN+E2BhWr5pSMhv9j434zDKTP6FpWWS
         82TZGEJUBq8nFjbYlOXd2BU1exsx7NSwsvY2pmmY81mQaciVeOtJ530qK3hnzNrXk2m2
         HRMWJd7aVXD3/vPIifjK5IEm+ZOM7BpqOZD4Cj2WE7Vh+jA7/9kEWvYFkSNwhlk/RTPv
         fe93EngbXK4DEFzXRmxu6hprKSaKohEcSd0xE9DJGZdwJSSwf9cXocxJWifT3SCd09Oq
         Pnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679051979;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cFGw0u2n8KUD7BLlUXmazMizht5nMVZl6kSY6hio1Q=;
        b=BCiVV+KsIE6bDwLDSPgikDbG9DpF6l/RyvNCeLdOoLbKLvPpt7zR8TJRkWqaN4gQbw
         0jgh5Yrl8WVoE7GDD+pUi9uERN81EkqkPyFhNongtN2VgPsLJdgbSOYXRyAShiFmzAmw
         ENCksR7vTnpPbPnIlDvfCmNnDCZL8I98d1jY0wInDls5CLiNfBjkw7nYB5ce20jT0jLl
         hRx+yPmSRjb8Ub1iJw+F8Q37/AhxgqPrBqbXyqnm2pgqm1wEvaHcu2nUF3qp4zWKyyMd
         4ZFJMB8fju1D1BlIgKXHzsAClj3g9KieqrRIBjCaZYnHWmhYFdnZmVo0OKvgV9xha8Np
         CEoQ==
X-Gm-Message-State: AO0yUKXXuI4KHstgQV2zHaVkSwmcuBGStr6FZwaKe3RAbHb8IzlhTrqF
        TYuLrBxVhEvPGjSbsWcAaNgDPec4JX4XAvtHUyXXAQpDQJ8=
X-Google-Smtp-Source: AK7set8QGmUVwCOtUEUCGDdAs69bISaDfQEqCIXK1AvR7kjBaoVZn+CQXQViIunUGG3FWkg/h39jV3w1ao9Y12xI+OE=
X-Received: by 2002:a67:d709:0:b0:425:de7e:3dce with SMTP id
 p9-20020a67d709000000b00425de7e3dcemr2664979vsj.6.1679051979549; Fri, 17 Mar
 2023 04:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLgTWNMSaZmE4UzOq8UhsLWnBzyt0xwsO=dS9NpQxh-h_g@mail.gmail.com>
In-Reply-To: <CAOuPNLgTWNMSaZmE4UzOq8UhsLWnBzyt0xwsO=dS9NpQxh-h_g@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 17 Mar 2023 16:49:28 +0530
Message-ID: <CAOuPNLiu+40HREtXFL_yMaXiaRtnZSbW9VvZRZmEpNXvZWzaQw@mail.gmail.com>
Subject: Re: ubi0 error: ubi_open_volume: cannot open device 0, volume 6,
 error -16
To:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Sorry, for missing the subject last time.

On Wed, 15 Feb 2023 at 23:06, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> We are seeing below "ubi errors" during booting.
> Although this does not cause any functionality break, I am wondering
> if there is any way to fix it ?
> We are using Kernel 4.14 with UBI and squashfs (ubiblock) as volumes,
> and with systemd.
>
> Anybody have experienced the similar logs with ubi/squashfs and
> figured out a way to avoid it ?
> It seems like these open volumes are called twice, thus error -16
> indicates (device or resource busy).
> Or, are these logs expected because of squashfs or ubiblock ?
> Or, do we need to add anything related to udev-rules ?
>
> {
> ....
> [  129.394789] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 6, error -16
> [  129.486498] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 7, error -16
> [  129.546582] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 8, error -16
> [  129.645014] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 9, error -16
> [  129.676456] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 6, error -16
> [  129.706655] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 10, error -16
> [  129.732740] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 7, error -16
> [  129.811111] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 8, error -16
> [  129.852308] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 9, error -16
> [  129.923429] ubi0 error: ubi_open_volume: cannot open device 0,
> volume 10, error -16
>
> }
>

I see that the errors are reported by systemd-udevd and other processes.
Is there a way to fix it by some means ?
These logs actually consume lots of boot up time...

[   54.300726] ubi0 error: ubi_open_volume: comm: systemd-udevd, pid:
1460, cannot open device 0, volume 4, error -16
[   54.507095] ubi0 error: ubi_open_volume: comm: systemd-udevd, pid:
1469, cannot open device 0, volume 5, error -16
[   54.509816] ubi0 error: ubi_open_volume: comm: systemd-udevd, pid:
1465, cannot open device 0, volume 6, error -16
[   54.650627] ubi0 error: ubi_open_volume: comm: systemd-udevd, pid:
1469, cannot open device 0, volume 7, error -16
[   54.680203] ubi0 error: ubi_open_volume: comm: systemd-udevd, pid:
1445, cannot open device 0, volume 8, error -16
[   56.311902] ubi0 error: ubi_open_volume: comm: mtd_probe, pid:
2042, cannot open device 0, volume 4, error -16
[   56.795532] ubi0 error: ubi_open_volume: comm: mtd_probe, pid:
2043, cannot open device 0, volume 5, error -16
[   57.087962] ubi0 error: ubi_open_volume: comm: mtd_probe, pid:
2044, cannot open device 0, volume 6, error -16
[   57.130853] ubi0 error: ubi_open_volume: comm: mtd_probe, pid:
2047, cannot open device 0, volume 8, error -16
[   57.345761] ubi0 error: ubi_open_volume: comm: mtd_probe, pid:
2046, cannot open device 0, volume 7, error -16


Thanks,
Pintu
