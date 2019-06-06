Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4F38006
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 23:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfFFVyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 17:54:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37804 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbfFFVya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:54:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so2319279pff.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nRTOxuA/Gwk436wjdRLZFFI2IWjHeK4nxXXVH9+gvJE=;
        b=EGncbImdzKfDyyHC/wGTZ/hfrEnzQxuTOp2J1Y0gY1VpXSC9Md3ikeKaFw/Z3B22v7
         0DNodTI71qmiSKyhcOcGu+kQr8Xu0pMtEttTsx96lJ6bMriq7jNWzBs9Y+FEnRfLOpYZ
         qz8wRnKzKQ/VpDiQMqXU5ddM+QmOqL0WbO7UAMFLeVZf/ZN5YPfFzeJx1xGjcCAya2fh
         dZWvMCYQhQ+zwgrcrrAc3oohAIXvEeBEVJRMsTPMM3Mg8+24b3tPfpaFLAnoONbYwo3M
         bJ862/yfW4n5Z66MhmTBXgNY7GFN7zknPozfRMiFJXfEWmnKk6ZewdvLUz9dDYBeAWlR
         IGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nRTOxuA/Gwk436wjdRLZFFI2IWjHeK4nxXXVH9+gvJE=;
        b=cGJ4SCk0qQg0CYlxVz9m3shiWmD8c8K4BczsNCXm41GYyiWvlcDTK7Tdg3evbkTlqU
         Mw59JY0wFa3iZzXG4mtiB62Nl55h1Tf/Rf3uEo7WbET6QnIZfuYRLwT3CwhfASe+k9E5
         tvEL+G/su544FxrGLgYf5D7nrWXmp0HIDREFnICdmtLUNSAWK8re9utu1pTE0X5UP3gO
         2BZukELxPKS5ik4+ZL8D48q8Lvxzhdqf2JeLvTWNVRYxIvalfn9L+auUhOvb5chGJr37
         qDb5D+UPridgGjbmglibX9HuZLylYGQrxm7K9mpvGRIfqw74kRAIKk4wUdowTBmmC4lf
         vxlg==
X-Gm-Message-State: APjAAAX06Oy1rNdO4e+cy9Lq4U4grqeoDQWHu0NacEXa/kJ5Uq8MIGGy
        M02BLIq/lJwje6wODzVp9OXr4w==
X-Google-Smtp-Source: APXvYqxFQa7/xE+mo3PRdCgIrbB81YZuPBHMMdpvWLdYui3Pw7zIn8HCIDPOffgGuFZp2pZ6jeQSxw==
X-Received: by 2002:a62:1483:: with SMTP id 125mr55452892pfu.137.1559858070049;
        Thu, 06 Jun 2019 14:54:30 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:f1c4:94fc:993:1923? ([2601:646:c200:1ef2:f1c4:94fc:993:1923])
        by smtp.gmail.com with ESMTPSA id h62sm126764pgc.77.2019.06.06.14.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 14:54:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications [ver #3]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <23611.1559855827@warthog.procyon.org.uk>
Date:   Thu, 6 Jun 2019 14:54:27 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD7898AE-B92C-4DE6-B895-7116FEDB3091@amacapital.net>
References: <CALCETrVuNRPgEzv-XY4M9m6sEsCiRHxPenN_MpcMYc1h26vVwQ@mail.gmail.com> <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov> <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <3813.1559827003@warthog.procyon.org.uk> <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov> <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com> <c82052e5-ca11-67b5-965e-8f828081f31c@tycho.nsa.gov> <07e92045-2d80-8573-4d36-643deeaff9ec@schaufler-ca.com> <23611.1559855827@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 6, 2019, at 2:17 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Andy Lutomirski <luto@kernel.org> wrote:
>=20
>>>> You are allowing arbitrary information flow between T and W above.  Who=

>>>> cares about notifications?
>>>=20
>>> I do. If Watched object is /dev/null no data flow is possible.
>>> There are many objects on a modern Linux system for which this
>>> is true. Even if it's "just a file" the existence of one path
>>> for data to flow does not justify ignoring the rules for other
>>> data paths.
>>=20
>> Aha!
>>=20
>> Even ignoring security, writes to things like /dev/null should
>> probably not trigger notifications to people who are watching
>> /dev/null.  (There are probably lots of things like this: /dev/zero,
>> /dev/urandom, etc.)
>=20
> Even writes to /dev/null might generate access notifications; leastways,
> vfs_read() will call fsnotify_access() afterwards on success.

Hmm. I can see this being an issue, but I guess not with your patch set.

>=20
> Whether or not you can set marks on open device files is another matter.
>=20
>> David, are there any notification types that have this issue in your
>> patchset?  If so, is there a straightforward way to fix it?
>=20
> I'm not sure what issue you're referring to specifically.  Do you mean whe=
ther
> writes to device files generate notifications?

I mean: are there cases where some action generates a notification but does n=
ot otherwise have an effect visible to the users who can receive the notific=
ation. It looks like the answer is probably =E2=80=9Cno=E2=80=9D, which is g=
ood.

Casey, is this good enough for you, or is there still an issue?=
