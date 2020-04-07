Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065861A15F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 21:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgDGT2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 15:28:23 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37805 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDGT2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:28:23 -0400
Received: by mail-ua1-f68.google.com with SMTP id l18so1755995uak.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GgYf7CH7W+96wQQ2FZhAczgJ5DAG4k/Vndh/B+/UNZw=;
        b=JefZe8LZ7qhnOFSDd8aDZ8EsgmvB2d7Q7wZZIij0gvh+P8fKqLAaPwf5kl55zurrH8
         amd4mlB/SWic/MuQCW6AbQdGIP/WayFImiyA3LJHD6o2dRfI4+KVoC/m46osnXkxw5xJ
         ledUluT4WqjVKmkQwP2p3TRnijR77QENj7pju6H4gk3HxWcfG1dbbjXMsJGTH6fCBKAv
         3uxm1duLZiQuKLBa0Lu/9ParnCz6AQodmZqObo3DaWlCucGmE9KwXTzDka255jLMdtZ1
         ZOgkG5kNAGw+C1M0BkT724bW6uHGe7sWjOtnp1K7rKf1qsJeU4R0yZFbV6VtemRyjDRz
         Zq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgYf7CH7W+96wQQ2FZhAczgJ5DAG4k/Vndh/B+/UNZw=;
        b=IFbwQBNpy8gGtnZZADpIefWRI1z84tIIM10TVihVWWp6GPZZ38W0wtrJ+xK0B03N9V
         5Vf8/51u5IP2Iv1wnV0wA9Bj6EMblTFzfOtWZffahJ2Y5zDV7V+2JIMPe/BaCWUaehJ3
         vhFruPBW7HgMrpivvRloqVhOdCtPu6/+tlGYkx2ck1W2LSAAi7ps4uT4K7jSHhf3ldZP
         FP93LOHJ9QzzF/ETVGNEgoMFhVYZdRDpRxEU6ppwB28Crrv/hKoAG/qOTvMMngrWSRGh
         dyU7yHW2lnbnb9SuYMbUlVubA9Z9Z2uX7aiJSHkKB0Ns48v/n/Zy8C4LOEi0hvBfJllE
         q8hA==
X-Gm-Message-State: AGi0PuaSCLfwBatOh/7ax8oD8BplzWY5esLVFOHPS/RHEH1kfSsPkSAi
        DaIC7hCar4o+e4GDuaER+iXtuHJPdsUkX35Y4W21ahnGkQA=
X-Google-Smtp-Source: APiQypJrNBiTt1QNxoZzH31i6nlD8cYyoeJ21GstftsZUw+4JfYpJxJGsqgV20Lff7YOWEAAKRqv1sbxF9eymB6UoDg=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr2442222uam.35.1586287700725;
 Tue, 07 Apr 2020 12:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <202004080121.tMvBN4me%lkp@intel.com>
In-Reply-To: <202004080121.tMvBN4me%lkp@intel.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 7 Apr 2020 15:28:08 -0400
Message-ID: <CAOg9mSRQYLJcnY+EOV+2y7A9xKKQuLtaB0HpXTSSjp_L76RQCQ@mail.gmail.com>
Subject: Re: [hubcap:for-next 1/3] fs/orangefs/inode.c:282:9: error:
 dereferencing pointer to incomplete type 'struct orangefs_read_options'
To:     kbuild test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think this came in because the patch Christoph sent me wouldn't compile
without the code I added in the followup patch.

It seems like our two patches should be merged into one patch, it would get
the job done and protect bisectibility. Does that sound like the right thing
to do? If so, then - Christoph: will you add my patch to yours and resend,
or, can I steal your patch and make my own from it?

I like the reversion and don't want to keep the "knob code", but
I still wish I could succinctly state what the race condition was.

Perhaps: process B could change the file while process A was
using the read count in its file private data.

-Mike

On Tue, Apr 7, 2020 at 2:00 PM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git for-next
> head:   dda33e713f3697b42e747342d6705d54c356f1ae
> commit: 38205b8496b1eb3498d02db0d0466df5b2aea124 [1/3] Revert "orangefs: remember count when reading."
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 38205b8496b1eb3498d02db0d0466df5b2aea124
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.3.0 make.cross ARCH=sh
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> Note: the hubcap/for-next HEAD dda33e713f3697b42e747342d6705d54c356f1ae builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    fs/orangefs/inode.c: In function 'orangefs_readpage':
> >> fs/orangefs/inode.c:282:9: error: dereferencing pointer to incomplete type 'struct orangefs_read_options'
>      282 |   if (ro->blksiz < PAGE_SIZE) {
>          |         ^~
>
> vim +282 fs/orangefs/inode.c
>
> dd59a6475c4cf6 Mike Marshall      2019-03-25  251
> a68d9c606a6795 Martin Brandenburg 2018-02-15  252  static int orangefs_readpage(struct file *file, struct page *page)
> 5db11c21a929cd Mike Marshall      2015-07-17  253  {
> 5db11c21a929cd Mike Marshall      2015-07-17  254       struct inode *inode = page->mapping->host;
> c453dcfc798157 Martin Brandenburg 2018-02-16  255       struct iov_iter iter;
> c453dcfc798157 Martin Brandenburg 2018-02-16  256       struct bio_vec bv;
> c453dcfc798157 Martin Brandenburg 2018-02-16  257       ssize_t ret;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  258       loff_t off; /* offset into this page */
> dd59a6475c4cf6 Mike Marshall      2019-03-25  259       pgoff_t index; /* which page */
> dd59a6475c4cf6 Mike Marshall      2019-03-25  260       struct page *next_page;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  261       char *kaddr;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  262       struct orangefs_read_options *ro = file->private_data;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  263       loff_t read_size;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  264       loff_t roundedup;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  265       int buffer_index = -1; /* orangefs shared memory slot */
> dd59a6475c4cf6 Mike Marshall      2019-03-25  266       int slot_index;   /* index into slot */
> dd59a6475c4cf6 Mike Marshall      2019-03-25  267       int remaining;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  268
> dd59a6475c4cf6 Mike Marshall      2019-03-25  269       /*
> dd59a6475c4cf6 Mike Marshall      2019-03-25  270        * If they set some miniscule size for "count" in read(2)
> dd59a6475c4cf6 Mike Marshall      2019-03-25  271        * (for example) then let's try to read a page, or the whole file
> dd59a6475c4cf6 Mike Marshall      2019-03-25  272        * if it is smaller than a page. Once "count" goes over a page
> dd59a6475c4cf6 Mike Marshall      2019-03-25  273        * then lets round up to the highest page size multiple that is
> dd59a6475c4cf6 Mike Marshall      2019-03-25  274        * less than or equal to "count" and do that much orangefs IO and
> dd59a6475c4cf6 Mike Marshall      2019-03-25  275        * try to fill as many pages as we can from it.
> dd59a6475c4cf6 Mike Marshall      2019-03-25  276        *
> dd59a6475c4cf6 Mike Marshall      2019-03-25  277        * "count" should be represented in ro->blksiz.
> dd59a6475c4cf6 Mike Marshall      2019-03-25  278        *
> dd59a6475c4cf6 Mike Marshall      2019-03-25  279        * inode->i_size = file size.
> dd59a6475c4cf6 Mike Marshall      2019-03-25  280        */
> dd59a6475c4cf6 Mike Marshall      2019-03-25  281       if (ro) {
> dd59a6475c4cf6 Mike Marshall      2019-03-25 @282               if (ro->blksiz < PAGE_SIZE) {
> dd59a6475c4cf6 Mike Marshall      2019-03-25  283                       if (inode->i_size < PAGE_SIZE)
> dd59a6475c4cf6 Mike Marshall      2019-03-25  284                               read_size = inode->i_size;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  285                       else
> dd59a6475c4cf6 Mike Marshall      2019-03-25  286                               read_size = PAGE_SIZE;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  287               } else {
> dd59a6475c4cf6 Mike Marshall      2019-03-25  288                       roundedup = ((PAGE_SIZE - 1) & ro->blksiz) ?
> dd59a6475c4cf6 Mike Marshall      2019-03-25  289                               ((ro->blksiz + PAGE_SIZE) & ~(PAGE_SIZE -1)) :
> dd59a6475c4cf6 Mike Marshall      2019-03-25  290                               ro->blksiz;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  291                       if (roundedup > inode->i_size)
> dd59a6475c4cf6 Mike Marshall      2019-03-25  292                               read_size = inode->i_size;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  293                       else
> dd59a6475c4cf6 Mike Marshall      2019-03-25  294                               read_size = roundedup;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  295
> dd59a6475c4cf6 Mike Marshall      2019-03-25  296               }
> dd59a6475c4cf6 Mike Marshall      2019-03-25  297       } else {
> dd59a6475c4cf6 Mike Marshall      2019-03-25  298               read_size = PAGE_SIZE;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  299       }
> dd59a6475c4cf6 Mike Marshall      2019-03-25  300       if (!read_size)
> dd59a6475c4cf6 Mike Marshall      2019-03-25  301               read_size = PAGE_SIZE;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  302
> dd59a6475c4cf6 Mike Marshall      2019-03-25  303       if (PageDirty(page))
> dd59a6475c4cf6 Mike Marshall      2019-03-25  304               orangefs_launder_page(page);
> c453dcfc798157 Martin Brandenburg 2018-02-16  305
> c453dcfc798157 Martin Brandenburg 2018-02-16  306       off = page_offset(page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  307       index = off >> PAGE_SHIFT;
> c453dcfc798157 Martin Brandenburg 2018-02-16  308       bv.bv_page = page;
> c453dcfc798157 Martin Brandenburg 2018-02-16  309       bv.bv_len = PAGE_SIZE;
> c453dcfc798157 Martin Brandenburg 2018-02-16  310       bv.bv_offset = 0;
> c453dcfc798157 Martin Brandenburg 2018-02-16  311       iov_iter_bvec(&iter, READ, &bv, 1, PAGE_SIZE);
> c453dcfc798157 Martin Brandenburg 2018-02-16  312
> c453dcfc798157 Martin Brandenburg 2018-02-16  313       ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
> f9bbb68233aa5b Mike Marshall      2019-11-26  314           read_size, inode->i_size, NULL, &buffer_index, file);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  315       remaining = ret;
> 74f68fce2a395a Al Viro            2015-10-08  316       /* this will only zero remaining unread portions of the page data */
> c453dcfc798157 Martin Brandenburg 2018-02-16  317       iov_iter_zero(~0U, &iter);
> 5db11c21a929cd Mike Marshall      2015-07-17  318       /* takes care of potential aliasing */
> 5db11c21a929cd Mike Marshall      2015-07-17  319       flush_dcache_page(page);
> c453dcfc798157 Martin Brandenburg 2018-02-16  320       if (ret < 0) {
> 5db11c21a929cd Mike Marshall      2015-07-17  321               SetPageError(page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  322               unlock_page(page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  323               goto out;
> 5db11c21a929cd Mike Marshall      2015-07-17  324       } else {
> 5db11c21a929cd Mike Marshall      2015-07-17  325               SetPageUptodate(page);
> 5db11c21a929cd Mike Marshall      2015-07-17  326               if (PageError(page))
> 5db11c21a929cd Mike Marshall      2015-07-17  327                       ClearPageError(page);
> 5db11c21a929cd Mike Marshall      2015-07-17  328               ret = 0;
> 5db11c21a929cd Mike Marshall      2015-07-17  329       }
> 5db11c21a929cd Mike Marshall      2015-07-17  330       /* unlock the page after the ->readpage() routine completes */
> 5db11c21a929cd Mike Marshall      2015-07-17  331       unlock_page(page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  332
> dd59a6475c4cf6 Mike Marshall      2019-03-25  333       if (remaining > PAGE_SIZE) {
> dd59a6475c4cf6 Mike Marshall      2019-03-25  334               slot_index = 0;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  335               while ((remaining - PAGE_SIZE) >= PAGE_SIZE) {
> dd59a6475c4cf6 Mike Marshall      2019-03-25  336                       remaining -= PAGE_SIZE;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  337                       /*
> dd59a6475c4cf6 Mike Marshall      2019-03-25  338                        * It is an optimization to try and fill more than one
> dd59a6475c4cf6 Mike Marshall      2019-03-25  339                        * page... by now we've already gotten the single
> dd59a6475c4cf6 Mike Marshall      2019-03-25  340                        * page we were after, if stuff doesn't seem to
> dd59a6475c4cf6 Mike Marshall      2019-03-25  341                        * be going our way at this point just return
> dd59a6475c4cf6 Mike Marshall      2019-03-25  342                        * and hope for the best.
> dd59a6475c4cf6 Mike Marshall      2019-03-25  343                        *
> dd59a6475c4cf6 Mike Marshall      2019-03-25  344                        * If we look for pages and they're already there is
> dd59a6475c4cf6 Mike Marshall      2019-03-25  345                        * one reason to give up, and if they're not there
> dd59a6475c4cf6 Mike Marshall      2019-03-25  346                        * and we can't create them is another reason.
> dd59a6475c4cf6 Mike Marshall      2019-03-25  347                        */
> dd59a6475c4cf6 Mike Marshall      2019-03-25  348
> dd59a6475c4cf6 Mike Marshall      2019-03-25  349                       index++;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  350                       slot_index++;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  351                       next_page = find_get_page(inode->i_mapping, index);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  352                       if (next_page) {
> dd59a6475c4cf6 Mike Marshall      2019-03-25  353                               gossip_debug(GOSSIP_FILE_DEBUG,
> dd59a6475c4cf6 Mike Marshall      2019-03-25  354                                       "%s: found next page, quitting\n",
> dd59a6475c4cf6 Mike Marshall      2019-03-25  355                                       __func__);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  356                               put_page(next_page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  357                               goto out;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  358                       }
> dd59a6475c4cf6 Mike Marshall      2019-03-25  359                       next_page = find_or_create_page(inode->i_mapping,
> dd59a6475c4cf6 Mike Marshall      2019-03-25  360                                                       index,
> dd59a6475c4cf6 Mike Marshall      2019-03-25  361                                                       GFP_KERNEL);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  362                       /*
> dd59a6475c4cf6 Mike Marshall      2019-03-25  363                        * I've never hit this, leave it as a printk for
> dd59a6475c4cf6 Mike Marshall      2019-03-25  364                        * now so it will be obvious.
> dd59a6475c4cf6 Mike Marshall      2019-03-25  365                        */
> dd59a6475c4cf6 Mike Marshall      2019-03-25  366                       if (!next_page) {
> dd59a6475c4cf6 Mike Marshall      2019-03-25  367                               printk("%s: can't create next page, quitting\n",
> dd59a6475c4cf6 Mike Marshall      2019-03-25  368                                       __func__);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  369                               goto out;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  370                       }
> dd59a6475c4cf6 Mike Marshall      2019-03-25  371                       kaddr = kmap_atomic(next_page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  372                       orangefs_bufmap_page_fill(kaddr,
> dd59a6475c4cf6 Mike Marshall      2019-03-25  373                                               buffer_index,
> dd59a6475c4cf6 Mike Marshall      2019-03-25  374                                               slot_index);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  375                       kunmap_atomic(kaddr);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  376                       SetPageUptodate(next_page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  377                       unlock_page(next_page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  378                       put_page(next_page);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  379               }
> 5db11c21a929cd Mike Marshall      2015-07-17  380       }
> 5db11c21a929cd Mike Marshall      2015-07-17  381
> dd59a6475c4cf6 Mike Marshall      2019-03-25  382  out:
> dd59a6475c4cf6 Mike Marshall      2019-03-25  383       if (buffer_index != -1)
> dd59a6475c4cf6 Mike Marshall      2019-03-25  384               orangefs_bufmap_put(buffer_index);
> dd59a6475c4cf6 Mike Marshall      2019-03-25  385       return ret;
> dd59a6475c4cf6 Mike Marshall      2019-03-25  386  }
> 52e2d0a3804c09 Martin Brandenburg 2018-12-14  387
>
> :::::: The code at line 282 was first introduced by commit
> :::::: dd59a6475c4cf69afac2ade01ab732b7825a2a45 orangefs: copy Orangefs-sized blocks into the pagecache if possible.
>
> :::::: TO: Mike Marshall <hubcap@omnibond.com>
> :::::: CC: Mike Marshall <hubcap@omnibond.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
