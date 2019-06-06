Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8437C37CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 21:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfFFTJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 15:09:20 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:41146
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728752AbfFFTJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559848158; bh=KPinPwVYIStvQmTsZ8fVXryXE8chlEpKVcNaTLUqBkk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ptIZ7O3DcCuP6w96YCf4TBwwelJOiWXKMueXaWyXXS5Hq4SYnr+yqA27IH0WbMQoPfbRbUAYQs6alr5jVMqntnHFO0+yYMLbtHu07P99vBJBR/ZbfP/q9g/AKfkOdYByqCRzi+YL7ZJCWcaOAIEP7aXHhA+KDM4seVJqvsWL4U6YdwfiAFzsG7yKAAHLbLvLFtIXtgAOEmLhSo7X254jAXTBVLDORGqw7jcx9cMvHyg+LgwOfgJEhz6RBLYq9HcoWq5RwT9x3qkQ5xp1LGAcf5td6F5w5rSU1teFRtvLCtzee7HmPQeoel+4MeK+9HKpsCKhfyBWCLA8zx5soQhZ9w==
X-YMail-OSG: hwHY0p4VM1kwRqNYlfVs6s8UA1io1Qfjq69S3APVqgYmJdqbzWmf7qM_wuOVZb0
 44B5oxy_HtlaNFHz1uTJf25C.0moouu50bDEYxg10avFv2azcLT5bO5NUW5OB.7OuBR3w7_Hvj1A
 qRg3JQPakoyrYycrPfyDrpK2jBhxa2Mdf3vI1UQGdWpt6zyg1YDdBr_cw0QZ4Ycor4QVTJWG4INZ
 KCPv4gPoKYY6XYoR3PusfzS66bJlVp3kcjYoAd_GOEcD8a4jxnw0dkJD3MZE_vu36MPjSMDBVbX.
 3NI8PTxJCV2tvu.v89yCWsiHuXhXDNl2A9TSOZlNEWsPz38IOJNXg4E2ZZLofdgqdcAAQhJg6Blm
 Se8VrP0PeDPtyklbpBV.Rm0xbDt3YbU7duji7YUvhWcJJrNWmEeFk6.fMCjeuKlNRSZls6KmGc0n
 eA.xZmw9ke9PqoPJ46MkZvUOQBBjhHiTbtvcIMOsWtXXQyfpu3yMCzCjNN9.nZazEHY3I6NCBW9Q
 v9KjC5tcfmQzzFOR3dWxL.WUhU7h.c9VomQfQgDtola0.PJobrTTeuUs.F2WZN5ONR7Demk4b9Rd
 K8XJUV0RjdcpPpcCVMrLwC.IzIlM4Pw_ko6TeA8mTH_gvceK_S4WUgnw1GlZACwnTPTP5dPLZ1V2
 BUxvg704FI_grQNcp7zt5Astvviru298J3zooXyAQQ7kADqT0ygNTtkECAolkQk7dJDgb8byXr0a
 kqGxMasgw8.De0uWywq6vWLnb0t91_rXwEZr17HHGAMhtBDk0R7Ri03asoPYZKATX2d4Y778N7H8
 6EaJ4m8z8TB9ulLUSLa_.ztDkP6Lszm3_ihfLVrD8kp.q8Od.xl99cvIM2MyLj2GDDPdWv_lXGCH
 1eBPljjZGzXWQHP4VxUcrDfDX2V6pfgGfXySasOB9ZYxN0M2KcpH.yy.CS31YvIcy1_4FPMcxy9J
 LIOJRrDOLIMcSP_55W0mMNvXFTbrF7gWQQ01eYcm.l2.TSh9KZOT5l2OAo_VgT2N2btyTh1sX.Bd
 _7gEkXyp6CFX9W_bT5PeCNVkjUOW2O54CFrvVfd0LW_Gu2wiVocWlWw._qFwB9Iv4.kTi_Fbu3Hn
 .j9mF9JRzytmZ91owEN15vId6q6qPWt7sUkDLojxv16KscbX6Qr7R51Ii6bX1trZZJi2uiRlXjs0
 G1i12exe9mz4FcI3AZza6l2YZfzpacHYfYwUmSjk04_fOIX.Z3QBy36o0qKVPGoKEC1sWVf5Uq8p
 AVaeu2iyQUIXNvUVMcQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Jun 2019 19:09:18 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp416.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b9532036bed4f2064fc104d314331dec;
          Thu, 06 Jun 2019 19:09:13 +0000 (UTC)
Subject: Re: [PATCH 01/10] security: Override creds in __fput() with last
 fputter's creds [ver #3]
To:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <155981413016.17513.10540579988392555403.stgit@warthog.procyon.org.uk>
 <176F8189-3BE9-4B8C-A4D5-8915436338FB@amacapital.net>
 <11031.1559833574@warthog.procyon.org.uk>
 <CALCETrUukxNNhbBAifxz1EADzLOvYKoh9oqqZFJteU+MMhh1ig@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e434a62a-d92a-c6e2-cda1-309ac99d4d5c@schaufler-ca.com>
Date:   Thu, 6 Jun 2019 12:09:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUukxNNhbBAifxz1EADzLOvYKoh9oqqZFJteU+MMhh1ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/2019 10:18 AM, Andy Lutomirski wrote:
> On Thu, Jun 6, 2019 at 8:06 AM David Howells <dhowells@redhat.com> wrot=
e:
>> Andy Lutomirski <luto@amacapital.net> wrote:
>>
>>>> So that the LSM can see the credentials of the last process to do an=
 fput()
>>>> on a file object when the file object is being dismantled, do the fo=
llowing
>>>> steps:
>>>>
>>> I still maintain that this is a giant design error.
>> Yes, I know.  This was primarily a post so that Greg could play with t=
he USB
>> notifications stuff I added.  The LSM support isn't resolved and is un=
changed.
>>
>>> Can someone at least come up with a single valid use case that isn't
>>> entirely full of bugs?
>> "Entirely full of bugs"?
> I can say "hey, I have this policy that the person who triggered an
> event needs such-and-such permission, otherwise the event gets
> suppressed".  But this isn't a full use case, and it's buggy.  It's
> not a full use case because I haven't specified what my actual goal is
> and why this particular policy achieves my goals.  And it's entirely
> full of bugs because, as this patch so nicely illustrates, it's not
> well defined who triggered the event.  For example, if I exec a setuid
> process, who triggers the close?  What if I send the fd to systemd
> over a socket and immediately close my copy before systemd gets (and
> ignores) the message?  Or if I send it to Wayland, or to any other
> process?
>
> A file is closed when everyone is done with it.  Trying to figure out
> who the last intentional user of the file was seems little better than
> random guessing.  Defining a security policy based on it seems like a
> poor idea.
>
>> How would you propose I deal with Casey's requirement?  I'm getting th=
e
>> feeling you're going to nak it if I try to fulfil that and he's going =
to nak
>> it if I don't.
>>
> Casey, I think you need to state your requirement in a way that's well
> defined, and I think you need to make a compelling case that your
> requirement is indeed worth dictating the design of parts of the
> kernel outside LSM.

Err, no, I don't believe so. There's a whole lot more
going on in this discussion than just what's going on
within the LSMs. Using examples from the LSMs makes it
easier, because their policies are better defined than
the "legacy" policies are. The most important part of the
discussion is about ensuring that the event mechanism
doesn't circumvent the legacy policies. Yes, I understand
that you don't know what that means, or has to do with
anything.


