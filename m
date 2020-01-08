Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F103C134C38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 20:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgAHT4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 14:56:04 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgAHT4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:56:03 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mxlmw-1jcQTU0aQ2-00zIlg; Wed, 08 Jan 2020 20:56:02 +0100
Received: by mail-qt1-f178.google.com with SMTP id w30so2620613qtd.12;
        Wed, 08 Jan 2020 11:56:01 -0800 (PST)
X-Gm-Message-State: APjAAAUr9p1t5xLdjB4/S5bY2JYHzKX7xwPORP5J+0dO8Ixmrm/HIQiW
        33AtIk4D4dzNSs5NnKoYQireHBkPyW9WEn1H2CM=
X-Google-Smtp-Source: APXvYqzXK0rfPwBftQB0RE1XIgRMNTUIw9qK3d59ooAvjGuihoB6fVlODosXZOAlUf75nlJAib+A4QY+RHOs+9BOv3E=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr5029098qte.204.1578513360994;
 Wed, 08 Jan 2020 11:56:00 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-1-namjae.jeon@samsung.com> <20191220062419.23516-3-namjae.jeon@samsung.com>
In-Reply-To: <20191220062419.23516-3-namjae.jeon@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 20:55:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1wcrKzhhODwoQTu=WHorkd+dQThk+G9w77QSgJ=LnR4A@mail.gmail.com>
Message-ID: <CAK8P3a1wcrKzhhODwoQTu=WHorkd+dQThk+G9w77QSgJ=LnR4A@mail.gmail.com>
Subject: Re: [PATCH v8 02/13] exfat: add super block operations
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        linkinjeon@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OpI7f7DP2Jh+tQ8zk/scRoTVj3fVoxTOYwxnefLYPhlQ6ME51lW
 jwWFn6yGu7sSanIpQ7ZeyGWPGuEFQPtpN1SuEb3VU5wwG1rAGENGnATeA1kupI+0GkszRpX
 jKP3H4gykBaDQlpBKdEZmhe8KUYVMLs6AsHiOcY9IajUoDBLfYF+5qr4h+g0i/NHA4MdrzQ
 0L+F3T/F83lrp/udgHrlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fam8oH3bCN4=:KE6Y2BgatYDMgkEeOTiUvy
 srhYE9igrfZ6MtuHhh5I7GEx5t9fwJYsDca54GJVJTm1qkuq//rUo6Jxz9gL7W/wSnYQP7Kwh
 kjiqkOxDFWDxG21i2O/P4jSIyqXvkhlppRw/zG0P1GN0J4kbiVdZAXTkHS1Oapk7yOBu44NCo
 ETd+eX1AcnOTSXwG3+aAwKqw4YHyOIvWUUt5c8/zIszQD9gbK9m4AF6oI5UDaQRkYBgKF2TmL
 Np7L7tHHk4AH7tRR1nr0D3zC//4B1js6GxI8AKnS3KsPAOxrcXP2m/PTvAVRQ/mm1QGquEQff
 wVjPylyK8PfRFJOhuccS3y9kHFLRH/EZukkJroygBrFMX6bGJgc47M3OtZ9NREG/yTCOkYRFY
 FoH0lojuEiYSAA98sSi+SfUWWYrVSI4dylHmfK2h3ba8RKDEXK8CK4RedYQvtzLkKvNhy9f7b
 o7V5PYlwoCRv1ns0GLRRNJRjcL6/hKfHtG+vrlyxmRAgkoy1utm96nXa006PrAZrBeKFYSfOb
 yENdJt14svhqG1hoKEDmzELgRgmtk0lK350xdMB+vst286V/QEOEZV253OU3TNz8Ntvb8P3D1
 M1p0X547yUXiIg3gUMKADCICb5FcXgLCpVLoy8b/95XHQP9zGGiC0dJB2QOUazBG+p/jskodG
 y+Ao2sscy7er7I7CLi+BA1DomuW+cRV+y+bUG7KauYKKVhoo/u3vuD9HRtoE0V3xdMPjLP/QL
 4ouwHMyy3gL+Cwh0BWqQBsDrJ2fR7IYZ9c0/fWmZ5s+2qu5BKkbpAFxNcVYI/dRxGHWTkvkRe
 lINU/L5elEQZJjkvG1a/xj5Gh4EAc2r1FhFImb2oNBT3JrhUotBpHfuCUy6oKQsHeGJqXPOtZ
 WqKVLVc78cNPJG+sK/Xw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 7:28 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:

> +static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +       struct exfat_sb_info *sbi = sb->s_fs_info;
> +       struct exfat_mount_options *opts = &sbi->options;
> +       struct inode *root_inode;
> +       int err;
> +
> +       if (opts->allow_utime == (unsigned short)-1)
> +               opts->allow_utime = ~opts->fs_dmask & 0022;
> +
> +       if (opts->utf8 && strcmp(opts->iocharset, exfat_iocharset_with_utf8)) {
> +               exfat_msg(sb, KERN_WARNING,
> +                       "utf8 enabled, \"iocharset=%s\" is recommended",
> +                       exfat_iocharset_with_utf8);
> +       }
> +
> +       if (opts->discard) {
> +               struct request_queue *q = bdev_get_queue(sb->s_bdev);
> +
> +               if (!blk_queue_discard(q))
> +                       exfat_msg(sb, KERN_WARNING,
> +                               "mounting with \"discard\" option, but the device does not support discard");
> +               opts->discard = 0;
> +       }
> +
> +       sb->s_flags |= SB_NODIRATIME;
> +       sb->s_magic = EXFAT_SUPER_MAGIC;
> +       sb->s_op = &exfat_sops;

I don't see you set up s_time_gran, s_time_min and s_time_max
anywhere. Please fill those to get the correct behavior. That also lets
you drop the manual truncation of the values.

       Arnd
