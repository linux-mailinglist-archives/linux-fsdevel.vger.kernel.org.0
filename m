Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA215B9B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 07:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgBMGmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 01:42:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38240 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgBMGmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:42:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so5263987ljh.5;
        Wed, 12 Feb 2020 22:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMmuNpdrddhrOWh+4K56L0YF6Be/7s8PGs+t3nQ9XBc=;
        b=q/D+kHXKQDgR3fVVwhifALKcssH8rymF8OkkigRJ302Sa9VjPP4heu3ZtnMqMs8SWS
         XLPb3FgDKBPMSWeu6sBU2k7bJZZY5mxwdfBDKVH2vG+qwbJUgymN/AujzSnIagkpxI8B
         6IwKRdth3Zw+n5TUFfbmmfKzR43Iv0b79GWIjqXfELXZy4lQWLgLSvuy+Pe+SinogQXV
         DFIka3jUmL7L2OdQDyh8pzvkFvrUGmOHBHsiW5GIFzJzlVvItSTQyyKNlBqhglDkJW36
         l35RuZ+o9SfVEpIwM2nUIAoj4Qaz+IBhHPe25z+ffapxWwPj6Bx2eMsdnxjwbVhuIx65
         MLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMmuNpdrddhrOWh+4K56L0YF6Be/7s8PGs+t3nQ9XBc=;
        b=RiZIQs4OWwu9m4IJjhLdOiAYiZyTlE1hsSMXQhh8y0O4aCyeK6zlP6F5KD+71WQpBX
         94cLd3pxZs6R+pnPb42pIcWPWnHzZI7MA9JXB+Kyu3KgXGpkB8yRiicSsMprPYY5MfKS
         g3s/oI+4jM45qopXkbpQ/IH+0tAXgDo0ZcUp3kSp4JWiUTgprhrvYtEem0hKYd7EKZBE
         DBZVUhgXffgNFpveEzxAxoTe4l8dlTzrjgQx12yZtmaq0EO3Zb1wexeA2uMjGcB4rzBf
         M4120sTV426pJTJq0qYpT/zIfSx3oxR3JQpT7S92hJeJaqjxBxAQ/ZnntPGWy+/y7Hk/
         RiLQ==
X-Gm-Message-State: APjAAAU3Fu+qJ6qvArydgSkF5EbriArZJTCr61ZrV3Yln/wN/CTu3UGP
        iHtaUOe1jC84OuZ+A5WCXAs54L44Kh4xU2btrAw=
X-Google-Smtp-Source: APXvYqxCY8Esw9mb9wmG/UGxD0UUKDvMB5s9SYeKowx88j1tinMMSnQmnoAJmOf7qqFYYldszD00sy05EvzJKFOoz2U=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr5046527ljn.64.1581576118811;
 Wed, 12 Feb 2020 22:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
 <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
 <1580998432.5585.411.camel@linux.ibm.com> <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
 <1581366258.5585.891.camel@linux.ibm.com> <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
 <1581462616.5125.69.camel@linux.ibm.com> <6b787049b965c8056d0e27360e2eaa8fa2f38b35.camel@gmail.com>
 <1581555796.8515.130.camel@linux.ibm.com>
In-Reply-To: <1581555796.8515.130.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 13 Feb 2020 08:41:47 +0200
Message-ID: <CAE=NcrYwBZVT+xTn384K3fit6UFUES62zsibL=7A5C8_nYaq8A@mail.gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     david.safford@gmail.com, linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 3:03 AM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > This is a pretty important new feature.
> > A lot of people can't use IMA because of the memory issue.
> > Also, I really think we need to let administrators choose the tradeoffs
> > of keeping the list in memory, on a local file, or only on the
> > attestation server, as best fits their use cases.
>
> Dave, I understand that some use cases require the ability of
> truncating the measurement list.  We're discussing how to truncate the
> measurement list.  For example, in addition to the existing securityfs
> binary_runtime_measurements file, we could define a new securityfs
> file indicating the number of records to delete.

I don't have strong opinions either way, just let me know how to adapt
the patch and we will get it done asap. I'd prefer a solution where
the kernel can initiate the flush, but if not then not.

Thanks everyone for all the help.


--
Janne
