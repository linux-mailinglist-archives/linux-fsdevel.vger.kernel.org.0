Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0081260DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 12:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLSLcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 06:32:00 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34675 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLSLcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:32:00 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MK3BO-1iOZQe2HL4-00LTop; Thu, 19 Dec 2019 12:31:58 +0100
Received: by mail-qv1-f45.google.com with SMTP id x1so2070576qvr.8;
        Thu, 19 Dec 2019 03:31:58 -0800 (PST)
X-Gm-Message-State: APjAAAXB5bwFEkVsoGBTjHpj+xzg5RPxUdiP5nla6zzs0fjuekGPlV9G
        hai2CntJU9zh2fwtGQvG2nBWH+7UCkSxmNe6Gck=
X-Google-Smtp-Source: APXvYqwq+q6D8rTIMB8KZItwAsS83uuBG4XEsHVi6nS5xeM4CNJDakxFmkQBf2UtMAyO+u9DeejJYNgUAsO8AvEmpn0=
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr7059944qvg.197.1576755117281;
 Thu, 19 Dec 2019 03:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
 <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com> <20191219103525.yqb5f4pbd2dvztkb@wittgenstein>
In-Reply-To: <20191219103525.yqb5f4pbd2dvztkb@wittgenstein>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 12:31:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1-hsnidMzQJghRGE-1voP4WHDoOLRZHe9P-UmTpea+Qg@mail.gmail.com>
Message-ID: <CAK8P3a1-hsnidMzQJghRGE-1voP4WHDoOLRZHe9P-UmTpea+Qg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>, gpascutto@mozilla.com,
        ealvarez@mozilla.com, jld@mozilla.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8D0/OjmjTCtC8NYK8+U1DBLyqoIMcYVm1PArq4gO/MH79DtzZ2f
 8lA7RWNhBh2TTbnK8V9H52IEsDqwKhUO9CUtFT3Cu7upEswQKB1R6/WiVYFe5DKqrUAoJKo
 F8FAMmMhTm0yAMr0RYnPlMi9qe+Pkakroh/wDwcdMwBv6828oSiT9LkwvMK2J34m+BU8ysL
 cu3FCoePnDNANfBDHshHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WBP7hzHAu34=:Xs+OM7mXb052e96l6KaNgz
 25gweXJYia1SqK5F1/aDSmux6qaCtxiw11HSujr5oudtUlCSo6rVqjDXdubzZ/WgxA9eMq4Sl
 NbWouEhaDbyzZ8xbMAL2MOi6HKPfUZ5BspkNMZbqQesVS90z/PqUw5oY8eY5IJASYaJHz3KMS
 2hnjXXKEgjjSaQ8qnyvjxkuZF7ZbxEgJawCB30moOhKoG1WB4Xj6UvM6nzQ5TPNnhcnP7w3UY
 2C+N7FsSfom3if7hArKwrI6KwkYWdQf6U7CJnYxkVcyGWnXQYJCOtjcGv+BZvvx6OHssXYB2E
 PaLnO0ExGYwWeN1F+fTWB01l+lTZYrWNNoPpQ8Hi3atiYTdO5NlAtoZINkebPd7zbouuNA0L8
 ohhDjO9yI0hn/MYDNgl873pEnTj+AAch4CVU1nXQndlkkyWTSJUdZ110YLpHBAYaTQm9E7Lo0
 NZJDK2CxrQ1T+AF1S1hmkeEUt7gbpmgazcFSPU1HNEXoS2kOhYpMJCT5Nt2ldA7wCTfPvf1wM
 Qt50EJEfSdwqxXNcMdf5Ws0fAnA8IZ4vImVOOkRZZJ2+4ciexgw4Skx9lTh9zxE1+vfh3Wise
 k9JgahkzDw47+bwDtzZWGMVVGhtM/5kw9U1FNwlVS+KVigCh5u8LyAlmYlHqtNWWofzfNbY/o
 XIlm4FGmxev6Dwtaz4KkevEbp1uBsLv8YBMCazOOVulnFuEoqZngmEHSMjfRbfJB/I0rbQu7o
 KTIdXZ1D9ftkgQG2CSiyuASJp0toJ6Go/oIlaUiU2eDMWlKF0PEVpthCkmA997kSN/znRQw6C
 yQbcpL+tP3aeG4UzPMiB/xchZuTlNaRd3dr9+HJ5hci0HKxLhECEuwhcIrybrg1dI+ZwwX218
 dXE5VNfOpiXmkMVOoLhw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:35 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Thu, Dec 19, 2019 at 09:03:09AM +0100, Arnd Bergmann wrote:
> > On Thu, Dec 19, 2019 at 12:55 AM Sargun Dhillon <sargun@sargun.me> wrote:

> What does everyone else think? Arnd, still in favor of a syscall I take it.

Yes, but I would not object the ioctl if others prefer that.

      Arnd
