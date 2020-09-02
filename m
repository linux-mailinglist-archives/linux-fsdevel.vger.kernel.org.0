Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4061725B535
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgIBUOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgIBUOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:14:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BCBC061244;
        Wed,  2 Sep 2020 13:14:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k20so466106otr.1;
        Wed, 02 Sep 2020 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=suskJZAhhjGPyfzpjHKUgDnYaYIBJVKayGrzunUwjkE=;
        b=NXneTfPzbwpxYqCpRItbeYtQ9ktjsEXsnMi3VhIDt7E2w+tuR2J10+9TbnlH1W8/dv
         XfVUTcfvUK+ioH/yneIC/qH7le9q6ZJLgU9OpM7C08On7oAC7At3hmyKJ3aiQxrsgxwF
         19dkOCqc3J2IkUG8gmevfWneEBnFhvohbzA0RQIRtTw8rsox+815w8XOHzdNoJ8V19rf
         8An8U7yDj9LV+Az4y2Xsx5xjyUDCE9SVyntKrgFSbpVlJyxSwSUINspIfrjzX/TzYC4y
         F1ewYXKoFn3EtnmkUDvn6JmehjS480KcGpiFuoaRnRyw9oNv4uFoREXNGJquCvm1cXED
         X+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=suskJZAhhjGPyfzpjHKUgDnYaYIBJVKayGrzunUwjkE=;
        b=pJN2wDEtd2/DbZFGOMWL33mm7m9pWLtnFp5x/JcLP4Vzn4DQc8f1LqM4d/+oEU9AEt
         PwLhy4QafzYEgZC/LuMZ3QxEcDylGTxnyppMpLfQ77KzpHyY6TaXl1exSBZFPDrpYABj
         yAkHW6JV4sO5kKLuX9FqNks98wO9XKFN+XPOzKLJ2zHOh4e28+kc7dKGIuDgnxrVNwpc
         DwAFj0n31DQJ4PhLafhL8vcPToOshKDVKmjHr04jVoXZ1Qd6ge6on53JhOExH/Hu5oEt
         vEJnNsfmLVWsX9OB36UKcssE/BUj2nAuADNpy7zHqCjicxLaRdxwgCOe44FbtLUeO05n
         cwGQ==
X-Gm-Message-State: AOAM533gJtJQEx7KFGWh5kjE+vzbyAVC3wbaRDd32Qho27v2i45Mb4Hs
        gjDN86W4e8JYBduu5gngWPpM0ym7NifW/+zxLVQcTMmJ
X-Google-Smtp-Source: ABdhPJzOOPPiscqZ4JYYa0ccAxr0YcUZaX1N88o+045RfHWYTYf7vSZhHIwwpjHUdFsqhszvg18l83mlBUfhZeLwHZM=
X-Received: by 2002:a9d:a2b:: with SMTP id 40mr8974otg.308.1599077673643; Wed,
 02 Sep 2020 13:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
 <CAKgNAkho1WSOsxvCYQOs7vDxpfyeJ9JGdTL-Y0UEZtO3jVfmKw@mail.gmail.com> <667616.1599063270@warthog.procyon.org.uk>
In-Reply-To: <667616.1599063270@warthog.procyon.org.uk>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 2 Sep 2020 22:14:22 +0200
Message-ID: <CAKgNAkhjDB9bvQ0h5b13fkbhuP9tYrkBQe7w1cbeOH8gM--D0g@mail.gmail.com>
Subject: Re: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2 Sep 2020 at 18:14, David Howells <dhowells@redhat.com> wrote:
>
> Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
>
> > The term "filesystem configuration context" is introduced, but never
> > really explained. I think it would be very helpful to have a sentence
> > or three that explains this concept at the start of the page.
>
> Does that need a .7 manpage?

I was hoping a sentence or a paragraph in this page might suffice. Do
you think more is required?

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
