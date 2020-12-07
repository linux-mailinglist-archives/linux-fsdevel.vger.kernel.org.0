Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269812D0E26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 11:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgLGKio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 05:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLGKin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:38:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91307C0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 02:37:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ce23so14986428ejb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 02:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXIL/mPGOivAPpqwxpyRTpp5LeodAai3f6shhhCJSvc=;
        b=epBZnYHYL+3atS7whj+dOGTaots4l4EmX2hejtWFeS/V33LeDhxYyPAz/HJjznLv7Q
         8tsFzOXpbq98t0RuB0fEK6P0GIQc1hP/GlQctUsRkYtM6qaPtfx4HUIIQz5F6C5IYSri
         +HjDh2eHZvBqxDEaeYBIO51faVdgqbYBTm0oNR+7hDI0lja7XI5qbGFOYZhXZzqorLB0
         GzKoNHZgFXO4G6TxJtxKHqo/bfJz+8ucTLBMqksXtdfb6Coy33JUz5Lodn7px8eNyS5B
         Ggi2HVNL/QrCC/omoO4tbOaf+8v+uRRGjAZ9r91a1Z4hePh7An+vGZ34zsuE8zOcijjs
         iJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXIL/mPGOivAPpqwxpyRTpp5LeodAai3f6shhhCJSvc=;
        b=VcLoExdWT3BHvDunROcj60nXfkYMgEPWszdw6/0HDEDhDyXau8ejdAiWZ2BJwbKeeN
         o++kO1IIMMdw8kr677fEoLnAxlMRxKgt8t9FBj4nJpeaxONybbsrMPr5RZQeXAXEzGXQ
         R5zWtIl0naXBg+CfKyGp41n6omTnBSfIOYjMCjWdYiVcnQBc0svR/TSfyVAuXOMZHr7j
         G6uun6EYIykuhE6g9WmYohc1wo5qw2rf3cuQzG9EV0mJqaKkVzTsms+uKqX0v8NbSin3
         GYWmRssRIm2FBs2IKB+alsZf1WPCThJR33B347JE5j0Xa7QuDFOzmtOCLXfOLEJDHafh
         sD7A==
X-Gm-Message-State: AOAM530qyywosRntKEZOBKnVT2SRsit0VoOXVKNP4TaNAcVLEZb1BVGG
        ZpOuxJLXVWQUlx7GDRw+P0RhPaYZnaJf3oM4NPAoBw==
X-Google-Smtp-Source: ABdhPJyS8NPxP/N8yUAkByj94DqmhT5XJMlOeyUF6KVf2Vx2H9TvyJW2H/KEgzqT4En6ecuhA0MrYltatpFPfGUXBLo=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr18025326eju.375.1607337475996;
 Mon, 07 Dec 2020 02:37:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs=nR-d0n8kV4=OWD+v=GR2ufOEWU9S4oG1_fZRxhGouQ@mail.gmail.com>
 <20201207060746.GT11935@casper.infradead.org>
In-Reply-To: <20201207060746.GT11935@casper.infradead.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Dec 2020 16:07:44 +0530
Message-ID: <CA+G9fYvQaBVRjxwQ0=+09RCVi-sExv4LAAXpH3-TSGNL29EY7g@mail.gmail.com>
Subject: Re: WARNING: bad unlock balance detected! - mkfs.ext4/426 is trying
 to release lock (rcu_read_lock)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org,
        lkft-triage@lists.linaro.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 7 Dec 2020 at 11:37, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Dec 07, 2020 at 11:17:29AM +0530, Naresh Kamboju wrote:
> > While running "mkfs -t ext4" on arm64 juno-r2 device connected with SSD drive
> > the following kernel warning reported on stable rc 5.9.13-rc1 kernel.
> >
> > Steps to reproduce:
> > ------------------
> > # boot arm64 Juno-r2 device with stable-rc 5.9.13-rc1.
> > # Connect SSD drive
> > # Format the file system ext4 type
> >  mkfs -t ext4 <SSD-drive>
> > # you will notice this warning
>
> Does it happen easily?  Can you bisect?

I have been running multi test loops to reproduce this problem but no
luck yet :(
Since it is hard to reproduce we can not bisect.

- Naresh
