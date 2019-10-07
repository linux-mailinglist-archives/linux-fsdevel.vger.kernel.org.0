Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33155CECFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfJGTtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 15:49:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39155 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:49:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so21004293qtb.6;
        Mon, 07 Oct 2019 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKLRuow+S9OqCZD+ZwnXS5BKikj0oOH26JZuOKs1SBc=;
        b=MWQHgu8Lz7xXr6b3L0k+K5jZEIYjkw/PzSJnogPsH4dvevuA4viSxuR3XyJJLMTU3s
         evwiIbB1wBE/1qzIo3U6Qn6WgHlmV1cBIG1GN1zrY73xpHCiS13oGNT/BeWRjR5fF2NM
         HpRGtFRJBABpbaZZznvfaV/D/qITCU1cBdcg99QA67L1CS4uNepyE2CKIWuqgwnSJUC8
         zCmMVXX1mxBsNSGcuOB7Wa+MXTsWyITwS6fqtcPWSClHvApLJGQkt++jYbmF5CgSh/bj
         5U4nGmRMJWCv5DOSAlRmiUW6qVUzqSQWhKS1ULlg1mTc6veg+nhUFqr+J/mkFyYcff1Y
         w/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKLRuow+S9OqCZD+ZwnXS5BKikj0oOH26JZuOKs1SBc=;
        b=GqBR7YaAPivnVDn+TKJpKbZ+jIv6d8Y0IKFKutRC4UHfgpcWq7rVBmr77Z3DOm0BMG
         hyJOE3cgmR60Ba86UkTb0xQA0ywmc0ngsi0jFuBEpZs12LESOUHdRGOvYxr3bcmv9iSA
         q00NPTlGeYqc2RGtGLSAq+t8WVf+vM3luy0nc4vJ9QWVdMR2vlYhflYbC1/u5v1LXMes
         Q0Dt76S6HLUf7pGJAK/MUXrEbwpDqfqNK/Pnkdh8brHwvyTQOtK0Souqwk7MhFjOetUm
         pYgoVA1sRteVgP2GzkZB7bVw91sqRJ2n8JlXuxFj403KCngDINSd4cJRhe52y+IRPSAL
         geNg==
X-Gm-Message-State: APjAAAVK5RCg6gqfiuxZGQ2M5pfyP1ENoaoArpWgLHKuOQRvK/KXo79H
        it0lXpjoAHPSaNzmDY3RZ8mbkyRcK1i7KgG5+NJC+B/B
X-Google-Smtp-Source: APXvYqy2jUwKRM/1cgnebb/SrMNeOdv41+/4DHRsPW8ShXC7QjVzqeFwUeQZOsY43/WTEahxNAJp8tHcNm1yfslt7uM=
X-Received: by 2002:ad4:42c8:: with SMTP id f8mr28230703qvr.94.1570477770597;
 Mon, 07 Oct 2019 12:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <CA+8MBb+VKk0aQZaJ+tMbFV7+s37HrQ6pzy4sHDAA3yqS-3nVwA@mail.gmail.com> <CAHk-=wi3P2NvBNocyNFTAb-G08P0ASVihMVKmiw__oNU4V2M5g@mail.gmail.com>
In-Reply-To: <CAHk-=wi3P2NvBNocyNFTAb-G08P0ASVihMVKmiw__oNU4V2M5g@mail.gmail.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Mon, 7 Oct 2019 12:49:19 -0700
Message-ID: <CA+8MBb+Vubsx3Qyav25tgUgiGbs1XmEwoaCXTM=8jk4m2CxRbw@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Hmm? I thought ia64 did unaligneds ok.

If PSR.ac is set, we trap. If it isn't set, then model specific
(though all implementations will
trap for an unaligned access that crosses a 4K boundary).

Linux sets PSR.ac. Applications can use prctl(PR_SET_UNALIGN) to choose whether
they want the kernel to silently fix things or to send SIGBUS.

Kernel always noisily (rate limited) fixes up unaligned access.

Your patch does make all the messages go away.

Tested-by: Tony Luck <tony.luck@intel.com>
