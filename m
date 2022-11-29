Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D263C7E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 20:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiK2TQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 14:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiK2TP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:15:57 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98494663FA
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 11:15:56 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id o12so10165066qvn.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 11:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MqLsTlK3xOAfA5+qmy2Lb5Y9nYgdDU/J+9s5H2nNNw=;
        b=J19VO0bDj6n1Xqhkk30nCIfkFuoj7dFZu9rb/qzz9vqkPyDe2yLoOHpxIOqUqHjgYy
         f/g5cjTFIZV02D0hMoVIyZWR1iip5gKY8hO7Vnpq0o6ykuhBkojS9c74dXST54SFhu2K
         IfoD/lVZU/mDz9vfxKHiQROZ0UqQyfmPc4kliTWR42fXRm7UCrUsb1u6S1a9CfKOnuye
         HxHu5HErC6D8JKwGbhMRA8dULqSDRNUKPBS5+TOntPohBb1Vj4Co0oxnOnOaeYUFwP8B
         5nNGolh/Fh7gMgibEv98XlbVJPFvwZB7ZwAFmlikZF1YGw1G9HKVtOpQZZQs1ErbrmpM
         CKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MqLsTlK3xOAfA5+qmy2Lb5Y9nYgdDU/J+9s5H2nNNw=;
        b=ok5J7p1mxfDAuCcLyfz9zV8DaKfxzbRQmXCeMr9/zbLkeykajfv7eP7HQfyYkMSs0z
         u30+LSjzPvrUuowQQbEjDHC9kkBIdSQ5LhU1Zc3QnOHV5iRN/FGrT1txhVU6uMEB2uXs
         bAsBM/DQ4I9ykV5/WeBGWqb0Lq7XAv2+/YvBpvDpjNxOvfIH2Y4fTMK/B2p1NryrLrnP
         b57IHJxFdBIzFKUYjJA/1xAhEZah0qAOqwnGby0lKENfVPYiA1mx3xA/fdukLx40L/dO
         XVmLRNOhj1YXY9sO4ZL4zOwzb+l7Guvyj6YDiNFa555OyTYO+VEOhH640E947rK0ECox
         HKyw==
X-Gm-Message-State: ANoB5pnWSYe2LOebYetzvojAsVjKAbJyqfvTAbWrg0KYhQy6BKEBKyFn
        bJ40shb9v0run1m/J0PFUarWF1gGJf/hY/QSkQ8=
X-Google-Smtp-Source: AA0mqf7VV1ndOamGPWEMXGdQ9usxRe1Xb8874TO6xFRpkG3wgcPJoXIYJZjeXrCiYSUKpfZudksHig==
X-Received: by 2002:a0c:8045:0:b0:4ad:68f8:1183 with SMTP id 63-20020a0c8045000000b004ad68f81183mr54560110qva.49.1669749355660;
        Tue, 29 Nov 2022 11:15:55 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q11-20020a37f70b000000b006ed61f18651sm10817838qkj.16.2022.11.29.11.15.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:15:54 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfsplus: fix OOB of hfsplus_unistr in hfsplus_uni2asc()
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20221129023949.4186612-1-liushixin2@huawei.com>
Date:   Tue, 29 Nov 2022 11:15:51 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ting-Chang Hou <tchou@synology.com>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5B1AB48-05CB-4A1A-8EA2-373BA1C119EB@dubeyko.com>
References: <20221129023949.4186612-1-liushixin2@huawei.com>
To:     Liu Shixin <liushixin2@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 28, 2022, at 6:39 PM, Liu Shixin <liushixin2@huawei.com> wrote:
>=20
> syzbot found a slab-out-of-bounds Read in hfsplus_uni2asc:
>=20
> BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0x683/0x1290 =
fs/hfsplus/unicode.c:179
> Read of size 2 at addr ffff88801887a40c by task syz-executor412/3632
>=20
> CPU: 1 PID: 3632 Comm: syz-executor412 Not tainted =
6.1.0-rc6-syzkaller-00315-gfaf68e3523c2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 10/26/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>  print_address_description+0x74/0x340 mm/kasan/report.c:284
>  print_report+0x107/0x1f0 mm/kasan/report.c:395
>  kasan_report+0xcd/0x100 mm/kasan/report.c:495
>  hfsplus_uni2asc+0x683/0x1290 fs/hfsplus/unicode.c:179
>  hfsplus_readdir+0x8be/0x1230 fs/hfsplus/dir.c:207
>  iterate_dir+0x257/0x5f0
>  __do_sys_getdents64 fs/readdir.c:369 [inline]
>  __se_sys_getdents64+0x1db/0x4c0 fs/readdir.c:354
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> The length of arrags ustr->unicode is HFSPLUS_MAX_STRLEN. Limit the =
value
> of ustr->length to no more than HFSPLUS_MAX_STRLEN.
>=20
> Reported-by: syzbot+076d963e115823c4b9be@syzkaller.appspotmail.com
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> fs/hfsplus/unicode.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
> index 73342c925a4b..3df43a176acb 100644
> --- a/fs/hfsplus/unicode.c
> +++ b/fs/hfsplus/unicode.c
> @@ -133,6 +133,8 @@ int hfsplus_uni2asc(struct super_block *sb,
> 	op =3D astr;
> 	ip =3D ustr->unicode;
> 	ustrlen =3D be16_to_cpu(ustr->length);
> +	if (ustrlen > HFSPLUS_MAX_STRLEN)
> +		ustrlen =3D HFSPLUS_MAX_STRLEN;

Hmmm.. It=E2=80=99s strange. As far as I can see, we read ustr from the =
volume
because be16_to_cpu() is used. But how ustrlen can be bigger than =
HFSPLUS_MAX_STRLEN
if we read it from volume? Do we have corrupted volume? What the =
environment of
the issue?

Thanks,
Slava.

> 	len =3D *len_p;
> 	ce1 =3D NULL;
> 	compose =3D !test_bit(HFSPLUS_SB_NODECOMPOSE, =
&HFSPLUS_SB(sb)->flags);
> --=20
> 2.25.1
>=20

