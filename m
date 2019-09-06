Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF49AC087
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 21:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393269AbfIFT0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 15:26:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46992 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393068AbfIFT0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:26:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so5140488pfg.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sT4y3CTgBYYtNnGarz3x+6thexIZIH7G3cYm8cMIUKQ=;
        b=PUlerU1rm1o41pTmV5KAjMoYKrczJxdkqqAsYNlzY/Wa7eDBmqtvItMFE46WtBKToZ
         VCuPteRT1/rLy1ZK/CfMMuPbVYP1YrDhyNNizNk2L4Lw6AsY1/Lwj8B48tdeCSlHjVzh
         HINtmovfAV2mhmzF/o1/nnnIdCulL5I31kes91DyNiGM4mL7gfcI3wPSmMPO7h0mz8Mx
         EcNxB9eMznHeWd1Rw1tSxIWsdL3hu/XZikw4QFp+8c1Tk2u4JF2DXDZLQmg7YTxvat9G
         mDAhYwckpcH1lKPwGZAs4Hptn/2a7GlooykTvhZ5MrxgjuAHKTgai4E4SF62vDJ7AHZu
         S81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sT4y3CTgBYYtNnGarz3x+6thexIZIH7G3cYm8cMIUKQ=;
        b=nRrhLmhy0LvHNhsTCeb0wDPCKhT8KUcrcJG7vfF7zQA7+GBSKCLDe9UiY7C+ggDh7I
         U9KQ8g0iRQk2Efn8kdyWySn8GLNu1gqCO2iRCIoY5Iv1eIZCd51/kc4fFGUcIjKfca+f
         UCR59zmj12Fu/7/wIAjVqnPYpeBkvc3TXwSKGW0pluzjbr5NYyiKb7SwH8CvN6zppEe0
         pLLXS+Z0Q3CqkBsltGm3gUNgn8NjfkzY5FGzm3DJ/9SF53mbl0ueBgr+EeVCJG3sCDeL
         fh0iKWF79icll/dT8Y2scG5LIL3mkWGYCYt1ZXrg0P1KTwGPv6ZhUgG63xqGGPrF9VZu
         lhgQ==
X-Gm-Message-State: APjAAAWJlV6yb/LYZB2CE7WHOy01EHhpiqEwoXgfGjoyaB3fwPqzDG/8
        H/74T3VGD0167pcgGM3Fpzy+jg==
X-Google-Smtp-Source: APXvYqzLKnx6gmrxEA2t3QvgVMgbsPAWbrDNzl75rw940UK/KcrRM5WCsQwR52Ya/WVS6aBnXlQZFg==
X-Received: by 2002:a63:c006:: with SMTP id h6mr9243639pgg.290.1567798013573;
        Fri, 06 Sep 2019 12:26:53 -0700 (PDT)
Received: from ?IPv6:2600:100f:b121:da37:bc66:d4de:83c7:e0cd? ([2600:100f:b121:da37:bc66:d4de:83c7:e0cd])
        by smtp.gmail.com with ESMTPSA id n66sm9546860pfn.90.2019.09.06.12.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 12:26:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/5] Add support for O_MAYEXEC
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <1802966.yheqmZt8Si@x2>
Date:   Fri, 6 Sep 2019 12:26:51 -0700
Cc:     Florian Weimer <fweimer@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?utf-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Thibaut S autereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C95B704C-F84F-4341-BDE7-CD70C5DDBEEF@amacapital.net>
References: <20190906152455.22757-1-mic@digikod.net> <2989749.1YmIBkDdQn@x2> <87mufhckxv.fsf@oldenburg2.str.redhat.com> <1802966.yheqmZt8Si@x2>
To:     Steve Grubb <sgrubb@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 6, 2019, at 12:07 PM, Steve Grubb <sgrubb@redhat.com> wrote:
>=20
>> On Friday, September 6, 2019 2:57:00 PM EDT Florian Weimer wrote:
>> * Steve Grubb:
>>> Now with LD_AUDIT
>>> $ LD_AUDIT=3D/home/sgrubb/test/openflags/strip-flags.so.0 strace ./test
>>> 2>&1 | grep passwd openat(3, "passwd", O_RDONLY)           =3D 4
>>>=20
>>> No O_CLOEXEC flag.
>>=20
>> I think you need to explain in detail why you consider this a problem.
>=20
> Because you can strip the O_MAYEXEC flag from being passed into the kernel=
.=20
> Once you do that, you defeat the security mechanism because it never gets=20=

> invoked. The issue is that the only thing that knows _why_ something is be=
ing=20
> opened is user space. With this mechanism, you can attempt to pass this=20=

> reason to the kernel so that it may see if policy permits this. But you ca=
n=20
> just remove the flag.

I=E2=80=99m with Florian here. Once you are executing code in a process, you=
 could just emulate some other unapproved code. This series is not intended t=
o provide the kind of absolute protection you=E2=80=99re imagining.

What the kernel *could* do is prevent mmapping a non-FMODE_EXEC file with PR=
OT_EXEC, which would indeed have a real effect (in an iOS-like world, for ex=
ample) but would break many, many things.=
