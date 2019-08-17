Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EAF913B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 01:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfHQXjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 19:39:01 -0400
Received: from sonic313-20.consmr.mail.gq1.yahoo.com ([98.137.65.83]:44202
        "EHLO sonic313-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbfHQXjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 19:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566085139; bh=dNZpHSLd1MuwxobwDIzjjPQQ+9FM8pPg85T+oHS7F4A=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=XxQf3c6Gcb0YtoB6iBaRiEGqCsT1ErD/JcSy8yQ+BJzKBsJY8k2cmd5RM3O6Ub0iVknNit104Fuo+fjkVmZbTAT9K0wMxPRrkEdwzG7KTifBNUQJPUNHkI5jyq2QPEaGVD/TaLnU7nqkyJn3K0kSHrxf6qtBcRGWxQnMlSEfO+2E76YPPEc24m2obNVz3REgQpPPemneAsmkz0Vejk05g01wd2GIYtFw1gMJND05xonjhhP3qZf/Q4OMecawaecvmSNyjGNieH3FRmqomInkiwHZeEmWx+aIe6dvYsQSsOf/PRmOSnBCzMY71RpV/zGzIGe4az6/imIVlesqlmpr5w==
X-YMail-OSG: Ep10XbEVM1kSG8sbeMSNao_0J_WWVtTwLsv5LkLVVRiUhy89YECRw79g_4ImXJI
 3hCZGvhWrl6eMjwWlXAbuYdMSnngJ6XORVtk2a9ORU7FjvIubJ2uEHLBGl80XnLR1lNWUgNU.l.y
 Mrg6KcPk0YrgWiw2nNrnSdkOcjwb3k.PDoeYfhahDLYlsDXlM097Tx1p.kWQV0bZsabdHovIzTDa
 g16UBb5M6ltAS47QRZeiGzXLXvLC0pvyqwP4xe.TUoKgaXTSRylquLcDdYk9fz5vS5q08Q_hBTtt
 Ivl7Xk9PaEAwB5Dn0QlZ7hf.xXhkkcQRF1BAZDqM4CzzGkvmVIsAsWKz2dEFbzqYLAHbZGZbMhSm
 DT7ZkVT.ecgUm6pa4taL8Dc4K8LmQllc593rYHC_uHaWoiqh6kGNiwOyY5SWYPR0odwzjTviHXi_
 9HXwtYYRKLXix5kQprvf474J6z.PdgKHVaMwnHkRTFg_4PGipILoOZNarkmyhYd6gzOWLohgiZCH
 C.KEZ22TNN87f_4lTKA70bec1ZYC0ojBg.AxYa4AYqIMIZHmMr4d9bpBea56tn1XhK3MQG50tL8D
 NijkvQKiIXZCcETePvTyhUPhUAWBkPi.AGzB7oQib2Ssyvv3f4zC3rKZ2ROgBcbfyb61j_D7Rh4q
 Vc1dA5_Jh4l.0M8Q3eR0zTL33O3AkAdvVOokgPeFBXBs6B_fbj44QHWpqfGtki_hxhfUhiM5fkn4
 dJJvr0WW4HLvcF06437_N4JoqfkCsMVEehZIY.KNHpwWtRD3vrN0FE7YAQLif4Ly8YriXzObRjGs
 hGt7S65J.zQVQaLevdR_0xAjFzfoPRUXm.hxosCj7paangwHwitjLZ2KwYqUUWePmFFKvdaFe3MX
 Yk6ZaKCa2V_Bpi4IyKoQy69OSs5AIIc0HU_K3C2jaM.HxXBcmxAOHTRb9pX7cIbfjUGAYDise5VU
 hQmNWc3tiUM.XTWayMWFWyghYJ_PhXZZhyV4H_AadKU6RmRdxyKB7gVZU4l2O3zmdCjnRzVY5zWU
 jZZk7EFVBCb9Tp79dPA1Dc.G1fOOvi2xdkfTHxNs8q03jedl.rBSvrUpXOE2jdEIiwoZ09WooofK
 HkGePYJ5pioTFtwMMnzRaxpqS4smZC0hKoOO8jyw9u.0b4mUnEWbfQDTNgKWwMfRwXQEBweXwrJ3
 MGJ3u8i12VDKqcE.8ksDvij4ANqPtkRawhyf3JEYx6jSK751DtA9obXEvix5fFFlgZKXnkRYb4oQ
 zNdzA_HXS5n3R9kYTMW5NBwZ8RTqUcTVcIfA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Aug 2019 23:38:59 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 00b0015a4452c970986fbbd4b408816c;
          Sat, 17 Aug 2019 23:38:56 +0000 (UTC)
Date:   Sun, 18 Aug 2019 07:38:48 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel <devel@driverdev.osuosl.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, tytso <tytso@mit.edu>,
        Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Darrick <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

On Sun, Aug 18, 2019 at 01:25:58AM +0200, Richard Weinberger wrote:
> ----- Urspr?ngliche Mail -----
> >> How does erofs compare to squashfs?
> >> IIUC it is designed to be faster. Do you have numbers?
> >> Feel free to point me older mails if you already showed numbers,
> >> I have to admit I didn't follow the development very closely.
> > 
> > You can see the following related material which has microbenchmark
> > tested on my laptop:
> > https://static.sched.com/hosted_files/kccncosschn19eng/19/EROFS%20file%20system_OSS2019_Final.pdf
> > 
> > which was mentioned in the related topic as well:
> > https://lore.kernel.org/r/20190815044155.88483-1-gaoxiang25@huawei.com/
> 
> Thanks!
> Will read into.

Yes, it was mentioned in the related topic from v1 and I you can have
a try with the latest kernel and enwik9 silesia.tar testdata.

> 
> While digging a little into the code I noticed that you have very few
> checks of the on-disk data.
> For example ->u.i_blkaddr. I gave it a try and created a
> malformed filesystem where u.i_blkaddr is 0xdeadbeef, it causes the kernel
> to loop forever around erofs_read_raw_page().

I don't fuzz all the on-disk fields for EROFS, I will do later..
You can see many in-kernel filesystems are still hardening the related
stuff. Anyway, I will dig into this field you mentioned recently, but
I think it can be fixed easily later.

Thanks,
Gao Xiang 

> 
> Thanks,
> //richard
