Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B905F4AB315
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 02:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiBGBWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 20:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:22:19 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936ACC06173B;
        Sun,  6 Feb 2022 17:22:18 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id w21so20344341uan.7;
        Sun, 06 Feb 2022 17:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jHTnR5GobKzUMKBNLltF74ItkF07WMZsWwxMYQZjeIc=;
        b=m/yyUgslxPpRsFcbvaxYgQnhBsoJgqsBtOGyCqlcuVlLtLpXpwNKLWVkimQfwDbgNN
         G3VzNQWFI/TpMvwUuKE+Q1xPNi7DTxW3FqA6dbw/VrvNe0P+NUq2kmGbaDm0MRaeH3gr
         aOodhTcyVMF9g3QzbxCasR159dB3pKupio1SaJxiFMmE8OAaYdw4lrxSv85F7axlnACX
         4/rN3LB4axQIfi6edpSvovQKHbG7vBk8FZU6NDexVQAeoeuDeKcHQQmvd9l740gDZwHE
         2OdWxQG/5FQikVjyKLGe/Jzej95vgz54z6G/2c2ll5Z34kl1YWWb4Keh0nZRzdP+WPE/
         e4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jHTnR5GobKzUMKBNLltF74ItkF07WMZsWwxMYQZjeIc=;
        b=AQtkiRzk8Nei9JakikDUTW8QDL9G1ME7RGPCHTIdmaUlUs12fxI+mXmZ6ZGGywINUA
         uC3FZIDvpSXsLHfQhm8RyhjbWdT7HokKEuFXKJVaQf+kkVxLODRHv0cV9eDNt9K097wf
         lfqBiczBirvzLE5FczjYexl6gkUVI8axWbehfXCXSluKsmFRKgMA9QG5o5d0BYqUHPZp
         KTH/xmYIVMD5f42NvtelE+i26LRq1MNisnDiSs9i71wl3iEPS32rRsA0i1IJXhgD9tj4
         oO5/GXJ5prlWAuIFKFrxGJmG/O9DELwZgl3/2c135aUXaAxufdLJQyPFUeB9JhxOjnu4
         o9MQ==
X-Gm-Message-State: AOAM53082CCMTZnJ+qDHRrKI3hAlckwzI0PVfTnJsQL7keveMwhHyqZH
        keZAxykF/YPs1UkoZ1wkyiOA0bYQd4j/8BXRAct+hd8ps/AYI8vr
X-Google-Smtp-Source: ABdhPJyqlv+pMNDZdv4z0FLnRXOeve02sbLMzOFljLZjcO9Ruce3F3q/7N6VIiUmgBTpWLlP34wTlkOHmar3+ncOA0Y=
X-Received: by 2002:a67:c907:: with SMTP id w7mr3792074vsk.60.1644196937107;
 Sun, 06 Feb 2022 17:22:17 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org> <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
 <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com>
 <Yf/DiefrNOkib5mm@casper.infradead.org> <CAPj211uFgCyri=RKnOJs2cV7-9FRFjOPLti8Jo0ODZeHEPgGAw@mail.gmail.com>
 <CAOE4rSzJtDwDpb6PDN-E1i=b5p6jePu7wnKKgwr8dnwextaxUw@mail.gmail.com>
 <YgBegj4a/0/PkRlc@casper.infradead.org> <CAOE4rSxV-BbpwNYe7cfY8Ag_mWY930yG3pubqASKHjsKXAp6TA@mail.gmail.com>
 <YgBwet7Av2qkaMaJ@casper.infradead.org>
In-Reply-To: <YgBwet7Av2qkaMaJ@casper.infradead.org>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Mon, 7 Feb 2022 03:22:06 +0200
Message-ID: <CAOE4rSy81hycALngZgCRj9vMR5rLU0Fq1F-g_N72bqvkVmpMsg@mail.gmail.com>
Subject: Re: How to debug stuck read?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     FMDF <fmdefrancesco@gmail.com>, linux-fsdevel@vger.kernel.org,
        BTRFS <linux-btrfs@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pirmd., 2022. g. 7. febr., plkst. 03:06 =E2=80=94 lietot=C4=81js Matthew Wi=
lcox
(<willy@infradead.org>) rakst=C4=ABja:
[...]
>
> I can't think of a way to solve that.  We can't know whether a dying task
> "was going to" unlock a page.  So we have a locked page in the page cache
> that nobody will ever unlock.  We can't remove it, because we don't know
> that task died.  We can't start I/O on it again, because it looks like
> I/O is already in progress.
>
> I think the only answer is "Don't ignore stack dumps in dmesg".

So looks like this is the conclusion of current state.

> We can't remove it, because we don't know that task died.
This seems pretty bad, maybe if there was build time option that
enables logging (eg. PID and lock time) for locked pages it could help
with debugging this and maybe allow even to force unlock. But then
again since there should be stack dump and I guess this is very rare
case of happening maybe it's not worth it.
