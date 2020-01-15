Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADCD13BD56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 11:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgAOKZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 05:25:42 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:38643 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgAOKZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:25:42 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Msqty-1jg3X12u40-00t9dl; Wed, 15 Jan 2020 11:25:39 +0100
Received: by mail-qt1-f173.google.com with SMTP id i13so15299053qtr.3;
        Wed, 15 Jan 2020 02:25:39 -0800 (PST)
X-Gm-Message-State: APjAAAUMoawuhGAUQ9MTz8INzejSe+qde0QOIWMaz/uZdZXOV9pghxpe
        j5FLZZ01KtJw6XJfkEmObjiT9BzxlypNZ6vvLLM=
X-Google-Smtp-Source: APXvYqxpuhynJBn4yx21WjIw3nubH1blYL0w6bO48MGvf28mqDOMWLqUGKBHq3Rnw96u8X2M6HN66y7y478g7fpYmxs=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr2754011qtm.18.1579083938582;
 Wed, 15 Jan 2020 02:25:38 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200115082820epcas1p34ebebebaf610fd61c4e9882fca8ddbd5@epcas1p3.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-4-namjae.jeon@samsung.com>
In-Reply-To: <20200115082447.19520-4-namjae.jeon@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 11:25:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3YOsFtuDDw9=d7_EY60Xvmx4Mc=NJmsy3f3Y9L87Ub=g@mail.gmail.com>
Message-ID: <CAK8P3a3YOsFtuDDw9=d7_EY60Xvmx4Mc=NJmsy3f3Y9L87Ub=g@mail.gmail.com>
Subject: Re: [PATCH v10 03/14] exfat: add inode operations
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        linkinjeon@gmail.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qQ16a62MJXwG16nVvWgdenECLmibZogu1QKYOCn6yF7WN+F64A7
 oCfznoFSDHUQvAI2cT+b49ziPDKC7yH4BJp1fLtx4FW38znBzVNXFaTjzc3fIGp4/3T09UA
 l5UwAcMCip1wMuWMh+QvJUvw7xdJtjB2H5K+7P/QgGeWA+R+BiPXKty5zTEKrV/cqHvC8H+
 UtdHaTpbbDTlIY/U/KY2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1WCkLNSHsGA=:fD2fqRZjniq/nEdkNJ6ajr
 b6/SpojxTHCCkIcJcnotza/iA3JSeUndTVdUF5eL6uGAW7NhLGr3U7RPhglGfP6nMhkVvsJmS
 785WSlpW1EV8rcU0sxp1soJsTo0nW39KHsU3H1CiYQjc/7JNAB9MQS1duPHX/C6CU6nRTLiHU
 be2o9p/Qky1zdjqLPQrqcATBBDE+IYd1S9V/mKDMDa2x+wf7Ez4PwazBqyuD0JMdn2+WEEF/1
 aWJ2KMl7xEtVgg6tscayjMLQ9/HTdDEUDRicnEvvyyoizNN24yGvQGqO8190SB4npt0IKL/GL
 GBXiIDonJJ77eFx1OA3wtVwNALQsfGmFLbMKvJaqtduL0YQE6Xg6yOgIq4FsUtdnU8Lp8j/uG
 K2uzjxnGtNYmwoQdvoIbklwefGSNbBPA1RTFSyIy83VOsnAojOVpjbkfvy5vOhBOqfb8p97cu
 u0nxPXlwuoICXkBEdyleFDrpKZN6WSJHMcf8ZsyzwOCANPwIrnaTdAcnli6kuH/9dbva7smTC
 aZKNn0WRTRmu7z7d5sZ3iIRz7p2vBpIHDiLtbBIroLLT/hDoU/H56cSPkMrGZxI/mUkcmR8K7
 6Ahg+WjPL0crdsi9USLeIjn0jjrzRudpcBiRtNJPEpnwbefyHZyHxPZxUcQSHUIpx0h8ZS6eW
 sWsBAEqQ5vWQkKjYdY1a0kx1oe0Wgfgyd+Xmpy55z/GXzTBuk6yydxDm8lHF+NI2hx9SRnLgB
 zG/onPjPm1tXug3x26LALOl0XlQub3MaIe80RUuAzgiUxQ647sqJb628yCroj8qrwe+bYqiyn
 +f0BIAwT4kUaTXl4J1NRSWkjiKjhB9ZvWVJ2sXsV5VElVFz0PD42AL2I/F3MKfpj3672Qgc+X
 Zug/MC75cp6m73vTr2Qw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 9:28 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:

> +       /* set FILE_INFO structure using the acquired struct exfat_dentry */
> +       exfat_set_entry_time(sbi, &inode->i_ctime,
> +                       &ep->dentry.file.create_time,
> +                       &ep->dentry.file.create_date,
> +                       &ep->dentry.file.create_tz);
> +       exfat_set_entry_time(sbi, &inode->i_mtime,
> +                       &ep->dentry.file.modify_time,
> +                       &ep->dentry.file.modify_date,
> +                       &ep->dentry.file.modify_tz);
> +       exfat_set_entry_time(sbi, &inode->i_atime,
> +                       &ep->dentry.file.access_time,
> +                       &ep->dentry.file.access_date,
> +                       &ep->dentry.file.access_tz);

I wonder if i_ctime should be handled differently. With statx() we finally have
a concept of "file creation time" in "stx_btime". so it would make sense to
store dentry.file.create_time in there rather than in i_ctime.

It seems that traditionally most file systems that cannot store ctime separately
just set i_ctime and i_mtime both to what is is modify_time here, though
fat and hpfs use i_ctime to refer to creation time.

      Arnd
