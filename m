Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF228CB39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgJMJxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 05:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJMJxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:53:48 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506DFC0613D0;
        Tue, 13 Oct 2020 02:53:48 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w141so21902589oia.2;
        Tue, 13 Oct 2020 02:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lyB08XWhqOUJQK6ifm/WpCCovJvCw1e4gjA29DSo70o=;
        b=Hle4/yXumsNYrAL4PtajK+6wiPj+EIy8o1isAuZSObqhOHmBzOQ1DvjJoAwAt4E5/R
         +P4O+f2qgAADtlkHSoOI+1VSqFnHP1zlO/XQjD3S8dfQX9hPnALnl01ziXfEUWxt3DfD
         vfB98mOJFqAyD4kZp6F/ffCQLvqzHF519AvdqCHPFO5tREiDPzGSQpD/rgpyxLR8RfM6
         Otn/hcCLfHQJ5Uc7ZctmYCFr5W33agu54nHvcjXg/j3cQO2O4lcE9QcbmDPfIOO8iDye
         JVnQ/21qKgB2KGEJY2ZjllPl0+AjasgdEELKaN8QvgbjGshpCSK5uRTA9v0cpsbdkAFK
         Uelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lyB08XWhqOUJQK6ifm/WpCCovJvCw1e4gjA29DSo70o=;
        b=NtgLIQolTbUUtYym6bf8bTf/PYZH9yW81sBpSlOH6TXcPMlXGkke+bOAsL4lv2qVxF
         skqDYiabnC8P0HnoVZqDb9vzEc++4wIie6+WYK2qtsrsgeCX0nhgsbgUavaLIjiQR30B
         szBTTgsiOb5ACL/7gXG12pPafg5jK26p3265kCOZOlI6slrSG5CEJNw9urb4q8aShOGE
         79FGnkiWvQbVe3VZL+M1Y+V1TE939JfAc+lb2W3AC/dRDhvd5gKxRDDEtzoMeXWUU/OP
         vMPiSjLkE7wJ4Zu/4NvdCLJyfgpBqAbwRryxh4QoM4HG3xB3u93/x5mcaQWl1XVFaKCw
         OaRA==
X-Gm-Message-State: AOAM531wqgQ2XHa1EKeQViTyWEnqUwxoe/+6yCZhwRlaYi8DQrtKRzTu
        Xxciy5yq3quAXSyY3fuBonlWmodoe98PA+zByfzvyGGkkSA=
X-Google-Smtp-Source: ABdhPJwvHK7qenSGPnVGtyxegEBVSleoetTJevfMvGpRo0rVhyTc9bUr3RWMz6+QrV7I0F9jPNV2KRGRBzj4ole9/sQ=
X-Received: by 2002:a05:6808:89:: with SMTP id s9mr2929894oic.58.1602582827567;
 Tue, 13 Oct 2020 02:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <87e23dfbac6f4a68e61d91cddfdfe157163975c1.1602093760.git.yuleixzhang@tencent.com>
 <72f4ddeb-157a-808a-2846-dd9961a9c269@redhat.com>
In-Reply-To: <72f4ddeb-157a-808a-2846-dd9961a9c269@redhat.com>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Tue, 13 Oct 2020 17:53:36 +0800
Message-ID: <CACZOiM0c9AdD97RrtBaSjFvteqWEqdU4SG1DFcLRZ49G=3u4-A@mail.gmail.com>
Subject: Re: [PATCH 04/35] dmem: let pat recognize dmem
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 3:27 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 08/10/20 09:53, yulei.kernel@gmail.com wrote:
> > From: Yulei Zhang <yuleixzhang@tencent.com>
> >
> > x86 pat uses 'struct page' by only checking if it's system ram,
> > however it is not true if dmem is used, let's teach pat to
> > recognize this case if it is ram but it is !pfn_valid()
> >
> > We always use WB for dmem and any attempt to change this
> > behavior will be rejected and WARN_ON is triggered
> >
> > Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
> > Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
>
> Hooks like these will make it very hard to merge this series.
>
> I like the idea of struct page-backed memory, but this is a lot of code
> and I wonder if it's worth adding all these complications.
>
> One can already use mem=3D to remove the "struct page" cost for most of
> the host memory, and manage the allocation of the remaining memory in
> userspace with /dev/mem.  What is the advantage of doing this in the kern=
el?
>
> Paolo
>

hi Paolo=EF=BC=8Cas far as I know there are a few limitations to play with
/dev/mem in this case.
1. access to /dev/men is restricted due to the security requirement,
but usually our virtual machines are unprivileged processes.
2. what we get from /dev/mem is a whole block of memory, as dynamic
VMs running on /dev/mem will cause memory fragment, it needs extra logic
to manage the allocation and recovery to avoid wasted memory. dmemfs
can support this and also leverage the kernel tlb management.
3. it needs to support hugepage with different page size granularity.
4. MCE recovery capability is also required.
