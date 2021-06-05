Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174A939CA7F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 20:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFESZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Jun 2021 14:25:34 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:43734 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhFESZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:25:33 -0400
Received: by mail-ej1-f50.google.com with SMTP id ci15so19533139ejc.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Jun 2021 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWseLMsHC1Tl+tjltvawHbNPgfRx7qxCEi8/dkUNOU4=;
        b=dq91qTUDZfLAHHlQj01Xackwp7mLXGslcYSqKR8QjQWjay1MPlIiBx9Q2OjLRJv3Ny
         tUvoHIhp+fIOQUEt5cgx436HWwJytvd/+6hnvkb9my5cWuHI21RlTnevNOOSMWGTQ9Xp
         QlUNP5FJUEwnP+uHbMzVIztOiIoJLIajgm2Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWseLMsHC1Tl+tjltvawHbNPgfRx7qxCEi8/dkUNOU4=;
        b=jDRl+jUxFOwQcp09o6lM6lTaGt9d0Z9QiKn3uTlbwEPMSHwpBnUbDCU1kuw3YXOGaT
         HYulwgf0z5JMu566xQwooKUzNj5vj8XXytpiYcUfrafBNygCYd+tUO39oarlc3g823hR
         bxvwfQVLzgklEdncXoMNbElCMTCknmzBNDmwJ8p2SqVDX8Q6Aba9fJShDfKsov9bDw2d
         1N6fI+/k7IVuAFw1DjH8B1bbaMGEADRAhBKog7jyTajwr0uBakNgoM+Si9tYz46zPdeg
         DTxOI7t47OC8nrp6H28MrOE0ISGLh17U2EpMyFRPbYCyyIQK70rHp/ieFNx723I0X64d
         ngIg==
X-Gm-Message-State: AOAM532hecOTJiqExY70lHhMmwgYHeOex+BCjcGZD03GbcVv3k9OFkV8
        ML6ZWLTYYjNqe90KNfsVkGwFOGCUMdEnXzX4JM0=
X-Google-Smtp-Source: ABdhPJzQSxGy0ZNALipaizoDZMBmL/zbcb7Zajon591+Aw4fXP5yjWw6yKF7UguOOINtE+U3bhRuIQ==
X-Received: by 2002:a17:906:68c1:: with SMTP id y1mr10165429ejr.32.1622917354933;
        Sat, 05 Jun 2021 11:22:34 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id h6sm1657649edj.91.2021.06.05.11.22.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 11:22:34 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id z8so12563565wrp.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Jun 2021 11:22:34 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr6305938lfs.377.1622917038058;
 Sat, 05 Jun 2021 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <CAHC9VhTasra0tU=bKwVqAwLRYaC+hYakirRz0Mn5jbVMuDkwrA@mail.gmail.com>
 <01135120-8bf7-df2e-cff0-1d73f1f841c3@iogearbox.net> <CAHC9VhR-kYmMA8gsqkiL5=poN9FoL-uCyx1YOLCoG2hRiUBYug@mail.gmail.com>
 <c7c2d7e1-e253-dce0-d35c-392192e4926e@iogearbox.net> <CAHC9VhS1XRZjKcTFgH1+n5uA-CeT+9BeSP5jvT2+RE5ougLpUg@mail.gmail.com>
 <2e541bdc-ae21-9a07-7ac7-6c6a4dda09e8@iogearbox.net> <CAHC9VhT464vr9sWxqY3PRB4DAccz=LvRMLgWBsSViWMR0JJvOQ@mail.gmail.com>
 <3ca181e3-df32-9ae0-12c6-efb899b7ce7a@iogearbox.net> <CAHC9VhTuPnPs1wMTmoGUZ4fvyy-es9QJpE7O_yTs2JKos4fgbw@mail.gmail.com>
 <f4373013-88fb-b839-aaaa-3826548ebd0c@iogearbox.net> <CAHC9VhS=BeGdaAi8Ae5Fx42Fzy_ybkcXwMNcPwK=uuA6=+SRcg@mail.gmail.com>
 <c59743f6-0000-1b15-bc16-ff761b443aef@iogearbox.net> <CAHC9VhT1JhdRw9P_m3niY-U-vukxTWKTE9q6AMyQ=r_ohpPxMw@mail.gmail.com>
 <CAADnVQ+0bNtDj46Q8s-h=rqJgZz2JaGTeHpbmof3e7fBBQKuDQ@mail.gmail.com> <64552a82-d878-b6e6-e650-52423153b624@schaufler-ca.com>
In-Reply-To: <64552a82-d878-b6e6-e650-52423153b624@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jun 2021 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUVqHN76YUwhkjZzwTdjMMJf_zN4+u7vEJjmEGh3recw@mail.gmail.com>
Message-ID: <CAHk-=wiUVqHN76YUwhkjZzwTdjMMJf_zN4+u7vEJjmEGh3recw@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 5, 2021 at 11:11 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> You have fallen into a common fallacy. The fact that the "code runs"
> does not assure that the "system works right". In the security world
> we face this all the time, often with performance expectations. In this
> case the BPF design has failed [..]

I think it's the lockdown patches that have failed. They did the wrong
thing, they didn't work,

The report in question is for a regression.

THERE ARE NO VALID ARGUMENTS FOR REGRESSIONS.

Honestly, security people need to understand that "not working" is not
a success case of security. It's a failure case.

Yes, "not working" may be secure. But security in that case is *pointless*.

              Linus
