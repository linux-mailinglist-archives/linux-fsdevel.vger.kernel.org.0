Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB839AAFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFCThZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 15:37:25 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:31392 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCThY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:37:24 -0400
Date:   Thu, 03 Jun 2021 19:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1622748936;
        bh=upIN3rRVlmuGccakb3pkBawIHaqI8SnKPwFBlV2wP3A=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ih7mvRTeDlgXaPIULSRAbKPIdZ9gIUzCeK3vte6y6mP23bMDrzDX/Sk0/vEeOrpuf
         J8GFqBTsHW24SKyj5MSoG+PkQPicFn7ty0v81/yNQDLSyDWhGPcrQ32+XDWiqZdYtV
         ztFTRmbt4a8ylZb3s0Cy9aHF/16s0JBBLsyeiAnKSkZL9fuOXi4QVLI2PhTNTaLZMd
         904/8+WerJVMz1mnBlJMEXr2yj7w9LpjPPnk7yCcRdJIAmARpg93jg64mW5L1fMjRD
         U0+Pqsp0jVn+x5DN/ZAqdTOuPnBTT86gzF0OJYSVZd/7x5rTi++MsSMfXHX2bDEdvn
         choACIjT9vlYQ==
To:     Andy Lutomirski <luto@amacapital.net>
From:   Simon Ser <contact@emersion.fr>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Ming Lin <mlin@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
Message-ID: <ESvSq0tQ6RgG4pGNwnmAG4jf38xY8Uhg6hL-MBsU0nRE_rXmW_musHce9lnlWWKxkPMAnuH1Yg6o0V1lpO-RWlT7BktnvJEnQoYApKHIe48=@emersion.fr>
In-Reply-To: <1FD047D2-F5F3-4AC6-A4E4-DB8FB1568821@amacapital.net>
References: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com> <1FD047D2-F5F3-4AC6-A4E4-DB8FB1568821@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, June 3rd, 2021 at 9:24 PM, Andy Lutomirski <luto@amacapital.ne=
t> wrote:

> I don=E2=80=99t understand the use case well enough to comment on whether=
 MAP_PRIVATE
> is sufficient, but I=E2=80=99m with Hugh: if this feature is implemented =
for
> MAP_SHARED, it should be fully coherent.

I've tried to explain what we'd need from user-space PoV in [1].
tl;dr the MAP_PRIVATE restriction would get us pretty far, even if it
won't allow us to have all of the bells and whistles.

[1]: https://lore.kernel.org/linux-mm/vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KH=
bXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=3D@e=
mersion.fr/T/#mb321a8d39e824740877ba95f1df780ffd52c3862
