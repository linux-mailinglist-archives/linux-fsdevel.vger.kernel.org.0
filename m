Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E933B305251
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 06:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhA0FqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 00:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhA0FNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:13:52 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F016C061756;
        Tue, 26 Jan 2021 21:13:12 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n7so910294oic.11;
        Tue, 26 Jan 2021 21:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lkAOCkZLhiRhESPWaixN2MvbV1dLQbX6PialWqIYmA=;
        b=ZPMOZu06eWQzjXjxWxIspBOLObioWCxRf2UHT5evPGVmB6tspZpqK52XRobaa/T3z3
         sHpiMqKGJbGwc9mPZvX249P/D6x+ntP0NbRniwppBk4ox0UVcQ5BYBDENM7MuFlbxk1k
         Prwfehj34Kq85DRkXe8JeYDWe9W5iJGoYm1ji5QMnjbYmhcputW9a3DrIxsPTb7htLVr
         9hcZ005LIqP4WgP5ZkhgQ5hsZH0e2y+v0pDWvb4pK4N/rJzkWd84F6tOLDluVognENTV
         vaS0eHTnjMYNoivyR7KeDFC41F35A0NNDPtTEue2pVD21qiDnuyN2qqpPH7MZyQiesIJ
         umTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lkAOCkZLhiRhESPWaixN2MvbV1dLQbX6PialWqIYmA=;
        b=puLkbYugTq4rHgLR+oHu7yAHrv6Rt8G3dUJiF4TevvR/bluNuemZBxjKIa7aLs7yZZ
         W3TVB0X8XXcz10jrdbg/JJCKD2FqYfch4CmUBfyIyZG2cwUpAIVrRWnevEGWFHiFaFls
         ARb9nD9fuZHb7wpt58T39edwnDd9DFWbTBc3pydHaXju2qd4USKuo+PjTyjDhIdG7C/o
         aF9P4SyERPU6zyRN92IAm1D9NzJMqKb7Zaoj/dRY3njnQwqYg1oZFw1nFpDVx3IH2H5w
         Hus91QWLpKrcSe2HNu82axsWb5ah552u6W4vZElow5dJ3ynbd59w+cr0EdfS6+SOATSt
         CXiA==
X-Gm-Message-State: AOAM533v8Gw23X5vcPdIkUiaYubxSglRnP90v9gdm8NRLxcgdXirbKQI
        vxxr3iPjbF9bRJkm0VYqozRKVhKXUI9mCkAwVNE5GYigw5M=
X-Google-Smtp-Source: ABdhPJzETN39ZAK23znCBTKdZnDVKcbA59PYENpiPJRUyk0cr4r1/OgZCgRO1uNKY4S5RwK6gZhRfo2S6MwJWiP8Nu8=
X-Received: by 2002:aca:d5c5:: with SMTP id m188mr2133263oig.114.1611724392062;
 Tue, 26 Jan 2021 21:13:12 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
 <5d005259-feec-686d-dc32-e1b10cf74459@infradead.org> <df3e21ea-1626-ba3a-a009-6b3c5e33a260@infradead.org>
In-Reply-To: <df3e21ea-1626-ba3a-a009-6b3c5e33a260@infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 26 Jan 2021 21:13:01 -0800
Message-ID: <CAE1WUT4qQ2=Qkz1xsTYCvxdr5NJp8wMKhV_AiXKdq_kwWw1mfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efs/inode.c: follow style guide
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 7:59 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/26/21 7:46 PM, Randy Dunlap wrote:
> > Hi Amy,
> >
> > What mail client did you use?
> > It is breaking (splitting) long lines into shorter lines and that
> > makes it not possible to apply the patch cleanly.

Was worried about that, thought I had all my settings straightened out.

> >
> > You can see this problem below or on the web in an email archive.
> >
> > Possibly Documentation/process/email-clients.rst can help you.

Yeah, read that. Thought I had everything fixed up.

>
> Also tabs in the source file have been converted to spaces.

Was this inconsistent throughout the patch? I can't really seem to
tell. If it's consistent, bet it's probably my mail client - if it's
inconsistent it could be my editor, I had to switch out temporarily
for a different editor today.

>
> It would be good if you could email a patch to yourself and then
> see if you can apply cleanly it to your source tree (after removing
> any conflicting patches, of course -- or use a different source
> tree).

Yeah, I'll make sure to double check with that in the future.

>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> netiquette: https://people.kernel.org/tglx/notes-about-netiquette

Should I send in a v2 of this patchset, or just attach the patch here?
If I should just attach it here, then I'll do the same for patch 2/2.
