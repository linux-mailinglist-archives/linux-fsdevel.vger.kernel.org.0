Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB176E0418
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfJVMp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 08:45:27 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbfJVMp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:45:27 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MS3vJ-1iT6mV3syZ-00TWZZ; Tue, 22 Oct 2019 14:45:25 +0200
Received: by mail-qk1-f180.google.com with SMTP id 4so16058417qki.6;
        Tue, 22 Oct 2019 05:45:24 -0700 (PDT)
X-Gm-Message-State: APjAAAVKVuXD/mdkUexILNImqeP3fGPG3tptMHWHdXkZMyDAT+s6zHJi
        pVEP+iUo6BJn6KEc7oX66vG8mF1GzbkG1C17Mz4=
X-Google-Smtp-Source: APXvYqyjciZdavu1JPPPe0N7rFEefMcrTxNfxfTRa9du3KMTgEVclLMbFRHL5tu6WR3npY9i8xQxY+iAtUJmsd/5bVk=
X-Received: by 2002:a37:a755:: with SMTP id q82mr2720249qke.394.1571748323679;
 Tue, 22 Oct 2019 05:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191021201550.GW26530@ZenIV.linux.org.uk> <20191021225100.17990-1-guillem@hadrons.org>
In-Reply-To: <20191021225100.17990-1-guillem@hadrons.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Oct 2019 14:45:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1OOz2fSgn1YMGxdL+_ZSb5Wc0sAcROfaX=xfJANKpxjQ@mail.gmail.com>
Message-ID: <CAK8P3a1OOz2fSgn1YMGxdL+_ZSb5Wc0sAcROfaX=xfJANKpxjQ@mail.gmail.com>
Subject: Re: [PATCH v2] aio: Fix io_pgetevents() struct __compat_aio_sigset layout
To:     Guillem Jover <guillem@hadrons.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-aio <linux-aio@kvack.org>, Christoph Hellwig <hch@lst.de>,
        Jeff Moyer <jmoyer@redhat.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:K4GvhTjBFSXesAG7lBbAkSm70PIPiqjrBqmyNFcH+7pB132R9ZE
 KwQOJyq0Cox+x9AFBDY2meNYRyv8ImM2SC9Ax/fmCk6bxluncYjPXRBInI1rrKDaldt01sW
 cHEH46DBelFKALEZMkoJVEyB6f/sCjI1gCR3QyxgbVeuJewr1bpUzfD9RGJk2mUUt7bjKrN
 fXER3Frmot4PWz9/zq2bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GoouX5b415s=:TVfiSSZCtk4Zy+TRdN/NQW
 XD8VhF+Uo5QOOsBvQp7r6eNF36qGFhEOXukCdzm2+SzFdBc/l2XJ+db/CNPoKgCCsrxI17G7B
 z7+cNib0LVI0CYX8ORwTsDl6oVKkN1RP9/2YdOcDNjNOA5Y6gGaRpE8XEXLljCfXLOsF3eOUS
 0wcjmE25Zw1DzlV8ljBNDw3jixM+iVdqyYyTdTKUr1Irgv1jqMKb8RoD+qchghVOEiosaxkde
 ZFuTY4ckcCkrsfU/GWeTD79vX1Ar92kbmxm4NtSlxJ8I2nR/up4/UPiFaLcnQQ6Qh8Rl1X3Pz
 onUMgSMLRxl5Uhw56yPDrbBKNxwLvpoDdCZ3kYJz71zgF+IL2C/f1L4HkfdVYyxyBh43hnJ89
 MuS7RJvIj9cqdqXhGonUDLtb5M8jW4CZ141wVp/4vnMCGFak//Q5j3vuKnCQk+F76o7hzfPXR
 NUxsH4hXcV5D25ggrTXfZQWDfrnmtFR6KHFL052bVHlcwV5vr00wna9ICMpeRUmEeRQF9smbJ
 uaVfKsgKriSuS/abv51ifTXyXSn3Nb3fGlc+vZevgEq+4mJzistBwA6uSUBWysPPcuHrdg0y4
 7HWi3aBviurzW4Wm8TycLJ0/X/AbI+MHroe/GDZ1yhGhBh5fYKRLYxi+lNdUcR32DZfM8wH19
 Lce6nSpXB7BTv9t+5Y/TWOyDSLm7Xcr9KFE/T98UTscxTa0VPjPU0oo9aMh0zgJIlIFpLNx9L
 dG+KwMZ7Xm0KCdap4pzqEzerlueC7Urc25MrnuL6pIR3WjD+obKnbV7XNeR8PRutqjU/ZzRgq
 +UJsI4kRfXBWoNySpMo9rD4kCHkVure9sGztl8XOJWhyuSSRKmfnY/Z8CIDmti8+U9bFclRi3
 IajZzHFaqY+mOBWFEpAA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:49 AM Guillem Jover <guillem@hadrons.org> wrote:
>
> This type is used to pass the sigset_t from userland to the kernel,
> but it was using the kernel native pointer type for the member
> representing the compat userland pointer to the userland sigset_t.
>
> This messes up the layout, and makes the kernel eat up both the
> userland pointer and the size into the kernel pointer, and then
> reads garbage into the kernel sigsetsize. Which makes the sigset_t
> size consistency check fail, and consequently the syscall always
> returns -EINVAL.
>
> This breaks both libaio and strace on 32-bit userland running on 64-bit
> kernels. And there are apparently no users in the wild of the current
> broken layout (at least according to codesearch.debian.org and a brief
> check over github.com search). So it looks safe to fix this directly
> in the kernel, instead of either letting userland deal with this
> permanently with the additional overhead or trying to make the syscall
> infer what layout userland used, even though this is also being worked
> around in libaio to temporarily cope with kernels that have not yet
> been fixed.
>
> We use a proper compat_uptr_t instead of a compat_sigset_t pointer.
>
> Fixes: 7a074e96dee6 ("aio: implement io_pgetevents")
> Signed-off-by: Guillem Jover <guillem@hadrons.org>

When resending a patch that has already been reviewed, please
add the tags you received so they get picked up into the final
changeset as well:

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Let's make sure this also gets added to stable kernels

Cc: <stable@vger.kernel.org> # v4.18+

Finally (if you like)
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

     Arnd
