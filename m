Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9622E32F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 00:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGZWwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 18:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGZWwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 18:52:04 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24EC0619D4
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 15:52:04 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dd12so1613354qvb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qxqp4Cra7c8Q17ZGNold8rkyaZiozPWBwMAyhGj2zo=;
        b=JkDdmLMlOOUeQhUCCC15e+gkl4e2eabFhCb9ynbxSm34RgDUqt6M37JmbF9hvf/noi
         fiFoU3kOcsHOhNWXL74Ui2bXI3vyGhKCRSw9Msvo+e4uuTvycKoym9Lrcs1SiiWKhQcb
         cuL/ajKCgjMdxo28TW2jfxoifsW/74Pnvjv5+gT1hggLnSYYtgEzIFjz6VNEMMGgp4jx
         u+YJcX54ih5WlXdreWOiBX7ylgibmQ6QnmdGd2fqoIBXQYAmx6gVcqaa915e3Vsmhp3x
         LMRhA8A+HoUvA5BsBW/hxJ5UB2PRENXf9ouMF1/xOHDoV/wQpvueF2EdJg23BOyuqG2l
         Wt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qxqp4Cra7c8Q17ZGNold8rkyaZiozPWBwMAyhGj2zo=;
        b=Mp5V8DjnCHY5s1qpXndn3EzLBfK97woBRG8At9BPQacqSAVU6o8pPK55pPpvg1H2Vz
         fL11biOXH5k0SzfNrV7GzbjzbL+tRuvKTFJCJw+2e0gQPmx2tshFgTUV4iueqJ0jOK2g
         BE1U2kgVoVt7Bt/SxZRqHQqO6kkPc7df9vIaEXIpDftbG6YkcPKB6kcrRCk1mJjgJBSC
         2miccTzbi1AYyFTIfIfci+2e14OnBtQ6G2A6TpGuzv9Su4n1tsLn2nE6ZeX/vI2PVdfn
         HAnS+uyQhQTS85oXJyO7lykrdUXffsC2vjIaVwqXCwgCQMXbZl3yc+97nL6gct9rpgbn
         /7Xw==
X-Gm-Message-State: AOAM530Amc4r0sdBv88XlV9rEdWMslwdHx7uwAJfV4fyIMSKZJFq0FfF
        gCyPbFWMUgA0Ji4IyJnlLJ8bU1vIrCcTaw==
X-Google-Smtp-Source: ABdhPJxtX6CIU9klIDmZxKuPl98KVTqY07BMK/VxQByZcrYhNr3TrR1gvudNaJwU7iLZffa5iyqWPA==
X-Received: by 2002:a05:6214:11f3:: with SMTP id e19mr9636442qvu.220.1595803923650;
        Sun, 26 Jul 2020 15:52:03 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p17sm2043556qtn.15.2020.07.26.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 15:52:02 -0700 (PDT)
Date:   Sun, 26 Jul 2020 18:51:54 -0400
From:   Qian Cai <cai@lca.pw>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, khlebnikov@yandex-team.ru
Subject: Re: WARN_ON_ONCE(1) in iomap_dio_actor()
Message-ID: <20200726225154.GA929@lca.pw>
References: <20200619211750.GA1027@lca.pw>
 <20200620001747.GC8681@bombadil.infradead.org>
 <20200724182431.GA4871@lca.pw>
 <20200726152412.GA26614@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726152412.GA26614@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 04:24:12PM +0100, Christoph Hellwig wrote:
> On Fri, Jul 24, 2020 at 02:24:32PM -0400, Qian Cai wrote:
> > On Fri, Jun 19, 2020 at 05:17:47PM -0700, Matthew Wilcox wrote:
> > > On Fri, Jun 19, 2020 at 05:17:50PM -0400, Qian Cai wrote:
> > > > Running a syscall fuzzer by a normal user could trigger this,
> > > > 
> > > > [55649.329999][T515839] WARNING: CPU: 6 PID: 515839 at fs/iomap/direct-io.c:391 iomap_dio_actor+0x29c/0x420
> > > ...
> > > > 371 static loff_t
> > > > 372 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> > > > 373                 void *data, struct iomap *iomap, struct iomap *srcmap)
> > > > 374 {
> > > > 375         struct iomap_dio *dio = data;
> > > > 376
> > > > 377         switch (iomap->type) {
> > > > 378         case IOMAP_HOLE:
> > > > 379                 if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
> > > > 380                         return -EIO;
> > > > 381                 return iomap_dio_hole_actor(length, dio);
> > > > 382         case IOMAP_UNWRITTEN:
> > > > 383                 if (!(dio->flags & IOMAP_DIO_WRITE))
> > > > 384                         return iomap_dio_hole_actor(length, dio);
> > > > 385                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > > > 386         case IOMAP_MAPPED:
> > > > 387                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > > > 388         case IOMAP_INLINE:
> > > > 389                 return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> > > > 390         default:
> > > > 391                 WARN_ON_ONCE(1);
> > > > 392                 return -EIO;
> > > > 393         }
> > > > 394 }
> > > > 
> > > > Could that be iomap->type == IOMAP_DELALLOC ? Looking throught the logs,
> > > > it contains a few pread64() calls until this happens,
> > > 
> > > It _shouldn't_ be able to happen.  XFS writes back ranges which exist
> > > in the page cache upon seeing an O_DIRECT I/O.  So it's not supposed to
> > > be possible for there to be an extent which is waiting for the contents
> > > of the page cache to be written back.
> > 
> > Okay, it is IOMAP_DELALLOC. We have,
> 
> Can you share the fuzzer?  If we end up with delalloc space here we
> probably need to fix a bug in the cache invalidation code.

This is just a wrapper of the trinity fuzzer.

# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make
# ./random -x 0-100 -f

https://gitlab.com/cailca/linux-mm/-/blob/master/random.c#L1383
