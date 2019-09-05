Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF49BA97C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 03:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfIEBEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 21:04:06 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com ([87.248.110.32]:46329
        "EHLO sonic307-7.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbfIEBEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567645443; bh=4b8n4T3EgXBNYEU3+TfHpe17gl48aHIqQ+x8f/qQM1k=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=Du9eMyoFu8T+65UVjsqsrrG9OFD89V0kaQ+OxwR2cTeV3mpb6c/R/DCattd0+5AzclqpAv0dAY4GPzoGOKRNRaNzBR+etkyRLFJYBLW5WhHDVzpkba/Adhc2haMDnAM0EQ4XDutSnRtjvXJLd2T89TvkaWxApBlGPL77E3t9j516kugw/5ORozkvC7kx9Q1lxQayvl5EztUVWHrdFBJ9rJVJOBn3ZDvDVHpf9Nk1GBaBDn6sQDoROg5sMu2ovFQyiVRHK9vWr/30qebssRvBfewO0X7jT8YeTnyEx83FiIxAXelOXEQGwMzlGQ5dDqdjsGe72k+ybGjx/hxuzEECog==
X-YMail-OSG: 4unSnbUVM1k3ATGEQfOMWu420qP9Ev983uSJ30R3iHTmcCj2NrJy4oEbzIVCfoL
 frxe98FSWUAXpzGA2_vCUPQWAXLWDnmNalXSeu5uy20Tot8oL9ReyZM6LAvP3SZyCrqGu5Sdbw2H
 STpxQHR_dTtuR0WLVgG78vGn4puJaBlOPev6useSSTTz6iUyVF75BfzpwKe6D.z.eQPXuPVllauk
 .4r1rlQPkghHWdwO8wqCJlSdOOLb38UtVtgfUQ7Po4K0zc7.bkOZHpYmJfLjc_HpTk05KChySxoh
 9rmV3WIhNoHQKW.Pn.x7n9x69qGn_GJKJ0GnyJBkH1a4Nhuu_apVfBkLec7YZWuc2W5cNtJZC2av
 _twlKXVy_fEeYoA7OI_9mdUuGYlPw7hoasHwRsaJ_WEWuyi4PrwlS.iKZVmfBjJgIuh_fS5CkKu9
 Wcei7NMGvO77R144DGrTMa8jNPJ7T01P6PO5YWVo9H4CAuvLMRZlDlMlnER1OsaRyNRk2Vatck_1
 yBPAGdVtBzFsVS0Hn_fHA0yTZvQmNRSXsUDy0ar3j8dEjcLb2YRhlFtlRQk1k6wSp_i1lS.sBS6p
 1sYU3YxuZQT2rNavnti78ofX2GIf6ucYsi8cskH3lIm4qVjdCoNLAgDCRZVXeryO2fqmVrRugzaP
 TLWKlN2yWrb_8MaojtmwTnqenYaOz7QNUz.olCCCd42GUZAGhrj9DLksk2i6RnkUQGi85Y_.e2C0
 f4EoXwGGx3XxBbn.ifRYrVPmo8BxXuOCELdTIzPVksTplwLMo1d1obYmwBZRt9raDHAsvHDq0yFz
 Pe9.HPMzp_LBUyyTmCUlCBU786J176Hq8ZmsSMh6AsYYGVi5r6wxvXaPypl.j1.FsLVUKfvuoa3s
 aVimP3evDR0S9wSq1L44BIYfulXF20_MNqOL.FyE8iFiB5zieLgbJx18QCmcXmf2cDZiYw1yVx_6
 5amYo87QcXQFcGJ65w6cHargiNseeV1f3uEy22hgPRMYNjDKPtUsZVZIxBz7JLh3AoKRh3Sx7ljl
 lZuwotK1XH9nMCccujhJLm5w9UhGHgbXkAj5kO5OtHs32eV673MYrxEEAcAEPZoqF2TvVZYpQBlt
 .qW_HBJ8vV.8.CDkt3.iNb25Qa8dXhxQQCMxoPoZMsbILruCyelulNuzEaiTrKXTOrN_Wl8QIvR.
 LqIxIsakxAzU9O4u3Zerk_HKeEBIwNDqKSznZnrruPshwnKlLQbeTYkoTGR4S78NKeDlIcT8vw6T
 LVkO9QWCZ5ZNISpu6CvZzfYyRfm25I4o9uIijDNCzJV8yjx_6j5Kb25FECsk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Thu, 5 Sep 2019 01:04:03 +0000
Received: by smtp426.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8dca055fbec642163ec5566d488a20c8;
          Thu, 05 Sep 2019 01:03:59 +0000 (UTC)
Date:   Thu, 5 Sep 2019 09:03:54 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 00/25] erofs: patchset addressing Christoph's comments
Message-ID: <20190905010328.GA15409@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
 <52a38cb7-b394-b8a8-7254-aafe47f2caa5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a38cb7-b394-b8a8-7254-aafe47f2caa5@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Wed, Sep 04, 2019 at 11:27:11AM +0800, Chao Yu wrote:
> On 2019/9/4 10:08, Gao Xiang wrote:
> > Hi,
> > 
> > This patchset is based on the following patch by Pratik Shinde,
> > https://lore.kernel.org/linux-erofs/20190830095615.10995-1-pratikshinde320@gmail.com/
> > 
> > All patches addressing Christoph's comments on v6, which are trivial,
> > most deleted code are from erofs specific fault injection, which was
> > followed f2fs and previously discussed in earlier topic [1], but
> > let's follow what Christoph's said now.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,

Could we submit these patches if these patches look good...
Since I'd like to work based on these patches, it makes a difference
to the current code though...

Thanks a lot!

Thanks,
Gao Xiang

> 
> > 
> > Comments and suggestions are welcome...
> > 
> > [1] https://lore.kernel.org/r/1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org/
> > 
> > changes since v1:
> >  - leave some comments near the numbers to indicate where they are stored;
> >  - avoid a u8 cast;
> >  - use erofs_{err,info,dbg} and print sb->s_id as a prefix before
> >    the actual message;
> >  - add a on-disk title in erofs_fs.h
> >  - use feature_{compat,incompat} rather than features and requirements;
> >  - suggestions on erofs_grab_bio:
> >    https://lore.kernel.org/r/20190902122016.GL15931@infradead.org/
> >  - use compact/extended instead of erofs_inode_v1/v2 and
> >    i_format instead of i_advise;
> >  - avoid chained if/else if/else if statements in erofs_read_inode;
> >  - avoid erofs_vmap/vunmap wrappers;
> >  - use read_cache_page_gfp for erofs_get_meta_page;
> > 
> > Gao Xiang (25):
> >   erofs: remove all the byte offset comments
> >   erofs: on-disk format should have explicitly assigned numbers
> >   erofs: some macros are much more readable as a function
> >   erofs: kill __packed for on-disk structures
> >   erofs: update erofs_inode_is_data_compressed helper
> >   erofs: use feature_incompat rather than requirements
> >   erofs: better naming for erofs inode related stuffs
> >   erofs: kill erofs_{init,exit}_inode_cache
> >   erofs: use erofs_inode naming
> >   erofs: update erofs_fs.h comments
> >   erofs: update comments in inode.c
> >   erofs: better erofs symlink stuffs
> >   erofs: use dsb instead of layout for ondisk super_block
> >   erofs: kill verbose debug info in erofs_fill_super
> >   erofs: localize erofs_grab_bio()
> >   erofs: kill prio and nofail of erofs_get_meta_page()
> >   erofs: kill __submit_bio()
> >   erofs: add "erofs_" prefix for common and short functions
> >   erofs: kill all erofs specific fault injection
> >   erofs: kill use_vmap module parameter
> >   erofs: save one level of indentation
> >   erofs: rename errln/infoln/debugln to erofs_{err,info,dbg}
> >   erofs: use read_mapping_page instead of sb_bread
> >   erofs: always use iget5_locked
> >   erofs: use read_cache_page_gfp for erofs_get_meta_page
> > 
> >  Documentation/filesystems/erofs.txt |   9 -
> >  fs/erofs/Kconfig                    |   7 -
> >  fs/erofs/data.c                     | 118 +++--------
> >  fs/erofs/decompressor.c             |  76 +++----
> >  fs/erofs/dir.c                      |  17 +-
> >  fs/erofs/erofs_fs.h                 | 197 +++++++++---------
> >  fs/erofs/inode.c                    | 297 ++++++++++++++--------------
> >  fs/erofs/internal.h                 | 192 ++++--------------
> >  fs/erofs/namei.c                    |  21 +-
> >  fs/erofs/super.c                    | 282 +++++++++++---------------
> >  fs/erofs/xattr.c                    |  41 ++--
> >  fs/erofs/xattr.h                    |   4 +-
> >  fs/erofs/zdata.c                    |  63 +++---
> >  fs/erofs/zdata.h                    |   2 +-
> >  fs/erofs/zmap.c                     |  73 +++----
> >  include/trace/events/erofs.h        |  14 +-
> >  16 files changed, 578 insertions(+), 835 deletions(-)
> > 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
