Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8362B4BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgKPRB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 12:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgKPRB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:01:28 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5949CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 09:01:27 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id r23so5581070uak.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4fm0SwFqZ0vPQiIJuzDxd2kgsTV8XkzW98Kg4ojMik=;
        b=vgnNA+Y72z0phAYhPwIasWMbeqabwKaTma99OCoKWPG9Ao7GTBL+3BWvfvW1KPZrHp
         w63FXOSZeRmtpkpVh9Q1YNN//6Na2/5ywEOmL5GRKEJdktHqQAHVyyNmUwo70e2buKtX
         pJ5ZQ51q50nuSI3h2qbRAZ6a9p151gJnSjerBsFxx86ASzNGeABogNwFPu+gIbmQAyil
         jLu/WpggBuzcsd/4Dal+KblKcdXzw9k0Jw0IPJhnVXFtrd6pHYkCc56pbs0hrxwZodzP
         CLaNN1BfkTx7hOkSbj4BOkTd6Dn0LwVv39Wd76ZNVIEvySpgGnFhD/GbJ/wmxXfvbiQX
         59bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4fm0SwFqZ0vPQiIJuzDxd2kgsTV8XkzW98Kg4ojMik=;
        b=tKSGBelgBk/99zcitmeUBD2eDpgJFQHgesQb2eYFUDEJF/i3I87/cWbJJvD7xDdidi
         CxNhyp26TPL4HjkA97T6oXSBTWVSuRVYYAvuaIlrI4jOV09mNb/nZzpNnS8KgvEnN5HZ
         UkM3iSb/tpbC9Ot/LQwr2vpOVUBioDTuOJroT5c9N0vBXGUaw2KICqXrDIPhalOINgmx
         y4uz0x4dRB0pzYCGya9TcIa0O77D54UmpMN1jIZL0xNxRpNS1pEJMYhVzwAbyGgC+3Ra
         KZ3sbavJYf8CdZ6tkE/2L2xNu3VUXI28vCyYhRAWE0pMImRUYwBI7SWiHrdlBa7eHZFQ
         va8A==
X-Gm-Message-State: AOAM532aMyf5tLwpwjhPP8OCrfqYtw8JR+POIIydqeKCdFPmheVGCv8b
        BJzvHKBvv/Hyhxbp5UmlXGL0m2d3mA8=
X-Google-Smtp-Source: ABdhPJyrN6VxAUuSA+8vzh6i6ZM+OUpbff9lpT+yDeqHrDJa3KUrGP/z0/Ww6AT1y5ZEqMa7ELX6oA==
X-Received: by 2002:ab0:2986:: with SMTP id u6mr8684045uap.118.1605546086126;
        Mon, 16 Nov 2020 09:01:26 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id h79sm572204vka.50.2020.11.16.09.01.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 09:01:25 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id u7so9503360vsq.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 09:01:24 -0800 (PST)
X-Received: by 2002:a05:6102:240f:: with SMTP id j15mr9171653vsi.22.1605546084314;
 Mon, 16 Nov 2020 09:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com> <20201116161930.GF29991@casper.infradead.org>
In-Reply-To: <20201116161930.GF29991@casper.infradead.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 16 Nov 2020 12:00:48 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdifgNAYe4DAfpRJxCO08y-sOi=XhOeMhd9mKbA3aPOug@mail.gmail.com>
Message-ID: <CA+FuTSdifgNAYe4DAfpRJxCO08y-sOi=XhOeMhd9mKbA3aPOug@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:19 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Nov 16, 2020 at 11:10:01AM -0500, Willem de Bruijn wrote:
> > diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> > index 8a3432d0f0dc..f6ef9c9f8ac2 100644
> > --- a/include/uapi/linux/eventpoll.h
> > +++ b/include/uapi/linux/eventpoll.h
> > @@ -21,6 +21,7 @@
> >
> >  /* Flags for epoll_create1.  */
> >  #define EPOLL_CLOEXEC O_CLOEXEC
> > +#define EPOLL_NSTIMEO 0x1
> >
> >  /* Valid opcodes to issue to sys_epoll_ctl() */
> >  #define EPOLL_CTL_ADD 1
>
> Not a problem with your patch, but this concerns me.  O_CLOEXEC is
> defined differently for each architecture, so we need to stay out of
> several different bits when we define new flags for EPOLL_*.  Maybe
> this:
>
> /*
>  * Flags for epoll_create1.  O_CLOEXEC may be different bits, depending
>  * on the CPU architecture.  Reserve the known ones.
>  */
> #define EPOLL_CLOEXEC           O_CLOEXEC
> #define EPOLL_RESERVED_FLAGS    0x00680000
> #define EPOLL_NSTIMEO           0x00000001

Thanks. Good point, I'll add that in v3.
