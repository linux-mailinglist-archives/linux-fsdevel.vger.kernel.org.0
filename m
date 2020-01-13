Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1270139427
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 15:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAMO7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 09:59:55 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:38907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgAMO7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:59:54 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mv3M8-1jhkGu2QxU-00qyh5; Mon, 13 Jan 2020 15:59:52 +0100
Received: by mail-qt1-f169.google.com with SMTP id 5so9339754qtz.1;
        Mon, 13 Jan 2020 06:59:52 -0800 (PST)
X-Gm-Message-State: APjAAAUkWUZHjTkzsf5F1mDo85SPeANxN5MtDe6cNFWG6JZjqfgNvNgt
        bYS925y3u3ErEsKuPlzTrMe5O5dKnaPo4XKI1R8=
X-Google-Smtp-Source: APXvYqxiLj2wevglx5PMrcSeH3ieonohCOIBtZJiPN4aZqmn8jtgw7RUzenpGKQGwDOInwqXHgXQNFN0lGfRPS4hcg8=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr10516984qtr.7.1578927591343;
 Mon, 13 Jan 2020 06:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20200107175927.4558-1-sargun@sargun.me> <20200107175927.4558-4-sargun@sargun.me>
In-Reply-To: <20200107175927.4558-4-sargun@sargun.me>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jan 2020 15:59:35 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0NO2d5oD1dMhunyrHmoa_+CeD-JsM-Yffbp+vgJwu8fA@mail.gmail.com>
Message-ID: <CAK8P3a0NO2d5oD1dMhunyrHmoa_+CeD-JsM-Yffbp+vgJwu8fA@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] arch: wire up pidfd_getfd syscall
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2AACtcI4qkurdtORyUyh4PXYxvV94KBzn9Ud9I489qlGWCMakAL
 0Qtg97WXjtBsns67iAaS8UiACPmURGdHm35slfCae15WEGX+8Du8ZDK63mPI/itcWFvlByt
 6/fOAv9agSTK1ufYVLULfcOQFHil/338kndMoRmYkYzV7H9JfAETjixFSRGiR4h3kHswxBG
 TPv4ocfyyJMtrhyTFYZvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/XoSKrJOcRc=:6RmmOTiWEj5AmHd7ljY4NI
 AuBj1ifmljtEWVta9rVL18WFBEx7NZGrRIh/9qkvJ2q+J07Fo6vmZXrG/0Y3FMMPrgLMCKVZE
 JxICpCMdBVhP5/zmqD84oGoGVb6/o9Ia4x8ng6Fwq0vX0VrxKXsRaJfeps05660cDYsgYIM/O
 K8OqQ1N2n4MO7ddDB0XWfdaUpy53ob6KwwVX13SjMPxsPKC+DUAVOeluawtUfJ3dvON5OYgky
 mCjT/1PkB08fcKc8RHAh+fPKes0UTdDI3vkLcL1G+isXfzve5cjIZghSwXXpvuHgmIuQOotUf
 mGE8e73i+TBzo0exhUxzP0/J2v5krNKOykm1/Z+QmZKlgsFV1sdTHGUSg8h0SRqmyaRhh8r+g
 0Ob+Up1L5wOMO65oFS+FEj4Y9Apas72aC6V+CZ8RCpEVkZBzShtuEkd+D4jwEY1zWN4VQHWe6
 q13HZ6Td5RNzzbUcqa56JTn5R7CbO/8JJ9ZINZpQKcg8WsebU6/GYWVT8+kwCnfOZHz/2DNug
 F3UMuGaK7TfIRZ9LaSmprqVlVtSnqKYm3Ifym35aV8eXACoos8lgHqD51k9U4rMPU+fTRfSoy
 xdhmzqinDe+rMcltPZLyqyLZGcwmjZdAvzs3TtFiZJXi+2KSa1P5av5Xwt2cqXWO9+Y0MdnA6
 c4sMgSi0SkNQmcEQvsH/SSY5AxSxaLiSX/hTkBU3Pw0BGLTPcIQ7n/KdXOqYzYbb0wpbjgsmc
 V7t1jex2fulLFhstVgIWUc+AG55r+r2A0M3a6lwbIlYV6yPwHqDmEIxVm/QllJgsOCuba6cNE
 0hyULfPDKXLzTVMal4pFP93YZtTHLNvRXzmT4aGupH78hgjRuMuthZ+PMqzW1v7NpqptO4VjR
 25DIRpw2mqZ/4NNiypSA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 6:59 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This wires up the pidfd_getfd syscall for all architectures.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

This all looks correct,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
