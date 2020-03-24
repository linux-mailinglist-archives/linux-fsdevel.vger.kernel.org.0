Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6EB19098A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCXJaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 05:30:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40252 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgCXJaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:30:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id e19so16367558otj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzTnB3iS1qilKNurvByNSklxmCSliWtJkL6J5/1oEN0=;
        b=dT+SeYyH1BkKkZWUaBk5uj0MEH4L6HjmlSYG1+nPnGCG3gAENzp0qjsWHAigkjMhtR
         ljAI1uUGzbpci1deREeZbmrQws6bf2gHk+9gusG81aJYoCIN4nyvPaaP6ug29PD+78AD
         pBmUMig88uOYaX5iSgRyVzEwUEzyGAd5Yu8cNqY1KACcX65WNHrT7gMMS3T4RjMXKiRj
         9kQwaauv82/bqrFcDf7AtzgFGJe0b9boON8gM98zVPL6FMxsx9RRo+vJqhikkynkr4WI
         +/oWFfjdmud6SHbfCHGyb5rghdGaq7+cR5SuHhjkz0L5/L+PbiIqnNVLVHCPGSKi0cpY
         kOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzTnB3iS1qilKNurvByNSklxmCSliWtJkL6J5/1oEN0=;
        b=peVdHn3KRn56/B72iJKYUOODGvby0p5ERL3HfCnpmPUCmIjTPya+GduhIcJmcc+rZ2
         /ahImHDPL+sn5FEzMRsaFEWIZfKlFNsHJzc2iPskPiMhhEDtCl1MiIWgSuoD1gNGwxgz
         7sB/jI9vIVAxAUjVkj8ZsEuRXvkHxh/BM7S33f/jervR1PWThKCnUfiiGMUaQglb4BwE
         z9Km9QFWv8wpNUWL0det62IaBsH4Br8tMp3ZUC4HNKWv+4U7REQNxEja9KUSFVBh8k/u
         33QCWaKWTFDvM84leUVywA/nTD0T7VrZ91fJ8Dyzl81dJNATtNGw3AADMi4wCmfPYo2A
         C8Pw==
X-Gm-Message-State: ANhLgQ1awNfNqz7rMHHS7qAKf2chxoRHdjeSfYXXe9RNeoXUBhSGlJBu
        R9wsQ6PO9GmcyTKGLq64Mjq31ejy5aT/Lf5MRPd5eQ==
X-Google-Smtp-Source: ADFU+vsVpjNMAvc6231UF5jnLInFznAbjT7PjgwTqzNrcYLn3q1rK1MSp0eBo3cutIGiQ6yNzxYDBwJUhUQYQLc0WIo=
X-Received: by 2002:a4a:d1a5:: with SMTP id z5mr1673767oor.63.1585042209973;
 Tue, 24 Mar 2020 02:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
 <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
 <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
 <CACRpkdYuZgZUznVxt1AHCSJa_GAXy8N0SduE5OrjDnE1s_L7Zg@mail.gmail.com> <20200324023431.GD53396@mit.edu>
In-Reply-To: <20200324023431.GD53396@mit.edu>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 24 Mar 2020 09:29:58 +0000
Message-ID: <CAFEAcA_6RY1XFVNJCo5=tTkv2GQpXZRqh_Zz4dYadq-8MJZgTQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Mar 2020 at 02:34, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> Another possibility, which would be messier for qemu, would be use a
> flag set via fcntl.  That would require qemu from noticing when the
> guest is calling open, openat, or openat2, and then inserting a fcntl
> system call to set the 32-bit readdir mode.  That's cleaner from the
> kernel interface complexity perspective, but it's messier for qemu.

On the contrary, that would be a much better interface for QEMU.
We always know when we're doing an open-syscall on behalf
of the guest, and it would be trivial to make the fcntl() call then.
That would ensure that we don't accidentally get the
'32-bit semantics' on file descriptors QEMU opens for its own
purposes, and wouldn't leave us open to the risk in future that
setting the PER_LINUX32 flag for all of QEMU causes
unexpected extra behaviour in future kernels that would be correct
for the guest binary but wrong/broken for QEMU's own internals.

thanks
-- PMM
