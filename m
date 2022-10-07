Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5F55F76CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 12:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJGKWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGKW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:22:29 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B833DBED;
        Fri,  7 Oct 2022 03:22:27 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 297AMEvQ026718;
        Fri, 7 Oct 2022 19:22:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 297AMEvQ026718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665138135;
        bh=v6R9VW9CvNnIPxZU2kpYVPvJFCqUvYSumQarCG0Cerk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zLSJjHLIQJAkeagXnGYLwewIgt97fZLTzOId4Oe8VaS10oWFyd9D+CNgzkwUOlRVc
         JEegGYepg822P00bA0N/ktpVz7Od6lVius4h4rtoHWlOyeCjUr5oe1C+457OTZMnH6
         QpW6iUVrYSxr6ZVPRf9Q70yrdcFpTo9/FOMR94tiJQzy6ffL7ZhTV3Alj8dKKyMVEO
         QZ/hH9OaK0hEKBFTCMTRouTa0vWlvOIqhjj4/mp0hoTjOwrtCiOTw3S+mVoNi9UTlR
         AroDM6GIpTyuc9c4CJ50gO+3diiSvj1ja4wW9v2V1Cu8p4dyVdfKWUepyeXpj49acI
         6K0wXPsNUgySQ==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-132fb4fd495so5076569fac.12;
        Fri, 07 Oct 2022 03:22:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf2nYq3OFkh3JYTwcuc+uyA9Vw1fzimcAUwgm1YcYBxlcmWV11V7
        HCEOSdddAx0zpIS6Ro9B8aMY0ypJhJMeCOxv7RA=
X-Google-Smtp-Source: AMsMyM6p4RmVl0lWCJhJ6LJiYVBZr+poUdbCGiq93ZYl33z69uioaMPeZvHhvZHGTn59a1RuLFsTqu2SZdyREGXDS0k=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr2087845oab.287.1665138134138; Fri, 07
 Oct 2022 03:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221003222133.20948-1-aliraza@bu.edu> <20221003222133.20948-11-aliraza@bu.edu>
 <d2089a89-21a9-1e05-5d58-91b8411f7141@gmail.com> <53c84c25-31ff-29d5-c6fb-85cb307f1704@bu.edu>
In-Reply-To: <53c84c25-31ff-29d5-c6fb-85cb307f1704@bu.edu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 7 Oct 2022 19:21:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-Q=sS-9L1eRuOnomqqDNyRp2knZh+2SYLqB2Gn8ekHg@mail.gmail.com>
Message-ID: <CAK7LNAT-Q=sS-9L1eRuOnomqqDNyRp2knZh+2SYLqB2Gn8ekHg@mail.gmail.com>
Subject: Re: [RFC UKL 10/10] Kconfig: Add config option for enabling and
 sample for testing UKL
To:     Ali Raza <aliraza@bu.edu>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, michal.lkml@markovi.net, ndesaulniers@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        ebiederm@xmission.com, keescook@chromium.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, arnd@arndb.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, pbonzini@redhat.com,
        jpoimboe@kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, rjones@redhat.com, munsoner@bu.edu, tommyu@bu.edu,
        drepper@redhat.com, lwoodman@redhat.com, mboydmcse@gmail.com,
        okrieg@bu.edu, rmancuso@bu.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 7, 2022 at 6:29 AM Ali Raza <aliraza@bu.edu> wrote:
>
> On 10/3/22 22:11, Bagas Sanjaya wrote:
> > On 10/4/22 05:21, Ali Raza wrote:
> >> Add the KConfig file that will enable building UKL. Documentation
> >> introduces the technical details for how UKL works and the motivations
> >> behind why it is useful. Sample provides a simple program that still uses
> >> the standard system call interface, but does not require a modified C
> >> library.
> >>
> > <snipped>
> >>  Documentation/index.rst   |   1 +
> >>  Documentation/ukl/ukl.rst | 104 ++++++++++++++++++++++++++++++++++++++
> >>  Kconfig                   |   2 +
> >>  kernel/Kconfig.ukl        |  41 +++++++++++++++
> >>  samples/ukl/Makefile      |  16 ++++++
> >>  samples/ukl/README        |  17 +++++++
> >>  samples/ukl/syscall.S     |  28 ++++++++++
> >>  samples/ukl/tcp_server.c  |  99 ++++++++++++++++++++++++++++++++++++
> >>  8 files changed, 308 insertions(+)
> >>  create mode 100644 Documentation/ukl/ukl.rst
> >>  create mode 100644 kernel/Kconfig.ukl
> >>  create mode 100644 samples/ukl/Makefile
> >>  create mode 100644 samples/ukl/README
> >>  create mode 100644 samples/ukl/syscall.S
> >>  create mode 100644 samples/ukl/tcp_server.c
> >
> > Shouldn't the documentation be split into its own patch?
> >
> Thanks for pointing that out.
>
> --Ali
>


The commit subject "Kconfig:" is used for changes
under scripts/kconfig/.

Please use something else.


-- 
Best Regards
Masahiro Yamada
