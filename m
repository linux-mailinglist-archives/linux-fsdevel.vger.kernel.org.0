Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5E20FFC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 23:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgF3V6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 17:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgF3V6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:58:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40591C061755;
        Tue, 30 Jun 2020 14:58:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so9778881ljl.3;
        Tue, 30 Jun 2020 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RR/UNoI7uOiKww7o9+rFTcbImZ17UI5RyQbYWAUPpvM=;
        b=iJODyCvU2nZ44YgjY0+h7PYFr8bUm1v/dfcPFTwyhwfUTbQtYDODJNoZKcMdJvlKX0
         L5q/qZi5MVLiWFoe7z+Sb57bxais8fPl62U6luMni2am6yZwHMab7pN/ysPQnK9q36sc
         eOzOHSRutQ/RYWsoDaZFk/icfmYv1u9EPm6/9IXBOe413QEbAJiw+YeRHluCLU0Rzqsq
         LOg/zjJwykLIqewbAO80JRafO5N0U7qpMf9HeklaG/D0vGjHgLOAijxNevggEgHCT7wz
         xTHPxz5DJ1+XDASvmnurklA5+gjMejTBkVebCHY4HcPyoTQIDvM64o4W6EFHVLSqg7IF
         GS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RR/UNoI7uOiKww7o9+rFTcbImZ17UI5RyQbYWAUPpvM=;
        b=d55gFnIowzNjiq+1bwK8EXUY1PAMZMnyM/2aaCh92h5Tqioq8/xnJxwSkehNo6ewKv
         /QAcTRpeScgPEdi6EcqWRf0Mfy5wwBX1+/BNCAN5VakWfnCQnpCfCLnpRtgfqdb9naYA
         a0xtr7NZU0fIY0OYguiqtZNzuAD44nAQhzEc4Jkvkmp5H0lEXvVPvVF2psMi+kQiVpnk
         In9mypncT9sxQhtTCBhexUNMaerSWi8ncrQ1SqILFbJvdf/Wo+E08Skm5zT3WUTizHFr
         sLh7H7ht87ZjGiRhKgk4eacXTroaiYHkj+swLsnv0SV0oNcBFXTOO2ETog+aNZY2z/TV
         sMXg==
X-Gm-Message-State: AOAM531ODlB+6iCH1ayvR98Pzc01T2AmRzbUuOu3NPsqAe2ytDgrbFtJ
        27vSZ5mLr9xOYvXsuS/ORBFuUo4X5krmKNRLF08=
X-Google-Smtp-Source: ABdhPJxMOq1MHbq9NqdaWC/RlC3zbcLh0U2x964uF2dtLoJiI7GgbNv49vIL8FhnvXggN3dxv2yfLtKmgwYP1ngfZZ4=
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr12006024lji.450.1593554289688;
 Tue, 30 Jun 2020 14:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
 <87366g8y1e.fsf@x220.int.ebiederm.org> <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
 <20200628194440.puzh7nhdnk6i4rqj@ast-mbp.dhcp.thefacebook.com>
 <c99d0cfc-8526-0daf-90b5-33e560efdede@i-love.sakura.ne.jp>
 <874kqt39qo.fsf@x220.int.ebiederm.org> <6a9dd8be-333a-fd21-d125-ec20fb7c81df@i-love.sakura.ne.jp>
 <20200630164817.txa2jewfvk4stajy@ast-mbp.dhcp.thefacebook.com> <c7d4df91-d78e-5134-2161-192426fc51cd@i-love.sakura.ne.jp>
In-Reply-To: <c7d4df91-d78e-5134-2161-192426fc51cd@i-love.sakura.ne.jp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 30 Jun 2020 14:57:58 -0700
Message-ID: <CAADnVQKrRpjQpc9-xMizCPr1E12_jXrvH-kaKwxBmvQ03n_uiw@mail.gmail.com>
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 30, 2020 at 2:55 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/07/01 1:48, Alexei Starovoitov wrote:
> > On Tue, Jun 30, 2020 at 03:28:49PM +0900, Tetsuo Handa wrote:
> >> On 2020/06/30 5:19, Eric W. Biederman wrote:
> >>> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> >>>
> >>>> On 2020/06/29 4:44, Alexei Starovoitov wrote:
> >>>>> But all the defensive programming kinda goes against general kernel style.
> >>>>> I wouldn't do it. Especially pr_info() ?!
> >>>>> Though I don't feel strongly about it.
> >>>>
> >>>> Honestly speaking, caller should check for errors and print appropriate
> >>>> messages. info->wd.mnt->mnt_root != info->wd.dentry indicates that something
> >>>> went wrong (maybe memory corruption). But other conditions are not fatal.
> >>>> That is, I consider even pr_info() here should be unnecessary.
> >>>
> >>> They were all should never happen cases.  Which is why my patches do:
> >>> if (WARN_ON_ONCE(...))
> >>
> >> No. Fuzz testing (which uses panic_on_warn=1) will trivially hit them.
> >
> > I don't believe that's true.
> > Please show fuzzing stack trace to prove your point.
> >
>
> Please find links containing "WARNING" from https://syzkaller.appspot.com/upstream . ;-)

Is it a joke? Do you understand how syzbot works?
If so, please explain how it can invoke umd_* interface.
