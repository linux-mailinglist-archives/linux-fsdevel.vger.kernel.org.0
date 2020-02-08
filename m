Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A05156296
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 03:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgBHCCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 21:02:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38635 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgBHCCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:02:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so1296678ljh.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 18:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSdbqNdPUtUOvCueS/kVTLhf/ggnA3z2ZykHjuNmsTs=;
        b=VjcqDW8gFUGTKHEOyfrP8+Sz/MKzSyHKR1RBD8+MxKlM4JHzWLHEDfAaKf8H1gM88v
         vuL5c8C6Gt9Mc6Z39qUSOcCQ5o5ZfPL+RKcd2AbIHEEly13PPff2bSDVm0ZAuX6jzQgc
         wqSt3wapwl+Nw1u3e+WOKGpDc3wRmryDrCoAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSdbqNdPUtUOvCueS/kVTLhf/ggnA3z2ZykHjuNmsTs=;
        b=khTKS8BI0dw4JMhTS1JCD8qJqKpoDtR9euF3wp3lOhzi/2uNJ0o6zkHf8eHl0AjM3d
         ZN9obYW3KBKffeOSvXVp8yYTkPd6VKtPZxDgVB53M7IOL8W9qgMa9kKmGVN6TZox3ofB
         MdoZ6XPHQ7z2T90ZwY++EBQYW4Y3Kb0G2xhzn0trM7j/EcU5CjvnjfWHuhgB31IOC1Sa
         k2rrK07FFwiaCTRPiKFTEyfr5oM888mFG3zZljE0MO9lJX2rDwFYOF0+ja/RS9qTyVnF
         AslU5oCGREObv5EA1EsrcY0ODpOe/P7ynIufigluK/DZ1p1mOImedE3eDtamcS04W/nT
         1Rhg==
X-Gm-Message-State: APjAAAUSBBUnvbUKGUI5mz9e2CEFFBgwU5DK/mxqGusr5EXDA/3V+Sy3
        jh+KASjzuNuGcVwKXOqCgxFDqis4kk8=
X-Google-Smtp-Source: APXvYqzOSiI1GKrJHBvNJMe4fGFgKDl8nNyyKNdxbGApGT5fZ2WOXgQWppaWKsk13FhamFT2WF/bcw==
X-Received: by 2002:a2e:88d6:: with SMTP id a22mr1143731ljk.163.1581127357482;
        Fri, 07 Feb 2020 18:02:37 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id b17sm1815785lfp.15.2020.02.07.18.02.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 18:02:36 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v17so1302268ljg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 18:02:35 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr1220068lja.204.1581127355277;
 Fri, 07 Feb 2020 18:02:35 -0800 (PST)
MIME-Version: 1.0
References: <297144.1580786668@turing-police> <CGME20200204060659epcas1p1968fda93ab3a2cbbdb812b33c12d8a55@epcas1p1.samsung.com>
 <20200204060654.GB31675@lst.de> <003701d5db27$d3cd1ce0$7b6756a0$@samsung.com>
 <252365.1580963202@turing-police> <20200206065423.GZ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200206065423.GZ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Feb 2020 18:02:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whniQCaQmduhPedBg6cird8R5GHqfMGQWedYLsV4FpHig@mail.gmail.com>
Message-ID: <CAHk-=whniQCaQmduhPedBg6cird8R5GHqfMGQWedYLsV4FpHig@mail.gmail.com>
Subject: Re: [PATCH] exfat: update file system parameter handling
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sj1557.seo@samsung.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 5, 2020 at 10:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         The situation with #work.fs_parse is simple: I'm waiting for NFS series
> to get in (git://git.linux-nfs.org/projects/anna/linux-nfs.git, that is).
>  As soon as it happens, I'm sending #work.fs_parse + merge with nfs stuff +
> fixups for said nfs stuff to Linus.

I've got the nfs pull request and it's merged now.

               Linus
