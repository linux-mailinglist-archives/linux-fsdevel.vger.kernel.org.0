Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC1362F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 19:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFERrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 13:47:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44254 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFERrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:47:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so9955643pll.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ucWCwvVe2E+kF3/9x6UVXNkpj7I7/le1K1pgNhk52Wk=;
        b=cf3XUuHjKnHDuygJqjMW4Pvrkp+iI7+WKpuoF1XIiqVZ/JZIMrgy/fr1+gwTrAofLn
         CX6r2s6VgOW6isGJKyiBor2PZnfFJ9+BAp5NdIODNc7nnjGeZ09Mj7MlcmSipAQFLVfj
         efi8muYh128r8+vJ4Mr5uIb/vSIkMb9/unG5pImxhBdc5q3Ot98iiTMu30NyguBu8HUz
         KW8dYB3SXzEjR6PRAmSUsJf9kDhvzhHxAE4YYxNmrXZNHNC1S/W7DeZjazTy9MPhGthd
         PlFQOII6yqr++UZFL2of8Ou9W30d7C884SKj0l16pU68VVzNBaZ1F8hOpyOrwAx+WHOv
         5emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ucWCwvVe2E+kF3/9x6UVXNkpj7I7/le1K1pgNhk52Wk=;
        b=mSIXUpRDFJVGd3WF6bxnf1yfKnTZdGXDb05fWDG0jMxdSzZRxwoGU85XYNl+OmShFM
         JTAVFr+/jIhtwCIn+bBwPCrR9gFJR0eHAF7KFjnsL6sxBBfHpQx75qQngcLJE30PbNG8
         6y2bD5KvceEf3MBkbb7BI3EJoXNyfZ40ErPV8R14+ayiYK02AvQhJxT+5x+Tvr9t5kps
         F01VsPefqP7AkCJEquNHxAfll0SHnp+cNUkzpAEcOLyVgYXYMkBT+T/LTPkquTRsUrx0
         masqUD+aowEgaV1PZSlpumogOL+yJQDCcdAlULNJq7MfahQ/Dk7XhZAis+MDruxHBg5J
         qJ+g==
X-Gm-Message-State: APjAAAVXk68Y+rUHJWYS7HBxCt3YsSqS5sryRe/vTx2wUf3R2PeBF0q/
        dGu+petaJHvQ+4FSzFdid5Z02w==
X-Google-Smtp-Source: APXvYqxRFHeFG//ygaQoyoax8fdsP9765j7Qc7TlC5rnDGASJj9qGVe/LEieko76+EghhpHkAScuTA==
X-Received: by 2002:a17:902:ac82:: with SMTP id h2mr45718057plr.303.1559756865582;
        Wed, 05 Jun 2019 10:47:45 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:31dd:a2eb:ca:4a50? ([2601:646:c200:1ef2:31dd:a2eb:ca:4a50])
        by smtp.gmail.com with ESMTPSA id f2sm17456235pgs.83.2019.06.05.10.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:47:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <9a9406ba-eda4-e3ec-2100-9f7cf1d5c130@schaufler-ca.com>
Date:   Wed, 5 Jun 2019 10:47:43 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <15CBE0B8-2797-433B-B9D7-B059FD1B9266@amacapital.net>
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com> <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk> <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com> <20192.1559724094@warthog.procyon.org.uk> <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com> <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com> <9a9406ba-eda4-e3ec-2100-9f7cf1d5c130@schaufler-ca.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Jun 5, 2019, at 10:01 AM, Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
>=20
>> On 6/5/2019 9:04 AM, Andy Lutomirski wrote:
>>> On Wed, Jun 5, 2019 at 7:51 AM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
>>>> On 6/5/2019 1:41 AM, David Howells wrote:
>>>> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>=20
>>>>> I will try to explain the problem once again. If process A
>>>>> sends a signal (writes information) to process B the kernel
>>>>> checks that either process A has the same UID as process B
>>>>> or that process A has privilege to override that policy.
>>>>> Process B is passive in this access control decision, while
>>>>> process A is active. In the event delivery case, process A
>>>>> does something (e.g. modifies a keyring) that generates an
>>>>> event, which is then sent to process B's event buffer.
>>>> I think this might be the core sticking point here.  It looks like two
>>>> different situations:
>>>>=20
>>>> (1) A explicitly sends event to B (eg. signalling, sendmsg, etc.)
>>>>=20
>>>> (2) A implicitly and unknowingly sends event to B as a side effect of s=
ome
>>>>     other action (eg. B has a watch for the event A did).
>>>>=20
>>>> The LSM treats them as the same: that is B must have MAC authorisation t=
o send
>>>> a message to A.
>>> YES!
>>>=20
>>> Threat is about what you can do, not what you intend to do.
>>>=20
>>> And it would be really great if you put some thought into what
>>> a rational model would be for UID based controls, too.
>>>=20
>>>> But there are problems with not sending the event:
>>>>=20
>>>> (1) B's internal state is then corrupt (or, at least, unknowingly inval=
id).
>>> Then B is a badly written program.
>> Either I'm misunderstanding you or I strongly disagree.
>=20
> A program needs to be aware of the conditions under
> which it gets event, *including the possibility that
> it may not get an event that it's not allowed*. Do you
> regularly write programs that go into corrupt states
> if an open() fails? Or where read() returns less than
> the amount of data you ask for?

I do not regularly write programs that handle read() omitting data in the mi=
ddle of a TCP stream.  I also don=E2=80=99t write programs that wait for pro=
cesses to die and need to handle the case where a child is dead, waitid() ca=
n see it, but SIGCHLD wasn=E2=80=99t sent because =E2=80=9Csecurity=E2=80=9D=
.

>=20
>>  If B has
>> authority to detect a certain action, and A has authority to perform
>> that action, then refusing to notify B because B is somehow missing
>> some special authorization to be notified by A is nuts.
>=20
> You are hand-waving the notion of authority. You are assuming
> that if A can read X and B can read X that A can write B.

No, read it again please. I=E2=80=99m assuming that if A can *write* X and B=
 can read X then A can send information to B.

