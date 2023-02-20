Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2669D5C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 22:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjBTVZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 16:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjBTVZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:25:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1581E9DF
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 13:25:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id l15so4035576pls.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QESLl69yTFuw/UHokvPcBCupvaRLpWJFOxU9lYfGwWo=;
        b=N5kDy3DCypsUjNTIL6uKqPnIi4VuPmqW/5tC0XFeR4brBKCtKvN+UyuKUVGmY06M0r
         sqU4mlP5niEuq7PrXx4wZlFEqrMe/1cE7qvgAttb/jZOt6T6Egg+dd5TkiAeo1q3igMx
         woZqabfyycCzfKIe/OhmkQwObwKvDhvIXyYKUmG5xYEwZbx4LydK6tsL5DkHVdGaQPz+
         UGFB1y7LLPxMky0ZXcdRcqO+b/sepsCmbJ53Ch2qjYGFnID2tPRxSkN3Zh/KKk/yL8wh
         vSrFRSU0KA0AVOYVMpFoth6W5HDuoBsUQ3CGaOipNmKzGGSydVezHT3ZivmEpURxhaKy
         Tkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QESLl69yTFuw/UHokvPcBCupvaRLpWJFOxU9lYfGwWo=;
        b=nNhb8cGCuGAOcEvmHf/PR6Ptzx88Gs7P8xJ4wJWx5X2S//uhSn7CEvcTxsjUbAa+Yu
         SZvhSVO+WeFp0nWpeAZfYpXFMkULMtotXKcTel8kNmMwjciqqlzaS834cwk73+5K7WqU
         JWNDDOkPORdslVTG5NTL+Ci96kKLgJDZmvKZkKuDlcnxbvcbqvqYybccN2kX/DuqSry+
         jsm2fn9GypRXclqWe+ygTz/6yD6w0Bn17RRDdnn+knCeV0lIzumf4m5UCyfL1OHnuMCp
         11agT9lQHgs8VEQhD3XmmgyFIjDkMi0SE5JJlNCZy8+10s1N1VClPEAyVxV+SOQadviZ
         HvVQ==
X-Gm-Message-State: AO0yUKUlhDhpdvWgXXJdThQGncIRZZtjTyWJ1MpOL0sn3TMMGKKqmHH9
        xWMZjDh2T9uBj6CrCjxOnR8xkQ==
X-Google-Smtp-Source: AK7set/7p/rU3G5m3+Tu0pQdEIVeL6cGQ6eHnMmFlnj9qkTBEkSagKYJEBYzfb8nFNFw6MFe34UtYQ==
X-Received: by 2002:a17:903:234b:b0:196:595b:2580 with SMTP id c11-20020a170903234b00b00196595b2580mr2854902plh.0.1676928310567;
        Mon, 20 Feb 2023 13:25:10 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902748800b0019a7c890c61sm8337880pll.252.2023.02.20.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 13:25:09 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pUDek-0007sH-Ij; Tue, 21 Feb 2023 08:25:06 +1100
Date:   Tue, 21 Feb 2023 08:25:06 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        djwong@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        jane.chu@oracle.com, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v10 2/3] fs: introduce super_drop_pagecache()
Message-ID: <20230220212506.GS360264@dread.disaster.area>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1676645312-13-3-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676645312-13-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:48:31PM +0000, Shiyang Ruan wrote:
> xfs_notify_failure.c requires a method to invalidate all dax mappings.
> drop_pagecache_sb() can do this but it is a static function and only
> build with CONFIG_SYSCTL.  Now, move its implementation into super.c and
> call it super_drop_pagecache().  Use its second argument as invalidator
> so that we can choose which invalidate method to use.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

I got no repsonse last time, so I'll just post a link to the
concerns I stated about this:

https://lore.kernel.org/linux-xfs/20230205215000.GT360264@dread.disaster.area/

-Dave.
-- 
Dave Chinner
david@fromorbit.com
