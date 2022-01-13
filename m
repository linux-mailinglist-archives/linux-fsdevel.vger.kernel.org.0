Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3350248E083
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 23:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiAMWlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 17:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiAMWly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:41:54 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BAC061749
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jan 2022 14:41:53 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t32so1168238pgm.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jan 2022 14:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=YbEI3Q/NEjCtDTVCV1jkA7nYNYBH/Wfa2wk3IkVyJko=;
        b=OZP/QoKN8ru5XovrHZZEtRGAPOqy8yRZtZX0efEKVWs/Q7f6+2JX3Mloojh5SZ/AxH
         cPAHMJhJrLRzzoPYh5n9fG2/pMOrYfS/PU2zx88sTYLTj0Dv1cVWivcA/TNU5IJgRtzI
         yyO22l7H4XiZ577o8zD4nj2E5AestX9VYls3ntwqOHZNPl0OsU/EptDmXh66odxZFNCy
         EIQC+hO6HyVDK/x5ziZcfqIxZJTlgvB+YGNZLq+4zSXQW5IZ9FoHkF7Eb5K19JwK6tqA
         L1pbJiPTkM7B36B6kKA792uSFGR69D9KVeYMTQ95Fzk4WvuXfGt3UHBLmZ7aOqdAe8eh
         8P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=YbEI3Q/NEjCtDTVCV1jkA7nYNYBH/Wfa2wk3IkVyJko=;
        b=evGykGCBFpub/OS+e35ovaqC30pZb+YU8yXLAEG57PTS7MvF8bpuBd1cxGExDvItGr
         3Y8X4Q2XDkFSH9LDFh5MXdtcS6nueBlTzDWDyvWIsL7caesWaVOwKuEHtOFCaXWCoC8W
         imbZuB7QcBhUMEE8mpyAmVhdNGeh0Xih/5OnDIykllM4/OVyNX9Cc6F5N/ZSrJI1W4Ys
         L6YIbsoxd2V4Nn3tCcilDafjQQOZhQM8uL1ag7y11jZ5kTjHeVRmKNc8rkEOxfQ15Kfg
         GRNGoBphKYqMDKhCaXGJ8gi67jKUWUS2s+rG7Pvcw59r9QO2fI/izWCqPiUg7ITg2pJA
         6QHw==
X-Gm-Message-State: AOAM532YyOtQZiwmF7Qgh9F2Fw8IhyoF1buUlO1b5WisK+GQPDE7vKBq
        970ATafY0a59/sG/dvRzneG3cwFoKq29kxMTzGw=
X-Google-Smtp-Source: ABdhPJwo/BFuE/MyrXvV4Wc2jiueqzTZxw+feN+I2rvhYn2V6MZ0AjtfVc00EmStBrmKGTDtifrnIaK8zXPI0L+vd18=
X-Received: by 2002:a63:4507:: with SMTP id s7mr5556975pga.252.1642113712456;
 Thu, 13 Jan 2022 14:41:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:f38c:0:0:0:0 with HTTP; Thu, 13 Jan 2022 14:41:52
 -0800 (PST)
Reply-To: mchristophdaniel@gmail.com
From:   Marcus Galois <marcus.galois@gmail.com>
Date:   Thu, 13 Jan 2022 23:41:52 +0100
Message-ID: <CANqBaXVSfOGLj7J26QWPsx3dwN0Cxmg71Yc9hV9b7yv0f0E1qQ@mail.gmail.com>
Subject: Good News Finally.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello friend.

You might find it so difficult to remember me, though it is indeed a
very long time, I am much delighted to contact you again after a long
period of time, I remember you despite circumstances that made things
not worked out as we projected then. I want to inform you that the
transaction we're doing together then finally worked out and I decided
to contact you and to let you know because of your tremendous effort
to make things work out then.

Meanwhile I must inform you that I'm presently in Caribbean Island for
numerous business negotiation with some partners. with my sincere
heart i have decided to compensate you with USD$900,000 for your
dedication then on our transaction, you tried so much that period and
I appreciated your effort. I wrote a cheque/check on your name, as
soon as you receive it, you let me know.

Contact my secretary now on his email: mchristophdaniel@gmail.com
Name: Mr. Christoph Daniel

You are to forward to him your Name........ Address.......,Phone
number......for shipment/dispatch of the cheque/Check to you

Regards,
Mr. Marcus Galois
