Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65350155C98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBGRGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:06:49 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:51093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgBGRGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:06:48 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7ayR-1is7HH3r9p-007ym1; Fri, 07 Feb 2020 18:06:47 +0100
Received: by mail-lj1-f173.google.com with SMTP id y6so93648lji.0;
        Fri, 07 Feb 2020 09:06:46 -0800 (PST)
X-Gm-Message-State: APjAAAUJHNPXCh/xK8YFHLoStO0M8ozKP/4l15jS3+ofrisLfvHUxlQn
        iAOqtj8EusCpznG9RAxb7yFTLwI9MAu2e89RTqM=
X-Google-Smtp-Source: APXvYqyFrxs4D067Cq+LTtKdfrn+W0Vf9eBI5h4pPAoPLWMwWdS7Kqx2r3OvJt5B7b7BK2Cuvpcqo/wFc3iKjBsrS34=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr138394ljd.164.1581095206323;
 Fri, 07 Feb 2020 09:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20191217221708.3730997-21-arnd@arndb.de> <20200207072210.10134-1-youling257@gmail.com>
In-Reply-To: <20200207072210.10134-1-youling257@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 7 Feb 2020 17:06:34 +0000
X-Gmail-Original-Message-ID: <CAK8P3a2n6qttV0hhMHjb7XngA6-Aj4Q9Q_6LdK7LgyoYSvQJSw@mail.gmail.com>
Message-ID: <CAK8P3a2n6qttV0hhMHjb7XngA6-Aj4Q9Q_6LdK7LgyoYSvQJSw@mail.gmail.com>
Subject: Re: [PATCH v2 20/27] compat_ioctl: simplify the implementation
To:     youling257 <youling257@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fdtLroLKRF3z9lpaDoAat+saKdez6k1gz9YQ/JdPIcbHjwBh2SR
 cRQdIW8DVR79qmzqUQuhgKbx+WdYHxoQ0do7i5hr1fVa6EJKg5pC6cROq9wYyK9qhzoLcgM
 Jqafa17Fe8mwhjeEUUMPq4eC9N+kw6Vs78frR2Xohi8lDaDziOETYvOrzT20OYYC+p1K9mw
 B2R69JBXeNbHjhZ6gD94Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ly7G1KQZ0uo=:fERR7UDTKiJeYRbOJJZXwJ
 mKHoYCmN3zdJ+sAOvBYptoQLTQ+oWDBVkJZyHI9LzcBuaRpEuLfs3Zp2V6ao2plD+q1TG1XDq
 Xb/Kb4xSHeH76ydf6aoLsX3cJjFtUP33xdYVxO8Y/nb/SLZTfIHL4ZsxWMAjDRyXG11s/MrLY
 H+hMQfE1zvrQtS0daFK0FtVXaYcIBKyzg/mNcyx+JAwfPL56NmG87tgd2rucwMn25h4aqmcdk
 vkSnMOdjxLE09hNEYb4ldkruUHySCkTOYrDcCaQv51KxO/JT7e76RthjVdrSRsAToK/im3lGZ
 SgBshuowGaZhBjVoTvxOjjRpdjEZREyKOjdsyz/mAN2vatU84hm47XjiSzZGHncelAXSm8yna
 QmqaoZoiEM/xS1T8VPiYORLbDkFyhPGdJefplJQsYYzgGElNeXWAjYq1mtl6BJBYvfVNu6Y+y
 AfOaDuohFym2X6kdekvWRF+Mb8tc3DIZawhs3XSwDHuxB9zWWybsdT6EylCPC8qq1t1Jsvx2D
 sdm25mQ3KV2Eh94d2mYN292LRd4Xl+AaPRrXLXy7iqeFoaSdfeD2dbOqbSUQx7NPff+R4L0MU
 YxzKOo26cCY0wfSnBr0HNQoIBJLHx6490ZUJ+lljfNHDbgGKB5oJgy6Ks5kxdePUHG77+s5vj
 p7vXXS5Gvg6hBpdaNL2TLLL5FBDeXP9ewEXecRIjTvnrx89zGkBupNACJuaTAq2jvX+UYiyT1
 FSsrkkExVn047OxAf7yGbgJHoCVETBYmtJ2vRoIKW3MB3juc98dJMslUAAx0Cyhla5i1JXwY2
 mhs3w49LwyDWx0dGExupZgph8hBMmhjdsu+F4JHqp5IzM1j3v4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 7, 2020 at 8:22 AM youling257 <youling257@gmail.com> wrote:
>
> This patch cause a problem on 64bit kernel 32bit userspace.
> My 32bit Androidx86 userspace run on 64bit mainline kernel, this patch caused some app not detect root permission.

Thanks for you work in bisecting the issue to my patch, sorry to have
caused you trouble. After Christian Zigotzky
also reported a problem in this file, I have been able to find a
specific bug and just submitted a patch for it.

Please have a look if that fix addresses your problem, as it's
possible that there was more than one bug introduced
by the original patch.

       Arnd
