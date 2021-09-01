Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2C23FE2DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhIATWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhIATWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:22:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C1C061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 12:21:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id x11so1592049ejv.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7waZP141l6RVzw3QCJzeAvHVAvzV7QKI02xHaEuqMY=;
        b=KuLxFt0pQiPUfjI95nepnibmq64Kb0FvbTBGbWaCMNyL58vHsOAYuzc6Km3AIm+UZ+
         AxzU3+7rvZWWxefgHOnzh5MLLzuGLlyoFPPrw9Ul4/ZBWun5QKZ2MsU3bg9otMOEWks4
         V4JD0uMu3gQ6k8vOyiFSaKhpjxrRumXbnIT5tumYhEVr4Ykwf1q9qikfWVtsJvEP7t2Q
         LMbXzRmMp07c773FqwlcUFjMxH/7mcCWfQoXkX6TKQq2bAM8gGx+2OPtY7tCOg1rt4e9
         gETazcYiDzIx2op8V2Tw6YtQKlhMwGHY8eB+xEkqCeGw/ZPlcRhNufWazcopeXNEsVDX
         BRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7waZP141l6RVzw3QCJzeAvHVAvzV7QKI02xHaEuqMY=;
        b=c1n+9aGkVwGvsvbmutkNJZJzMn55i1U5voDhcJ7b5jqKIJz4WqjDNBTjm0nfNxzipS
         GEK22dpqZeWsOwHOf1WqV5RJc1ZtI+YmcrqJ/vj8zVXnxPLlB5agqwKAWHKcUyFd3VtV
         mM4CEGTiVFySbVZfiWErhCTjmKGf9lryaYKCyoKJhLxtbLPu+AsY5TuoubO0b9sp+l9v
         jRxVhySqkYe93H8rP6wn6tQTZxRo8wU4PSmUA6xU5+LMLiiwy31P9FMbulNF/nGSwI7/
         rm+fh/JMD1P0XqZXdZUH0vyvtjym5lSLsgHEBKnb00UvSWKBiRPqrF681nthMgVJPoze
         sdMQ==
X-Gm-Message-State: AOAM530fAn9f8F3RKHKJEkIlp3HLHz+idyt9U3lLKkpgto2HxInCHMjJ
        Y133Iro7aeoe0X7HyygEF9GbcPxTTQ1+3x1H35wq
X-Google-Smtp-Source: ABdhPJwMrws0ZJXM5KYsE7dIYrlyxtDTBxi6QrrhcjBLlBr8Y8LgOmFcwtA8cvyU9xh8mHyp4mp2LOKjQ+7fHgWM4ok=
X-Received: by 2002:a17:906:b845:: with SMTP id ga5mr1224071ejb.106.1630524077778;
 Wed, 01 Sep 2021 12:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <162871480969.63873.9434591871437326374.stgit@olly>
 <20210824205724.GB490529@madcap2.tricolour.ca> <20210826011639.GE490529@madcap2.tricolour.ca>
 <CAHC9VhSADQsudmD52hP8GQWWR4+=sJ7mvNkh9xDXuahS+iERVA@mail.gmail.com>
 <20210826163230.GF490529@madcap2.tricolour.ca> <CAHC9VhTkZ-tUdrFjhc2k1supzW1QJpY-15pf08mw6=ynU9yY5g@mail.gmail.com>
 <20210827133559.GG490529@madcap2.tricolour.ca> <CAHC9VhRqSO6+MVX+LYBWHqwzd3QYgbSz3Gd8E756J0QNEmmHdQ@mail.gmail.com>
 <20210828150356.GH490529@madcap2.tricolour.ca> <CAHC9VhRgc_Fhi4c6L__butuW7cmSFJxTMxb+BBn6P-8Yt0ck_w@mail.gmail.com>
In-Reply-To: <CAHC9VhRgc_Fhi4c6L__butuW7cmSFJxTMxb+BBn6P-8Yt0ck_w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Sep 2021 15:21:06 -0400
Message-ID: <CAHC9VhQD8hKekqosjGgWPxZFqS=EFy-_kQL5zAo1sg0MU=6n5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] Add LSM access controls and auditing to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 11:18 AM Paul Moore <paul@paul-moore.com> wrote:
> On Sat, Aug 28, 2021 at 11:04 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > I did set a syscall filter for
> >         -a exit,always -F arch=b64 -S io_uring_enter,io_uring_setup,io_uring_register -F key=iouringsyscall
> > and that yielded some records with a couple of orphans that surprised me
> > a bit.
>
> Without looking too closely at the log you sent, you can expect URING
> records without an associated SYSCALL record when the uring op is
> being processed in the io-wq or sqpoll context.  In the io-wq case the
> processing is happening after the thread finished the syscall but
> before the execution context returns to userspace and in the case of
> sqpoll the processing is handled by a separate kernel thread with no
> association to a process thread.

I spent some time this morning/afternoon playing with the io_uring
audit filtering capability and with your audit userspace
ghau-iouring-filtering.v1.0 branch it appears to work correctly.  Yes,
the userspace tooling isn't quite 100% yet (e.g. `auditctl -l` doesn't
map the io_uring ops correctly), but I know you mentioned you have a
number of fixes/improvements still as a work-in-progress there so I'm
not too concerned.  The important part is that the kernel pieces look
to be working correctly.

As usual, if you notice anything awry while playing with the userspace
changes please let me know.

-- 
paul moore
www.paul-moore.com
