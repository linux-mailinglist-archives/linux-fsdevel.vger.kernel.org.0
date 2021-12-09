Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BD46F170
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhLIRTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242644AbhLIRTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:19:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4AC061746
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Dec 2021 09:15:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l25so21859490eda.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Dec 2021 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tHtN7G3YGgTFoTuLt2UtzoWso0slwegtyye0NyKD6E=;
        b=EkUZICBj3sLfwkSa6PVgwK3UJYMBWKD3Zl6QL503dGClSkUivH631EePhpBTiQgDNd
         VoCL1zBnYteGbjvNrexkMxulvtqSc6W1x7ANtURNimEiRxxY81sHWsZDJM+iJu2oAiti
         SYA5FO15uZ/NSRZ6dw7jltE7xXAi1A4hAYadw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tHtN7G3YGgTFoTuLt2UtzoWso0slwegtyye0NyKD6E=;
        b=H0LxGquTvBsCSKxwO8ljQxMraGff0YroB2hdTFTOZjY2V+vkJKwCC6dnjLSYB2UCyB
         08gW8a/okeGwQgC6r+kHwGF4EkHDpAXHHz1MWLAcCWWX411fAWbWYqDVQHuaEIM5Hnrt
         dN2XOjwc6hTfr7FTGQWYHlBULwn5KnLi9cMyfJILVRm1V/mCMUw//LcL1FZ4ky6vSTf3
         gTtGaytopMBY+X1uuUETSo6vhGMhQXnGu0g4dom0YleOkmJRuzaxSZ9xiJFV47niE9vx
         Z8nUBkHue+ogUqqzOimDT7vtENVABrS7pwZzH1ANu3qLioL1SsOXBEPHMJdFYSA19JCY
         t/1Q==
X-Gm-Message-State: AOAM5325mbxizE9TDSFq/ERlP1kDxJ4snMDLR7p+aKxAi1aOjZ1ZWM/n
        U3e0mwhLYLaELUG/Himgp5VxLYlqRuCpjLEn
X-Google-Smtp-Source: ABdhPJxzkl4gYg+miw8jTcEL9lkfzAxbwaC0xAnqOkS0U1EEPvfVZ7wT5+LDAf92eSrmukx+EO4cIA==
X-Received: by 2002:a17:906:d108:: with SMTP id b8mr17174555ejz.531.1639069995428;
        Thu, 09 Dec 2021 09:13:15 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id dp16sm290112ejc.34.2021.12.09.09.13.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:13:14 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id p18so4751082wmq.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Dec 2021 09:13:14 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr8992229wmq.26.1639069994552;
 Thu, 09 Dec 2021 09:13:14 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 09:12:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
Message-ID: <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
Subject: Re: [PATCH v2 07/67] fscache: Implement a hash function
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 9, 2021 at 8:54 AM David Howells <dhowells@redhat.com> wrote:
>
> Implement a function to generate hashes.  It needs to be stable over time
> and endianness-independent as the hashes will appear on disk in future
> patches.

I'm not actually seeing this being endianness-independent.

Is the input just regular 32-bit data in native word order? Because
then it's not endianness-independent, it's purely that there *is* no
endianness to the data at all and it is purely native data.

So the code may be correct, but the explanation is confusing. There is
absolutely nothing here that is about endianness.

           Linus
