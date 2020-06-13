Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7159B1F83F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 17:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFMPeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFMPeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:34:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03942C03E96F;
        Sat, 13 Jun 2020 08:34:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j12so7108859lfh.0;
        Sat, 13 Jun 2020 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjUp1aZacXSl469efXs/K8NncMUX+rtEEDwLEUTi3c8=;
        b=hCR4IPWUr5wNYg689+TEIg95ISR843+AEPYfTyr/Z2pgwEY/wrCDf6M92UbtG0rsnG
         EWhlCsS9mKZ9P3qhRWrtY1BaOvyD8SyLJOJkqsUYHOkHfE+JcOP6ty9zcvCsBN/pRjiM
         FjWBZw9cbyqoyPetNvJZGLClka9cvjUDPsuMfCyQHbKvXksLW8KS2+ggIEM+ai8CXDDJ
         qn4u0RIExSJU4tM7GFrD7bnGN7S4bxi/KdymwBRJmp4kxEKHMi0CinYgLkvX5xO1Rn+O
         cOSnpwViA3HS8zEjPOVyxV6uMo+fgsjQ+ms+qAmi3UjapHCC8UkjNEtMwTc8JzAfuskY
         qkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjUp1aZacXSl469efXs/K8NncMUX+rtEEDwLEUTi3c8=;
        b=gVrcCKhk15IeMJCffgdxAnMAtFrDeaHTnz3L6HkI6CerwWaSgARG2LjbHb2qvw8WWP
         BQIvZcMZxn+PV4pVdKoJC5VaRTVcPvs79NFGwDDoHCfFknBEwu87kBCYKKuhh5ZtzQwK
         Tcpbc6Ru27vo8QBbA2PuqXv87Tp2WfzCRoOcvYe19aRaddsBrq0Zr7UFDGynxLTOuNQn
         doRfbtGfAeUCfP7ZMbNNSQZxvLR3fqZ5q6JeRebsMq8s7RczirIJDG34BeVXc7JIszNU
         r0FnenOBjBkGtmU9mTYprHplqiokhHW14OiM7qW7FpT3NWwyo4zlZr/avFbBLvz4lMFx
         kDWg==
X-Gm-Message-State: AOAM533o8ZuVI1k6lKwF/W0/WSlnzUH3KHG+WDrczRVZOjPpASR3wKJD
        s9cTieRsWMH7YH/Ez0ECPc/xOq+W/Bv89MsfQkc=
X-Google-Smtp-Source: ABdhPJwWZLeJUm8avt2Ro0fSxLmd3OO1rG4ZcP3SlkITu14HiNc/o6GTJ59gqgiDaYw4/Rcoe2wzqqb7v+BdmFZMRec=
X-Received: by 2002:a19:103:: with SMTP id 3mr9164991lfb.196.1592062444322;
 Sat, 13 Jun 2020 08:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <202006051903.C44988B@keescook> <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp> <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp> <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org> <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org> <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org>
In-Reply-To: <87bllngirv.fsf@x220.int.ebiederm.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 13 Jun 2020 08:33:52 -0700
Message-ID: <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 13, 2020 at 7:13 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> I am in the middle of cleaning up exec.  Send the patches that address
> the issues and make this mess not a maintenance issue, and I will be
> happy to leave fork_usermode_blob alone.  Otherwise I plan to just
> remove the code for now as it is all dead at the moment.

May be stop being a jerk first ?
It's a Nack to remove the code.
