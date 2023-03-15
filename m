Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D6E6BB3FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 14:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjCONKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCONKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:10:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CF45D442
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 06:10:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j13so3012281pjd.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678885850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iM7UqGaYvm7BzQmjPzFTbD+VCi1s05wVU7R+PFPtIQ=;
        b=d2XRh/0jnDbb8BJSVteBA7TvOKV8xbk6pdCqTOQcoOrShowab5iwHiCFFnz0/Pshsz
         vS5a48SIWacvJ8o9s8pgarz8rU7Nk6EQDTx80rj/4iNeASMVgpVtyCttdLykp0wEcbMO
         9ZpYnG0Kd3+JCmpIYNaYbqk+Ms4jtktRfLBDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678885850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iM7UqGaYvm7BzQmjPzFTbD+VCi1s05wVU7R+PFPtIQ=;
        b=MCbAOipT8eZDoM6ElBvFDzsHK4i/eRRva49E+rhMuFLE7v/jHpII5WV5jp8lNFYNjb
         hB6/mwijEEA43OcM1IFh+cZUGZgXmmLO1qBQNxF4c9rCfm5J2YYsg/x5Bzz7p1+8HsxG
         4vhEGNhHv1Mm0kOGvtRNFSBix1H6SYXcD0/FE1MzLjkTy8AFCpmro4ch7A62bljlLDlv
         EWw8ACpMhsQP0Q9ze7Gs5MXw08AlfrlRw861KgUaBhwdb8ZS7WUtvCn3Nxv4usRPRr+f
         vOC4U6kSFP8NmRppBqejtRYaiqEvGWXkQ7xZcUHy5+1qd6vCjXf5TnwrRd9bbRBKXgnQ
         QMzg==
X-Gm-Message-State: AO0yUKXcQ0RqlOo28BuZeXktXLeA+5pXjs6/iXBKqzpodU/uBpvZYMjM
        Nliov1U+QLcMqIwDZyNh9EDw+Q==
X-Google-Smtp-Source: AK7set9dN3OnjgQ1zJzmAaDS5Ava8qB+TCv5SKJAmAnQ8LoY5y/PvI+b/14sPf9bRAqmxxxgI5nUMw==
X-Received: by 2002:a17:902:e5d0:b0:19e:29bd:8411 with SMTP id u16-20020a170902e5d000b0019e29bd8411mr2794015plf.30.1678885850225;
        Wed, 15 Mar 2023 06:10:50 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902854a00b001a05bc70e97sm3574903plo.189.2023.03.15.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:10:49 -0700 (PDT)
Date:   Wed, 15 Mar 2023 22:10:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: Re: [linus:master] [mpage] 7d28631786: fio.write_iops 27.8%
 improvement
Message-ID: <20230315131043.GA1927891@google.com>
References: <202303101630.ef282023-yujie.liu@intel.com>
 <20230315075816.GA32694@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315075816.GA32694@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (23/03/15 08:58), Christoph Hellwig wrote:
> 
> I think this simply accounts for the I/Os now that were skipped
> when using the bdev_read/write path before.

Oh, that would explain it. Otherwise I was slightly surprised (in a good
way) and puzzled.
