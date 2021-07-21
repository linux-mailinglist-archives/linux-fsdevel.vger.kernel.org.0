Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D773D11CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 17:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhGUOWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbhGUOUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:20:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB6C061575;
        Wed, 21 Jul 2021 08:00:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x17so2751020edd.12;
        Wed, 21 Jul 2021 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QH0L1galc4dXmyAjj6SONbiSv0qVq6f5DQ4NUtGEno=;
        b=ksK3cQEkcbM2A1jLvr4UuKTvyNMRVEzp0tvWg8di9oPfOkQHQy6xwZLfWylwgHXeky
         zT5+pr/Vo1E5ZvqpCBJ76fS1+G1yypiU54zm2N54vDXPS4tmEzVUY1Xhl8/gOc3dOq/Z
         DOmdcOMb6d85MqtiR8FoXDdcafAr+rlf+lWJ5C0q+TGyAfHgwVZa6hDATsFxBTdOX4qj
         xZC16RQwxKt+eCQdTc47xPXWJD+ObiE8Z0zUEoI7M2Q3WT5Rt/dZTDxr75xcq1E1ey8i
         kcqOU0q8BmVtpv3lBZR396OEXoDJtCUMwPIpQX4BxHiNydCqSlzCcjiSURY1NtDsvfxI
         ZZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QH0L1galc4dXmyAjj6SONbiSv0qVq6f5DQ4NUtGEno=;
        b=Dq8q+eltPKNOhyPaJ8dYHAbDzy39ZGWzGA6DOAtPBvt5+IBAvGqJ+2M3GAxgR+38mG
         3L4gGZ+ADhXlgqZnMbdCxjLqt+XiU+cdZpkPOfnAengxy1oi+Ur4hpWJClj5SvPXevC2
         1ee9N1XeODFUw9pevOZ4MXvQp23GQRh0b9G65efq7F8L/8W3pQt6zr/APinu/jeVZAvJ
         Y2VL4G8DMwyCQgk0CY9CJDxe+tUol/o8A7F48/OiceAjrlq3A/ovP+1jH+La+7TZ0vCU
         5A0Vdvt/33xT3fLEJx07HgyKV5qcJLrSo21DM8KQa016uT1defjuhXGYeWwaKWhZwl/u
         xAuQ==
X-Gm-Message-State: AOAM531/Kl1Znb54H2mQqGnxrA7W0K3pYHl/CNFdR8upMyPLoRvC8dra
        tu1KzXVZboAZFTAUTPf8DdXUSrsv/Pe2tMe6/7k=
X-Google-Smtp-Source: ABdhPJwsdM7NhMOEPZ+TG7bCz9J7fuNtMI27TGWdC6n7lbhoBMHBK0YuVNjfgWVfOXR7v0uUr3SK5Qg0rxNOhwip2XI=
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr47901608edv.230.1626879650292;
 Wed, 21 Jul 2021 08:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
 <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 21 Jul 2021 20:30:38 +0530
Message-ID: <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting issue
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Jul 2021 at 17:12, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Hi
>
> Try to set up dm-verity with block size 512 bytes.
>
> I don't know what block size does squashfs use, but if the filesystem
> block size is smaller than dm-verity block size, it doesn't work.
>
Okay thank you so much for this clue,
It seems we are using 65536 as the squashfs block size:
==> mksquashfs [...] - comp xz -Xdict-size 32K -noI -Xbcj arm -b 65536
-processors 1

But for dm-verity we are giving block size of 4096
==> [    0.000000] Kernel command line:[..] verity="96160 12020
d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681 0 "
rootfstype=squashfs root=/dev/mtdblock34 ubi.mtd=30,0,30 [...]
root=/dev/dm-0 dm="system none ro,0 96160 verity 1 /dev/mtdblock34
/dev/mtdblock39 4096 4096 12020 8 sha256
d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681
aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7"

Now, we are checking by giving squashfs block size also as 4096

In case, if this does not work, what else could be the other option ?
Can we try with initramfs approach ?

Thanks,
Pintu
