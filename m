Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B56350EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 22:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFDUbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 16:31:52 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:34785
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbfFDUbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559680299; bh=2oO3AC7G3WVdgBC1FKSrqp/j5wxp08KaHcpA6OlkO6A=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jBIjnMHsIyJRcyvAU0UF3BYvTIt4W4TMczgDwxdye2DBPuCU8t45Btn3ndfYuEiUHK4p8Cb21r7GQBz0kNdq9IOpTsn4S4o7b/FPwF6qivAyB0cIDOsEr3JBZpsXDm+po2lHhg2FFnH3bMDBxnJlB7rOiJj62AbKJzrkDQG/B5V08AZ9gH8BG7AxqBzS2bDZNjy/lksUFfvihMBx4IMM5jbNVMamBWSfxtNufhwjuch1OAp4j+RhbJizg6HbuoQ1xCOwhGQk8etJbbGmCYkKPrDbZtQVfmXhpsumWmzwbc69MCHLao5lPluuXpqkwWNi0gXyick8XaRVkXOxtNfkow==
X-YMail-OSG: cib7.UMVM1k2qx.6kYvO5LekyL_FU44OpDYXhwxPFdOijDYShRUGNYGke9UPe6L
 oFD0ocRk7DSAmbjxy._XhHAuOk9hCm2gGu.Z3uOYUJlXE_iNMp9xei2aYos2zyCRcAWXOzAo2wOT
 TeMMtFtWQ.kkJZRnjjtSjRirP_l9jH1HTNgiz6bTVes4Afe9lGIUAxOjlW82ibm93.dbwgzVPWNh
 XpbWR.qYNNO_htGy1Scntcsb3hzdkSnSseBtMvTMcjYv.uxMhUvMFH30EIWstgN0X4D.f6QslVic
 KlDCqImByxadZJeNTiyJ3KMqiYTn2z72ya0Op699srkclQUis9KOGiTToVuBN_6hFXfMCWPolQBC
 zynNyjkku7SR4nPVqGVDKjT7ptLhh_lxngHnRZBOvcl705ZAkYTIEJ7IvUydu._d6Bfjkahbe7Oz
 Te1bKtGt3JshpBEZK_3oNsFd4W6399iSpY20Co6MPpoGHNmTiinZfnK7v3Km2ydmkK5TMRzKQSia
 Sbjnnd5x6brUHZj7c7c_p1dVZcXNqBCuGMkJHB1u1FX5x7hZ8PWE5f4xMG84eVWGtRSnJ9WPJ6pi
 5vjOhHOvHHiRvQkHHvZMn2fM8dbSbXrCxogbQVmYQDO7q96hG4YaZn5c4GWZViO1SonEFgdHjSAQ
 Vx2VqY6McjuBL3NRK0p.E_W7jgjddNQ_0Z7WKQIGNCP11b2IfTtSelYSgertmJBbETmIwU2K9BeU
 Se7wmih1dXv1tBWq92kQ6PfIuJwo1PfZp9vpzCmgvGePU0pAkihNZoU7r_mPKgWE.ahrAtgKp2cW
 psOWaUJCb6CR3LpR5n0U2bjX.ID4tA9zYBR9If_N5d8wopY2_mYcESiRgcoyvby6.ngFKiDyXUZQ
 Ih.fXtErrFjNucqfHBtX4iyJW8l3s0OyUpA9eZE.ULrykvzyIwKbPVqzqC0k0O6FgU49Os029zsF
 neWfJhp1Uv5GTrHKo8nhMe8anQNCI_tXEOZ_jte2pW3Y08ig7ojqMY5be9GTi6LWWPUDpIosE.Ol
 B4BAlbtMOgrMb_YppD2Z24BFi.qjPRyz.dCFCtK6XKzmYXh1Z1QodedG5ltnwvWKpS4rfwHgriWF
 Uk7AF9n7T9m.vfMftWZdF4qd9X8XrN5VFIBdHWWWTNnwVNFYr2ILcAkyPPdo7Qfnfs7XV8cBt7v0
 XW1pty6Ek3waZ2JzOUGy5IhHEaKxBZVupQ9TzUlBhmecLZJiwslESBuG0F6v0.5jvXLr4_eVhUTv
 bdJOyRfZr689L5c3Oy9k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 4 Jun 2019 20:31:39 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8ee78ba6e07883911f0213d43032097d;
          Tue, 04 Jun 2019 20:31:38 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver
 #2]
To:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com
References: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
Date:   Tue, 4 Jun 2019 13:31:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

n 6/4/2019 10:43 AM, Andy Lutomirski wrote:
> On Tue, Jun 4, 2019 at 9:35 AM David Howells <dhowells@redhat.com> wrot=
e:
>>
>> Hi Al,
>>
>> Here's a set of patches to add a general variable-length notification =
queue
>> concept and to add sources of events for:
> I asked before and didn't see a response, so I'll ask again.  Why are
> you paying any attention at all to the creds that generate an event?
> It seems like the resulting security model will be vary hard to
> understand and probably buggy.  Can't you define a sensible model in
> which only the listener creds matter?

We've spent the last 18 months reeling from the implications
of what can happen when one process has the ability to snoop
on another. Introducing yet another mechanism that is trivial
to exploit is a very bad idea.

I will try to explain the problem once again. If process A
sends a signal (writes information) to process B the kernel
checks that either process A has the same UID as process B
or that process A has privilege to override that policy.
Process B is passive in this access control decision, while
process A is active. In the event delivery case, process A
does something (e.g. modifies a keyring) that generates an
event, which is then sent to process B's event buffer. Again,
A is active and B is passive. Process A must have write access
(defined by some policy) to process B's event buffer. To
implement such a policy requires A's credential, and some
information about the object (passive entity) to which the
event is being delivered. You can't just use the credential
from Process B because it is not the active entity, it is the
passive entity.


>
>> LSM support is included:
>>
>>  (1) The creds of the process that did the fput() that reduced the ref=
count
>>      to zero are cached in the file struct.
>>
>>  (2) __fput() overrides the current creds with the creds from (1) whil=
st
>>      doing the cleanup, thereby making sure that the creds seen by the=

>>      destruction notification generated by mntput() appears to come fr=
om
>>      the last fputter.
> That looks like duct tape that is, at best, likely to be very buggy.
>
>>  (3) security_post_notification() is called for each queue that we mig=
ht
>>      want to post a notification into, thereby allowing the LSM to pre=
vent
>>      covert communications.
> This seems like the wrong approach.  If an LSM wants to prevent covert
> communication from, say, mount actions, then it shouldn't allow the
> watch to be set up in the first place.

