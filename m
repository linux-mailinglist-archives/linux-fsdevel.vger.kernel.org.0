Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394E436200
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 19:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfFERBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 13:01:36 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:40234
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728757AbfFERBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559754094; bh=Iw6G8saJS8XwfQEsaETSOJ0YcpEREEU39n8ez2O36WQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sMks3gOdn1LtawqVfEy+7zU8pO8G6U/hqnaUojM5aOFDGH+7PZ5CjjrWlFYGEDkMi9D6nThAwwQBbStwRi2jI0h5OEOCypt9V2SwTmS+Nb6u2lzK6hKEjcZr3UrJevZcrINUxvcdq9p1qYxSloZ2zhXkWloPCIDnKu/R3bgIEzV6wj2BPbw/CtHPX70I0yzSA7scZ7BjzPusQ/JWX8gQGIyIRKLTiH4JsAJIn3xVEPffKkzgkyvZulmcTMt18FaRI4hgECZDU4n49U1KsRoCG0+pbkEO1vYS6RUL12+CjYYLpYH8Wlbr+g31zFJosfPdg2vwif4nUt36WHYda/XnfA==
X-YMail-OSG: l_XreXkVM1mTGrgCFNfVRxO5XSsNjt4beFtcXXy9Y15Pe7j4Cq3QQDnFcya9iVD
 WJkKRWk4SoQCIgB0YUsm4V9gMT_DL_WkV528xDfjMKA4Ylgtb4uJn22PdxGZ.lFeB56SFM3DfxV9
 nXzUVSRVhMN1Geom31xk4mVLkyA1G3CJUkZeAxwYic.Ej5s4cz_pkIQxtiaXpxyDt0zSsyDFd.fb
 DVsIG0LLckXNjg7ooKh84e.jQPyEcspVLygZwaYFyu96RMGySc60bk8n.qIaW1Zf9vDkReoXHBSO
 nPaLs23taTXIeQfgMQ7rSMD_1IdMOogJ.ewawNQ0diorAa9S_t2Chrr7vy46eoqzJIXPe8ihWPax
 oHKncNfowQq3mrBhNi1MsY8_0zgocDYIT55bMRiO88LzTlM.V2tlGzwrudwleWGqkU1fFZ7lGSUS
 5w3B8H9fnSq1y9YhY9QkggZLYH.yVCuJ.jdC5ie9Rgcr1xaqlNa8ym0I7u6cSCMvBZwZPxNCFNXr
 f1AmIxuqAxXbjR544LyKhYGP1pL871l6cFkXBMkXzT65pL2hpKlvhXSc.ifeIdPs3vZA0idG6IPA
 gh9SAPF0zPwYt2USw9kPlerspmlmzI_EyjSgGRwKHKFtFWw4CLfTCMT7wI2wD0B7OKwo.c4tXXNl
 rx5ZLfmXqq2DOZ3BjjgLVUiTY5U7w5zveiE40CGtVkR8Ktk8szfmIiqRW_Hi3.mgb..4B691wurP
 TCqzkrONPpTSRek7uTVmjVd8ScRIxv0k7p8BEERQo7z85dK7YLbbrLHpjX5uJyQ.66EabuCiPAFa
 1SMhDKm5ozYtNWODkaw.b4sfuwCHSL4DlNWANW2PD9ueELh6JoiVAQo0CoDHhSJrzM1bqaM_uPHA
 IW.olxy5Ft2gmUwSpQfFIPUfDkiiOcUH6g6x2Fx1Ri6lutXr_BNWUMBsAmcNKMDM7ah0cx9nqET6
 DrN7EBbOq7E9AOzKHD4PyRTFTgQa133Hz.Qa6G_bAMk.0AyqeD1py_.onN9y0PBP.Eo0LVbUkDbZ
 CXSV7qq7fXPBC8MWZql6hcl34lxuSFQQCxH_gPEqwj11YDTEri_zr2nME.4kb2A.K1SPtXg3DiQY
 KSFQBcio5bOouUrOu1ECccHnGoemow1RkJVPwxr4uzGyztAOKobwXDCiwjnMXgioHumWoQOJwwEF
 xkrnBBKumimyhX0uwK7CiqqYCi7hXsI_Ei.ONq.AlKjo13DVb8Xi0FL3d_fwPb_W4N.WvC8ab4ZJ
 uPpjx_Kfx5TWALkq5KTDgKXhcGqNqxV_zDzWi4OXe
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Jun 2019 17:01:34 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3b81f76de5e095803bd03e36e9f0cfa7;
          Wed, 05 Jun 2019 17:01:30 +0000 (UTC)
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
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk>
 <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
 <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9a9406ba-eda4-e3ec-2100-9f7cf1d5c130@schaufler-ca.com>
Date:   Wed, 5 Jun 2019 10:01:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/5/2019 9:04 AM, Andy Lutomirski wrote:
> On Wed, Jun 5, 2019 at 7:51 AM Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>> On 6/5/2019 1:41 AM, David Howells wrote:
>>> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>>> I will try to explain the problem once again. If process A
>>>> sends a signal (writes information) to process B the kernel
>>>> checks that either process A has the same UID as process B
>>>> or that process A has privilege to override that policy.
>>>> Process B is passive in this access control decision, while
>>>> process A is active. In the event delivery case, process A
>>>> does something (e.g. modifies a keyring) that generates an
>>>> event, which is then sent to process B's event buffer.
>>> I think this might be the core sticking point here.  It looks like tw=
o
>>> different situations:
>>>
>>>  (1) A explicitly sends event to B (eg. signalling, sendmsg, etc.)
>>>
>>>  (2) A implicitly and unknowingly sends event to B as a side effect o=
f some
>>>      other action (eg. B has a watch for the event A did).
>>>
>>> The LSM treats them as the same: that is B must have MAC authorisatio=
n to send
>>> a message to A.
>> YES!
>>
>> Threat is about what you can do, not what you intend to do.
>>
>> And it would be really great if you put some thought into what
>> a rational model would be for UID based controls, too.
>>
>>> But there are problems with not sending the event:
>>>
>>>  (1) B's internal state is then corrupt (or, at least, unknowingly in=
valid).
>> Then B is a badly written program.
> Either I'm misunderstanding you or I strongly disagree.

A program needs to be aware of the conditions under
which it gets event, *including the possibility that
it may not get an event that it's not allowed*. Do you
regularly write programs that go into corrupt states
if an open() fails? Or where read() returns less than
the amount of data you ask for?

>   If B has
> authority to detect a certain action, and A has authority to perform
> that action, then refusing to notify B because B is somehow missing
> some special authorization to be notified by A is nuts.

You are hand-waving the notion of authority. You are assuming
that if A can read X and B can read X that A can write B.

>   This is just
> introducing incorrectness into the design in support of a
> not-actually-helpful security idea.

Where is the incorrectness? Are you seriously saying that
you expect all events to be generated exactly as you think
they should? Have you ever even used systemd?=20

> If I can read /proc/self/mounts, I can detect changes to my mount
> namespace.

Then read /proc/self/mounts!
Can't you poll on an fd open on /proc/self/mounts?

>   Giving me a faster and nicer way to do this is fine, AS
> LONG AS IT ACTUALLY WORKS.  "Works" means it needs to detect all
> changes.

So long as "WORKS" includes maintaining the system security
policy, I agree. No, I don't. We already have too many bizarre
and unnatural mechanisms to address whimsical special cases.
If speed is such an issue you could look at making /proc better.


