Return-Path: <linux-fsdevel+bounces-2889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA67EC126
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 12:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26D01F219EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95864156F4;
	Wed, 15 Nov 2023 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHdL0K0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317114F60
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 11:15:04 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB3FA
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 03:15:02 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b9c8706fc1so2574813241.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 03:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700046901; x=1700651701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Na/qyJPpv7M2mD4KWI412UY7s6MpSD8TKED279inyuc=;
        b=vHdL0K0CwABdeT0hx8LtTyrdzYxSMfHoMGIE9qSXixw4F2f/tbbqIJpxHt7AJ2UvVb
         2O0Q/6PI5nYis/J9QSSixVh6VwD36cJLMdnErmAB+bRLcexgRX+phF/fR6CmZP656kPE
         FQFPj3UUOkkspocgvsOGtDMfFYsXlKxw1uOw/w0dRkfckzgTpV2vr5Fqhr3GBuKTY2mX
         FLs2ggvfKkm91o08rGQpc1CzOzYKpjxZ31IdGX01s41qt/beKnj2Nr6VB1Rx/pywP/n3
         ivZo1693LGIo/iKaITVOBNae/Lwe7rN2WwrWnFU501bynAqI9n1pTfnCm0wvaD+irWDF
         Pkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700046901; x=1700651701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na/qyJPpv7M2mD4KWI412UY7s6MpSD8TKED279inyuc=;
        b=PH0QaUMV48gpgTeq1yMkf6ESImAu2C4tRTAPchbl3gmeFTt5phKcAy8C/ib2+pByOQ
         WEYYX0aLSeOy2ZITvjeQ+UplPd+4zSS/TuEQZ+0/JWE8KQ5UDQWmaBOQOeUpG/AwJ9cf
         VctuYlN+cKKBrE0MVcoQ+57XooPGj7tO0veV+LNV7Omiugb38Uk7tJexQlIOZXst7HIy
         YxzdBr0U0JnSu4oMvXPdvD/yw/U/C4mJZxv2Jer+c2g5ADP7zAaarxNeQE+DnT5XaSa/
         V/KuoPVJUmf+rK8J6IUsU0wpyEZEwbEzwwxcPjXEmImtooKOy8afgAHhv6JtyVo4mnNV
         +1JQ==
X-Gm-Message-State: AOJu0Yzkb6DUh5T9AE9XtuVHmXt1e0ikw73rmbi+lqpwtkG1Glel/1kB
	3//5JjlctmlQPOCF2j0DS+75ZRYXub5LHlkzhvyrxTISgPNkcXWCAis=
X-Google-Smtp-Source: AGHT+IFTWpi4Ff/kgs493Yi1PtmVxMEBSw015UrnpDNqrt3IXeS1C8RYEVdQRr67V4vRMJRNPFGXcdY6WD7U8DE0Wd4=
X-Received: by 2002:a67:b202:0:b0:45f:8783:beaa with SMTP id
 b2-20020a67b202000000b0045f8783beaamr12841662vsf.12.1700046901398; Wed, 15
 Nov 2023 03:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109210608.2252323-4-willy@infradead.org> <202311121240.AN8GbAbe-lkp@intel.com>
 <20231113091006.f9d4de1aaf7ed2f8beef07fb@linux-foundation.org> <20231113172052.GA3733520@dev-arch.thelio-3990X>
In-Reply-To: <20231113172052.GA3733520@dev-arch.thelio-3990X>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 15 Nov 2023 16:44:49 +0530
Message-ID: <CA+G9fYuA_PTd7R2NsBvtNb7qjwp4avHpCmWi4=OmY4jndDcQYA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size > PAGE_SIZE
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Hannes Reinecke <hare@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Mon, 13 Nov 2023 at 22:50, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Nov 13, 2023 at 09:10:06AM -0800, Andrew Morton wrote:
> > On Sun, 12 Nov 2023 12:52:00 +0800 kernel test robot <lkp@intel.com> wrote:
> >
> > > Hi Matthew,
> > >
> > > kernel test robot noticed the following build errors:
> > >
> > > [auto build test ERROR on akpm-mm/mm-everything]
> > > [also build test ERROR on linus/master next-20231110]
> > > [cannot apply to v6.6]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/buffer-Return-bool-from-grow_dev_folio/20231110-051651
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > > patch link:    https://lore.kernel.org/r/20231109210608.2252323-4-willy%40infradead.org
> > > patch subject: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size > PAGE_SIZE
> > > config: hexagon-comet_defconfig (https://download.01.org/0day-ci/archive/20231112/202311121240.AN8GbAbe-lkp@intel.com/config)
> > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311121240.AN8GbAbe-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202311121240.AN8GbAbe-lkp@intel.com/

KFT CI also have been noticing this build problem on Linux next.
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> ld.lld: error: undefined symbol: __muloti4
> > >    >>> referenced by buffer.c
> > >    >>>               fs/buffer.o:(bdev_getblk) in archive vmlinux.a
> > >    >>> referenced by buffer.c
> > >    >>>               fs/buffer.o:(bdev_getblk) in archive vmlinux.a
> > >
> >
> > What a peculiar compiler.
> >
> > I assume this fixes?
> >
> > --- a/fs/buffer.c~buffer-fix-grow_buffers-for-block-size-page_size-fix
> > +++ a/fs/buffer.c
> > @@ -1099,7 +1099,7 @@ static bool grow_buffers(struct block_de
> >       }
> >
> >       /* Create a folio with the proper size buffers */
> > -     return grow_dev_folio(bdev, block, pos / PAGE_SIZE, size, gfp);
> > +     return grow_dev_folio(bdev, block, pos >> PAGE_SHIFT, size, gfp);
> >  }
> >
> >  static struct buffer_head *
> > _
> >
> >
>
> No, this is not a division libcall. This seems to be related to the
> types of the variables used in __builtin_mul_overflow() :/ for some odd
> reason, clang generates a libcall when passing in an 'unsigned long
> long' and 'unsigned int', which apparently has not been done before in
> the kernel?
>
> https://github.com/ClangBuiltLinux/linux/issues/1958
> https://godbolt.org/z/csfGc6z6c
>
> A cast would work around this but that could have other implications I
> am not aware of (I've done little further investigation due to LPC):

Thanks for providing this fix patch.


> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4eb44ccdc6be..d39934783743 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1091,7 +1091,7 @@ static bool grow_buffers(struct block_device *bdev, sector_t block,
>          * Check for a block which lies outside our maximum possible
>          * pagecache index.
>          */
> -       if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILESIZE) {
> +       if (check_mul_overflow(block, (u64)size, &pos) || pos > MAX_LFS_FILESIZE) {
>                 printk(KERN_ERR "%s: requested out-of-range block %llu for device %pg\n",
>                         __func__, (unsigned long long)block,
>                         bdev);
>
> Cheers,
> Nathan

- Naresh

