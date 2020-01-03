Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C2012F5CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgACI5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 03:57:17 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:43873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgACI5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:57:17 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MXXdn-1jE6oX3zhv-00Z0Or; Fri, 03 Jan 2020 09:57:15 +0100
Received: by mail-qv1-f49.google.com with SMTP id n8so15948781qvg.11;
        Fri, 03 Jan 2020 00:57:14 -0800 (PST)
X-Gm-Message-State: APjAAAVzLmqwU93oflz90OayHaRkEtlgScMlOuLS/3OTCZ8ZWWg0eGOl
        mflxRaKgKsis3TorOKBNsDywfOcYAuSaQxGCies=
X-Google-Smtp-Source: APXvYqzTMjLfB/djZfKHN6GJc8U6SPp+bLcFseejCOHPAhzRIWhN2S9BjSwrezU2LR8WsFgGtj/vSg4385pE/8QPXy8=
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr67496854qvo.222.1578041833501;
 Fri, 03 Jan 2020 00:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20200102145552.1853992-1-arnd@arndb.de> <dc17d939c813b004e0a50af2813a1eef1fbf9574.camel@codethink.co.uk>
In-Reply-To: <dc17d939c813b004e0a50af2813a1eef1fbf9574.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Jan 2020 09:56:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1tTCk_qYQ+iLp_L50biemmz+vh8kHYHL7hRPgirhxxLA@mail.gmail.com>
Message-ID: <CAK8P3a1tTCk_qYQ+iLp_L50biemmz+vh8kHYHL7hRPgirhxxLA@mail.gmail.com>
Subject: Re: [GIT PULL v3 00/27] block, scsi: final compat_ioctl cleanup
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:I1cvh4okryzhKcNilmC8/jvbYZfVuC7Gu3zL5E1dw1nhWS1IsPm
 G5Ds416TnXhCHX4N3OqQef6+9rsjiCiGuKfWmAtK/kFOnOyvcSN/CM27gw3dr311C5NSxAG
 ZK+7kxKBQVfr2hmw+eOxuNVU4n+uzNKY6ER9uc6wUCq/po24V2cfsgPkO6+Glgb5QjnctA4
 71SZQChXFWIiX0RFKbYmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lmKs5T3XinI=:vpspqsdsexs7fkhPmpGBPe
 +oi0veEcyaz8JCYiR15ghmGkLyeZ6HJHk179W7e5mfPsKuxTRJXeQzjsCfg072D68yi9izXvO
 WsL1ZfDUZEtWNc0cq7jGaKe8rsGuFPzoT2kQ06jrb+pT4/i4CCNb1A7MK6VY/InoR/D7jGcag
 jp8ZCPVPU9vA0SryIbqhkPKjkGdJ0FZcDQCNJNf2cvEt065jp91OY5vYQ2fcZZ/otbszo31t6
 HCXDmRfd6/ZBQYpbQ0qpv5P9oL0TIGbj1pEQFPc9bku1ODtXZAaqKrhi/TkgXpi5DBv7km1Iu
 uvOQDQcbSm2CZNtJ7cPaybjnc0JADX/zTOU3JvsJvzke28q6A8bwYN1H0RcrEvaLS573+42uM
 3GfIfenhzmZkbuxNUiqZbJ/UCe/9/+sCqXsZBZVu3tzP4KOOEz7AJLiRlhCgjVSPLYrcXbLt4
 bbp0QaNhxPMbX0fMM2UwBcsHbEXec9lf56bTcwVT9B+IhMOAndTZA7/wWYFBpPbUWJAY06ofO
 dIizah+LcSpUN3KoZVstllojgWETUEBuOkpq+zCR5JyTTxDjw/D197lBWdTCB5CvmAuvjkZKM
 1EJ8zSPWzopPoQt4xncQLEm+dwXoK5Is8WMisZ2uXX3xAeYpHn7ORJPni9rGPQlUWq6wj+Wwe
 IjqE0m7ovG8fbl7sGAVbfy7KsiHjJHTHs/p5nrciWUGlITYfILc6dg5xH0psdXNS7jJH/j3hr
 nu/MleWWupSZPSFaS1USBZOKGgUa0uEt8rwzess6PcjplX8ebeRSK+Elfd9tGEtI4bfpSEbrJ
 +P+lnbheWzNL8jYl5oMMz7zZr7eKm9RV9eysM8hYhnU/kPr28qeHCTelYTPL3y1RD6vj7Q6F2
 bIu5/3/E/zoju4Tpu+3A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 3, 2020 at 1:22 AM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Thu, 2020-01-02 at 15:55 +0100, Arnd Bergmann wrote:
> [...]
> > Changes since v2:
> > - Rebase to v5.5-rc4, which contains the earlier bugfixes
> > - Fix sr_block_compat_ioctl() error handling bug found by
> >   Ben Hutchings
> [...]
>
> Unfortunately that fix was squashed into "compat_ioctl: move
> sys_compat_ioctl() to ioctl.c" whereas it belongs in "compat_ioctl:
> scsi: move ioctl handling into drivers".

Fixed now.

> If you decide to rebase again, you can add my Reviewed-by to all
> patches.

Done, and pushed out to the same tag as before

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/
block-ioctl-cleanup-5.6

Thank you again for the careful review!

Martin, please pull the URL above to get the latest version, the top commit
is 8ce156deca718 ("Documentation: document ioctl interfaces better").

       Arnd
