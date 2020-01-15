Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F813BCE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 10:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgAOJ4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 04:56:21 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:57443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgAOJ4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:56:21 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MC0HF-1ixQ342HWv-00CRwE; Wed, 15 Jan 2020 10:56:19 +0100
Received: by mail-qv1-f46.google.com with SMTP id y8so7071620qvk.6;
        Wed, 15 Jan 2020 01:56:19 -0800 (PST)
X-Gm-Message-State: APjAAAXpzGtW47WTGsCBCrUdEexzOZE5EZO3Knf58Yx2wt35mio/E9Oe
        Dr5WGwzMavMite6+nTQhTMvcwpIkoL1PTDHk16A=
X-Google-Smtp-Source: APXvYqwR/A2rmomxhmxWks30Xg5wVuEywHYP7SdzwD+g4m36c8guVmzB2RyLAR07jVZacI+LFPENXm2FvIcAxBfepZU=
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr21091474qvg.197.1579082178394;
 Wed, 15 Jan 2020 01:56:18 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200115082821epcas1p4d76d8668dfac70ae3e3889d4ccb6c3ee@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-6-namjae.jeon@samsung.com>
In-Reply-To: <20200115082447.19520-6-namjae.jeon@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 10:56:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Hp4CiMQE8NrZt5vKrSn=-mYEbOXTC+Eqp35=pSocz+A@mail.gmail.com>
Message-ID: <CAK8P3a0Hp4CiMQE8NrZt5vKrSn=-mYEbOXTC+Eqp35=pSocz+A@mail.gmail.com>
Subject: Re: [PATCH v10 05/14] exfat: add file operations
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        linkinjeon@gmail.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xf7OWvxLyO5dkv9UTAUdswA1svDNZpiN9KtYlnOxJffY31aOJDG
 nEHQrs1pvYo9MuF5GZIOeAIuQ+OGhpZWH+KG799/uh1/hutFDZ22RETd3ZWyFjEaurxuIU5
 Qq2AnpzdTuCpzW4EoC7yflLYYxITzp55uvsXf2OQJq07QqG/FIButW8zCZtsdDe42NfdpFa
 4QpOM5fr3OzlhLWEjomIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RbamRkxCeF0=:nyoJl9JmUQttD+Y1SGP/Wj
 mAZ+F+zqYYS5uRyPpQBGztLht3oT3PfsiLkreOM8PutdDmdoNWUyXXxtNK5hD7Fr+jDHLBkcP
 KFdCG7oLeqxf+AnMGKxYNZ0/6FAL0kB965nB6dLSbe0c2YAol8Vw9EYo/8dueGJB4cc0rxNP7
 xAYwsJoZduexyGhC98lz82u+AE5HNiLdxSGX1ItO5JFazKFh8zctKhPHsANLYgGT9jA7l27A3
 zbaQ4iKHgfhZnMVLq3YgRCwYTwTEjhGEL37RBcIQRzhSfKSgU9tfHhk14DpvQhu2SvQUmKCGY
 MgEWhwC4iItJO4b/tYD52EqvCht3tmRbY2KVqHhO4PWDF8jhlYSJrB4CC0ml1moTi0P+EE7cP
 3Z2s4pVzZLkwhfzhUxnISzKx9CnVMUMTZ7Ucg8fZhI/iRNhixz7Fn8EeHWekMm676jbxC3S2p
 HdpLRTSh64y4NnQIeX1DZzms4D0GjK4Xh9uqAPROdwar0XRyTmJj4gsHRML7DYpvagHLo881D
 k0wVd8TQNKW7Z3Dn2oYFqMdOOQkwFl8X/S7vzustWJ8svIXEvrh/q8nowC7hFX5TxRtNKogHY
 zNsS64FgCq29EOPWJ9ZlTJS3E9yT7/u80jJILAXIJBL5nxXuVEGQIcyvZ6+YLkc08QO2Nmh0/
 qBmGqWg5ekB1KlCM68U7PMMXmY/drZClG06QsfIjYfuJcAjQM+hauqNDrU18OoofnQBKQkysv
 sa6bvVFJBj7mSQlg77DMgSeg8RH/Jj7CSNJSEfuo7k3xtbc36iPxPmDJwodCJJYkoUtSdgV89
 Ggzh3GXw3mKy2xiv390c4VUIKhQO6FhGsGC/SlGbFnJxmcDTDY4J/kL3a7Tc9npDjnJFIPRQ7
 wJXQq4ev3ILdJNfZkbng==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 9:28 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:

> +
> +               ktime_get_real_ts64(&ts);
> +               exfat_set_entry_time(sbi, &ts,
> +                               &ep->dentry.file.modify_time,
> +                               &ep->dentry.file.modify_date,
> +                               &ep->dentry.file.modify_tz);

I think this part should use current_time() instead of ktime_get_real_ts64()
so it gets truncated to the correct resolution and range.

Please also check if there are other callers of ktime_get_real_ts64() that
may need the same change.

      Arnd
