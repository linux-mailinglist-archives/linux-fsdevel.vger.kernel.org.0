Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD6D576C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 20:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfJMSoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 14:44:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44892 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfJMSoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:44:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id q12so10238104lfc.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2019 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8HGIEbrDSNPBNz7JZoslo//D+Z+JzvW8skzuFZjDGQ=;
        b=f9i6bWjbBXi5YmlUV3DTVdezpTlauLxUBUjXqJYCSgalQknuScN0wHySkl2SSeu9XB
         GOpYTJ00altZjFy1bQvCrvWsJGmDkqUcWgEW6wUohQtZAxESLOgQ/vblEwHGQMuSn3GI
         ehtFlVmKVpewR97jYh5+IGyYqOVdYNxr5pT4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8HGIEbrDSNPBNz7JZoslo//D+Z+JzvW8skzuFZjDGQ=;
        b=tWcatOwhm3yls7axAvyPaDUsDYxFbKBTE6PoD3Tb3/g/TrjXWJKDXuCjTbtlb72Ki1
         VpZPv5GZsS68MoWDUwVFDOKyviOpABRafs14sN/N49iN74QRwxfL2lnVOuJAQ2R2lMjI
         789Aq6rxYqEzeeq54fJIlaZwKYs0w02/7Kv21GJaTGiYivdfbIm5+qQY/JiK0tUXknsW
         TogMyf2zcik2DEkQJyELFmUVUwwudz28wttJHy9sw996lBeSPdU32YFT23FvT4ZoHwZF
         40gI4q/SIpz3VDTsGetqu3Ti9nImfLhlLk0PXD++doJF3wizRBa0BKl/tU6HtL6MLtjD
         QEkg==
X-Gm-Message-State: APjAAAWsaKEm1UZyKR+M25reVq0sPR5p1J1AFhMEmReIRz/Qx//S3MOt
        ApULKO7U5PZYPEBZ9pirT9SNH7UFkjA=
X-Google-Smtp-Source: APXvYqyCz1/AhR5cje55vtvj7pqpB80xMnUWRX571FE08x2XGF+Epj9IUERpSdtL6RnFLC21t9ZZsw==
X-Received: by 2002:ac2:5610:: with SMTP id v16mr14889367lfd.93.1570992255262;
        Sun, 13 Oct 2019 11:44:15 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m18sm3516506lfb.73.2019.10.13.11.44.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 11:44:14 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id q64so14400416ljb.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2019 11:44:14 -0700 (PDT)
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr16095288ljc.97.1570992253891;
 Sun, 13 Oct 2019 11:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
In-Reply-To: <20191013181333.GK26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Oct 2019 11:43:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
Message-ID: <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
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

On Sun, Oct 13, 2019 at 11:13 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  TBH, I wonder if we would be better off if restore_sigcontext()
> (i.e. sigreturn()/rt_sigreturn()) would flat-out copy_from_user() the
> entire[*] struct sigcontext into a local variable and then copied fields
> to pt_regs...

Probably ok., We've generally tried to avoid state that big on the
stack, but you're right that it's shallow.

> Same for do_sys_vm86(), perhaps.
>
> And these (32bit and 64bit restore_sigcontext() and do_sys_vm86())
> are the only get_user_ex() users anywhere...

Yeah, that sounds like a solid strategy for getting rid of them.

Particularly since we can't really make get_user_ex() generate
particularly good code (at least for now).

Now, put_user_ex() is a different thing - converting it to
unsafe_put_user() actually does make it generate very good code - much
better than copying data twice.

               Linus
