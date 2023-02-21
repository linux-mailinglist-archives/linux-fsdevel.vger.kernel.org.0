Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79D69EB8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 00:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBUX6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 18:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBUX6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:58:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3245D2CC45;
        Tue, 21 Feb 2023 15:58:37 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id pt11so7567613pjb.1;
        Tue, 21 Feb 2023 15:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxYAOATXwwZXmQtvACIiPy5oHqnMX7B0skEyunTy3sc=;
        b=krz8Bxnd4wTi4x00bBO2/hpMchfNH9zO6RksOyW+dvhOTP4LwgUeuf3wcCzBhNUoXv
         wX//Zkp2SgLgo7E1lg4+lbHLvCIW+dh5LMG57emv4k50kgBb+XjTnCOjNsqvarXLzxRK
         X0c8WhZ2llrIaWtbwiDSLZZ+rNvMt90REjZlOZMTWzmnt2VpyQ80ns+ZZNAj+sVcHDXo
         bivCzWv/gye/6++lIUXKbjMletWViBEdT9LC8uQoER4tdg8BOr4m72UmbF8Pt1NT6c09
         M86wNR3tDFHhGzTfJ+YyhCoAHi0JK7D63GKOpWnB84asedBh5JuUZU8eZC9gLYtRNRYG
         kVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxYAOATXwwZXmQtvACIiPy5oHqnMX7B0skEyunTy3sc=;
        b=gw45n+NYNASX/f8LmrHMJMLeYL/pFcN7MeIGt3GlggpgJWci1M51vmeXijewZripmL
         dzxqgEFfpfl5zAd8r2zfP/6s5covnRImDmt90ru6kOhoaLJG0V02HhjBbqj832JSjNhH
         VgnzvC6vTMv7aGqEey0Yx8GyiLM70orgnZGWpCccnr00DYceKl4VF/zcWW6m1XTKrzh/
         Zfbh5jACWAOJNE5CDcUrYK8Xe9tJqJDENeLcbAEGTVKGjDkC81c1qR+OmvC3LXnziSvm
         3KkaNMVTerPEWzvoYbDH9MxqMnU6T649PeRaNwwHYcYvUUzDEedXUyh5xcN87ShnzY+G
         1jAQ==
X-Gm-Message-State: AO0yUKXala1BIu1K4dqde91GWtadRkPMfdy9Xsso+CWxnlz/h7Q5a8bI
        Lydv/U404jnUFooCNhkfzyE=
X-Google-Smtp-Source: AK7set8mA8AovJsVEgiRILnqsy5kyIIpZuG+CasVxypbtihvOZT+c/1ugL7OC3W+zb8/8oWG2s3pAA==
X-Received: by 2002:a17:903:28c4:b0:19b:c3e:6e61 with SMTP id kv4-20020a17090328c400b0019b0c3e6e61mr7453237plb.68.1677023916448;
        Tue, 21 Feb 2023 15:58:36 -0800 (PST)
Received: from minwoo-desktop ([1.237.94.73])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00189ac5a2340sm6126741plx.124.2023.02.21.15.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 15:58:36 -0800 (PST)
Date:   Wed, 22 Feb 2023 08:58:28 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 2/8] block: Add copy offload support infrastructure
Message-ID: <Y/VapDeE98+A6/G2@minwoo-desktop>
References: <20230220105336.3810-1-nj.shetty@samsung.com>
 <CGME20230220105441epcas5p49ffde763aae06db301804175e85f9472@epcas5p4.samsung.com>
 <20230220105336.3810-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230220105336.3810-3-nj.shetty@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/*
> + * @bdev_in:	source block device
> + * @pos_in:	source offset
> + * @bdev_out:	destination block device
> + * @pos_out:	destination offset

@len is missing here.

> + * @end_io:	end_io function to be called on completion of copy operation,
> + *		for synchronous operation this should be NULL
> + * @private:	end_io function will be called with this private data, should be
> + *		NULL, if operation is synchronous in nature
> + * @gfp_mask:   memory allocation flags (for bio_alloc)
> + *
> + * Returns the length of bytes copied or a negative error value
> + *
> + * Description:
> + *	Copy source offset from source block device to destination block
> + *	device. length of a source range cannot be zero. Max total length of
> + *	copy is limited to MAX_COPY_TOTAL_LENGTH
> + */
> +int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
> +		      struct block_device *bdev_out, loff_t pos_out, size_t len,
> +		      cio_iodone_t end_io, void *private, gfp_t gfp_mask)
