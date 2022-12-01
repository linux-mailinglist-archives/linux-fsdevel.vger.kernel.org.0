Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019A63ECF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiLAJvm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 04:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiLAJvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:51:37 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719AF8DBDA;
        Thu,  1 Dec 2022 01:51:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so1477410pjm.2;
        Thu, 01 Dec 2022 01:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrJSojTV6RrHvze89O/IlMBMa/Wl5GG63Kf9bSkTTUE=;
        b=fOopXHu4NEpn37RqMn1jStq5Gn/RKWx0+/DZ+HXdJdbS/fT3D1u3x0nWUfxcRYviYp
         Lv50JneAQoW8gwypybV9oR1LsWcMGOC/plxtnnTQCy1mTFxnglY82LdDPSzUNVgfaFdR
         NutgLUJg3pQxqSdoZB9+sTd+UM3Ro3iIFFD1SdGvxDJATNmZNivMRsx/G9iwjyZW61AM
         bZyVqOmfHmFrij3Ypi+n0CQnlk75l+nrr9+4Se2Xj+o9oYmvMLeFzS+pzSfdN/e5s6T3
         c5iizWDYanYOarl3tlk+ndB07LbTVAFg8wNPF24q8gtLS8XEirGoWg1Ru8rko+FULX0U
         U2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrJSojTV6RrHvze89O/IlMBMa/Wl5GG63Kf9bSkTTUE=;
        b=Mnnua+ZvJaPyAnE/5HBXTagYYzTtF88NzLJsVHsPYhkgcw6lmSc1meOyMJNucRhbIn
         XaUjmatQWI23m19SpL835FDVZeTYalf2l+ihPBszsKPFz29ArsbCZC8L107IiUpPh5Ly
         Y7tXC4z2/DtF/9LBYSmXv8QaWqSAktOGYH+hLm4QOVOP7NgWQwDlrMuYOlZZ5qa07ZTh
         ye9GKJQZPY0Fdxfb4mdabocHGtRLnn36qQSXpBxCT9v9F1XD7YZpOguS8agk/IiqNdpc
         yRas2TmR9fC92Q2xS03b1b3G6DVz3JSzoZzMvpAKLMeWLvvxJHkaELOZLKUaO2OMcFxG
         oyMA==
X-Gm-Message-State: ANoB5pkpJdxOtUKrJSWOB7ef4qVU+3sNWcBwhhCphNm87D35114ym/3P
        pR3l5GWnsrd5crgBmi9wA3s=
X-Google-Smtp-Source: AA0mqf5pJvpyquWJcf0MKPRDWHxvP2lDQaG60lOW1NTaRKr/Lnk3n0MX7XmbcQchM7EQsslPHIGKWw==
X-Received: by 2002:a17:902:8c8e:b0:179:f6ed:2ca8 with SMTP id t14-20020a1709028c8e00b00179f6ed2ca8mr46559844plo.14.1669888294917;
        Thu, 01 Dec 2022 01:51:34 -0800 (PST)
Received: from smtpclient.apple ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id q100-20020a17090a17ed00b002196b5a0efesm2022625pja.47.2022.12.01.01.51.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Dec 2022 01:51:34 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Feature proposal: support file content integrity verification
 based on fs-verity
From:   Gerry Liu <liuj97@gmail.com>
In-Reply-To: <CAFCauYOuVrSFmeckMi+2xteCcuuCfsuNtdMB0spo2afcGOxSeg@mail.gmail.com>
Date:   Thu, 1 Dec 2022 17:51:24 +0800
Cc:     Eric Biggers <ebiggers@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, fuse-devel@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <8242669C-B41F-4310-A244-973D9793E652@gmail.com>
References: <D3AF9D1E-12E1-434F-AEA4-5892E8BC66AB@gmail.com>
 <CAFCauYOuVrSFmeckMi+2xteCcuuCfsuNtdMB0spo2afcGOxSeg@mail.gmail.com>
To:     Victor Hsieh <victorhsieh@google.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> 2022=E5=B9=B411=E6=9C=8829=E6=97=A5 08:44=EF=BC=8CVictor Hsieh =
<victorhsieh@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Nov 17, 2022 at 9:19 PM Gmail <liuj97@gmail.com> wrote:
>>=20
>> Hello fuse-devel,
>>=20
>> The fs-verity framework provides file content integrity verification =
services for filesystems. Currently ext4/btrfs/f2fs has enabled support =
for fs-verity. Here I would like to propose implementing FUSE file =
content integrity verification based on fs-verity.
>>=20
>> Our current main use case is to support integrity verification for =
confidential containers using virtio-fs. With the new integrity =
verification feature, we can ensure that files from virtio-fs are =
trusted and fs-verity root digests are available for remote attestation. =
The integrity verification feature can also be used to support other =
FUSE based solutions.
> I'd argue FUSE isn't the right layer for supporting fs-verity
> verification.  The verification can happen in the read path of
> virtio-fs (or any FUSE-based filesystem).  In fact, Android is already
> doing this in "authfs" fully in userspace.
Hi Victor,
Thanks for your comments:)

There=E2=80=99s a trust boundary problem here. There are two possible =
ways to verify data integrity:
1) verify data integrity in fuse kernel driver
2) verify data integrity in fuse server.

For hardware TEE(Trusted Execution Environment) based confidential =
vm/container with virtio-fs, the fuse server running on the host side is =
outside of trust domain, and the fuse driver is inside of trust domain. =
It is therefore recommended to verify data integrity in the fuse driver. =
The same situation may exist for fuse device based fuse server. The =
application trusts kernel but doesn=E2=80=99t trust the fuse server.

Thanks,
Gerry =20

>=20
> Although FUSE lacks the support of "unrestricted" ioctl, which makes
> it impossible for the filesystem to receive the fs-verity ioctls.
> Same to statx.  I think that's where we'd need a change in FUSE
> protocol.
>=20
>>=20
>> Fs-verity supports generating and verifying file content hash values. =
For the sake of simplicity, we may only support hash value verification =
of file content in the first stage, and enable support for hash value =
generation in the later stage.
>>=20
>> The following FUSE protocol changes are therefore proposed to support =
fs-verity:
>> 1) add flag =E2=80=9CFUSE_FS_VERITY=E2=80=9D to negotiate fs-verity =
support
>> 2) add flag =E2=80=9CFUSE_ATTR_FSVERITY=E2=80=9D for fuse servers to =
mark that inodes have associated fs-verity meta data.
>> 3) add op =E2=80=9CFUSE_FSVERITY=E2=80=9D to get/set fs-verity =
descriptor and hash values.
>=20
>>=20
>> The FUSE protocol does not specify how fuse servers store fs-verity =
metadata. The fuse server can store fs-verity metadata in its own ways.
>>=20
>> I did a quick prototype and the changes seems moderate, about 250 =
lines of code changes.
>>=20
>> Would love to hear about your feedback:)
>>=20
>> Thanks,
>> Gerry
>>=20

