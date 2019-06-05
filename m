Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 536BE362E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 19:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFERkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 13:40:35 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:43935
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbfFERke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559756433; bh=FS6WCQ6HVfSkh3J0UVH/IQ/2GQPN/OqOn4OrRQ+6OPQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ufZCMCLYUl6UAUQEZ3KwKtjlvoz9q4r9ng+4eMCv2rEiIYX7oay/xaodRzNTkCifF51hZl8jlW3oN2C6qa7dW3WUHZY+o4Tn66sRSvSympWZOl0sT2XbvAqTpjJ0NyaRW9DJtVgOCyCQlFXTW0S3aGgh5hiITnf77bQodv74HltngK+0ZuRrLTRCwJWfprdbevZCqClhBA35NFosV71oFJ2ChQnh2AmtQ5Jl5nRI2UG+sv5JvHLON+zK5Uskf+/F5z9j8+A74thssvcG//7zVcfTjBt+Uyya6VTzVVeGELyeD8zVR5FP9UngNpVOG8fgrcwsXl03i6IhH7F0vu28fQ==
X-YMail-OSG: y_9fc_YVM1lWRx7mTBhYhhPz3g4wm.S1hP99Bt9EaKfswcAQnEuiquBxrNScDQG
 p2sQbtG_v6KJa1C1v51ucqjjAN8TfgChJgQXOOP9gy0sPmLlKU3qYpoCUSI36QJmA4cGm3b7fl9r
 .mixH0ZIkVz_TxtrwIrx2Tss4s9IPsMtJFrdyvROyhaZ4a5XWYn.6Nu52yRg347j4u4Rof_euj5j
 eqXFO5zcHk9039gTnArU7rrZuRg6.KL13SBGPHfJstYnRq8ADV0qPbeU.qR7_kJz6ar3_ABxulZ0
 8UQzKeeRdQGxadia4tqzIfgTUNKv9kANU3O6q1fQtMDjbMRUpGCwXjBxjOG3sLT0sG8U2jxlu.i1
 lZNPhrGReRptXcI.O_8wETnAAAogReR0EbYB9X3Do13.1GuU8bWyvo0G88asLXzgVtwJ9b0xTxGx
 QblRMGFUrjLxlLiNpJYlYple2wTaaAf9d6NsI4_aECmnunj5txvZ3vea5M2CVHn4tOnkT7ibGF_g
 5w0yNwSBe9PTAwRSbGeG59dr7zovpy1.aI8gq5AiM3QiQSM5PDKq7oXgbc1IN77kWs.qL6Djc9V9
 _Z7GbfBoTt3m6B96L0yxQ5g5xZ5iPyjloMHbQGInMdom_3fTOAbRRjWlgclWf7CDutcuVK3X5igZ
 XLwfT8nR3o3JDrAumIy2R94lfK.EhH92jYgqDKCUD389UbKmnrr4yoomdNyGVvWiIZfDYedhqN26
 FBT9jNc1h92D52KIX42d46I0hpUNX1ijRWLpVRGbkRF3wHpGXnHMiJCbjGYRw09s2_6TagIG82Fc
 vD064Y3Sj.i1hrYG1w162kVOJc2KmT9I3nsOtUDOYCDDxmuV55NjxUh6nQIsUXQC65e5GRRp6L7o
 ZJSFo_.XUPUvI8JsDBKgDWKey6peEnISfa3lVBsy0gY7gVHp0aszlLBu9swVEwZMbPazpG6opbNQ
 RhHy3geMCHWEu9zI3P741z0iEkLwElmM2pw7lozE0tyxSMJCzxVIU2wtz7LWNEMAPzJHmy0Elj4o
 JTZDE.y5NvmMPBocirK_YiuXe6KvM7FPIOHnp.OIXRjw8HdYbhAJQyvc4zojoIB7WCdoGaJVjcGC
 giLAH04fcBd8Fw_ApRn2cL1_7z.nfgsWNEcJE6xMSY3K3oyVmLTNtR87jre5j09PfGTvtfCNmETE
 mCcfLxQNB1.Ip86KUq2KZMYUpHTNTxi5HKhkvxG2XeltpOnCFyMpavVQpTIF6AJ288BJHUZ32dbh
 HQWDUXNMYHz_NdY6OR.zl4XUt01HIPkbFkY1xsGQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Jun 2019 17:40:33 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 28445be5e0da53369f19e049a63ecef3;
          Wed, 05 Jun 2019 17:40:29 +0000 (UTC)
Subject: Re: Rational model for UID based controls
To:     David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com
References: <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
 <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk>
 <18357.1559753807@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <f19dcdb4-f934-34c2-f625-95c2c928d576@schaufler-ca.com>
Date:   Wed, 5 Jun 2019 10:40:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <18357.1559753807@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/5/2019 9:56 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> YES!
> I'm trying to decide if that's fervour or irritation at this point ;-)

I think I finally got the point that the underlying mechanism,
direct or indirect, isn't the issue. It's the end result that
matters. That makes me happier.

>> And it would be really great if you put some thought into what
>> a rational model would be for UID based controls, too.
> I have put some thought into it, but I don't see a single rational mode=
l.  It
> depends very much on the situation.

Right. You're mixing the kind of things that can generate events,
and that makes having a single policy difficult.

> In any case, that's what I was referring to when I said I might need to=
 call
> inode_permission().  But UIDs don't exist for all filesystems, for exam=
ple,
> and there are no UIDs on superblocks, mount objects or hardware events.=


If you open() or stat() a file on those filesystems the UID
used in the access control comes from somewhere. Setting a watch
on things with UIDs should use the access mode on the file,
just like any other filesystem operation.

Things like superblocks are sticker because we don't generally
think of them as objects. If you can do statfs(), you should be
able to set a watch on the filesystem metadata.

How would you specify a watch for a hardware event? If you say
you have to open /dev/mumble to sent a watch for mumbles, you're
good there, too.

> Now, I could see that you ignore UIDs on things like keys and
> hardware-triggered events, but how does this interact with things like =
mount
> watches that see directories that have UIDs?
>
> Are you advocating making it such that process B can only see events tr=
iggered
> by process A if they have the same UID, for example?

It's always seemed arbitrary to me that you can't open
your process up to get signals from other users. What about
putting mode bits on your ring buffer? By default you could
only accept your own events, but you could do a rb_chmod(0222)
and let all events through. Subject to LSM addition restrictions,
of course. That would require the cred of the process that
triggered the event or a system cred for "hardware" events.
If you don't like mode bits you could use an ACL for fine
granularity or a single "let'em all in" bit for coarse.

I'm not against access, I'm against uncontrolled access
in conflict with basic system policy.

> David

