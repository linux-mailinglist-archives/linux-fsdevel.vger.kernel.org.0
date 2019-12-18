Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B68124F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 18:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfLRRYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 12:24:52 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfLRRYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:24:52 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M9Ezx-1ie4xy3w9P-006OkQ; Wed, 18 Dec 2019 18:24:50 +0100
Received: by mail-qk1-f178.google.com with SMTP id x1so2188813qkl.12;
        Wed, 18 Dec 2019 09:24:49 -0800 (PST)
X-Gm-Message-State: APjAAAVXfTLNz8CslELgOfx/whf7bJynMYr+1RoXR7XgH0b/wBmABeaa
        K5S/8uy/H00fG/L6wYmbH856Lhm56mOcPG7rTOs=
X-Google-Smtp-Source: APXvYqyNJEBloZ1YqNMcwCEEBSPalbN1+SGYcbTZM7WF7GsOI/WVULRZC6cWixz2rQbuIblJbLHmDbv7N0/KEb50vz0=
X-Received: by 2002:a37:b283:: with SMTP id b125mr3790918qkf.352.1576689888424;
 Wed, 18 Dec 2019 09:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20191217221708.3730997-1-arnd@arndb.de>
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Dec 2019 18:24:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3fsDRsZh--vn4SWA-NfeeSpzueqGDvjF5jDSZ91P9+Hw@mail.gmail.com>
Message-ID: <CAK8P3a3fsDRsZh--vn4SWA-NfeeSpzueqGDvjF5jDSZ91P9+Hw@mail.gmail.com>
Subject: Re: [GIT PULL v2 00/27] block, scsi: final compat_ioctl cleanup
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2yS9E+h3iiHLMSpr5Oh8QkPIqh/ADGCowjCUJa4BCmSJZisJXDU
 9FQQIivHcX6CjxWkchwJ5jtwZ78lyJnp7HGjOWtGkQM7R6W2haa9g/EWb8BARbQxEafXQjd
 cHFBF68pN/FQPhSJ8d2u6zzngsRMJih9uhI501zg4jSLvB1Mdfd9ZiRvnuP1WjMogC0fW8n
 PCKXpGfe6dIy3kLQ+NtkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nsc1mGgJPC8=:l98U0iLtPWXLaCrol5kh8i
 5jxpqkJxR8p/2dDN9RZuOgt+RItYvjwTnYFTqwScAIbHbkjDAPuZvWZEmCQoAM2e1v495lZda
 CSrsVs8izEjV6eVvWFGcV0z3dIU49G5DrhyFonUiuiI4260okE8wXfvcgPWVeR4O58UkoPvmg
 VS9KgIz7snMm5W9F27h9nXnjLSmUHgG+UcVPsQq7uuKgDyTomltqfmfmzreN8amH8B1Xf9f1b
 CnpJj+pHKeZDwwpSALnHU6rkwmoWJGwY2zrgVvlbhwAr6ow5+RfOEMcUj0Qy8PnhnkiHiS2Q/
 xFTHkWN8u5jvNSwKSP4O2Le+pAl/LmowS6mCqRjPrXsRei4k90YEqyyZkoRXzqf1pJ5pWc4o4
 oM2mEJb1kRL+w4mscgkEVMFuFv2hsZExn/HqIfp5qHzURkBkPT6FKoNALuCOZ7k/fR5MlR8F3
 eJ6k66mnlvVQ3ZTZ7iWuA+EbVjfyt6tdaFtyoFgfrkId7L/f1HoTsx3XcUzHza5UrtfhPk54m
 ZRc77vl9b/HRWBIeNGWTP/7C4JoIBHImj9LyHk25mkWybdac2fDvPOgUBRPj3f5RaLFyhFAFX
 c7JgaZpsuuEwniRmBeUZHmQunx48BiGNf7M2XugatqoyD3gLZEWB37cuYoEMmCjHT7pUE2+Na
 g+m49nPBcGpRonpFEA/3eKtTFaD9OxRC7T4giRBioFpL/5YnmCEsf40Ev68OSo6Hzu04NGvKg
 B9iMjyQlhQBIgtKBGvYa+MnTiI8qylh5IwW4AtXAWsTtPo89C/EhTAZhzzMQK0IXhlL4IvU6S
 nTQE60gykztYji474VdaTc0t5K02c3sJazbA2bA3R8s80EGme8CqkMbhkPdFp0F8s6WL2DQhV
 qOIqjWjFptnMpgjs5BKw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
> My plan was originally to keep the SCSI and block parts separate.
> This did not work easily because of interdependencies: I cannot
> do the final SCSI cleanup in a good way without first addressing the
> CDROM ioctls, so this is one series that I hope could be merged through
> either the block or the scsi git trees, or possibly both if you can
> pull in the same branch.

I have included the branch in my y2038 branch now, it should show up
in the following linux-next snapshots, but I'm still hoping for the block
or scsi maintainers to merge the pull request into their trees for v5.6

Jens, James, Martin:

Any suggestion for how this should be merged?

        Arnd
