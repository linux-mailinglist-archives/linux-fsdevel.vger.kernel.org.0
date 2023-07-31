Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EECB76904C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjGaIeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGaIdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:33:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9416530F7
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 01:31:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-585f254c41aso26814867b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690792266; x=1691397066;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIyrJ6YTSIxuAhVNdXFr6FJPfNNKzUzYSSPmHeUyBEk=;
        b=enkMKgU1Ayx4i1zq0/7Jurq7ZnNXCX1BoIPAmM0BWTh6mP7/Z1J+YHhjU0MTdpLUM4
         aqzhqtT7GLoCcLSJV6zyI8YEnfSw3dZXTqK4MmW9JYWZXeyGj/QmZvjOZFCEMcO+WpOK
         DHaUs9pqHIbf/BgnNSMXPv5Vgdn90ALfiIjheXTiBbnqyew0L/DZtEDgd6QJnA4SHw/J
         1inOv2WWjxaCwow1osC8V2CWs7Xs4u3VYMUxTB1Z1z2SWA5sAhuzovoy9Ot4/o45U+TM
         R9xz+ABSS2V4FTJvIIy/qalnlcwiXognJOsYNtM7csQs2nGrxnKx6X4xpsoiN05diNFj
         2D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690792266; x=1691397066;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wIyrJ6YTSIxuAhVNdXFr6FJPfNNKzUzYSSPmHeUyBEk=;
        b=Bh4SH7PV1wsO1WG8TNTVo+uWfa62S0xMcQOBIZC6YlhYsgPQROwJv/uDB/FeC4uUaW
         1IhRaU4+RdbfRdZm5QCO1IykdgznPzBsHcwt5/rERWj1WilwUWDaMluRc4LtNNlazfS3
         DtE4YbcdPn9JYGOb+xe6fshLbss/HzbVGZghC9mjJKbKcDQUvh5hBZv33fTunDtzu7nY
         +iw9UJxjK4MUbuCPWYIKMyHbVHgcW5lix6ZNvY9kySXEFCdy/mnpaQVjYZCpj4NYDD+P
         1CcNLIUFXqnw7+m5zNk+rpSRTWwmJvLrpiwbm0mpy9bvBVuKJNAXUACH4fTpSUW6hT3n
         iZOQ==
X-Gm-Message-State: ABy/qLa2rC+fnAKkMSkimyWAElUsWV59m0BDBXZ1QsvD5nhZWmNDjkwN
        2NZEkuvkEpTL/ff0/zMTuRASCC8gE+8=
X-Google-Smtp-Source: APBJJlFCg+R7DYMvt31p3Yv9GzoKPkkzY61U+VGeK0geW2WgDvq6Rro0YL8uWxxHgGmNGb8hPXDfMwAtpac=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2445:b5a:365:8863])
 (user=gnoack job=sendgmr) by 2002:a05:6902:100f:b0:cf9:3564:33cc with SMTP id
 w15-20020a056902100f00b00cf9356433ccmr60052ybt.13.1690792266208; Mon, 31 Jul
 2023 01:31:06 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:31:03 +0200
In-Reply-To: <ac314809-0afc-7a1c-d758-da28b0199e7e@digikod.net>
Message-Id: <ZMdxRz64zGBM5dY/@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com> <6dfc0198-9010-7c54-2699-d3b867249850@digikod.net>
 <ZK6/CF0RS5KPOVff@google.com> <f3d46406-4cae-cd5d-fb35-cfcbd64c0690@digikod.net>
 <20230713.470acd0e890b@gnoack.org> <e7e24682-5da7-3b09-323e-a4f784f10158@digikod.net>
 <ZMI5ooJq6i/OJyxs@google.com> <ac314809-0afc-7a1c-d758-da28b0199e7e@digikod.net>
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Matt Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Fri, Jul 28, 2023 at 03:52:03PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On 27/07/2023 11:32, G=C3=BCnther Noack wrote:
> > I'm puzzled how you come to the conclusion that devices don't do such
> > checks - did you read some ioctl command implementations, or is it a
> > more underlying principle that I was not aware of so far?
>=20
> I took a look at fscrypt IOCTLs for instance, and other FS IOCTLs seems t=
o
> correctly check for FD's read/write mode according to the IOCTL behavior.
> From what I've seen, IOCTLs implemented by device drivers don't care abou=
t
> file mode.

OK - That's surprising.


> > In any case - I believe the only reason why we are discussing this is
> > to justify the DEV/NODEV split, and that one in itself is not
> > controversial to me, even when I admittedly don't fully follow your
> > reasoning.
>=20
> The main reason is than I don't want applications/users to not be allowed=
 to
> use "legitimate" IOCTL, for instance to correctly encrypt their own files=
.
> If we only have one IOCTL right, we cannot easily differentiate between t=
he
> targeted file types. However, this split might be too costly, cf. my comm=
ent
> in the below summary.

I believe that for "leaf processes" like most command line utilities, the
fscrypt use case is not a problem -- these IOCTLs are only needed for setti=
ng up
fscrypt directories and unlocking them.  Processes which merely access the =
files
in the unlocked directories can just transparently access them without usin=
g
ioctls.

The close-on-exec ioctls might be more relevant for leaf processes, but the=
se
ones are uncontroversial to permit.

For "parent processes" like shells, where the exact operations done underne=
ath
are not fully known in advance, it is more difficult to define an appropria=
te
policy using only the step (1) patch set, but I think it's a reasonable
trade-off for now.

When a policy distinguishes between /dev and other directories based on pat=
h,
that's already a good approximation for the ..._DEV and ..._NODEV access ri=
ghts
which you proposed previously.  In addition to the nodev mount flag, mknod(=
2)
requires CAP_MKNOD, so it should not be possible for an attacker to place t=
hese
where they want (at least not through the Landlocked process, as we have th=
e
NO_NEW_PRIVS flag).

Step (2) discussions though :)


> > Understood - so IIUC the scenario is that a process is not permitted
> > to read file attributes, but it'll be able to infer the device ID by
> > defining a dev_t-based Landlock rule and then observing whether ioctl
> > still works.
>=20
> Right. I think it should be possible to still check if this kind of file
> attribute would be allowed to be read by the process, when performing the
> IOCTL on it. We need to think about the implications, and if it's worth i=
t.
>=20
> It would be interesting to see if there are similar cover channels with
> other Linux interfaces.

OK, noted it down for step (2).


> > Summarizing this, I believe that the parts that we need for step (1)
> > are the following ones:
> >=20
> > (1) Identify and blanket-permit a small list of ioctl cmds which work
> >      on all file descriptors (FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC, and
> >      others?)
> >=20
> >      Compare
> >      https://lore.kernel.org/linux-security-module/6dfc0198-9010-7c54-2=
699-d3b867249850@digikod.net/
> >=20
> > (2) Split into LANDLOCK_ACCESS_FS_IOCTL into a ..._DEV and a ..._NODEV =
part.
>=20
> I'm a bit annoyed that this access rights mix action and object property =
and
> I'm worried that this might be a pain for future FS-related rule types (e=
.g.
> reusing all/most ACCESS_FS rights).
>=20
> At first glance, a cleaner way would be to add a file_type field to
> landlock_path_beneath_attr (i.e. a subset of the landlock_inode_attr) but
> that would make struct landlock_rule and landlock_layer too complex, so n=
ot
> a good approach.
>=20
> Unless someone has a better idea, let's stick to your first proposal and
> only implement LANDLOCK_ACCESS_FS_IOCTL (with the FIOCLEX-like exceptions=
).
> We should clearly explain that IOCTLs should be allowed for non-device fi=
le
> hierarchies: containing regular/data file (e.g. /home with the fscrypt us=
e
> case), pipe, socket=E2=80=A6
>=20
> I'm still trying to convince myself which approach is the best, but for n=
ow
> the simplest one wins.

OK, sounds good.  I'll go for the LANDLOCK_ACCESS_FS_IOCTL approach then.


> > (3) Point out in documentation that this IOCTL restriction scheme only
> >      applies to newly opened FDs and in particular point out the common
> >      use case where that is a TTY, and what to do in this case.
> >=20
> > If you agree, I'd go ahead and implement that as step (1) and we can
> > discuss the more advanced ideas in the context of a follow-up.

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
