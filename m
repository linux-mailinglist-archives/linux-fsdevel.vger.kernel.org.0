Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36521F8441
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgFMQOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFMQOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:14:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D4C03E96F;
        Sat, 13 Jun 2020 09:14:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so14393906ljh.7;
        Sat, 13 Jun 2020 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Z22YICQz99p/3fJOvv++fyY9F0HKpG3y5w4PdDzU70=;
        b=A1P9spR+f6bHj2n3TGvTWpFq9f4pLAWeJGvVcGB+vUsLZ1v6T2k5rcVSZVvWoP85vD
         Lxk6eSMAclQNHOo30Xvdm8BI1NSLIBi1svdH6pZhjnKu4deA8hm6f7xKyE062cnSIRMi
         z2F2b8+iI62pLgTXXd7WtwZDhtTocRO4MCGzEaI6DpMtt/QltemDBGbZycBSLBcIg0Wg
         N6K01/GjeoOEqlafAbCBKLdW20SecoB26XYYKzOMztTL4ynoZQNOSdzVXxEzslFNu18B
         o8McVjf2bGN12SV/T0QkX2r/tRZ5N+Vd4m9G6n1zD4RJ/cuLIh6Qg12SRDCCPq3aweO3
         kvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Z22YICQz99p/3fJOvv++fyY9F0HKpG3y5w4PdDzU70=;
        b=ig5pzXN6jYcX2a+6H1DHUbGnAsBo0Bxh2nzCyUXiyuPJtp3klrb7Yczn0pGRyl14vI
         xbGYQEkn+2hwZxti0MVN0125Y0K+pxV2OZ0ODu5su0kgDcMWM5OgWrs8ZyOadSesxQ5l
         IYPmWTelf7MK6c3gMc4kUC0ZfRqDp0To1K51d/FHGQvxVe/rd+a3dvrYw2G1KIRvhQPZ
         pbUKDpSHnUv2fZbHuLeDBOyyjbQO+0G5GaF+HC8BBHzOslrlEg8N76TkT+UOIg2ijNg/
         AbjfAVNFcRgqkbgY9yo6SqXf3sB4S2TyF2bo5X3fFqT+g8n7+rNNEwYvz+v3Ycs/5H9V
         3KdQ==
X-Gm-Message-State: AOAM531HNgc7amSdQ/kLN1GxrZ62o8JDaiJZjlDj7XHP0xZ9C1bZrm3G
        9gWldPB63tGTX0EkXd32VLT8A6rmwfr+eTfRGjc=
X-Google-Smtp-Source: ABdhPJzOKo/GorobPu735mwueaLomXxYZbLz9eL+BquGghJcyzOhJo2f4GfhEul/wctM5P5KLsVXWiuXCE+fuAgQOBQ=
X-Received: by 2002:a2e:b1d4:: with SMTP id e20mr8884027lja.290.1592064854002;
 Sat, 13 Jun 2020 09:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <202006051903.C44988B@keescook> <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp> <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp> <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org> <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org> <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org> <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
In-Reply-To: <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 13 Jun 2020 09:14:02 -0700
Message-ID: <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
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

On Sat, Jun 13, 2020 at 8:33 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Jun 13, 2020 at 7:13 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > I am in the middle of cleaning up exec.  Send the patches that address
> > the issues and make this mess not a maintenance issue, and I will be
> > happy to leave fork_usermode_blob alone.  Otherwise I plan to just
> > remove the code for now as it is all dead at the moment.
>
> May be stop being a jerk first ?
> It's a Nack to remove the code.

I'm happy to work on changes, but your removal threats must stop
before we can continue discussion. ok?
