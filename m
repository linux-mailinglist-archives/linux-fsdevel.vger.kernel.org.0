Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4311E8AD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgE2WCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:02:51 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:39990
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728739AbgE2WCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590789768; bh=mEj+xfzKlw4Ib7x5AQ10oWbC2hqZKkrwlMK84MkhhpI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=c88/l/pQJgxvc0MmnUAl5HrXokW6XiILcttim2Qoqmyy3gQF6CsjkOC0zZxZp6SXkRnRu5N2+GGH6Wztygl1i/tfh/3+vtO78BGcx39QG4uG1C/HHhVHRv9BmWNiIfRPMo2hO8oedEGRwSZcFPAjvp1mO0rYCR+PHOhe7VmyePT0umkmnrlP7InzYhMqimliRfniWJnnh458MBiI+eFXdE1DRcsF6y66Ctk7INCypzndds9u6HPgbmpeA9JssPvwvgY6qVzRIUIGQVN+gPh3pFwEuWeNHUfGsKIjcFADUlEGP0nJLoLw2ltlLPa4YDGGn3Szbu6a/8pYsRJ61IPNFQ==
X-YMail-OSG: BbHTdY0VM1l_f3uGlIt31U3Z7YOjnIP8_01nB_WwQppkYchHpCO3knH_x467xSC
 cN5Y_P4sR1wed9Ixzc_W5.SfVJusYlgQj5gALvW4amsGAG93fuFVj9Jw8klt5YSSiwHyrj_Vui9E
 lAZkbGhf.gtLCSyucpKECJAJUD6afb6PDcmYmeBbYRKmkijIvs5QK7hUZ4OpWbOKIq5C3TTTo5E6
 vOsmRMMnxNNNBDJCXIrG.xVbxYMigJFLhQ_W04koNYJR27xMRHRhieHpfky6RMYzk252XTW0FGR6
 awBMBESOGaP_9olDkoKkUqfh8U9bqGmIlRJG4S9QWZlCM_9T0mhEL_YCRaA1V_sLZpLb4mYKFltQ
 I3rq3hspfH44q9100HSRubIaka8T6VQpM8PIqrb_7sgAgoFDBqe37Agj0h9qial5zgE1siSzIln0
 kV2JkTZGdu0lUJfKupl4M84UUBRdynDwnUkugGXjCsLJK17K3arocsZ4OVb5H0h0LPWTXNEPYHYi
 1ObX05LNnPM27nIE8cwPmizDZKn_2YzY5X6.OnW4y_Yzaf1b6x8jJUwYPQ3ihb5n9JMsEtnn5xKF
 faaIIe6Y2LWaqh3j9ZbNMH0A0K0MrnZpPvJGCsD84uO1lCzDN1AnBMot3Y0NRObsB3zOSWY1Mncq
 tx0nOVrBfny8ADKwhqCh6cH_0a.785a6JwN87p5rtsj1sS03THKg2EclEcWHPGtmgIDE517a1089
 M9pCsYdjgeILDkjJWSpDwHq5qI37Y3DjknLpQPOxV6Npt4787_Xxq7jMwd2FdpdJ60ij2FrWIaxn
 G0VBKRVKguZd_AK1ELoVZ8iRH1q_qYmIaoQwtugZxYkqANZhugzD9xJccyw4co3M_ln6SG1WIRUn
 s05vsuve.v2Q1D.Eax0lIvdX.6UJBThM0AIRRFm.3jcAdbLol5zetpPVEeo8JBLbuJFO.cAFwVwo
 1FZJco4gK15YRUWfhN9Qsjxk6rnwweHi3ALHhwQnzCH89x93jDXXm30XKetT9KU_55w0SjrN9cjy
 V32bR6hLjyYD0c1m6DMEZFLMeXVwyo7Zsjpu_zju.Qm3FwruGJI6FJn5yYJXkb6ZnUpMbAUjxG68
 e_1_ZSftnrnD7Ax158.N_sByg1pB01ZxnJgGUPPQ0iJh55n0u6Nq57BHpaRMTrHHLBfFJ5WRjTN2
 YJkw.KTLMpBx9gQZ7l6O2yCyw0zcNxBOLo41i78o3scQKnJv8T57GRzjOiY3VHiqRNz47.PfElN1
 2sxNYeG1fFJG7FVDpTc_gDm8NB4uZrXy1P1xEZXbVODsUUFqJRjFwmbyiQv.Q1KsSo8297f_7trq
 IK0Y5PC6O0PpZS9mLXIu4tvI_gvED9gt7g.QcQBxSSO5tqZGQU74Ln9HMcxBnaeJnQ4SPQCXAYtm
 plMdPL99pzw3qgfZjlqJ0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 29 May 2020 22:02:48 +0000
Received: by smtp420.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 20de778416897511a1a9920cd4567e13;
          Fri, 29 May 2020 22:02:46 +0000 (UTC)
Subject: Re: clean up kernel_{read,write} & friends v2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <20200528054043.621510-1-hch@lst.de>
 <22778.1590697055@warthog.procyon.org.uk>
 <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com>
 <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
 <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7b6a91a5-8c6d-044f-f675-800e0157dc39@schaufler-ca.com>
Date:   Fri, 29 May 2020 15:02:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15959 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/2020 12:19 PM, Linus Torvalds wrote:
> On Fri, May 29, 2020 at 6:08 AM David Laight <David.Laight@aculab.com> =
wrote:
>> A wide monitor is for looking at lots of files.
> Not necessarily.
>
> Excessive line breaks are BAD. They cause real and every-day problems.
>
> They cause problems for things like "grep" both in the patterns and in
> the output, since grep (and a lot of other very basic unix utilities)
> is fundamentally line-based.
>
> So the fact is, many of us have long long since skipped the whole
> "80-column terminal" model, for the same reason that we have many more
> lines than 25 lines visible at a time.
>
> And honestly, I don't want to see patches that make the kernel reading
> experience worse for me and likely for the vast majority of people,
> based on the argument that some odd people have small terminal
> windows.
>
> If you or Christoph have 80 character lines, you'll get possibly ugly
> wrapped output. Tough. That's _your_ choice. Your hardware limitations
> shouldn't be a pain for the rest of us.
>
> Longer lines are fundamentally useful. My monitor is not only a lot
> wider than it is tall, my fonts are universally narrower than they are
> tall. Long lines are natural.
>
> When I tile my terminal windows on my display, I can have 6 terminals
> visible at one time, and that's because I have them three wide. And I
> could still fit 80% of a fourth one side-by-side.
>
> And guess what? That's with my default "100x50" terminal window (go to
> your gnome terminal settings, you'll find that the 80x25 thing is just
> an initial default that you can change), not with some 80x25 one. And
> that's with a font that has anti-aliasing and isn't some pixelated
> mess.
>
> And most of my terminals actually end up being dragged wider and
> taller than that. I checked, and my main one is 142x76 characters
> right now, because it turns out that wider (and taller) terminals are
> useful not just for source code.
>
> Have you looked at "ps ax" output lately? Or used "top"? Or done "git
> diff --stat" or any number of things where it turns out that 80x25 is
> really really limiting, and is simply NO LONGER RELEVANT to most of
> us.
>
> So no. I do not care about somebody with a 80x25 terminal window
> getting line wrapping.

The first law of good C programming is:
	"Thou shalt adhere to the One True Brace Style"

It extrapolates into indentation, line width, and a number of
other things. Since Linux is a trademark of Linus Torvalds,
you get to define what the "One Truth" is. Time to resize my
terminals.

>
> For exactly the same reason I find it completely irrelevant if
> somebody says that their kernel compile takes 10 hours because they
> are doing kernel development on a Raspberry PI with 4GB of RAM.
>
> People with restrictive hardware shouldn't make it more inconvenient
> for people who have better resources. Yes, we'll accommodate things to
> within reasonable limits. But no, 80-column terminals in 2020 isn't
> "reasonable" any more as far as I'm concerned. People commonly used
> 132-column terminals even back in the 80's, for chrissake, don't try
> to make 80 columns some immovable standard.
>
> If you choose to use a 80-column terminal, you can live with the line
> wrapping. It's just that simple.
>
> And longer lines are simply useful. Part of that is that we aren't
> programming in the 80's any more, and our source code is fundamentally
> wider as a result.
>
> Yes, local iteration variables are still called 'i', because more
> context just isn't helpful for some anonymous counter. Being concise
> is still a good thing, and overly verbose names are not inherently
> better.
>
> But still - it's entirely reasonable to have variable names that are
> 10-15 characters and it makes the code more legible. Writing things
> out instead of using abbreviations etc.
>
> And yes, we do use wide tabs, because that makes indentation something
> you can visually see in the structure at a glance and on a
> whole-function basis, rather than something you have to try to
> visually "line up" things for or count spaces.
>
> So we have lots of fairly fundamental issues that fairly easily make
> for longer lines in many circumstances.
>
> And yes, we do line breaks at some point. But there really isn't any
> reason to make that point be 80 columns any more.
>
>                   Linus

