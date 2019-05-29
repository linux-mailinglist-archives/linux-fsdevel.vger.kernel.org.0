Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A302E8E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 01:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2XMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 19:12:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39921 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2XMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 19:12:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so781237pgc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hXo8tqJj43axubOUsA5cbLHV2YxMMkvWWZc8Ao43XSA=;
        b=Z1Hek7XJ1MZIIz+UBdT1hkUxpFkEtBxkX7b8Pl+AuvfBm/IPaoj+3yYDDhyFmBSr8t
         ZyngPhfKqhFeH8KtT9ihHyAGNF0mVOBohNPK6oiiKdkcllg+SB3DTem+ke3Tbp9d3ZhF
         jLYDOq40vl7XlC62+xYv7E0fb/m9J/uc0J22pFtLOiIUiRR1GTcIKwHD6Zf9Bm+KXWj3
         D4JplobPLr3d5LtYSaPsuWNjGuQhf5Fp7Thu6PUnWwGHCrlwzqJr0B7H1KLyYj4weXKF
         yRBFSSsk5f2vEFSCoP3KI86yzvNF3YZLbLW3Tmtep1Czd7T6a6w0/iH7jguogVigeucG
         bPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hXo8tqJj43axubOUsA5cbLHV2YxMMkvWWZc8Ao43XSA=;
        b=XvaiOuSrgVfQOaZNKhrtj35HwpnWNBcQS1/54VoDUW9nUFNNgpqeMUk2mwOIf1xrCk
         Z6AHUzQRbuc3XbuQHZ0C6MrBpebNEs6VDu8ca4Fw/hDWlOyCdKRmAcTBY/60Mqlq1qWp
         +V9om65rDElBYSfiHsEJdO1bjYCfxRSTVgUFTfFgFoXXmfJZ1ZijI0MkaLpem9UHChat
         Ngbti5j3PDHXoEOKKoAQPw9PmaW7s/Tgfdz8yY2Se9mOAbbNi3tkEyOUgEaCYn4DNDlz
         M7pfZQLV/djXGOFbLLEUG8RSGqW0I9k3n12ZRqhglXDnusOpKi7KflVlS/aqtv65Vsse
         Yq6w==
X-Gm-Message-State: APjAAAUFw6lAn1C1Nn98xDWYYbNZyWOXMpHlbcoP2Cl0o+x8XezUhDMd
        zRuyMcTQFk894J8H09GvIf604w==
X-Google-Smtp-Source: APXvYqzSbiZOcqIEBdHHVXH9gx83KIlHBGDGOZAgGMpsekS+eED+muYtsmS9Z1I4BxDAKp+PBWv5SA==
X-Received: by 2002:a17:90a:bc42:: with SMTP id t2mr186703pjv.107.1559171521905;
        Wed, 29 May 2019 16:12:01 -0700 (PDT)
Received: from ?IPv6:2600:100f:b107:bb64:69d6:593c:1bea:7300? ([2600:100f:b107:bb64:69d6:593c:1bea:7300])
        by smtp.gmail.com with ESMTPSA id q20sm391919pgq.66.2019.05.29.16.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 16:12:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <058f227c-71ab-a6f4-00bf-b8782b3b2956@schaufler-ca.com>
Date:   Wed, 29 May 2019 16:12:00 -0700
Cc:     David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FF92095-E5B1-4811-A7F8-B7D4C32F86DD@amacapital.net>
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk> <14347.1559127657@warthog.procyon.org.uk> <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com> <4552118F-BE9B-4905-BF0F-A53DC13D5A82@amacapital.net> <058f227c-71ab-a6f4-00bf-b8782b3b2956@schaufler-ca.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 29, 2019, at 10:46 AM, Casey Schaufler <casey@schaufler-ca.com> wro=
te:
>=20
>> On 5/29/2019 10:13 AM, Andy Lutomirski wrote:
>>=20
>>>> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.com> w=
rote:
>>>>=20
>>>> On 5/29/2019 4:00 AM, David Howells wrote:
>>>> Jann Horn <jannh@google.com> wrote:
>>>>=20
>>>>>> +void post_mount_notification(struct mount *changed,
>>>>>> +                            struct mount_notification *notify)
>>>>>> +{
>>>>>> +       const struct cred *cred =3D current_cred();
>>>>> This current_cred() looks bogus to me. Can't mount topology changes
>>>>> come from all sorts of places? For example, umount_mnt() from
>>>>> umount_tree() from dissolve_on_fput() from __fput(), which could
>>>>> happen pretty much anywhere depending on where the last reference gets=

>>>>> dropped?
>>>> IIRC, that's what Casey argued is the right thing to do from a security=
 PoV.
>>>> Casey?
>>> You need to identify the credential of the subject that triggered
>>> the event. If it isn't current_cred(), the cred needs to be passed
>>> in to post_mount_notification(), or derived by some other means.
>> Taking a step back, why do we care who triggered the event?  It seems to m=
e that we should care whether the event happened and whether the *receiver* i=
s permitted to know that.
>=20
> There are two filesystems, "dot" and "dash". I am not allowed
> to communicate with Fred on the system, and all precautions have
> been taken to ensure I cannot. Fred asks for notifications on
> all mount activity. I perform actions that result in notifications
> on "dot" and "dash". Fred receives notifications and interprets
> them using Morse code. This is not OK. If Wilma, who *is* allowed
> to communicate with Fred, does the same actions, he should be
> allowed to get the messages via Morse.

Under this scenario, Fred should not be allowed to enable these watches. If y=
ou give yourself and Fred unconstrained access to the same FS, then can comm=
unicate.

>=20
> Other security modelers may disagree. The models they produce
> are going to be *very* complicated and will introduce agents and
> intermediate objects to justify Fred's reception of an event as
> a read operation.

I disagree. They=E2=80=99ll model the watch as something to prevent if they w=
ant to restrict communication.

>=20
>> (And receiver means whoever subscribed, presumably, not whoever called re=
ad() or mmap().)
>=20
> The receiver is the process that gets the event. There may
> be more than one receiver, and the receivers may have different
> credentials. Each needs to be checked separately.

I think it=E2=80=99s a bit crazy to have the same event queue with two reade=
rs who read different things.

