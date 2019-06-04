Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1B35278
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFDWDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 18:03:20 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:46778
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbfFDWDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559685798; bh=it87Li8X1fzF6GnnpwKo6n6EaGmfjJ8Zx/rKpthubcA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=nTT+jq/IkCSW8jSPuC7/EK2CCafFikNs7Nxw1eVCJ+35tu+RUoNf6sJppH8Cxcu9guKIcRsIi0BtfAMXkrqFVQIGBJex3tF/eMZQMYum1gvFy0BYx8GyRUuyz+BgwTYUaEbDYK58eqU2pDA/BzIh05WojCGemt+NzYK1EIFC57/sFMXq2VNcXkzOntfSkPXzDmaogCyAp3UVWg+RFhKUvPiC6/w/nAQYxNxZdw/V64cR9FjHMexZbbZDEAnC9m/Kq6/g6JqD9Q9Z7t6t2Krzy6bXolNfEX4oMfnpI6gRKiMWsHEWcRmrX0/PHVhfgeWwGvmrk0uQr/GaG1baRZ6/Dw==
X-YMail-OSG: HV0Z7VcVM1me.wz6aCLBtkVrXZPA34GAH._hP_ysc0btY5aY.ICZx0YRJneQSFz
 2_..lJdN.bMR_HPncp8WGB.hDsTj_baStuZAmvgjmnxS990UtjdGvrvYfr4sAWRE1qEmhbNixDGM
 9p2YGaXpFdSpo0OU2QKXc39qeb7SUgd2qXPIRI1uFPuzz1qk3rlQbY8BZYwAmt2o5FO2JINwaUZv
 H3zICJvqi7U.TNDHJxp6jcTRTRp5PQmGKcIEySX6_Vm2ImwnozvwaD7q.BIoTDbaGYgbFipVYEW2
 cp.BQz4Md3_XtXwDuMybaMPP591sV.bTvN.B9Pw.2wKzAbMC5SRL6fCO_bUbek7kDIAXMHt1FNZx
 zsc2iRI6UibC8ahPEAhVSeJVWPkR_FOY9kRVXvGCctfAITwrtY_u27t4.OCtxTx0DLaXNQFGGOB0
 E9P6p8F5Iei6vgqbIruTro.KBL1pJp4Q4c8qztomPgSfuzycXYjyThSMDEpRfbcONGaOuZGRGvhs
 s.kDM8yFBGwmC3wjaUFqUTIxUU7HuWkyXPK.iNstgEByce_TXzZRitnhP8x2AonyhWKFAbgjd_5g
 wqZzTEjqWplglZwLJXjGTyqLudmVDKON3cEJCQ6RTxbsuCweXnYdaoY.vOthd8ajNyyIp5tmB9HJ
 J8kzuClvOPvJbAPuejISlhCTDNppq4qKddF4ZZX3PtvqrIaSNuxRNPhgulGOdHVbbKFoZmLlzdCC
 cwVZ7vr0p7opz9sMEc4IzmG4JXkNRBE_F6POrEsGgO0hDJvHiL8LBhZmyboUfoRvLdXTDVuf3x95
 VpOzOElFvyM8jsIY2vvMdt5dXSk_JPiJG5dE.NrEh07ZnqqIdH_x4aLpbdjemn8IL52g5RwXXe49
 le0eJ.Kb9.XPXRg6WGwvRKcibf3p2Ghzef.jDRHCGtsk0CAiD6usMzguLVHdOwXBBMc4U85J_1qG
 _ZMzXpznr_1sdQcrJ0MqUlOwSDl7E.2aGTL5MIuDi9BPdtkwgCVyrujndwLwovXJ8aAYeQl_Pcrz
 7xUCB8kLgHQPyA0N7g1oGsxLcrJp2fqI4e3mon_pop8RBkZv.x.H2O7l74wv8acwppXTLNMz_jqy
 02.6ZisMlRLmOUY8yPAXLOLnvEmbajtyRQcQgD1iLs9gNICjrFcSCyFsvQjWLxj3yQ__jIyIA0eu
 1MR0Str0aPbFZrspZqk.PnIKlARtm_dharD6lUxJPvhQMYTqiG9jUjp5YhTdyJEwWXM6IcG21_WW
 4oVxGZgzfqg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Tue, 4 Jun 2019 22:03:18 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f9df356a2f48fa04da5bc0865b0d3777;
          Tue, 04 Jun 2019 22:03:14 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver
 #2]
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com
References: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <CALCETrWFBA8H0RiZPikLtEi8xg-cqJLtQgnU2CGTuwByrHN7Dw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7645e662-8053-aeb4-ec79-57aa0bab4932@schaufler-ca.com>
Date:   Tue, 4 Jun 2019 15:03:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWFBA8H0RiZPikLtEi8xg-cqJLtQgnU2CGTuwByrHN7Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/4/2019 2:05 PM, Andy Lutomirski wrote:
> On Tue, Jun 4, 2019 at 1:31 PM Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>> n 6/4/2019 10:43 AM, Andy Lutomirski wrote:
>>> On Tue, Jun 4, 2019 at 9:35 AM David Howells <dhowells@redhat.com> wr=
ote:
>>>> Hi Al,
>>>>
>>>> Here's a set of patches to add a general variable-length notificatio=
n queue
>>>> concept and to add sources of events for:
>>> I asked before and didn't see a response, so I'll ask again.  Why are=

>>> you paying any attention at all to the creds that generate an event?
>>> It seems like the resulting security model will be vary hard to
>>> understand and probably buggy.  Can't you define a sensible model in
>>> which only the listener creds matter?
>> We've spent the last 18 months reeling from the implications
>> of what can happen when one process has the ability to snoop
>> on another. Introducing yet another mechanism that is trivial
>> to exploit is a very bad idea.
> If you're talking about Spectre, etc, this is IMO entirely irrelevant.

We're seeing significant interest in using obscure mechanisms
in system exploits. Mechanisms will be exploited.

> Among other things, setting these watches can and should require some
> degree of privilege.

Requiring privilege would address the concerns for most
situations, although I don't see that it would help for
SELinux. SELinux does not generally put much credence in
what others consider "privilege".

Extreme care would probably be required for namespaces, too.

>
>> I will try to explain the problem once again. If process A
>> sends a signal (writes information) to process B the kernel
>> checks that either process A has the same UID as process B
>> or that process A has privilege to override that policy.
>> Process B is passive in this access control decision, while
>> process A is active.
> Are you stating what you see to be a requirement?

Basic subject/object access control is the core of
the Linux security model. Yes, there are exceptions,
but mostly they're historical in origin.


>> Process A must have write access
>> (defined by some policy) to process B's event buffer.
> No, stop right here.

Listening ...

>   Process B is monitoring some aspect of the
> system.

Process B is not "monitoring". At some point in the past it
has registered a request for information should an event occur.
It is currently passive.

> Process A is doing something.

Yes. It is active.'

> Process B should need
> permission to monitor whatever it's monitoring,

OK, I'm good with that. But the only time you
can tell that is when the event is registered,
and at that time you can't tell who might be causing
the event. (Or can you?)

> and process A should
> have permission to do whatever it's doing.

So there needs to be some connection between what B
can request events for and what events A can cause.
Then you can deny B's requests because of A.

>   I don't think it makes
> sense to try to ascribe an identity to the actor doing some action to
> decide to omit it from the watch -- this has all kinds of correctness
> issues.

It works for signals and UDP, but in general I get the concern.

> If you're writing a policy and you don't like letting process B spy on
> processes doing various things, then disallow that type of spying.

That gets you into a situation where you can't do the legitimate
monitoring you want to do just because there's the off chance you
might see something you shouldn't. "I hate security! It's confusing,
and always gets in the way!"

>> To
>> implement such a policy requires A's credential,
> You may not design a new mechanism that looks at the credential in a
> context where looking at a credential is invalid unless you have some
> very strong justification for why all of the known reasons that it's a
> bad idea don't apply to what you're doing.

Point. But you also don't get to ignore basic security policy
just because someone's spiffy lazy memory free cache hashing
tree (or similar mechanism) throws away references to important
information while it's still needed.

> So, without a much stronger justification, NAK.

I try to be reasonable. Really. All I want is something
with a security model that can be explained coherently=20
within the context of the basic Linux security model.
There are enough variations as it is.


