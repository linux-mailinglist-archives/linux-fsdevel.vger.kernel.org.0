Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43C012EAD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 21:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgABUWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 15:22:51 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53641 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABUWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:22:50 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MvJo7-1jeFg12wev-00rEBI; Thu, 02 Jan 2020 21:22:48 +0100
Received: by mail-qt1-f174.google.com with SMTP id g1so28554104qtr.13;
        Thu, 02 Jan 2020 12:22:48 -0800 (PST)
X-Gm-Message-State: APjAAAXcuzat/FvU7gXdKMvGfoNPS9BFkBdJdfJ+1XfrxLMxCVoSsWA5
        40Y8kvtdfphEOvPyWUUwJWHCpOZLdKZKTGuqkZo=
X-Google-Smtp-Source: APXvYqw1WBWes+WH0CrFxHA8FylK6AQHYik3my7LV7FPF6NFz9oKafXjddaDiVHL3AvLnvKIAQdI30SksZ7m1AJhJMc=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr60326581qtr.142.1577996567289;
 Thu, 02 Jan 2020 12:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20200102145552.1853992-1-arnd@arndb.de>
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jan 2020 21:22:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2y71R38AyOJBXWwukZ-odjSMSL4wBumdMBsNp=So0u7A@mail.gmail.com>
Message-ID: <CAK8P3a2y71R38AyOJBXWwukZ-odjSMSL4wBumdMBsNp=So0u7A@mail.gmail.com>
Subject: Re: [GIT PULL v3 00/27] block, scsi: final compat_ioctl cleanup
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
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
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Jod/qPEhvywko/uHVmu+k/2nrH/2auin298Lqla0cYwztJPxo5C
 tLWz1QNbBuqG4709wjHgQPhajRdhnyjJXXJrpiBrVl+Jk4ADzkngavtkCIMCjN6iHkraSBs
 ZV+IvhXdxvLukbpxY61cN66ZxnhA141x8ANnPQizAb6FtEJD4dry5W+qIk1QRB1Rpe5IN0X
 37nsI95RQKc2/Vq+q3wtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IxD7BSXId+w=:WWN1G8LdJPkOr+99O/QmC5
 JcnNbFZfZzf/2ftaUZXmNHErTwB3LEorjS4FMM3IIEPFeYuWUdWR2ZoEFz1lpUpl45WkOzq+A
 iDsulEehz+MvJfKVoDE2vt7wchLJKFWAptGi4P7AKwAIFsxTt++fUEVCPURvwLREIvoLnWT8F
 uIubzCfzIz7bU17Pt0fbMkSO7jULmL2M2Aepw/S+m9Q3r+js6bEqO5OCphEVDNfU4mNlZ3DGM
 cXU8mH7JOccjHiub57p+0TrqpTk4aJEyBTwDKQOzAbcmtbWoLDTbTomznpf//L/4KsiMH3iG+
 mAX6UeC3+UAgVhNPoJN5/D0ty7cnKf5fr1wTHGvnuKYqwGUDsxx9P1+DzPrnF7FCuo0MSmH0V
 YFx2TeiyEMn6AoAR0TRKAeh32l2ESvsOFn1vZARvZlwzP+KtvgdrHTHryV/HStThTFmHxjz9v
 HGtn178fhQ0k+1UlPZ2hjwQeG0FV/4oFJxn+d/ipNTHhZXrRmX+BtT2BLAca66a6yYS6oFXub
 8Au3Uy2YicXn5j+BRYROJ+BNllEmajO6Tgz7DIFxxbpQQ9lBFsZBUZ6JHGFFtloOwy35xqnM2
 bEyFljrf0eWNA/LiBOcn+FRdwT2P2EsAX01aqtab9PDKv68Y97ktFtcW4UPUAfa4sLlUsgbdz
 q+CIGru+2SC0WCtq4gKsP/cBCBtD0MxeT1Vrh+ntZwuEaKvPU5sSrPDBApeW1P9KiXjjeW45E
 cSq9JY/C8uzVyOezQM4LQSTcjsm6GoWUIwjLF3bLnrXCVTWFrbAc/3OhDuTDmNOnuKy/2Pf1k
 6gpKe/RXiVJXj3jb2dOFku/0xbKjurbfVef5RcaweVnJP6x36AjJ/johGqTvODN1LcsAtZnlv
 jkVlaQ5tKcNFq0mm9D6g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 2, 2020 at 3:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Martin, James,
>
> If this version seems ok to everyone, please pull into
> the scsi tree.

It seems I slightly messed up the Cc list here, in case some of you are
missing patches, the full series (22 patches, not 27) is mirrored at
https://lore.kernel.org/lkml/20200102145552.1853992-1-arnd@arndb.de/T/
as well.

         Arnd
