Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AEAD7F7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 21:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfJOTAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 15:00:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46059 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfJOTAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:00:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so21363094ljb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMAvaim9+S74+cLKGfKpPV0jt0ePKq4pl+dUnol7U2k=;
        b=DhI3jZcx/uyOLfu8ny5Lt1siVQgFVsCm5kmsY6i2FCqBbzb8QH9PPyTN8DCmdhDr5S
         A4G11LYL3O44P/4Ql7Jt/VeZd1nO1dKf4kVncZj73MdbJR4Dzd9pa/QE5Xu42b6DB/NB
         KjEixpuat22YXDmNzVBhKNDv8Olnc7lfHEeOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMAvaim9+S74+cLKGfKpPV0jt0ePKq4pl+dUnol7U2k=;
        b=cA9m2IA2EzKsNBjOaFVTBLU0FqeyLR4tpWBeFLtIKXuCKXFw6M89xQ7kuJ9smuHscH
         jGvG58aq2LTjNDieKs2l5Y/eDFSqX0WiX5fep09pZ6GUMyBLGOpMfOnmUjdGDgIkv2mr
         qJhsbuWaS2YB11m269h+giIiFRggHIJx4v667CHNDANdFjHVuJan2wXo7QP775axWhyj
         KLMIZ3wkd5wWWDae09F4BNGK5jTylN/GgYl6S3nSBeOnCHytVaBP+9wcJiX/CTmolio7
         m2aqZ8ixB4yIMmm3vPqcGmpe2YnJsafKU8GidN0FcxSriLvYItJ45zOth7HTxU4wZ0hY
         2wMw==
X-Gm-Message-State: APjAAAVJw0R4Wy5beT7TNceuH8I/oCkZy4pneWPFq12kG11cbOE9JBU2
        0o9r7/APkQKD+kGtrNYKzUOnde53Q7g=
X-Google-Smtp-Source: APXvYqwdDr4fwXKyFS4Y2dWLJNLXQY0uSuF2EDlPZtQTmzbHGzoD72sJBlK+xpadZ48gxOUIgrhN7w==
X-Received: by 2002:a2e:420a:: with SMTP id p10mr12865162lja.16.1571166052874;
        Tue, 15 Oct 2019 12:00:52 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i17sm5352048lfj.35.2019.10.15.12.00.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:00:51 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id l21so21413620lje.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 12:00:51 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr1159643ljf.133.1571166050946;
 Tue, 15 Oct 2019 12:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk> <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk> <20191015180846.GA31707@ZenIV.linux.org.uk>
In-Reply-To: <20191015180846.GA31707@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 12:00:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjyiiYhAbzVDUW1F3j9CAcu8+ugSvGYwUivdBfKoeU6yA@mail.gmail.com>
Message-ID: <CAHk-=wjyiiYhAbzVDUW1F3j9CAcu8+ugSvGYwUivdBfKoeU6yA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:08 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Another question: right now we have
>         if (!access_ok(uaddr, sizeof(u32)))
>                 return -EFAULT;
>
>         ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
>         if (ret)
>                 return ret;
> in kernel/futex.c.  Would there be any objections to moving access_ok()
> inside the instances and moving pagefault_disable()/pagefault_enable() outside?

I think we should remove all the "atomic" versions, and just make the
rule be that if you want atomic, you surround it with
pagefault_disable()/pagefault_enable().

That covers not just the futex ops (where "atomic" is actually
somewhat ambiguous - the ops themselves are atomic too, so the naming
might stay, although arguably the "futex" part makes that pointless
too), but also copy_to_user_inatomic() and the powerpc version of
__get_user_inatomic().

So we'd aim to get rid of all the "inatomic" ones entirely.

Same ultimately probably goes for the NMI versions. We should just
make it be a rule that we can use all of the user access functions
with pagefault_{dis,en}able() around them, and they'll be "safe" to
use in atomic context.

One issue with the NMI versions is that they actually want to avoid
the current value of set_fs().  So copy_from_user_nmi() (at least on
x86) is special in that it does

        if (__range_not_ok(from, n, TASK_SIZE))
                return n;

instead of access_ok() because of that issue.

NMI also has some other issues (nmi_uaccess_okay() on x86, at least),
but those *probably* could be handled at page fault time instead.

Anyway, NMI is so special that I'd suggest leaving it for later, but
the non-NMI atomic accesses I would suggest you clean up at the same
time.

I think the *only* reason we have the "inatomic()" versions is that
the regular ones do that "might_fault()" testing unconditionally, and
might_fault() _used_ to be just a might_sleep() - so it's not about
functionality per se, it's about "we have this sanity check that we
need to undo".

We've already made "might_fault()" look at pagefault_disabled(), so I
think a lot of the reasons for inatomic are entirely historical.

                Linus
