Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E2FD57B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 21:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfJMTW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 15:22:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45600 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfJMTW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:22:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so14453303ljb.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2019 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcke8lUrtb8vhHtb5SzfvLcSsz8Joiz0psIhCZXHclw=;
        b=ALg9ZHg/wXXbWsRVKIX2Tj6yGXeSM+rooiwzW8dCPBNoVNlR1Pig56y9g/E4pjK0L+
         gu3SSubcXh8qX90I1wrsT/Wx79+uX7oPKjAxXF6b1oZab7+Q1pxPOfBG+7OPTSBYKtFP
         Decyu1cQ2EPt4/bb0wu/abfV/QsXzpoC8Lnzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcke8lUrtb8vhHtb5SzfvLcSsz8Joiz0psIhCZXHclw=;
        b=Zz+Q9HMs2FJEpvudeF8BCYjUTci6jU2KBHkBkwQsf5uTUyCKbn5qBwcTXbqZ0HGQFo
         zj4cVDwGp+x4LjrKu/wlDxxvou5zXZCE9eoJekrNT8HbG3xqadkYagUYQX7BP4KDBw+D
         UGGbTZgEeqHMbgCOEOb/83GZQIatvw0OrX1kmM3jy56WGjHrAip6cQBmTbxdnawOQgww
         hOrUotpe1nGLwC9Eh2mxenyKAFWe5l0f+yvjutqSLxTM93ZYlkytPR71flTY3e5GA6aB
         wmHuzNGdRNMi20CWaNXa/lKv0aQRCplnB/idMKizLeOlAhPDmFNjw7BPGOk+UNauBJs8
         xdFQ==
X-Gm-Message-State: APjAAAUtUv39jwL4vRSa/8/MZp965J0slasl5ATTCwk4h5ynojRKHOnK
        n+wpTgh2we+DIqL2noQyskpBEMTqOZU=
X-Google-Smtp-Source: APXvYqzuekW+isZ8TSjQxo9niS5GRI8K0sokqMGMdvJHRDOHeOxkTdtqdhXE9Lv+ib2cxNu3iCtlvA==
X-Received: by 2002:a2e:5354:: with SMTP id t20mr14598930ljd.44.1570994576177;
        Sun, 13 Oct 2019 12:22:56 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c18sm4209838ljd.27.2019.10.13.12.22.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 12:22:55 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u28so10288542lfc.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2019 12:22:55 -0700 (PDT)
X-Received: by 2002:ac2:5924:: with SMTP id v4mr15064721lfi.29.1570994574844;
 Sun, 13 Oct 2019 12:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk>
In-Reply-To: <20191013191050.GL26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Oct 2019 12:22:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
Message-ID: <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 13, 2019 at 12:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> No arguments re put_user_ex side of things...  Below is a completely
> untested patch for get_user_ex elimination (it seems to build, but that's
> it); in any case, I would really like to see comments from x86 folks
> before it goes anywhere.

Please don't do this:

> +       if (unlikely(__copy_from_user(&sc, usc, sizeof(sc))))
> +               goto Efault;

Why would you use __copy_from_user()? Just don't.

> +       if (unlikely(__copy_from_user(&v, user_vm86,
> +                       offsetof(struct vm86_struct, int_revectored))))

Same here.

There's no excuse for __copy_from_user().

           Linus
