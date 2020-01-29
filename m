Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B897A14C8DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 11:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgA2Kks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 05:40:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42267 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgA2Kks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:40:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so6301904plk.9;
        Wed, 29 Jan 2020 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzRHTQO3pKjBfSJ2Rfvh5FEUg0GL15o7FlclGpgfTy8=;
        b=mXXPkK8PdQ2HdiEfv6/GdfMm2GHaXIbrDmZE6DD7Ikgky9gFKICmwUhAGVv62RvaGo
         0LvGo8bD2iL13nEuUbdsCGON79b56e0+xUNbWjsihsxRNealZEf4eLifUd+FdnG8xFEU
         SUx8GApPVHqVlym8IjGEYT0dVck16glEdhbRyhfeJwqSh3dYI3gjRSXSV82Bz8SoG7Ul
         DySpydLaiVdTS18v9FYxMhuNkyshDxDQi6NsoB3JiXQ5ItbffCpELITTXwAYvXHZIkjm
         ydLKgbfsJa8Zgr11su/bnscBM7IAWC6hA2ewzu51NYnSJRK44W9xTqA+Tu20YUu5M12M
         x5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzRHTQO3pKjBfSJ2Rfvh5FEUg0GL15o7FlclGpgfTy8=;
        b=mmYeTx52qorRCgXizrGQ8th1FX+zfOwAJQWbe3JfZD593LipEEDqUCSBHK6YbSf5LW
         hdDEudhw3Jj/kI0KIq+MpoFY6pNWJ8kFTAUGtOv3Uv54WKLOiNL1/Kk6Rugwely/n5eW
         oiH6IeVweRyoUE7V56Im6Ov9gy4kPHqNtY6J8ZJoRR80PFoRDemYxEyb2XXUzsdo4kZQ
         aRbtGfhSu3O17mSyjqh8TApZOOeMT9jeRf89VK8GxhHZF6l9bcfFldQtPg2IU10gQNXR
         eu+ldLSoq0ueD8QmULX7Ji3fkwhDnoivlcldlOS8s3NMdGodfR54KcYr7L/2TJhqzT0v
         WukA==
X-Gm-Message-State: APjAAAWJNLTiKh1iYp9AKjjASHRAc4xA+Tlam7PMkXmhcCzesI1UvCvc
        OrP4hIpRRsu7C1sukvK2hu4=
X-Google-Smtp-Source: APXvYqwyd5UBrtC57QGpd9Ru9Ha2G15gvVk/UC14vHvGCkou957aoLuYoIipivd+xRp9PllidBEvXQ==
X-Received: by 2002:a17:90a:2545:: with SMTP id j63mr10615588pje.128.1580294447327;
        Wed, 29 Jan 2020 02:40:47 -0800 (PST)
Received: from pragat-GL553VD ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.googlemail.com with ESMTPSA id h3sm2319678pfr.15.2020.01.29.02.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 02:40:46 -0800 (PST)
Message-ID: <287916429826dd2f14d82f9b7b6b15a9cace2734.camel@gmail.com>
Subject: Re: [PATCH 09/22] staging: exfat: Rename variable "Size" to "size"
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 29 Jan 2020 16:10:39 +0530
In-Reply-To: <20200127115741.GA1847@kadam>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
         <20200127101343.20415-10-pragat.pandya@gmail.com>
         <20200127115741.GA1847@kadam>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-01-27 at 14:57 +0300, Dan Carpenter wrote:
> On Mon, Jan 27, 2020 at 03:43:30PM +0530, Pragat Pandya wrote:
> > Change all the occurences of "Size" to "size" in exfat.
> > 
> > Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> > ---
> >  drivers/staging/exfat/exfat.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/exfat/exfat.h
> > b/drivers/staging/exfat/exfat.h
> > index 52f314d50b91..a228350acdb4 100644
> > --- a/drivers/staging/exfat/exfat.h
> > +++ b/drivers/staging/exfat/exfat.h
> > @@ -233,7 +233,7 @@ struct date_time_t {
> >  
> >  struct part_info_t {
> >  	u32      offset;    /* start sector number of the partition */
> > -	u32      Size;      /* in sectors */
> > +	u32      size;      /* in sectors */
> >  };
> 
> We just renamed all the struct members of this without changing any
> users.  Which suggests that this is unused and can be deleted.
> 
> regards,
> dan carpenter
> 
Can I just drop this commit from this patchset and do a separate patch
to remove the unused structure?

regards,
pragat pandya

