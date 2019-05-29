Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198BE2E2F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfE2ROA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:14:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32813 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfE2RN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:13:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so2054769pfk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+4Eck+CFhCFREBdh4WIXuLZ5kettic1ax4lTFdn88wA=;
        b=RJWFuUbmbLU9gIBz85ery+5ZrcHRD50gf+QgLi0fsnsFBkSZVVTge0BZRDH214wxlM
         xR1FFryYZcnL06XkYs3karxylMDI4ZPBxg4hGX0q+kFpGJhWNTcoqbhTjFqwHfWg+0Sh
         iXq39rEwL79hjOaWNzhZg2UvhqlbHp9V5TGHA46JMpBQT/gKJOQtlUPu6V8LOlAfSTsf
         TQq70k4ixv5h06DmUpLIrTdS2Xnr//ws3EImfTsBmxGxj7guv7T9fFPcIrWPGl03Byh+
         LO4lVCRSICVNoPsP+tTwipnXTg3fYfDIrhTt5EpOw7O+6K9Vafqci5ZdOdTBtWGgCc4t
         43Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+4Eck+CFhCFREBdh4WIXuLZ5kettic1ax4lTFdn88wA=;
        b=RlEHSFh6yYSspDKqCntJl9SO2pduQ7/s05tt684EVJ7gLhxML1enONFIz34VdQyq7n
         OicmehSHhm4GyXx0i8GA9n8VeL5Srv/x7T0qwYa0RuaShcqeRcPB9LrWe+y5YLum6IZp
         T80duv+886n8xaMRwDTDKGMjyius09vKhVSOtyAMNrE+c3vIgf4g6PrXpazKgNXwQ63p
         oSNHqhqcnXUljX1SJQN82fUYucMH7RIJKU0U41A5mpehOIsamWK3hv+FjM7QsITYiGDc
         UbEnmz4GeeHYoQNNRFm0Q9M/1vm8elIWjTq+22+oYt1K/YIwgdeHfIYka27urdTgklmF
         UyLw==
X-Gm-Message-State: APjAAAUWlu23eUS7rXwEYRWEOq1PK2oUFAPUIahBmhAULzAL9JCSVN1l
        soNhEEDzQNbCoPuzB9lVG9jUAQ==
X-Google-Smtp-Source: APXvYqyqmVMGLdTKYRRZzhmdhFCtL1BSUXhR/WZs8Ia9RHc7j0jqYo6Fp8wxiPWFhDb0CF4Dl70TNw==
X-Received: by 2002:a62:ab10:: with SMTP id p16mr117966777pff.222.1559150037283;
        Wed, 29 May 2019 10:13:57 -0700 (PDT)
Received: from ?IPv6:2600:100f:b10c:ace6:b862:4204:5f4a:fe22? ([2600:100f:b10c:ace6:b862:4204:5f4a:fe22])
        by smtp.gmail.com with ESMTPSA id y10sm204418pfm.68.2019.05.29.10.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:13:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
Date:   Wed, 29 May 2019 10:13:54 -0700
Cc:     David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4552118F-BE9B-4905-BF0F-A53DC13D5A82@amacapital.net>
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk> <14347.1559127657@warthog.procyon.org.uk> <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
>=20
>> On 5/29/2019 4:00 AM, David Howells wrote:
>> Jann Horn <jannh@google.com> wrote:
>>=20
>>>> +void post_mount_notification(struct mount *changed,
>>>> +                            struct mount_notification *notify)
>>>> +{
>>>> +       const struct cred *cred =3D current_cred();
>>> This current_cred() looks bogus to me. Can't mount topology changes
>>> come from all sorts of places? For example, umount_mnt() from
>>> umount_tree() from dissolve_on_fput() from __fput(), which could
>>> happen pretty much anywhere depending on where the last reference gets
>>> dropped?
>> IIRC, that's what Casey argued is the right thing to do from a security P=
oV.
>> Casey?
>=20
> You need to identify the credential of the subject that triggered
> the event. If it isn't current_cred(), the cred needs to be passed
> in to post_mount_notification(), or derived by some other means.

Taking a step back, why do we care who triggered the event?  It seems to me t=
hat we should care whether the event happened and whether the *receiver* is p=
ermitted to know that.

(And receiver means whoever subscribed, presumably, not whoever called read(=
) or mmap().)

