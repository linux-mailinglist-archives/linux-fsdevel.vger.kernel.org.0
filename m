Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB238F127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfHOQrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 12:47:18 -0400
Received: from sonic312-24.consmr.mail.gq1.yahoo.com ([98.137.69.205]:41165
        "EHLO sonic312-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfHOQrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1565887637; bh=synLMlaglsY0Z1eDHodD6fZP0N3IIeMoHfFfRAPdHSA=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=THAPNN1iVhpXmu/CI7B3zBiQNSrMASs+XgqCS+pihKjgUNDvQpMItp8MEiOaj72s/9wgLmDFsSllP4tu/lEY93aUsMkocu5U9Tt9N0cRps18lZ35QIKTil/BChWuwQnALwEvwyQ+IaxmVRT+gDv23QfySBgBgbtwO/M8DE9d5nuce8yNtqHM6Ke9EZLX2FTuPXH/G1jQdElTDK9IiEjoex6HPX0ZI9DHl7AN5lSYqPwgfqXoU9DknORdRJ48QsLLKDAraK/ZHH7l5trmK5PHX5WhPBxEN3cAm2JUzE8YpzUiTufpBivPOT+FqySzvgVl/E6GSaGtUuY+Xrmqw8AnRQ==
X-YMail-OSG: DGMMZyYVM1nVJU6KZhXFai9ZsZzdlOD3JwSg.75gQuSAfWNRT_EdhIWzE9BEdkd
 oz6gBRaOYYaMCZe8LZu4DlIWjmyM2ydY343Fk5E.IPEgQHsYdM7wwmqZ3qeqcAheN5QFoLjlo4Zd
 P8vvxWuhodBdOw7P4bkeGiRBZkOZQd5z1FJOQfsfJUBxa92VWpbFvwkrjt7w8Wymwshtae.lUHyl
 SZd3jYBdO8NVMacLZf4XFqbK8giyX0YjGNTbFN6Bi5XdjFF4O404ljiEg39huKQmx_GkHGV6X1_W
 D.sTojNbGIZVqPKZeIu7uY.znsCq9THeltGrsE53G6pACdtQXNYY4BuoU9bs8IytRVM5sckdDqSB
 vzcIYTjf_SL2exUr6uye3Lk6pcyr7MsgdjfO69bsuMJpHGMgn4KBIxJWs4rDrY8IGMNaM6WofrsH
 8bY28b2GKgtY01EXFJsAtWgO7Xc3_O2cbBJn.A9RYkp3MW905rALj73N8nTEVP3yqYKnbY1yR_j2
 CSa0Ox_HPprd7d1PNsgkt_YPUxwU3PTdFM80oJKQZ_75PWVnqKom.n72vuW6HmHTev4N4mZprOHs
 TfcVQsAme05z7tjxaTqvbJ8LS_ndTTx1Lqw3tIOtPEVSCf0BDevkgkE9FozKeL7phFdj_pAM7G3E
 Oye6ej8vJztxw274hLF8b8G49wXzeU9J9uuuwihnWcqOx7GjpkaytItErGsfGUshAffLWAJi6BCs
 DPrUKKU6.6thtlm3SiTolAi7zV73Yxphs0lpCKc_SSBhrjkps_6tFASc196bbKsiQ9P3qStvk5R8
 YBcSgTPdg3xvSw93WtrAHrDJudAC0H5BZj6NKk5rn_8.K3MvGeSvCpCproE00WQyPeGOEnE6HUtm
 bqGuQXiGEdrOOu6rd2O0groFg9qU9_ScAi37G_s9dwL40L6Ajw0Y0IikXpeeb0T5fLDp0FjTTihg
 Cmsq_zON8rwea32UArZ.Z9_bTyvwTUNPeLRm80pWX0oivxIbX.PeIHc4YvuxLRL_VkOkT4jaqVuD
 4L9pI3QwFYdwNZtb7y.vg99qrp2QDwJe10qhaHQl_c.SoqKUMJTNM6e.AinWmDenI8xynYvSurJT
 6C_OpJQtX_9UJZhYkUUP2EOPjNRWFmEr9gBlvdRq0umIK3n3GrhufOOn80goFhaRDmg6EV9_r.Mp
 HAQCS8gVleKfOeu7iI1QHhUo94k4lH8_jcQh.KKv9.Uy0xeq7qsNu3tdK.nYwuNjhX_q3IJ1om0z
 c5Rr38ZhyxTDNvz_zEPhDCJWvHv223_K90Hs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 15 Aug 2019 16:47:17 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 56dbf3541076f4413fe12889395d767b;
          Thu, 15 Aug 2019 16:47:15 +0000 (UTC)
Date:   Fri, 16 Aug 2019 00:46:56 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Richard Weinberger <richard@nod.at>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v8 07/24] erofs: add directory operations
Message-ID: <20190815164650.GA4958@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-8-gaoxiang25@huawei.com>
 <CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On Thu, Aug 15, 2019 at 09:13:19AM -0700, Linus Torvalds wrote:
> On Wed, Aug 14, 2019 at 9:42 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
> >
> > +
> > +static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
> > +       [EROFS_FT_UNKNOWN]      = DT_UNKNOWN,
> > +       [EROFS_FT_REG_FILE]     = DT_REG,
> > +       [EROFS_FT_DIR]          = DT_DIR,
> > +       [EROFS_FT_CHRDEV]       = DT_CHR,
> > +       [EROFS_FT_BLKDEV]       = DT_BLK,
> > +       [EROFS_FT_FIFO]         = DT_FIFO,
> > +       [EROFS_FT_SOCK]         = DT_SOCK,
> > +       [EROFS_FT_SYMLINK]      = DT_LNK,
> > +};
> 
> Hmm.
> 
> The EROFS_FT_XYZ values seem to match the normal FT_XYZ values, and
> we've lately tried to just have filesystems use the standard ones
> instead of having a (pointless) duplicate conversion between the two.
> 
> And then you can use the common "fs_ftype_to_dtype()" to convert from
> FT_XYZ to DT_XYZ.
> 
> Maybe I'm missing something, and the EROFS_FT_x list actually differs
> from the normal FT_x list some way, but it would be good to not
> introduce another case of this in normal filesystems, just as we've
> been getting rid of them.
> 
> See for example commit e10892189428 ("ext2: use common file type conversion").

Yes, you're right. There is nothing different with DT_XYZ since
I followed what f2fs did when I wrote this place.

Actually, I noticed that patchset once in mailing list months ago
https://lore.kernel.org/r/20181023201952.GA15676@pathfinder/
but I didn't keep eyes on it (whether this patchset is merged or not...)

OK, let me fix that like other fses. Thanks for pointing out.

Thanks,
Gao Xiang

> 
>                Linus
