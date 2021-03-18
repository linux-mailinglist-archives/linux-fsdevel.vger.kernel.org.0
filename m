Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401B034114A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 00:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhCRX4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 19:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhCRX4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:56:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9041AC06174A;
        Thu, 18 Mar 2021 16:56:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g1so2094254plg.7;
        Thu, 18 Mar 2021 16:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T8YZFchahOt8+lJkHV/2xE+bNUKy8Aar3tpIvxe8Zmw=;
        b=MZyWIfRoYimVsnLxjnaG0IczdCG4R6V0S3hEk7xv8SPfeA4SZzJUVVRTpzyKWoSqaX
         eOg4KdljTpSgotTfEKB/4XwoXDI1oTZsmHEzCGVV1k3QEQFed0z24iuMM7TgCVnykONU
         E5scjxblZxPCbbo4l3aqZRivEuiwGQ3MWovJwO5U4tXBMFZj890qJ85xuxrmKeQqKaMX
         oJ63M+qdpa9N1rbm//YGatO6f11sa6717sJOJ9aZh6x84McdrPHJWmWTL0IXe3Git5/1
         Yz3ZHg565Y5s198rBwnDh4mMgYbPFq7e6cfgB7R7hGS2+n4p8Auwxm8Q2fSPOJL14VHB
         Gd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T8YZFchahOt8+lJkHV/2xE+bNUKy8Aar3tpIvxe8Zmw=;
        b=jz2f0N/o5QvuwZBAUFhpOAJGCTp7XFPKYq7b9aS/M4gJyKEV5ocgnHGMDDPy4rhopz
         zYr4927zYF7LrmY+80F/6naZoMv7Fdsmwd5rjlfI8OTJj/0SqkmS5vdOiXsdM55ZGQjS
         5fYGppDAM1x+HNKlR7ulIDb6MANSBUfWapeq0aUMPtikZSQ0GNo2SOtLrPXCeHHmBV2O
         FanSJdXrM6XAVj6uGkH/W16vh8tumqWn6j5w7VcQPur13Bl4dCXY9lwvTLv1nxk1sL+S
         Hto/DE/6V84Uby8Bn/smbbmkrW9vidjfqFxcOxjjF1/14svydbtK6oW9okkGb6VUGv0v
         5asA==
X-Gm-Message-State: AOAM531PygJ9gTMpngqwSTBBJg0ozBTFH3LARIhxRKw2w4AaGFRMEZEw
        zklR0HIefyIzpxE9XwF0K2Dm4ScQNFIN2Q==
X-Google-Smtp-Source: ABdhPJwKV/OCljF4pyv5z34SR5T42nAW11FJZei/P3z0qiI7W0gc8dBaLEgmt4fbLC9Zsk1LwGjA+A==
X-Received: by 2002:a17:903:2286:b029:e6:6499:8c2d with SMTP id b6-20020a1709032286b02900e664998c2dmr11726647plh.17.1616111810951;
        Thu, 18 Mar 2021 16:56:50 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id g2sm3338277pfi.28.2021.03.18.16.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 16:56:48 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:56:45 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/25] mm: Introduce struct folio
Message-ID: <20210318235645.GB3346@balbir-desktop>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:18:37AM +0000, Matthew Wilcox (Oracle) wrote:
> A struct folio refers to an entire (possibly compound) page.  A function
> which takes a struct folio argument declares that it will operate on the
> entire compound page, not just PAGE_SIZE bytes.  In return, the caller
> guarantees that the pointer it is passing does not point to a tail page.
>

Is this a part of a larger use case or general cleanup/refactor where
the split between page and folio simplify programming?

Balbir Singh.

 
