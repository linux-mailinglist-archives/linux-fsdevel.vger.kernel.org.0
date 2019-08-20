Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA895E09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHTL5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 07:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTL5h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:57:37 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B88F811A13
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 11:57:36 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id h8so6907236wrb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 04:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XDKEoOdHwq1lbeRx7Aw+gnzvXTG37O7vnLdKpNshzwg=;
        b=g+i3n65H6OfxPTDHLSf4bFy+lwoUCQVyErMfdLA32Y50fhCaAfn45rLSgORjqS/N6P
         jyEUGbThPJQsxP3Ly29oCXSXgQpxpo/RIig1TbRbo7qjrgDpVK2yYwXjKqfji+I6XKvY
         h41myu17/PtjT/umri+ymGOWU4T+KGG0PaKeQY/vgLnh52K8lH3YihC9WtBKzXWGVMpF
         +YsG05xIBmfooCXp698NwFV4iknL+0IIyRkf3NCR/auPEjyIPbYt6JH6MI6op1Er0gfI
         uwf63yP6Vz5iNFSUVQsM6iwt4y4p/nQl1EDFA3y3VmJs7qUfN6XwGHT8Dm0l1fx7G3XT
         0wBg==
X-Gm-Message-State: APjAAAXo+k8s/XXPIr1UrAUckGGnjCdpjTVz8aUkWxa3L+3zmRgn/xpJ
        Inos2y6cx4iFQ2HCESWrbVrsX0wMzwoD5rhOdHqJad9HFmWFqDMxwIkBezeUcfnlDRNcSgRSe1B
        Xsgq5UphoXKJOrVsQRU0dNdL2aQ==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr34260711wrv.345.1566302255528;
        Tue, 20 Aug 2019 04:57:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxacsi4LfxSfRp+8+CxkC8yY0Yg8as35IT8Y5TfMDGMA3q7N5ldlBJvJxDKANyD5thffwKLXQ==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr34260687wrv.345.1566302255317;
        Tue, 20 Aug 2019 04:57:35 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id v124sm14321570wmf.23.2019.08.20.04.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 04:57:34 -0700 (PDT)
Date:   Tue, 20 Aug 2019 13:57:32 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
Message-ID: <20190820115731.bed7gwfygk66nj43@pegasus.maiolino.io>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org, dhowells@redhat.com
References: <20190808082744.31405-1-cmaiolino@redhat.com>
 <20190808082744.31405-3-cmaiolino@redhat.com>
 <20190814111535.GC1885@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814111535.GC1885@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:15:35PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 08, 2019 at 10:27:37AM +0200, Carlos Maiolino wrote:
> > +	block = page->index;
> > +	block <<= shift;
> 
> Can't this cause overflows?

Hmm, I honestly don't know. I did look at the code, and I couldn't really spot
anything concrete.

Maybe if the block size is much smaller than PAGE_SIZE, but I am really not
sure.

Bear in mind though, I didn't change the logic here at all. I just reused one
variable instead of juggling both (block0 and block) old variables. So, if this
really can overflow, the code is already buggy even without my patch, I'm CC'ing
dhowells just in case.


> 
> > +
> > +	ret = bmap(inode, &block);
> > +	ASSERT(!ret);
> 
> I think we want some real error handling here instead of just an
> assert..

I left this ASSERT() here, to match the current logic. By now, the only error we
can get is -EINVAL, which basically says ->bmap() method does not exist, which
is basically what does happen today with:

ASSERT(inode->i_mapping->a_ops->bmap);


But I do agree, it will be better to provide some sort of error handling here,
maybe I should do something like:

ASSERT(ret == -EINVAL)

to keep the logic exactly the same and do not blow up in the future if/when we
expand possible error values from bmap()

What you think?

-- 
Carlos
