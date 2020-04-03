Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1BF19D430
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390695AbgDCJnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 05:43:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40978 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCJnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:43:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id d24so2496130pll.8;
        Fri, 03 Apr 2020 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=V/K/TopxgY/8Pfa0UGk/d52N4S8WjM3ZtpLq5otXWDg=;
        b=nLRJFbXvcnX9KjvdLeliIAClVlFBtpYf8dR/MOzxugDqqjEXaG3M2s3fBH0MUS9vNl
         d5byJptunL4LzCTFbC9z/84HwBQ1XTwCd7b9+4Dx/pkLAD5W7BqzYV9C6f9W9hyDuDI3
         wkGbtWVXIOj7PO/cvaGLBfMEGyzAJJuFPZZgGGpVy8UancS6V/Vjke33v7+8zZyV6ggx
         o4gkQGK7Z3zyxFFUHfOyX2crEth42imqyskO6rQ5RoklbXr6KsoCUwC9cXbEAxE4w47A
         AMrpHAzlMfhfcer8ERrz9Vt6D0iZ2jLL6pk6QBj5Ttb49GrYdTTPH4r3xloaJ/Zaq+RK
         qjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=V/K/TopxgY/8Pfa0UGk/d52N4S8WjM3ZtpLq5otXWDg=;
        b=Oguy+rJgRdnbqgcEE/7uf8sEv1NxSS7SpurxxoVXLCZGTzj94Sx90xXdCxEdv6b7Xg
         nc6+2LjwS6CCrH9VonRWyUWlrOn6nZK/CQYWgkscYNO6Ee5gMOHBLJVyJd/qARXYncei
         r731WY3tR2EuBVIMOtb7pbhysVDGkEjENtt85wVffFfrhFg+IQBXsKNaVGJYP4fXQwfg
         gPhsUF7bJPLbu2jx5qImb+Xaf7ZvyhvAlUjP+H7Zg98C/HYdWJcTr9i4/vT3eBqyyPd0
         e3xgG/z4+gqgWoJhet8H0sncHYIZCWsDN6Y6TncO3YE5s9qxP8yGGiiuJX3I6MLNXG16
         7g6Q==
X-Gm-Message-State: AGi0PuY1BGeao5nwBu1FYSscT/Wn/tR8S5cwrxAkXdqL5WpT1SlHFQpa
        4nnZvvsGxd6QeuM1dWVDSfE=
X-Google-Smtp-Source: APiQypKgzaEPql2QfLHfMCXRc3y1MZ8BdRgQhdTYpTU2xjaKbIbFQwq80Rz6RMeOZ9XNFArJ+MVGPA==
X-Received: by 2002:a17:902:9f84:: with SMTP id g4mr7276136plq.2.1585907002336;
        Fri, 03 Apr 2020 02:43:22 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id w205sm5432553pfc.75.2020.04.03.02.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 02:43:21 -0700 (PDT)
Date:   Fri, 03 Apr 2020 19:43:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v11 0/8] Disable compat cruft on ppc64le v11
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200225173541.1549955-1-npiggin@gmail.com>
        <cover.1584620202.git.msuchanek@suse.de>
        <1585898335.tckaz04a6x.astroid@bobo.none>
        <1e00a725-9710-2b80-4aff-2f284b31d2e5@c-s.fr>
In-Reply-To: <1e00a725-9710-2b80-4aff-2f284b31d2e5@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585906885.3dbukubyr8.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christophe Leroy's on April 3, 2020 5:26 pm:
>=20
>=20
> Le 03/04/2020 =C3=A0 09:25, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Michal Suchanek's on March 19, 2020 10:19 pm:
>>> Less code means less bugs so add a knob to skip the compat stuff.
>>>
>>> Changes in v2: saner CONFIG_COMPAT ifdefs
>>> Changes in v3:
>>>   - change llseek to 32bit instead of builing it unconditionally in fs
>>>   - clanup the makefile conditionals
>>>   - remove some ifdefs or convert to IS_DEFINED where possible
>>> Changes in v4:
>>>   - cleanup is_32bit_task and current_is_64bit
>>>   - more makefile cleanup
>>> Changes in v5:
>>>   - more current_is_64bit cleanup
>>>   - split off callchain.c 32bit and 64bit parts
>>> Changes in v6:
>>>   - cleanup makefile after split
>>>   - consolidate read_user_stack_32
>>>   - fix some checkpatch warnings
>>> Changes in v7:
>>>   - add back __ARCH_WANT_SYS_LLSEEK to fix build with llseek
>>>   - remove leftover hunk
>>>   - add review tags
>>> Changes in v8:
>>>   - consolidate valid_user_sp to fix it in the split callchain.c
>>>   - fix build errors/warnings with PPC64 !COMPAT and PPC32
>>> Changes in v9:
>>>   - remove current_is_64bit()
>>> Chanegs in v10:
>>>   - rebase, sent together with the syscall cleanup
>>> Changes in v11:
>>>   - rebase
>>>   - add MAINTAINERS pattern for ppc perf
>>=20
>> These all look good to me. I had some minor comment about one patch but
>> not really a big deal and there were more cleanups on top of it, so I
>> don't mind if it's merged as is.
>>=20
>> Actually I think we have a bit of stack reading fixes for 64s radix now
>> (not a bug fix as such, but we don't need the hash fault logic in radix)=
,
>> so if I get around to that I can propose the changes in that series.
>>=20
>=20
> As far as I can see, there is a v12

For the most part I was looking at the patches in mpe's next-test
tree on github, if that's the v12 series, same comment applies but
it's a pretty small nitpick.

Thanks,
Nick
=
