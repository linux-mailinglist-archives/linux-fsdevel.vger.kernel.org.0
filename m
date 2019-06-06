Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451E937CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 20:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfFFS4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 14:56:12 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:45397
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727246AbfFFS4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559847369; bh=NlyGDPUSIm+l2WtCwHE5ubPlB5te+dHeUApEhOctwXU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=lXEEOxeG/6LmeDGYwm0a86zYDqvYPMHOrllLSJpdVaBpvS994scNyDK/9DGsEJMwppf3iLPTafw6D9PWywydOwXZbC7//fSsQpvu9kU2FVF3j8/VPz3IYgVCuLp2yK5f7yCJfqGjXNMcwt7x9PRSoo5ir9O2hVSuCyYc+V06bwR3wMxBeWMqO4QAYFOF1FYpmyRosRWvaJeWOVJi1AVgFHPOEvtCkIpFuOMQQ+ENnOBCAe80olc6LJEd3ClZ3Ti7ve3PaKf6/BrjtctObI8gSnqAqO7DSSCuzG0s9TCsa1Ktzop3S4PqdEG3lNgdTt149NEghQn3dGhw19qnEzm9jw==
X-YMail-OSG: x_CT2iAVM1ns7rIv4O7BHZqMxa2ifhggjbDHMCkABzAYL6UF7XXXefOTZCeSoOo
 tZvZ.hNqnLH9tGliu6JLsoe6W7lrtBZA1AAN1Qjdly1W2.wkyFAtjVZf2ohVm6a51O4NRTUh1rtN
 _hfgI1bCKNHjjWcPr0f8jLsORlaunjYR6W2zmeSPxD1uupuYVS399Pku10nARq2zVpGzZ_dhWUs0
 5aLe4aIEpVemA6GtHLoeLw7BlNgnSJ23ETJrmQQMGbvAJ8dNP.MCDj6XKI6YSJOvjLgB0uC_nLNs
 KawlMdlnHzQFgSAFnuMj9WDSwOdIpFR8zMsg109UzuItusRQHB0E4xwI2alSEMSQ2P1.M8oI3qmO
 hkUDW9D8C6xwNr6iZDm2izUdjOleJMaHtgYH0pc8rLqWqour.BOSjaa.a_svNhoZMasqPfCI8gIv
 EmG2V8faXiyl3CJnIfcxgwqalGz69X099HGdiv3HJhWoOfcSMej7VZj7J_MhU7MLoDuzWCZgQ_Hm
 Z8U2HDOWEGybXBMH3nnYlrQl34jcCldOgAB7aOyvTVhDZWnO6lCy6cHHU926VNJbhroxcBHNOZJM
 SCc10M8CvBafBDw_MPYvr4JVB.tXXfeU5YfF_xWISoE5DfUNGDgU38AS7mrI4ddB0Yv59O.dVVI9
 T85gmYL3YFOIB2HwP5CVjCH4g7W9ZPUR54TtMXwhAVCdsWH9n9rqLtKx1KGekhwFWW_DpX9Nzbsh
 Y.2wM4dhGZitn5dwQLtTOFYcCqNfSo4phmPwejIddFf89E.LUCi9jrLkqDYIgyrjzcCVNsjJaTPg
 .wxNv6Bmpeu.nVlHqVVOsSr10hXa_ocnwd5Yk0jvUt8eAwY6TC5IkVYcy7Y2cCcC2C4Tqz2FqMOY
 SoAPmm6jOUhcFDP_3rKTG95Jl8kJ8aeyk1VUrprVmfICKf97mDQUvNS_7.uNakmu6mOUTx80V_Rm
 LAZOnKKZCqfOyuMhqrD5WUAV2Hv.c2y.fpjlr39YMvioUZxMG.qVfn9vf4g9.0P02FtWITJSDSpS
 _NqZqJUKrXz6jCufxZG0TQ3hFLwSIZ6t9BrK4KY7n53wQOrAfYFsY4FjsS9IooTTkyYp.c6vBMiB
 O.NPL5hNIcXdO6G2xWGsn3oZEYXBCKjQ9T3AAYHx8DfUxU2NISoAlcs29TQo_q0YBDeCJZ00O3KW
 c7OGXkLrppFRgTuj_cUA.PzID7Shv0ZzYNKpaCRPnFVo9R4SIkBRfzzOB3JF6gOoaQ.qwh9JcFVI
 38M_zW9P1JZXqwwy_2nl0tKScEL8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Jun 2019 18:56:09 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 75f9577105f271864dda01fe6e35d536;
          Thu, 06 Jun 2019 18:56:07 +0000 (UTC)
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        casey@schaufler-ca.com
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov>
 <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <3813.1559827003@warthog.procyon.org.uk>
 <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov>
 <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com>
 <c82052e5-ca11-67b5-965e-8f828081f31c@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <07e92045-2d80-8573-4d36-643deeaff9ec@schaufler-ca.com>
Date:   Thu, 6 Jun 2019 11:56:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c82052e5-ca11-67b5-965e-8f828081f31c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/2019 10:16 AM, Stephen Smalley wrote:
> On 6/6/19 12:43 PM, Casey Schaufler wrote:
>> ...
>> I don't agree. That is, I don't believe it is sufficient.
>> There is no guarantee that being able to set a watch on an
>> object implies that every process that can trigger the event
>> can send it to you.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0Watcher has Smack label W
>> =C2=A0=C2=A0=C2=A0=C2=A0Triggerer has Smack label T
>> =C2=A0=C2=A0=C2=A0=C2=A0Watched object has Smack label O
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0Relevant Smack rules are
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0W O rw
>> =C2=A0=C2=A0=C2=A0=C2=A0T O rw
>>
>> The watcher will be able to set the watch,
>> the triggerer will be able to trigger the event,
>> but there is nothing that would allow the watcher
>> to receive the event. This is not a case of watcher
>> reading the watched object, as the event is delivered
>> without any action by watcher.
>
> You are allowing arbitrary information flow between T and W above.=C2=A0=
 Who cares about notifications?

I do. If Watched object is /dev/null no data flow is possible.
There are many objects on a modern Linux system for which this
is true. Even if it's "just a file" the existence of one path
for data to flow does not justify ignoring the rules for other
data paths.

>
> How is it different from W and T mapping the same file as a shared mapp=
ing and communicating by reading and writing the shared memory?=C2=A0 You=
 aren't performing a permission check directly between W and T there.

In this case there is one object O, two subjects, W and T and two accesse=
s.

	W open O
	T open O

They fiddle about with the data in O.

In the event case, there are two objects, O and W, two subjects W and T, =
and
three accesses.

	W watch O
	T trigger O
	T write-event W

You can't wave away the flow of data. Different objects are involved.

An analogy is that two processes with different UIDs can open a file,
but still can't signal each other. Different mechanisms have different
policies. I'm not saying that's good, but it's the context we're in.


