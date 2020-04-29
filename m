Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606CB1BD6D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 10:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2IHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 04:07:31 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2IHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:07:31 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mqagw-1iqC123Skq-00mehJ; Wed, 29 Apr 2020 10:07:29 +0200
Received: by mail-qt1-f169.google.com with SMTP id z90so1107430qtd.10;
        Wed, 29 Apr 2020 01:07:28 -0700 (PDT)
X-Gm-Message-State: AGi0PubUYmDFnOTInJ1eyFUUywCG7T/YgBsKecYpdh1L0bNR/t+Nki6G
        Nw1BVV8wvYVGbaMPzNbL4dEq/vjb2BdmiRFwLPU=
X-Google-Smtp-Source: APiQypLfq9vA8PAqfU/YH18U09P0GJiLGEJ7pxzfmyyZ8eMnuqIgB3yzKDt07rPkw8Uw/LGU/qVDLoTi47iZXZD4HCg=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr32077431qtv.142.1588147647641;
 Wed, 29 Apr 2020 01:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200428074827.GA19846@lst.de> <20200428195645.1365019-1-arnd@arndb.de>
 <20200429064458.GA31717@lst.de>
In-Reply-To: <20200429064458.GA31717@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 10:07:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1YD3RitSLLRsM+e+LwAxg+NS6F071B4zokwEpiL0WvrA@mail.gmail.com>
Message-ID: <CAK8P3a1YD3RitSLLRsM+e+LwAxg+NS6F071B4zokwEpiL0WvrA@mail.gmail.com>
Subject: Re: [PATCH] fixup! signal: factor copy_siginfo_to_external32 from copy_siginfo_to_user32
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HDtOAVxf7F2kbOnVT+0Pbdsy6gyVLoRB+Ord+l/jmjxXPAbBL42
 3+X+s/6c2JKSUDROKdUmb5RfzZOCOLmDD0yRRZiZK+C7ON33X4xGtgMFU3xmOohU6YZuk7G
 TztkztYiKr7uIxCPFCPqnwjUVQ29tybSJMdZBq4nmAbY2lRPFzIWDPV5ZGvExkctRcT3yFm
 ZB2LEJX08qFqgpeyjSuLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wC5lmBW+bg0=:t+X4oCSjs88VFqmJoFXRW+
 PptH+Yin5M5HwIqowvIh7j5a3pqRYf4LmGVib8xT6NTu0w4nRBKkosFPAzHPM0+rNx+6ywE8H
 91s8dVamJO/NorU94C+chA5zrmcwuibPKaO5mJfgDl9EPm2EwYRoXgw4vDDEZiBuFkfLHPZsX
 lP5p424klNI+NYvHYYDKZox/RSfqUcRkPEvaQG1vYmcphN+IqPQLBUM6+vmtyxQPoO38jWS5R
 bBhCAXyq8UQMX9fW2FFtErI4qXrl258imjxI7l8+0rPOwApFoxi6/dI1dXNAC6nx2G+8Npkt0
 5RfwBFYY9e0qaztiFn0V1iNxalGyLiNkZCgU35oyMXgbSG+mtcfwZnrYBvK3VI9wK5D0FmfXB
 YqMchPDOamFSbN0XehNnpGoEMtc/L8lZr2121QvnnKOeM6JZs2VYzjZMA2vXtX2f2qMUHcgPM
 stQMu3VDvnm/ceky/oDEdfBWKiEk8zPpDXGMRBmjf41fsPTlHfsYrtKQFEH1vaLp0ksa1yYZW
 hEJUzpiV9QqyuTOOOCiA459HRGwy3LNYget1RVXzdcfdp2hUjsSv+CEaMyl4JGY673KznVcky
 y0Bo3A1brwQSdWPz/SVKVM5o3FH/0aOSXNAaQu0i37MjgQD/kBvUAGtSIFlU8M/6Ey0oeI3ue
 109PRLULFsB9+EPm8SWmKrU4YJCavN5kAc8dLWRf9efWbMY57yqsryhvV/wOWi7VbjWmx7Hcj
 h5Sju4us+oZYqLkMsNH7mXPIHBeKanbM3LPzM/cI9/buI6TdHfetDN+ODVhRrJDjJf/0e6Mi7
 nmedfvD/cN04U7eTD7/CP7sQa+NLyf3i+JtGQ+j1CCPfv+loUA=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 8:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Apr 28, 2020 at 09:56:26PM +0200, Arnd Bergmann wrote:
> > I think I found a way to improve the x32 handling:
> >
> > This is a simplification over Christoph's "[PATCH 2/7] signal: factor
> > copy_siginfo_to_external32 from copy_siginfo_to_user32", reducing the
> > x32 specifics in the common code to a single #ifdef/#endif check, in
> > order to keep it more readable for everyone else.
> >
> > Christoph, if you like it, please fold into your patch.
>
> What do you think of this version?  This one always overrides
> copy_siginfo_to_user32 for the x86 compat case to keep the churn down,
> and improves the copy_siginfo_to_external32 documentation a bit.

Looks good to me. I preferred checking for X32 explicitly (so we can
find and kill off the #ifdef if we ever remove X32 for good), but there is
little difference in the end.

         Arnd
