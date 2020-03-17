Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A071882B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 12:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgCQL6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 07:58:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42401 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQL6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:58:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id 13so12462655oiy.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tLG0UvowYMxwNr6UXAFjrYE3UP2cWO9OOJLVI6SNuM=;
        b=Mdv9Ev0hWdBHO5UtWJBB5vCi54nNKxRYMIn7zCsdg1tggsr/dFr1x5TNXD+4ERd0q2
         PUoF44Wb4BkSNPkR9ulesNTcwjCkGsbALj4ZupRv8XsmzqWwS5YJXopOOx8syMeK4533
         7eJYFQUad/uIAzsDKrZnKv5hZtUuKt17hNXGdkfIJoDgY97TICZViYb6603+aR6OzAIb
         2WSTWc2I0/1ENQjAE2ngPZCWMxZ8qIWEyPqceeV2NDusE76aX2/SupifuU1JiiZ96QMT
         fuESbGTlTjfcLIhal4/lii+GTNk+pVzllv8CdXvcxNo+Wm9dlKrXPl602p7K7WcrqKHS
         8gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tLG0UvowYMxwNr6UXAFjrYE3UP2cWO9OOJLVI6SNuM=;
        b=r1lacWxRQYNMB5hBpNylQLXw4SA2Bzh1u3ywGvvjql1r/yr6AwcschIEf1XYvWjtl4
         hQE5n4vqW8ptrvdq6RrVesaN16Qm3d/idGFVRkQpsU3/LWsiFBCi3BpcX1vJgfF4oAJO
         Sy9hclpRKM+FsIaDkq3HQuY1zohoy1pNB07HCpHpGb/TF4/GU9jSP7vKPV3OzxIVC3oa
         3ZeN+bCivy0GGKlyBu4ED6HCrLK056R9qBW9iVnN/JfNya5T53Z9FJ9zCQN/QITTNNxA
         ZFDMjqA/noPh+pEN3VPp0PNXrTq3WXHXfsdfE68wcKpdclBtdXL5J8PJBq8DgTdFV1z6
         vKvg==
X-Gm-Message-State: ANhLgQ2CirUo6meHrHH4i5ws7fI1Lis6rlQphE728Ev8ZD5oSNuifSZA
        SP+aC1IjLU9rP3IgAiTkp2pXfoL0jOiKepeQNObhHw==
X-Google-Smtp-Source: ADFU+vv2vA2intsubk2Bd6nP5kQhiggirL2UjEzCPX13Y5LB21Ez3zUMdijWMELThsGoCt5RUUEDjjKOmgDyl+5iHeY=
X-Received: by 2002:aca:c695:: with SMTP id w143mr3238753oif.98.1584446301315;
 Tue, 17 Mar 2020 04:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
In-Reply-To: <20200317113153.7945-1-linus.walleij@linaro.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 17 Mar 2020 11:58:09 +0000
Message-ID: <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Mar 2020 at 11:31, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> The personality(2) system call supports to let processes
> indicate that they are 32 bit Linux to the kernel. This
> was suggested by Teo in the original thread, so I just wired
> it up and it solves the problem.

Thanks for having a look at this. I'm not sure this is what
QEMU needs, though. When QEMU runs, it is not a 32-bit
process, it's a 64-bit process. Some of the syscalls
it makes are on behalf of the guest and would need 32-bit
semantics (including this one of wanting 32-bit hash sizes
in directory reads). But some syscalls it makes for itself
(either directly, or via libraries it's linked against
including glibc and glib) -- those would still want the
usual 64-bit semantics, I would have thought.

> Programs that need the 32 bit hash only need to issue the
> personality(PER_LINUX32) call and things start working.

What in particular does this personality setting affect?
My copy of the personality(2) manpage just says:

       PER_LINUX32 (since Linux 2.2)
              [To be documented.]

which isn't very informative.

thanks
-- PMM
