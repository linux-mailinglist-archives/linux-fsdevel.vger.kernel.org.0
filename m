Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E3114B03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 03:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFCnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 21:43:39 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44537 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfLFCni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:43:38 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so4899603iln.11;
        Thu, 05 Dec 2019 18:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwnBRTdDP35mDXJCuQNvxNiSYSSqXwSGYAdihSOqw+M=;
        b=gCLNHz0qL4ivBuWruGSb8Xtxv2Z1379625iOP5mM4vBOY4sCCvuXZ+vvF2UJDRi+yn
         QxHqtTvfoxkT5y8pzoTHiaWJiRIYMXDvjiGbgLBglM11TaQUOZZqHr0wmr2iUNkiNwk4
         tJJ0BexyBfvQ3IWJl7duudecacL2B0mi2xk1VyYCJkv2SplICq+a5qha8bXgkE8ysj6u
         xWP4t6uuzlfTJRrHemZx3MJpRhfgbal9n9D8BQylY9kElVBfPwxTLsbZYmpNvcAzGUsT
         W4+96ljzNYUyPztXTqM6/v/gBgXt9tBYfiSIZcg69cxet1DimIaX4LTs/h7kGaKmf/V1
         F/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwnBRTdDP35mDXJCuQNvxNiSYSSqXwSGYAdihSOqw+M=;
        b=WiUjVf3iXLtM3dJGhm7YugRwY9TS37yUy4FnEJX4eUyXNJmDk4QYG6/o99rPDfj5hY
         PfjNoDXZ2Cl/lA6uzOhPoUvbYWo3bcB06345h6Z2IJlTXnZVpcIBMv8AFlRNRHOPwGAC
         e24WvI1rcyiBROi6QrKTHvQfzA9VB9ncrf96TjDoxxvZGyO99KAKLoTPsV1xkcmxZhzj
         Z4KLPADSizQ9JIpuWm9SpVz8HP5CE6jGm/FJroBJxq0m3twYWp6jB3x2Znwq4WVHwy3d
         V0rkjbsCCg82YSqQsOKzllncE6mKMlp0pboMUx4gtXKMvDJ8TGMZKZLHSuyT6FUcIwcG
         zhZA==
X-Gm-Message-State: APjAAAVWWE921Tt+1f185ydrvPJ43r3x33JZfncuTmbKd55+mbfaBj9B
        4bugeIeViten3aoDQGyvaz1me8mu2XKnHglFfO8=
X-Google-Smtp-Source: APXvYqzRyd3cAihQ+Rt6RtZIFeU6QgRGdFGDxYndwn7fjlACobL26vsFf06MfqJiSaF7mTavf4q0Snt02U+m1Zo1HH4=
X-Received: by 2002:a92:7f0a:: with SMTP id a10mr12071154ild.110.1575600217860;
 Thu, 05 Dec 2019 18:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
In-Reply-To: <20191203051945.9440-1-deepa.kernel@gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 5 Dec 2019 18:43:26 -0800
Message-ID: <CABeXuvpkYQbsvGTuktEAR8ptr478peet3EH=RD0v+nK5o2Wmjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Delete timespec64_trunc()
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jeff Layton <jlayton@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 2, 2019 at 9:20 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> This series aims at deleting timespec64_trunc().
> There is a new api: timestamp_truncate() that is the
> replacement api. The api additionally does a limits
> check on the filesystem timestamps.

Al/Andrew, can one of you help merge these patches?

Thanks,
-Deepa
