Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929781D4E65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgEONEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:04:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgEONET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589547858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9P1wHySLzxRU4jlM3CaGwEcVH4Xc+9sJuJmZ3RkQbQ=;
        b=hJnhLmZqMq5x/MOOggfdgQe99/zt3dYhUTYYhSHtmFwCiwdzKTLcRL7tdDx+NXjfVqfw2I
        EFf1L5PJUQ1YqiMLpRwAXo1a/4MD/1ZMv0tCqTW5Rf2ePiK5kq6ZU/zjk+KB4w0hVHU8pO
        p3C4W1D5rQad8/rOYNm2QKNDDz7WqTo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-UG8hbkY-Pb2Q2EahWOqa-g-1; Fri, 15 May 2020 09:04:14 -0400
X-MC-Unique: UG8hbkY-Pb2Q2EahWOqa-g-1
Received: by mail-qt1-f200.google.com with SMTP id b22so2339649qto.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 06:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9P1wHySLzxRU4jlM3CaGwEcVH4Xc+9sJuJmZ3RkQbQ=;
        b=X4clYm6rqsXaVP5uD+IX4W2rHUBFL59nYW3uCVbVWINthFRs43YY/pQI7Zv/Yo6O6W
         KfwZgOABUUWTA58y7S/7lz84TE794WdTnAvZlWjB0YixT/aK8sjyuOe2in0mSyg/Pguu
         zt0vCRAcZ7aaFW5qRQeMdv+DzXXVYSs7QK2wgpcvP6mm5V6btE228ueCmW/h+2Udyw6r
         bZJebGV6zdia57myP6sMsp7LHYijiGnxAkrp2Wiw7CY8bzlfy7N4a9Zb1XBrbTgrqEM5
         Kn6KwntxDl5qLFI+1S7vP9Ai4L9F61T07UjvqeU5XV+u3MjyEy4bdbi5gGz3FB3rLI9J
         W2Sw==
X-Gm-Message-State: AOAM5317oiogXzXlzX1rtqcAInc4BHJLiKhBFDBQ1oOUj5oeLwTQxcnw
        eijzGaewN4TUTP6ehMEwAn5RIPJTgGE8LQ3+apV+WYR14PEBCyCG5SxhoS7+hUJl8/j8xdhnVNb
        thY4ezCyYsydkpRu4YFcusiLuCWQsjZ/5i4xVZfhrmQ==
X-Received: by 2002:a05:6214:13d4:: with SMTP id cg20mr3360615qvb.214.1589547853901;
        Fri, 15 May 2020 06:04:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi1B0UBGGCEAObMRpalHhMZoO8+wOs8WLL++8iuIs8cjiM63zLXDpZtbnW9R9hy/gk7q9U/9q8Y3jYAjf5MgA=
X-Received: by 2002:a05:6214:13d4:: with SMTP id cg20mr3360586qvb.214.1589547853602;
 Fri, 15 May 2020 06:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
In-Reply-To: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 15 May 2020 15:04:02 +0200
Message-ID: <CAOssrKeNEdpY77xCWvPg-i4vQBoKLX3Y96gvf1kL7Pe29rmq_w@mail.gmail.com>
Subject: Re: Setting mount propagation type in new mount API
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 1:40 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello David, Miklos,
>
> I've been looking at the new mount API (fsopen(), fsconfig(),
> fsmount(), move_mount(), etc.) and among the details that remain
> mysterious to me is this: how does one set the propagation type
> (private/shared/slave/unbindable) of a new mount and change the
> propagation type of an existing mount?

Existing mount can be chaged with mount(NULL, path, NULL, MS_$(propflag), NULL).

To do that with a detached mount created by fsmount(2) the
"/proc/self/fd/$fd" trick can be used.

The plan was to introduce a mount_setattr(2) syscall, but that hasn't
happened yet...  I'm not sure we should be adding propagation flags to
fsmount(2), since that is a less generic mechanism than
mount_setattr(2) or just plain mount(2) as shown above.

Thanks,
Miklos

