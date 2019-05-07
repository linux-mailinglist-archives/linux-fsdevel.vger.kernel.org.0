Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F516C8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfEGUrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 16:47:52 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:44325 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEGUrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 16:47:52 -0400
Received: by mail-lf1-f46.google.com with SMTP id n134so11029325lfn.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kdv9nSMUlrd4GCcRzSl6xwpcWlq/+hgYrQfZOrRT0o0=;
        b=fw3e0JpONfe14HLxlQvZ2U3hr0x7TDuvkN0RlwCV93UKyTNtDvwVwnvfsR+Rdm8OvQ
         d9U1/wxrnRU1b9xSr9mcESjhOoUpP56iLcf5x/OuRqB4UK7nxDPSJfODTUimerSkT5VS
         5JDnUuUXPHTP6KvPlgPnFy9QyyzWqfmGYYJgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kdv9nSMUlrd4GCcRzSl6xwpcWlq/+hgYrQfZOrRT0o0=;
        b=hH7uJjKILujc1uBWcGtHpt4h845T0AO3Krj7f/PIE08qNz2Etxj9Hi+6DL5vnH1rKk
         5hNsD5KwZuRf/LHUjMv+0oxfGQJ2fkI/ksa7GoGVEDPrxNxOu0fY4QTnlhAuXuh9teQb
         Pp2CSjna4cAdSXiRH6gkBO685DbAJkyMOwOaXNIzQ1PkIftZ2X/W2Dg0GIVb2LY6BdXP
         C/3vZLXeHg4adCx2gEJUJRQC/pssDaW1q8/KrtO/PrsyBGyJKGvRY3FmjbFQO1MRIwu9
         rkoc0naWYBDs7STnFLIUIn0zZuXL8q7EoRCRXwGnL4CHXnJ6iFlDrUGswQhAuoiFFu23
         beZQ==
X-Gm-Message-State: APjAAAUCgXB7Zxj0J3wkCCrV9kOCsX8hKK8pIj4yBQWvwn9cxTiBTn+F
        v5O/tQnMJHd4mW2f6plHDaobvEOTUis=
X-Google-Smtp-Source: APXvYqyC4Hd0dYW2r1V2UHkcljcYZizZ+smybQ3E9NOp6ROXJnWujHev+76PpwbeaIWesXiQjzhjFg==
X-Received: by 2002:ac2:5c48:: with SMTP id s8mr18727161lfp.126.1557262069240;
        Tue, 07 May 2019 13:47:49 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id m19sm3485010ljg.35.2019.05.07.13.47.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:47:48 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id z1so3344319ljb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 13:47:48 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr16963855ljj.79.1557262067816;
 Tue, 07 May 2019 13:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
 <20190507004046.GE23075@ZenIV.linux.org.uk> <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
 <20190507041552.GH23075@ZenIV.linux.org.uk> <CAHk-=wiQ-SdFKP_7TpM3qzNR85S8mxhpzMG0U-H-t4+KRiP35g@mail.gmail.com>
 <20190507191613.GI23075@ZenIV.linux.org.uk> <CAHk-=whbaKc+5HvXypMTrS9qGzL=QCuY9U_27Yo8=bHC6BpDsg@mail.gmail.com>
 <20190507195503.GJ23075@ZenIV.linux.org.uk>
In-Reply-To: <20190507195503.GJ23075@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 13:47:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj-JPwYzmn6tCJHV219Z4nOPrNCYJr04DyCzoNZb79AQ@mail.gmail.com>
Message-ID: <CAHk-=whj-JPwYzmn6tCJHV219Z4nOPrNCYJr04DyCzoNZb79AQ@mail.gmail.com>
Subject: Re: system panic while dentry reference count overflow
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     yangerkun <yangerkun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 7, 2019 at 12:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>
>         Provided that lockref.c is updated accordingly (look at e.g.
> lockref_get_not_zero()).

Yeah, we should likely just make this all a lockref feature.

The dcache is *almost* the only user of lockrefs. We've got them in
gfs2 too, but that looks like it would be perfectly happy with the
same model.

>         lockref_get_not_zero() hitting dead dentry is not abnormal,
> so we'd better not complain in such case...  BTW, wouldn't that WARN_ON()
> in dget() belong in lockref_get()?

Yeah.

              Linus
