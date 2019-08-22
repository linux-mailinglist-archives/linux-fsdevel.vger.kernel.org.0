Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4419970C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbfHVOj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 10:39:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731487AbfHVOj0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:39:26 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 04F91F4E5300D576654F;
        Thu, 22 Aug 2019 22:39:23 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 22:39:22 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 22 Aug 2019 22:39:22 +0800
Date:   Thu, 22 Aug 2019 22:38:42 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>, Gao Xiang <hsiangkao@aol.com>,
        "Richard Weinberger" <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190822143841.GC195034@architecture4>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
 <20190822142142.GB2730@mit.edu>
 <CAFLxGvzGEBH2Z+Bpv68OMeLR1JH0pe6bHn6P-sBG+epLTXbR6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLxGvzGEBH2Z+Bpv68OMeLR1JH0pe6bHn6P-sBG+epLTXbR6w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

On Thu, Aug 22, 2019 at 04:29:44PM +0200, Richard Weinberger wrote:
> On Thu, Aug 22, 2019 at 4:21 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > It might make life easier for other kernel developers if "features"
> > was named "compat_features" and "requirements" were named
> > "incompat_features", just because of the long-standing use of that in
> > ext2, ext3, ext4, ocfs2, etc.  But that naming scheme really is a
> > legacy of ext2 and its descendents, and there's no real reason why it
> > has to be that way on other file systems.
> 
> Yes, the naming confused me a little. :-)

Sorry for confusing... And thanks, I'm happy that
you give us those reports. and sorry about my poor
English...

Thanks,
Gao Xiang

> 
> -- 
> Thanks,
> //richard
