Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31CC49DE85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 10:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiA0Jy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 04:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiA0Jyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:54:55 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704C0C061714;
        Thu, 27 Jan 2022 01:54:55 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id l1so3674466uap.8;
        Thu, 27 Jan 2022 01:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=trNlS0pW8+AdK8oPoeEN0//SqC3/8UgTG2KJa4FIOBQ=;
        b=MV3jZwKzZ8VY0/LnWzZV7iU8JTY4uG0D5J5tI3vL27e22iOFngHlGHkDwVcdUwP/Ez
         awBL3laFjaWTppvjzgEaWNfOvXknm0b1ugIvXeYVCI96fLrexEkRuLZqjTgBck6s/zXZ
         7H4SzoC3IU5ouBYMlFWaXzSKGKCYzWnQFiC791g0fGnjvGQE9y/yVjeabvY4fVF9KkYU
         BSY6LZxMfcSZXQ3uOhO9AHCMco+heNQq19aDu1YeWqfXuX84yb0SlF/YsELxLwPOn5Ak
         yuI027n1H52eQvmyshMuZae6EYzKPgU88pGrSAQIG4TeC+OzEvmYmBMJy3UiITPU0jjp
         CgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=trNlS0pW8+AdK8oPoeEN0//SqC3/8UgTG2KJa4FIOBQ=;
        b=tGozV9KYu2jmSvEblvawFR2bxHZ8bCPBS6HiaLgwb6GjPpW+J51uRLTn6S92nHBsmc
         UDB6Jb+JRGZro1wRPI8mkmkRKs81k09q4FHK8KiTWxU4vLmejsb4hE41pmuNLDWmsAW3
         uF6lsYmDUYxxO0jQZVqwR5sGaCKHV3CFviL1yNk7qMiOxD9qSQXhsk4qVAnL+sYZ6Wvl
         Gc23T8TtJFOnPnVl7uPzdIxjLXRTUpqD78SiTHnj0p0jrCtiy2ebgP0LoKOExXnpLEEw
         BtwfbXJeiu0VVLVTWfO3a3H6owsgVWx9rL/ZWMMQhdVxWjE0Y4oOKNtiDfCSwvnIO2Zk
         bLiA==
X-Gm-Message-State: AOAM533Iuf1Nekp0eBCu2cNCqHGbXPgancVKHUV9wxcQR8oP/MPZS9FG
        X74bs6N3xVc8Z3hqHsp+7n9u8PsVVIlOo2Vc9phsvtnb7/8=
X-Google-Smtp-Source: ABdhPJyhaMpwAgKc3/S6K/8UEEl1FmbfGFZ9O/M4KjWIIIOzKmT4dBW+d9wm3u7GRQkRWiRsXFGUUuKIySQrIrsVkg8=
X-Received: by 2002:a67:b243:: with SMTP id s3mr1350540vsh.62.1643277294480;
 Thu, 27 Jan 2022 01:54:54 -0800 (PST)
MIME-Version: 1.0
From:   Bharath SM <bharathsm.hsk@gmail.com>
Date:   Thu, 27 Jan 2022 15:24:43 +0530
Message-ID: <CAGypqWxPnYx1PwhCQcyb7LLAB0JPsK2kmPWcrmx98Cs0As1y7A@mail.gmail.com>
Subject: Mapping between EHOSTDOWN to EACCESS in cifs
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Team,

I came across the following behavior case of CIFS session setup failures.
CIFS returns "EHOSTDOWN" to userspace when it fails to reconnect while
doing session setup because of change in password or change in ACL's.
Should we instead replace it with EACCESS for these special cases.?

I would also like to understand the implications of mapping EHOSTDOWN
to EACCESS at the user space for the above mentioned case and how it
is done in other file systems.?
Can you please share your comments/thoughts on this.?

Thanks,
Bharath
