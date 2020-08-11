Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD024220B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 23:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgHKVfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 17:35:40 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:39404
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbgHKVfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597181736; bh=8w+EvcZsCqHpbTMb7B5p6NtPpopAs+8fJLhaCvPEguQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=i91CjXySd1TgYGOpZu2BTool5O+P8ufWcekoPfjnGFQp9kbbp4YCkeAzRTkM7AH8X3sfZ6sfWbJLK+FvddMQew7r5WK2dolRfKKtYB/IZ1DsFL0lWIv4vHJ6llQU/fFMYQo5h9TPmE2ayh6tItTnfAL5+Ldx4qBqCuG9VTH2MM1IvZNd3bBP7AM5qSRczXL+Efnqqm+SOq+gjKKb/sI1EIIzZwMj+/Ia3qfxdmSawd9ZwDE8hgiq5af6YRVSlcAoHNrMxSWpOiaE488/kd6fbcE3rRxpBnlnfLD5g9qRaB5lNZ34ODqUJtSClBjL7H+bCwvj7G5Pij/onFn6TBN22w==
X-YMail-OSG: WpZ3b0IVM1lOWflYFjwxd55lge1PeLe6UFcnTAkXmNFz68kn9XRwy3GlteeHBPi
 dzQAo.fvGwnt0N1bdticMs1as11oix7oMxoAXjzv0YmACD9HGQ38XBuJScIsbASifn4MIcIOmcv4
 5iDwRWMvXuDPIY37R38Rfeo_swDDA0w5ecqTDEoAzH7cQMPjz6fkj_1BQPYXJkMetYuxZXB2fivU
 .TFgOCK.C4_82teyT5tKiHwgfYzrZIf3jCUML8pZDLKqf202bzrDoP9wycwhqKzdAyd7pVbvfL10
 DL4oIU2JdaN5ri6mfHU.cqraJdoCGf2ptndpgPnU_6L_YRyd2XjM814y1ZbKtsQKnWSXjoljv6pw
 wwVoumV.nOdtp49.GffNPS1g3zcAaP.TYdSORXIyA_24BsvEkbuxr8hNRo86mdawuxIWbTaKtaHO
 0rKTCWQeXircV8F3XrgiK5XQgOype7HvJAddh0tN2JUVNRLKFsYVafPZEuqk68G9FQmBZAY.AYIa
 5TUFl23mEH7o6gG9Z8sE7hgq_.3IdEGf761nmp6qmbXFS75A12MamD_dc2Fbfo5ui7gDfQAGGb0W
 3UE8LNRuOuQ16wqoob86h4FrYVQVesPXlEBlSyUhAQPUG5TP_P2T0I56X2_frrGULaI.wsvS94kL
 rIASWAkB3Bp..fw0Ag3zYlfR4oGMB6uXa65aGnMvoqsfEYt7ORRyyP0oiSQsJzKM1n5mr3oFDaWY
 Bs4afdjlRC.A0dyd9FboZFNgTzHwgdo_Yg1NhlQEDUJZ1hbzvsWLB12qQInlMTfcBondpNmP34fk
 IhIwj0tfBbuguSuudR98cKAf_DioUGANHc1nIGTidBz4BSbS.1Oa7O_JjpWi4O4WAp_7RBfNt3MA
 S3NpsokMdgsIOKTlZVp7eN3mK18dczJs0_.0Xi21tc6.ohEr70gLejLMbbjhREn9kURu..k1gdNr
 EUYPJOSwDZf5eaGQd9j7.VH8Asu16xztRa9cmxzyNZGyF2WqcOOrGbkvhfAuOGe0zd7yfh0WKAQI
 8B3AoCYRz.wccr9hd.lS7kNel5rjpCUfpweZK_cP66XAZ_fCyoKDdLFOElU6zKQFdzGTCGEyMlyn
 ATPwA6O1Qe2ruuFkx.y6HLhdHAQ85jMhnNpdRFY4KedHWYsdnAG..cS9lxAfTM81z31E.3fcOOhx
 DvKyYL_YM7HhsGmX6wiXskyDSzS7H1jNTqei_OTjrr2j2m7lZQKDVMEYv6n3yhaTgbwxkSX8gGNP
 5PWXqcKMMQ8A5YDvuNBAhk1LJgXBnD6D5xJep6cmbHeyeC_JVyL1wRB_dAyYUNBscorpkn0D5hY_
 IxFJD0tiQhnl2tetFuJqrpq_NGHIR8aIq4ZkkHC1D4fys0ELI59Iq_CK1iV_6bLhFJKGZMrcSImc
 kvVBYO4myW2zF9GmT33nOUpmciPoyK_pdh_NHRQSECyWXoWVsu_ju8Wc7OgY8bnn9mTKZrflDwcB
 _B5SCzE92E6IdAorK8ll.vqIRtuhjgePlgw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Aug 2020 21:35:36 +0000
Received: by smtp415.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 96b01fe5efcd5843237bda437e1afa7c;
          Tue, 11 Aug 2020 21:35:35 +0000 (UTC)
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net>
 <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c013f32e-3931-f832-5857-2537a0b3d634@schaufler-ca.com>
Date:   Tue, 11 Aug 2020 14:35:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/2020 1:28 PM, Miklos Szeredi wrote:
> On Tue, Aug 11, 2020 at 6:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> Since a////////b has known meaning, and lots of applications
>> play loose with '/', its really dangerous to treat the string as
>> special. We only get away with '.' and '..' because their behavior
>> was defined before many of y'all were born.
> So the founding fathers have set things in stone and now we can't
> change it.   Right?

The founders did lots of things that, in retrospect, weren't
such great ideas, but that we have to live with.

> Well that's how it looks... but let's think a little; we have '/' and
> '\0' that can't be used in filenames.  Also '.' and '..' are
> prohibited names. It's not a trivial limitation, so applications are
> probably not used to dumping binary data into file names.

Hee Hee. Back in the early days of UNIX (the 1970s) there was command
dsw(1) "delete from switches" because files with untypeible names where
unfortunately common. I would question the assertion that "applications
are not used to dumping binary data into file names", based on how
often I've wished we still had dsw(1).

>   And that
> means it's probably possible to find a fairly short combination that
> is never used in practice (probably containing the "/." sequence).

You'd think, but you'd be wrong. In the UNIX days we tried everything
from "..." to ".NO_HID." and there always arose a problem or two. Not
the least of which is that a "magic" pathname generated on an old system,
then mounted on a new system will never give you the results you want.


> Why couldn't we reserve such a combination now?
>
> I have no idea how to find such it, but other than that, I see no
> theoretical problem with extending the list of reserved filenames.

You need a sequence that is never used in any language, and
that has never been used as a magic shell sequence. If you want
a fun story to tell over beers, look up how using the "@" as the
erase character on a TTY33 lead to it being used in email addresses.

> Thanks,
> Miklos
