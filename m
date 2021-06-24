Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC083B3395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFXQLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFXQLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:11:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918AEC061574;
        Thu, 24 Jun 2021 09:09:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c7so9305857edn.6;
        Thu, 24 Jun 2021 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NhXbcWrm933uql/n/aBmpwjEP8OaVS7r8CFi6W764Qg=;
        b=VZiCjLICEcJDJap5vKQBCc3Qflk3UIzrL5NRG54tE6sEHHyIiEORHnWYQYhGU6WWgu
         aDwFIjguK7HxzaRzxMfkfGl6u2zrQnJdYMcYVUYlBFazUWm+IhZ1JCHXihG9BALmb35U
         ujz1VYjEuxriiyZ2iospFGwSKru0bD9+yxd3VvARVFx4autzgPtdPDt6HukzuM+veJR7
         KVqUYu6JBAQbPga4okVnH8aRrY7y5fgGbDgDKVA+6w050uaFWaFrxBSUdPNOJli6tOFc
         iotb3wOzRbQY1edGOqvlMQ48ZSca2nV6jzs2IL+GMIu9i4ENHM1Au2N9JzIED4Lmj7Kx
         I2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NhXbcWrm933uql/n/aBmpwjEP8OaVS7r8CFi6W764Qg=;
        b=TorDZ32eSS1SGhzzKaR5/d6jjCK/K85AIIl9PeNuXL4lysnl9Ieviw3VJj/k0edKB7
         ccNP51Z1Og/cKOPn6/ilzFg9bbdZTFdzkIB5RhL4FWWjtSSGsuncj8Ol5XAi6YI1y4Hr
         BeREYRZvOTcSu+GXs6TbpZetuYqpb2yIAoZm1qDpTg6wcximB36+C/Bpz8t3p9/Vyo83
         zzU13C7JqeDeFpPjpUDvqKflYPwPO9nU+IFovugvPuQPtJ4aEgzDXv9k3KZyIhvr8LVp
         350RnxyBJ/HHsLXOeMRbeiL952AVYtArmofOWlNQ1AWTWWsTQLOMesJqvvnwm07qznsb
         jhLw==
X-Gm-Message-State: AOAM532mx1WNCE3IV7eLdX+VoTowg4PTKczpWPrL1U1r/xk7k6kBml2V
        Hq6GJbOXxsyGQ3xrdef4dH4mywKvfpMQ0enO12tGthV6VCeyYw==
X-Google-Smtp-Source: ABdhPJyHv3bFXE94qKF4P2jRHaesfIj8LSinkd90w1J4itsRJl2LWlKJS88uPRXvKA6do6N6MinjVkevV4aDe4q8yEE=
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr8403605edd.66.1624550957782;
 Thu, 24 Jun 2021 09:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiZL4wXc__+Zx+m7TMjUjNq10tykHow3R9AvCknSNR6bQ@mail.gmail.com>
In-Reply-To: <CAOuPNLiZL4wXc__+Zx+m7TMjUjNq10tykHow3R9AvCknSNR6bQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 24 Jun 2021 21:39:06 +0530
Message-ID: <CAOuPNLhoLBwksNt+tJ2=hZr-TGHZgEiu7dgk66BUsraGA16Juw@mail.gmail.com>
Subject: Re: Query: UBIFS: How to detect empty volumes
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I have one basic query related to UBIFS volumes on a system with NAND partition.
In short, how to detect a particular empty volume inside a system
partition while flashing the partition image?

Suppose I have one big system partition that consists of 4-5 ubi
volumes inside it with varying sizes.
Lets say:
-- System Partition (ubi image)
    - rootfs volume (ro, squashfs)
    - data volume (rw, ubifs)
    - firmware volume (ro, ubifs)
    - some-other volume (ro, squashfs)

Consider that all these could be flashed together as part of
system.ubi image in a single shot from the bootloader.
Now, suppose, one of the volume image (say firmware) is missing or
remains empty (as you know we can have empty volumes).

So, during system image flashing, we wanted to detect if one of the
volume (firmware) is empty.
Since this is an important volume, so we wanted to detect if this
volume is empty/missing we will abort flashing the system partition.
As there is no point in booting the system without this partition.

So, I am exploring options, how can this be detected ?
I mean is there any kind of magic number or header information which
we can read to detect a particular empty volume ?
Can we get any information from just "system.ubi" image to indicate
about the volume information ?
Also it could be possible that 2 or more volumes are empty, but we are
only concerned about one particular volume (firmware), so how to
detect particular volume ?

If anyone has any thoughts about this requirement, please share your opinion.


Thanks,
Pintu
