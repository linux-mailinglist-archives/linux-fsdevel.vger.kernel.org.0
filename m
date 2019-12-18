Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4231251DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 20:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLRT2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 14:28:40 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:47279 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLRT2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:28:40 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MTRIg-1iG2tF3jeW-00Ti9k; Wed, 18 Dec 2019 20:28:38 +0100
Received: by mail-qk1-f171.google.com with SMTP id z76so2927960qka.2;
        Wed, 18 Dec 2019 11:28:37 -0800 (PST)
X-Gm-Message-State: APjAAAVfjcA7mI13fASLcHDnctNIKUVBX9pBPJlJVZFDZiM8uRVlsMBh
        L+kOOq9Cnib0lO0pErZuFEI8NN8/vYuMPvB/t/Q=
X-Google-Smtp-Source: APXvYqwz+7AWjFh2K6hb1XV5mEQKNUiiATaBP2AbIqTPq+kukh7Z/1ivxqWRQftGY5n/Oyrty7jVKBXVMumZ36bF1Hc=
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr4410998qke.394.1576697316373;
 Wed, 18 Dec 2019 11:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20191217221708.3730997-1-arnd@arndb.de> <20191217221708.3730997-18-arnd@arndb.de>
 <22903f0af805452bfabf9c0b476a1b67646e544c.camel@codethink.co.uk>
In-Reply-To: <22903f0af805452bfabf9c0b476a1b67646e544c.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Dec 2019 20:28:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3QGa-U_-G6n1A=aFpci5GHksP_t+x8yLLAjOtB2WcqYA@mail.gmail.com>
Message-ID: <CAK8P3a3QGa-U_-G6n1A=aFpci5GHksP_t+x8yLLAjOtB2WcqYA@mail.gmail.com>
Subject: Re: [PATCH v2 17/27] compat_ioctl: ide: floppy: add handler
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bws3PSOvf3g5yZkCroDyZoyvmQiUgaMMGhPbGb8PrQ/F11oCNy3
 slGIeureTHmPT+6BvWj0xdmJObzSSvZcEN+VntuQzQqOIGCRM2ZT/Ewlzi8r/AobXu3yM/B
 C3t9O74YW5uQ8FgSl25gMBnzScg1Z2U8FRAUUUgOtDrv/WjFI60C9CerQiSMejBkbq2+G88
 awsAM0ruloDtqZHZTtJ2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RtI4sFgW1go=:tWnTBofzrSf0Xh2O74C0v8
 ZNpsx7NETLv3opuY3O/Jh/T5GZgVXBFwCPQ/j6uYc2HeQGu3S0OLB0ZtoKCxQcMnNuqq5Mrq7
 tbmUR9nFVVRPZ8bRMdczHn8hANav34i6GtDr7FDCWlXwO9DtHEP0yX6bz18tNP8IXQ8acOjjh
 Q8PRei/EYXlFH065ZFY+RLHYxLTdRKUABhNXCxApc1vK2j20EKB7aDUB+DY70GCv5X3/C1lPC
 V2H8x29gyv1GcXcrBVl34L6HarJ+TNlxeZUPzMV5ZKv84PiF3/nxDsB4h+hyUu1Ipa8pYtbd4
 hvHAOGLUNCCqZIjQu6TnJUElYmmCJ9LvvpjBgBNZ7dGWPAscV+zzBRt9FXrgqdCeIC3EkRBfb
 UGw8IH+H3cvlWqEQcBfCmguLzpxIuniJ7H76rSWvEPtwm1buNLjESWGGtCT5eTvAmzXm9qOD+
 nsOJhx6YLKpQ9nA1F2T4jNJUCJwKvhNZ4++COgmSYl5q37xEFYqv0/ZLyHACXBj/w44VyoazE
 BjOnISQuR4VvSCL1W4EN2oXa8ZugIsVdrGnCRoqbmHzKKsxDEDVYI8VjQdjjdqowfgjszzGlN
 i5o3gtCzMSRegt8TgVTxnfFEOt8BQZh+KsfMcSSZ78Y/Xj43gPTM+IcrobQIQUP0CZeJL86a3
 Kz4txIHFPHSYKlVOwQaUy3z7qwR30nNR7wOD1QuPYbUTOfpXLC9RLcp4G2BeJSeQSIWqUWxWP
 cUPLQg/u+sCBGdeQMBTlfuB+fDJ1XmBHST21OypwE87u2SymL+2fcm/1N4x4Kgld7DGI1V9uY
 u5ENcw6iUWK1jSuisuKT60vrie0QnCxHXoIlKByhnJ8I4sHrOcvSLNQTXW+FUb5aQzm4X6FkO
 0/oi8aAsmpctiQMiYUxg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 7:45 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Tue, 2019-12-17 at 23:16 +0100, Arnd Bergmann wrote:
> > Rather than relying on fs/compat_ioctl.c, this adds support
> > for a compat_ioctl() callback in the ide-floppy driver directly,
> > which lets it translate the scsi commands.
> [...]
>
> After this, and before "compat_ioctl: move HDIO ioctl handling into
> drivers/ide", compat ioctls on an IDE hard drive will result in a null
> pointer dereference in ide_gd_compat_ioctl().  Not sure how much that
> really matters though.

I'm sure it makes no difference in the end, but you are of course right that
this is a bug. I've folded in a check now, and leaving that in place
even after it is no longer needed:

--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -348,6 +348,9 @@ static int ide_gd_compat_ioctl(struct block_device
*bdev, fmode_t mode,
        struct ide_disk_obj *idkp = ide_drv_g(bdev->bd_disk, ide_disk_obj);
        ide_drive_t *drive = idkp->drive;

+       if (!drive->disk_ops->compat_ioctl)
+               return -ENOIOCTLCMD;
+
        return drive->disk_ops->compat_ioctl(drive, bdev, mode, cmd, arg);
 }
 #endif

I pushed out an updated signed tag with this change.

Thanks for the continued careful review!

       Arnd
