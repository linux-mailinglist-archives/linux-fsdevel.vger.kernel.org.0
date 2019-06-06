Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82E3810A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 00:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfFFWmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 18:42:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39546 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfFFWmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:42:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so14647plm.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KsNX6r5jKFOtQ4lc+eGRV9xmq07Fm18WJPMjS5Z5MPI=;
        b=PTRK9vmnWT/g5Zr13QQRSUiVwS2KbOUvsIl2db/P+q1I8gaxTF0N84zr8YwVEVwyxL
         1NzQ2DkAwfGv9hZcClcYfEqM1HX4/V4oVt7BdvmPoDazbYJaYLaMcEgjqlu3Uxg1/kb6
         n0eSP40bYpV5/gjNcG4y1fCKV7DSQn/yW9xDmUx9Ci2PbXiBlSy78NzILgwdl+f8NyvE
         QHEZasQgWh4BfDBUTRa2NVTPuoEkWz/LBCpTMu6QgdK6y15/L78uij70co/ARlFW4kUV
         2/KU00Eq47kw3ycEMGuxqu3uund8p1OPBUVsgPHr7HpKOu4Wc1yJ02Ts2iR7g1aSpMO4
         smRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KsNX6r5jKFOtQ4lc+eGRV9xmq07Fm18WJPMjS5Z5MPI=;
        b=INBPacT6cETevAdSB/ERiH8CWJQlp61+1akrTd1GkXZw1pDV75zICz7xSVBfVDlgCJ
         fbe2bT5ZzNVYPKEL3ACizjNTp+I7Bc+77ArC6AXU5+Nac0NhhtoCPGuw8Xlh40A539z8
         CZjiCXUDRiVLGx5xhwsmLnfO30fK20OmaZBa1BmHbPfOICABJ5rHGJ4lLTwdvDnFlr3F
         8wLauuRa7iFk8IS/9effw8bA+kEHpcEV2GwRjZqPFsoMfXKQdDMkqp5dgGUo/i7Yw6tz
         3iXmRY5XJvhtBzIiLw9uaUzGN03bmGvGsCz0KT8OZ/rToTDYgSe1rRTJuIK7uGUtJOfb
         JjJQ==
X-Gm-Message-State: APjAAAWrU9/pBb+vrxwM9TgDiTEqCLki6Tf3Yx35EfeyYDRftyJTm06x
        fGDsyDfupSsX1f6/QjCxQLymNA==
X-Google-Smtp-Source: APXvYqynrY/MWcua7DL8n0SxJjPX2N5fvHveHOTGRewZhfAbF+o8v10tdKo1UnQrl1Ben9xxExi0kg==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr33641433plo.99.1559860927859;
        Thu, 06 Jun 2019 15:42:07 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1d20:2c9f:a1b0:7165? ([2601:646:c200:1ef2:1d20:2c9f:a1b0:7165])
        by smtp.gmail.com with ESMTPSA id x66sm167031pfx.139.2019.06.06.15.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 15:42:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications [ver #3]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <30567.1559860681@warthog.procyon.org.uk>
Date:   Thu, 6 Jun 2019 15:42:06 -0700
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
Message-Id: <D2BD8FEB-5DF5-449B-AF81-83BA65E0E643@amacapital.net>
References: <AD7898AE-B92C-4DE6-B895-7116FEDB3091@amacapital.net> <CALCETrVuNRPgEzv-XY4M9m6sEsCiRHxPenN_MpcMYc1h26vVwQ@mail.gmail.com> <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov> <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <3813.1559827003@warthog.procyon.org.uk> <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov> <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com> <c82052e5-ca11-67b5-965e-8f828081f31c@tycho.nsa.gov> <07e92045-2d80-8573-4d36-643deeaff9ec@schaufler-ca.com> <23611.1559855827@warthog.procyon.org.uk> <30567.1559860681@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 6, 2019, at 3:38 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>> I mean: are there cases where some action generates a notification but do=
es
>> not otherwise have an effect visible to the users who can receive the
>> notification. It looks like the answer is probably =E2=80=9Cno=E2=80=9D, w=
hich is good.
>=20
> mount_notify().  You can get a notification that someone altered the mount=

> topology (eg. by mounting something).  A process receiving a notification
> could then use fsinfo(), say, to reread the mount topology tree, find out
> where the new mount is and wander over there to have a look - assuming the=
y
> have the permissions for pathwalk to succeed.
>=20
>=20

They can call fsinfo() anyway, or just read /proc/self/mounts. As far as I=E2=
=80=99m concerned, if you have CAP_SYS_ADMIN over a mount namespace and LSM p=
olicy lets you mount things, the of course you can get information to basica=
lly anyone who can use that mount namespace.=
