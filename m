Return-Path: <linux-fsdevel+bounces-5139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B58085A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 11:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA82B20BF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB337D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:35:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF881721;
	Thu,  7 Dec 2023 01:32:06 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5d400779f16so3520057b3.0;
        Thu, 07 Dec 2023 01:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701941525; x=1702546325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HITPOZ98TcxoeIJZrNjSo/OvrhbnTbF7gIrbNDfuq4=;
        b=GNfHWzC2mWUudtXiY+2FAqYeRIi00vGYJcUKtW9CoOqnQojs1UZ4daVnY+xmX2VTif
         6BbT568w/QtqjkHenDuj5RMEoaGF4W79nxCYQKGRQwLoD1cnLCwk7uUAV2raR4XiOZ3P
         2W1ezFSyb+EiXsJflpMexpTFUHHV+H7PXW04l1hGc49yCpTdpYm01ouhGLfMzXqrUVpf
         BoajSM5YZPMfQU4MyAld24uv3bUIon6ntXeEShWr6XzxpbW+b05WpBbi+yg5kJ7SuZmw
         ezG9y5iCdUka1o7nQlgTvxYRaN0UDhhCM0INdD1oOhmxOgJWO5IM0i7eprhz6RK5VTMh
         QYFQ==
X-Gm-Message-State: AOJu0YzS6mfM86mtrHfy360/oPOvFY2K8dPcNXxb8QjDILMRd6YgUoXC
	6qTRzWMu3C83ck2AY3VPxpbEbztB0o4j3o4K
X-Google-Smtp-Source: AGHT+IHUxkxGdq8C5WBHMuoj9KomT4pansS+cp/BBfvTVIKBqwDbdPfjsvriHOFPykzXf8ZVWIgmgQ==
X-Received: by 2002:a81:af43:0:b0:5d7:1940:3ef4 with SMTP id x3-20020a81af43000000b005d719403ef4mr1429648ywj.37.1701941525404;
        Thu, 07 Dec 2023 01:32:05 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id b62-20020a0dd941000000b005d6c21adea5sm273318ywe.40.2023.12.07.01.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 01:32:04 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d400779f16so3519897b3.0;
        Thu, 07 Dec 2023 01:32:04 -0800 (PST)
X-Received: by 2002:a81:84c3:0:b0:5d6:bc5c:9770 with SMTP id
 u186-20020a8184c3000000b005d6bc5c9770mr3593778ywf.4.1701941524678; Thu, 07
 Dec 2023 01:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com> <61494224-68a8-431b-ba76-46b4812c241c@paragon-software.com>
In-Reply-To: <61494224-68a8-431b-ba76-46b4812c241c@paragon-software.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Dec 2023 10:31:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVu1xAHDo1UUsCKEX=pbiZWab0HwkO6hObwE6uB2yD4RQ@mail.gmail.com>
Message-ID: <CAMuHMdVu1xAHDo1UUsCKEX=pbiZWab0HwkO6hObwE6uB2yD4RQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] fs/ntfs3: Fix detected field-spanning write (size
 8) of single field "le->name"
To: Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Konstantin,

On Wed, Dec 6, 2023 at 4:12=E2=80=AFPM Konstantin Komarovc
<almaz.alexandrovich@paragon-software.com> wrote:
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.c=
om>

Thanks for your patch, which is now commit d155617006ebc172 ("fs/ntfs3:
Fix detected field-spanning write (size 8) of single field "le->name"")
in next-20231207.

> --- a/fs/ntfs3/ntfs.h
> +++ b/fs/ntfs3/ntfs.h
> @@ -523,7 +523,7 @@ struct ATTR_LIST_ENTRY {
>       __le64 vcn;        // 0x08: Starting VCN of this attribute.
>       struct MFT_REF ref;    // 0x10: MFT record number with attribute.
>       __le16 id;        // 0x18: struct ATTRIB ID.
> -    __le16 name[3];        // 0x1A: Just to align. To get real name can
> use bNameOffset.
> +    __le16 name[];        // 0x1A: Just to align. To get real name can
> use name_off.

noreply@ellerman.id.au reports for all m68k configs[1]:

include/linux/build_bug.h:78:41: error: static assertion failed:
"sizeof(struct ATTR_LIST_ENTRY) =3D=3D 0x20"

>
>   }; // sizeof(0x20)

Indeed, we now have a hole of 4 bytes at the end of the structure,
which shrinks the size of the structure on all architectures where
alignof(u64) < sizeof(u64).

So either the patch should be reverted, or explicit padding should
be added.  Your patch description is not very descriptive, so I
don't know which is the correct solution.

[1] http://kisskb.ellerman.id.au/kisskb/head/8e00ce02066e8f6f1ad5eab49a2ede=
7bf7a5ef64

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

