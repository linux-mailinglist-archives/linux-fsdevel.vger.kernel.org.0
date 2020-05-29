Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25D51E87FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 21:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgE2TiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2TiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 15:38:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CBFC03E969
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 12:38:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d7so354616lfi.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPDvh01OW+FevR8FAzlmbShS/M72Zg3Luivf9HIfgLs=;
        b=LrZnHTTXPL8Gv8T18YKQ4OQw+iJDUIU6Cn+kPjUKqi1KUa3snw/0GNiCUkM3NTLFUt
         WaGXF/5J3xO34KQz1QjFfI2laIqN+4utc4RinC9Mo8ApPsGRmixK5pN8zASK6Fb38aov
         e2lzMbi+T0krf5CQoIcNxd+u/NaQHxG3nFMCYr8InkyKcAAfPWRBJLtN5YQ82kqLrlsD
         VRWs3Oi4zk/IFCtaK30GvrBE9W1zbUu59n6PnPLcucfY8Sz2kseQNN2v5TVKscxAu0Mw
         onNjU0o2vshZTIZboF/3JLMhSIbEC2qE1t2jeXFvXchfGVfgo6lIbANdiAAeqzrfHQi2
         s1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPDvh01OW+FevR8FAzlmbShS/M72Zg3Luivf9HIfgLs=;
        b=OMrnPDPgElyMx/XbYbJzGZI4zxZuIlBlyexgq1G5JeYNn8kqdC67O548IsSMBOuT94
         Mty6XYtXB4kYVhz4IQpLYpldl1z+e5jUnA1h5cP2Wbb03bu6Q3bJ8OIFfGlzyvIsdD0b
         MPO6y4SI/bUatDII/6O8gf7A4ynZQneP0qeYpOjiAu8qkVUc1P21ca92J2YMB6Q2jdWb
         ZjcOYeImqnOEQYbLcoYsMAoxZyFJFPZ70Aw9UXFJJJmqYx9eloS6vp0bX/izRS8uz1pm
         wk3f4QWqEh+qtWPuJvafv/+/5YK/IuH9CF7QEjQ5hP41inDFQ3CqvLSiK4AHHJSKtqOm
         NXKA==
X-Gm-Message-State: AOAM530TCLo2R8Yk/XBx6IRkVIsnuDuLBgXx9kEVK901hSA78K50MQcK
        VaHs9FH6V+V8o3/+tTRalD/vb/ZeG0CC02UEZZbb2Q==
X-Google-Smtp-Source: ABdhPJzZsWQ6yCZomjEhNZsfjr5eIjzigUuqaHKZzdWPyqSUuxSr+nHWobwJQM+oc/Nn6jtRvcEhNzAaTVQ7czdaOxc=
X-Received: by 2002:a19:2358:: with SMTP id j85mr5238576lfj.182.1590781081099;
 Fri, 29 May 2020 12:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz> <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz> <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
 <20200525073140.GI14199@quack2.suse.cz> <CAB0TPYHVfkYyFYqp96-PfcP60PKRX6VqrfMHJPkG=UT2956EqQ@mail.gmail.com>
 <20200529152036.GA22885@quack2.suse.cz>
In-Reply-To: <20200529152036.GA22885@quack2.suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 29 May 2020 21:37:50 +0200
Message-ID: <CAB0TPYFuT7Gp=8qBCGBKa3O0=hkUMTZsmhn3VqZuoKYM4bZOSw@mail.gmail.com>
Subject: Re: Writeback bug causing writeback stalls
To:     Jan Kara <jack@suse.cz>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Fri, May 29, 2020 at 5:20 PM Jan Kara <jack@suse.cz> wrote:
> I understand. I have written a fix (attached). Currently its under testing
> together with other cleanups. If everything works fine, I plan to submit
> the patches on Monday.

Thanks a lot for the quick fix! I ran my usual way to reproduce the
problem, and did not see it, so that's good! I do observe write speed
dips - eg we usually sustain 180 MB/s on this device, but now it
regularly dips down to 10 MB/s, then jumps back up again. That might
be unrelated to your patch though, I will run more tests over the
weekend and report back!

Best,
Martijn

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
