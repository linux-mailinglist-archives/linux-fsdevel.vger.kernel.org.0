Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395FE12E65D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 14:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgABNK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 08:10:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53400 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgABNK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:10:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so5520912wmc.3;
        Thu, 02 Jan 2020 05:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5QU9rTsOzLzEhmlH5FWURLkeBcEclcCF3nfzgMt4niY=;
        b=ko1LZAaC3JhmAHFPAOrUXMPiNlNhsRZ3FF16pKEN0EibdyTuqI1IMJIQ4Bl9+QZ7k/
         EEjHV12eix685/GRUonjG3feNA9p6Ogk0njCAfF50epGLzmfgxENK9rNcXLBYewt+GpO
         Ba3LVSVwtm1ECFPxaiPDess6e9DutWyEpCE4IJiZOpFDjYPikVlAWqXmpQKMai54OtG/
         ZgBsNGZw7ZIqO4h7KLhhRrd5QLvfr2F2pqzzGk/ms6KoGgj+iUUDaaeJtkR1picQWB4L
         LCKlU15m0HflbKLxRgDF/q3SkCs2VXz23kUKHrGR7gaxeyNgTL+zOjE1jyMUDtBxdc+v
         A0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5QU9rTsOzLzEhmlH5FWURLkeBcEclcCF3nfzgMt4niY=;
        b=YlwREIrdYQEWTnfzLKuB1pK29v8GUfYInoBB4rmrI0eIK7W2TvA2pRVXxa/7Wz1G5r
         FdMIBU3o0+Xum3NM5OY6ciqPCG3zUIEH3u76rnc1bscyCu3Eht+mF4dYmrFK2uuIIqNG
         RlwdY5xegmsCXTXGIzG6Kckaaw3zhuasDkEFIUY+tA2Z+wJV9ocZWG+D26D/3q1oITh3
         w+a3nVaAHET3Ft5k3Ap4XDvV5xrGcP2HUYcx81Lt1/trQS0gNz5rKvudrugfKX79OI7B
         cIvdrt87ViJBih9CEPyjWJ8bAwyXiroMTuxRrRXqaZE/XlHqEIQBu+tZttiTljE1Yobp
         pnlw==
X-Gm-Message-State: APjAAAUosECU2HtNBdAX4drdj6F4MXTK80JNoOQnJ6+C922hXXBhpkhu
        yfds+5Ji195E9DNoua1UM/Y=
X-Google-Smtp-Source: APXvYqzWm284jkC+hbemmMPb+amPG4TiJs/RHCW9IumhNHaPS8XGWJBRQJJcx9hxDY6WPq6sm2XOkQ==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr14876920wmb.53.1577970654921;
        Thu, 02 Jan 2020 05:10:54 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q19sm8512946wmc.12.2020.01.02.05.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 05:10:54 -0800 (PST)
Date:   Thu, 2 Jan 2020 14:10:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Subject: Re: [PATCH v9 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Message-ID: <20200102131053.kmvmik7aumctrih2@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082408epcas1p194621a6aa6729011703f0c5a076a7396@epcas1p1.samsung.com>
 <20200102082036.29643-13-namjae.jeon@samsung.com>
 <20200102125830.z2uz673dlsdttjvo@pali>
 <CAKYAXd9Y6o+a7q_yismLP8nNXOUqrudC3KW8N6Z05OghYLt1jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd9Y6o+a7q_yismLP8nNXOUqrudC3KW8N6Z05OghYLt1jg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 22:07:16 Namjae Jeon wrote:
> >> index 98be354fdb61..2c7ea7e0a95b 100644
> >> --- a/fs/Makefile
> >> +++ b/fs/Makefile
> >> @@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
> >>  obj-$(CONFIG_CODA_FS)		+= coda/
> >>  obj-$(CONFIG_MINIX_FS)		+= minix/
> >>  obj-$(CONFIG_FAT_FS)		+= fat/
> >> +obj-$(CONFIG_EXFAT)		+= exfat/
> >>  obj-$(CONFIG_BFS_FS)		+= bfs/
> >>  obj-$(CONFIG_ISO9660_FS)	+= isofs/
> >>  obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
> >
> > Seems that all filesystems have _FS suffix in their config names. So
> > should not have exfat config also same convention? CONFIG_EXFAT_FS?
> Yeah, I know, However, That name conflicts with staging/exfat.
> So I subtracted _FS suffix.

Maybe it is a good idea to drop conflicting implementation prior merging
this series? Or at least renaming conflicting name?

You already wrote that it is "random previous snaphot" which does not
sounds as something we would like to use or support.

-- 
Pali Rohár
pali.rohar@gmail.com
