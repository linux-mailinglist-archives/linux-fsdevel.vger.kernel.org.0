Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1C20432F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgFVWAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 18:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbgFVWAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:00:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20745C061573;
        Mon, 22 Jun 2020 15:00:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j10so5338761qtq.11;
        Mon, 22 Jun 2020 15:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rbwmv8Z/FP9ApAgbdwjt0jN7D1r57JUmODU4nLA9Mcw=;
        b=nKrUDlJ7NDzZ8GaINJaqizcT2hUYM1B1AOlOLE5hLf2MkYHTa+JsOUWbm9L6OKsRO6
         BAq2ynKZpJKaTqMDiZOyAsJXS8n8XbyM00GCctUp8qkzaHZETysYgvhuQt+8x9J/OMDQ
         NDa1SlTFEPPbJhY5rE4Dq09q/fIFj+83HTEat5Gz5lU4LYvx6OmHDEggXu/2if8NR8vi
         QzNYHmrG0xCS6HMsmMAIqEdAk0UMIqieoCUakd+ddd4S1GERmhDeQno+fVC1YEzDkG8f
         J5Jy+QRr8KhtDf7K029eNhajQyRVq4rAHT5wHjQ246Pyrmpl7dvHNxcYAQgI9A4AleDX
         UQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rbwmv8Z/FP9ApAgbdwjt0jN7D1r57JUmODU4nLA9Mcw=;
        b=W7JWDUtjGIzGx5dUp5yu7O8L0lzpMm2t3snKDOSGpAlWS9LWHs4IoxJVNy+ltiIcOO
         9Nxex/qG5PbsZO7g86/oNswhXeDwcfL5OO6OdKUFqlS8+deJjGcTtGJIXhKP7b+/TUOJ
         h5iqdPj4EJGQheXqUwQwmPQ8hEYrOXKObXbixDMEMYSB/RSUKTX2icUybqRzaJTcjs2d
         7C5TfaPK3WpWpLp9Yi8RfXpJKIXpeupztJ3Annt3ca/iccoAWpiDc2FqNTveG/Xjtwvi
         eBmn9ANFVTV9NfeyRRAR85xLbt61ohzUl86WEiiRpkYru9p6d0JTov1cBIZ6u/qAtztT
         2wWw==
X-Gm-Message-State: AOAM530WZDRVptGbcXEVfTXD+nww5wXgQOCQY7H4UKlajAq7fO6n2fwA
        YHFVNXmPe1UP88PO4CcOPehHObaapVNaef3cADs=
X-Google-Smtp-Source: ABdhPJyQpreJkF/hhbWDo7VT/jh/R4iAx7O6bLCYL2yAbMWc51SRvtco/EIZHB+pJK+3kFoGtNuigG9tWLHVONVsNCE=
X-Received: by 2002:ac8:5188:: with SMTP id c8mr18989475qtn.1.1592863250268;
 Mon, 22 Jun 2020 15:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200621043737.pb6JV%akpm@linux-foundation.org>
 <20a39fd4-622d-693c-c8d6-1fbab12af62a@gmail.com> <202006221445.36E03CCBE9@keescook>
In-Reply-To: <202006221445.36E03CCBE9@keescook>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 23 Jun 2020 00:00:39 +0200
Message-ID: <CAFLxGvw4NeBw3tDEnvL4USxgp--=vT1iXc6-tzAd_NkWCmUNFA@mail.gmail.com>
Subject: Re: mmotm 2020-06-20-21-36 uploaded (lkdtm/bugs.c)
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rd.dunlab@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Michal Hocko <mhocko@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        mm-commits@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 08:37:17AM -0700, Randy Dunlap wrote:
> > On 6/20/20 9:37 PM, akpm@linux-foundation.org wrote:
> > > The mm-of-the-moment snapshot 2020-06-20-21-36 has been uploaded to
> > >
> > >    http://www.ozlabs.org/~akpm/mmotm/
> > >
> > > mmotm-readme.txt says
> > >
> > > README for mm-of-the-moment:
> > >
> > > http://www.ozlabs.org/~akpm/mmotm/
> > >
> > > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > more than once a week.
> >
> > drivers/misc/lkdtm/bugs.c has build errors when building UML for i386
> > (allmodconfig or allyesconfig):
> >
> >
> > In file included from ../drivers/misc/lkdtm/bugs.c:17:0:
> > ../arch/x86/um/asm/desc.h:7:0: warning: "LDT_empty" redefined
> >  #define LDT_empty(info) (\
> >
> > In file included from ../arch/um/include/asm/mmu.h:10:0,
> >                  from ../include/linux/mm_types.h:18,
> >                  from ../include/linux/sched/signal.h:13,
> >                  from ../drivers/misc/lkdtm/bugs.c:11:
> > ../arch/x86/um/asm/mm_context.h:65:0: note: this is the location of the previous definition
> >  #define LDT_empty(info) (_LDT_empty(info))
>
> The LKDTM test landed a while ago:
> b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
>
> and nothing has touched arch/x86/um/asm/desc.h nor
> arch/x86/um/asm/mm_context.h in a while either.
>
> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?

True that, we can rip the file.

-- 
Thanks,
//richard
