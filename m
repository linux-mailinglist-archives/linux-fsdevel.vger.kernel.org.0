Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E162148D3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 18:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390759AbgAXRsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 12:48:14 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:43888 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390346AbgAXRsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:48:13 -0500
Received: by mail-lj1-f169.google.com with SMTP id a13so3391223ljm.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2020 09:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeNd8cDikAZfPsMDcLH3HXRHVWtJV1fmj5x2OtFe5U4=;
        b=Q7jDnV3uFGpcFOXfx0sDToVKK1+ShWxMawH60hxdkkobojekNBomm2UEWO8o7bmoTK
         HEErANJjl8S6iy89lk/sC4mE7wDDoMRvGk6OvK+x4eZg0R+df7JUg/C+RHn/1Gs9HK++
         MKLm5y9lb1HuYcsvG7Fptfe2ZYW/tYoYBXR/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeNd8cDikAZfPsMDcLH3HXRHVWtJV1fmj5x2OtFe5U4=;
        b=E3+9m4Xt+tqhrOMe4xhiDec1wTVDp+RHV0R2qaeyAPoi9q7NWWqukGLYoNULy2i4AL
         Wg1YFYQ0Ygc5bA+bMY7E4704OyNAoB2FzmVlxNTkKtAzn1hMvzhyPccVKrb68KEIdKOG
         LQVZ3DnWfoIQBFb05L2sc2WyKJIc2DZzMF5FXOpGBvwYI/cU/xSHDzs3YTXJVEu5+W/2
         ioFeeAQ7AxBSeGnvL3TPlraz+aQNKF/viLqVfWS73UUzpTpKb+aMdGLthxrsr71BSYWN
         qM5y+EsmGvK3uxjxmJKkD5LxADa9Ej2qWKtvD/GVbIIbyZrLVRjqjRHX740T84/bFQio
         qPUA==
X-Gm-Message-State: APjAAAX6tgaNSDJxfBuc/gauE3cqS1TDGc8jw92OFzL1QXtUDnSm0m2n
        pw44eWWubPAcnHm73h0xEv/JRfRkm+U=
X-Google-Smtp-Source: APXvYqw6YAbzF96PaNhQnvVKNgbc5rnC28417DG/Su0rPVEOXwPpk0JZEbGO5xCgIV2wcpTgAwR4Kg==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr2704159ljj.253.1579888091192;
        Fri, 24 Jan 2020 09:48:11 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id m21sm3116733lfb.59.2020.01.24.09.48.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 09:48:10 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id w1so3440808ljh.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2020 09:48:10 -0800 (PST)
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr2898619ljq.241.1579888089736;
 Fri, 24 Jan 2020 09:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20200119221455.bac7dc55g56q2l4r@pali> <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120073040.GZ8904@ZenIV.linux.org.uk> <20200120074558.GA8904@ZenIV.linux.org.uk>
 <20200120080721.GB8904@ZenIV.linux.org.uk> <20200120193558.GD8904@ZenIV.linux.org.uk>
 <20200124042953.GA832@sol.localdomain>
In-Reply-To: <20200124042953.GA832@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jan 2020 09:47:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwFMW09uz0HLUuQFMpi_UYtKAUvcCJ-oxyVqybry1=Ng@mail.gmail.com>
Message-ID: <CAHk-=wgwFMW09uz0HLUuQFMpi_UYtKAUvcCJ-oxyVqybry1=Ng@mail.gmail.com>
Subject: Re: oopsably broken case-insensitive support in ext4 and f2fs (Re:
 vfat: Broken case-insensitive support for UTF-8)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 8:29 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Thanks Al.  I sent out fixes for this:

How did that f2fs_d_compare() function ever work? It was doing the
memcmp on completely the wrong thing.

              Linus
