Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9FBA44BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfHaOZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 10:25:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34374 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbfHaOZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 10:25:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so6430881pfp.1;
        Sat, 31 Aug 2019 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fuK10nwdAooAp1cEGKZRp6CTH/iQnFvXzzNvFJFGwAM=;
        b=SnO4N+IVfW8RtyXP2psEWbWDmZwslTokmMa5jQv+M4PgMGS53s89b3Fc5uvAEgdK5A
         9xU4QOMj1ptpAHlTjggci5PT0sGPBXPWIHhMCbvYTnCcy/yiT5AewCu6qLX1MipEjiAl
         Lw8wPuQFOnFmMEF5rOvzBZgBdwMzouHMKlIGloBDVbB9aTsVoI/w11ov3fOExg8HbMxK
         /2dclho4DmZV/MYIEBdTlrEpblrN6sREgq+5Ye3jOw69zVKLcFwPZdL6XXE6Im12tLG7
         ON7k3/NGUG7kZ3w2WckWPiUAa+k5672zJsIojT67398x3jTtay82qNgHFgcN1N/zokgg
         NR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fuK10nwdAooAp1cEGKZRp6CTH/iQnFvXzzNvFJFGwAM=;
        b=NnAuHeApw0NvHIm0ZipmzrxjZaL2/I3ICaZlB8yb3TCdCAQkU0OP9D29bIcFcVk95o
         VnhUozuyOKWP846eTLaix2fHxRp2uY1pVktX5rdc/2L8CvVSwwDl3534QNWqlswlqWuy
         8fDCpgLuL/B25BNVgUteEADYmC0ccoSiGTvJH9tDSmzTyYxYfREAyqpYGXAbawJrA3Q5
         eSt0Sk310wkwBF6pbhpxLWZDowwW3KbVHENqe2XKN+YZq1cZMt4ThJ638rv8qlN+ypzJ
         E1yAxK/A093+Z2c6mkpVbQFdUvYYFP+fqXoH/Sw6heU0QZvuzMCzIMC2MUOJpdYuVV6A
         p/3A==
X-Gm-Message-State: APjAAAWDrTWDIJ3zVRjaKmf1MjMfE3Ldvy9KKuTki+3g/wz4GUxr8nQH
        BV7gBxzCyulg73/3NcMdcZwXu4kGyYH903BQDKs=
X-Google-Smtp-Source: APXvYqxGDJ4pQvla7dmPLqgxoF9sWTZH2kLtVjvSxCxH1l/b1IyLLh4D1b0gwUw4ipaVpNm2fCQKU0Ly/oiNBbSZtgM=
X-Received: by 2002:a17:90a:19c4:: with SMTP id 4mr4234604pjj.20.1567261500381;
 Sat, 31 Aug 2019 07:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <245727.1567183359@turing-police> <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police> <20190831064616.GA13286@infradead.org> <295233.1567247121@turing-police>
In-Reply-To: <295233.1567247121@turing-police>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 31 Aug 2019 17:24:47 +0300
Message-ID: <CAHp75Vc34bHCdsnd+FgzVgs7jjPeHsL6Np7VfEe7hnJ49xW3-A@mail.gmail.com>
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 1:26 PM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:

> [/usr/src/linux-next] git log -- fs/ext4 | awk '/^commit/ {merge=3D0} /^M=
erge: / {merge=3D1} /^Author:/ { if (!merge) {print $0}}' | sort | uniq -c =
| sort -t: -k 1,1nr -k 2

Side note:

% git shortlog -n --no-merges -- fs/ext4 | grep '^[^ ]'

kinda faster and groups by name.


--=20
With Best Regards,
Andy Shevchenko
