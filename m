Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3D65AABA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jan 2023 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjAAQnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Jan 2023 11:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAQnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Jan 2023 11:43:35 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C992621;
        Sun,  1 Jan 2023 08:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672591398; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ZdIco5S82jNZcc1SWnPRd9xwdwZWsyVleYrPay2ObR9BIbNwK3tGvTKj69THN6c6AZaif6T0N8hTYwPSY2bYu93xo/BQFYSoeu9T0u5PtdF2AO+Rq+fAgxOpeR1tHAkuwF+RxNOC60Mpg9HtP1oLD/NQrIViRmJ083HGbSmVKH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1672591398; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=TEeQeO6TY4vFIEf1eZcrDvhLFzRqjIwITXNArJVWYK8=; 
        b=AChNHaZE9bbaU5N5xZO4gGMZbyn5tqD4JqMlQiEHXIEawuuyhj9tia+JxH8wpnM/OdncsLEaH/5BSQZ2fZYG3diUPxLMChDS9Os3sJLuZ6OH9kChfyR6WyktOy7bjDVJ5cJR63h2XLV+fLpMYR5/HW7p0bh2xwyaMwqMsX+dPOk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672591398;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=TEeQeO6TY4vFIEf1eZcrDvhLFzRqjIwITXNArJVWYK8=;
        b=ai6IJ/on+tf3CDg14Kv9rbf6CiaO2Lm588IUYEabXutLxkedrJKgDQFd2Y/gGnET
        HKFXJF8qmJUk2PGLvHdE8mlNYgDj+NT+PfuIQbDeVxAH8QCjE8jMWcFAo+kltd73ogc
        I8rOyGNT5hDLijqFIAVht3fqu/LtksI1yOsfTxb0=
Received: from [192.168.1.9] (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1672591395924950.1870279856462; Sun, 1 Jan 2023 22:13:15 +0530 (IST)
Date:   Sun, 1 Jan 2023 22:13:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftests <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20221211092820.85527-1-code@siddh.me>
Subject: Re: [PATCH] selftests/mount_setattr: Remove redefinition of struct
 mount_attr
Content-Language: en-US, en-GB, hi-IN
From:   Siddh Raman Pant <code@siddh.me>
Message-ID: <24a4ca6b-8e05-b45b-5cbc-1a470051f1d3@siddh.me>
In-Reply-To: <20221211092820.85527-1-code@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 11 Dec 2022 14:58:20 +0530, Siddh Raman Pant wrote:
> It is already included via sys/mount.h on line 10.
>=20
> GCC error reproducible by: make kselftest TARGETS=3D"mount_setattr"
>=20
> mount_setattr_test.c:107:8: error: redefinition of =E2=80=98struct mount_=
attr=E2=80=99
>   107 | struct mount_attr {
>       |        ^~~~~~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
>                  from mount_setattr_test.c:10:
> ../../../../usr/include/linux/mount.h:129:8: note: originally defined her=
e
>   129 | struct mount_attr {
>       |        ^~~~~~~~~~
>=20
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  tools/testing/selftests/mount_setattr/mount_setattr_test.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b=
/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index 8c5fea68ae67..582669ca38e9 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -103,13 +103,6 @@
>   #else
>     #define __NR_mount_setattr 442
>   #endif
> -
> -struct mount_attr {
> - __u64 attr_set;
> - __u64 attr_clr;
> - __u64 propagation;
> - __u64 userns_fd;
> -};
>  #endif
 >=20
>  #ifndef __NR_open_tree
> --=20
> 2.35.1

Hi,

Please review the above patch, which can be found on the link below:
https://lore.kernel.org/all/20221211092820.85527-1-code@siddh.me

This was encountered before the patch adding missing <sys/syscall.h>
was applied, which just means that I went into the code path under
#ifndef __NR_mount_setattr, and encountered the error.

Thanks,
Siddh

