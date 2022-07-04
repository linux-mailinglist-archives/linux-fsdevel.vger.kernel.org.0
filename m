Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCC856503B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 11:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiGDJBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 05:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGDJBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:01:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716210E5;
        Mon,  4 Jul 2022 02:01:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s206so8383922pgs.3;
        Mon, 04 Jul 2022 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gff4bRc9l1CM3lMZz7jp+pp69/SmZ01DbDZ8owZYVXs=;
        b=AEHQkcXyKk//5++zVgOF3Y6WkdbYVotRWbOu2uonuIHG/djjFcJ/ndGd7mOzEiFrOs
         ordb1Ys6ogLsL8mOdmxu7YWqrXhCoUaCq1yu/7ihK867l1UABDFCYC6izb3MRWtheeJu
         IhBAucOBBZPEndboRb7slMO4LUPjjNfumlgghsXZJlAggUPne1GNt5BVDowa89BHmBV6
         D2D+6bdL7QXk/14d+eAwNpy/FaeXtqM0sttDDskgKDUGMFp957TFarllV6S1uk1LQlSX
         51tcufPNakfS83Z8lnDKsuET5w5uV8HHYDjVWXrT3MVnYLpTn491HeTjAVK8uGvyWqSi
         qo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gff4bRc9l1CM3lMZz7jp+pp69/SmZ01DbDZ8owZYVXs=;
        b=i0xJR3Pswo0B8OxA9nhsfNlNo8qMm86bnadL+RresCN6UlGsiuM6/SdKWzEvDnWoBD
         JLyZ0ryr+Sh0WaTCIqkehGKbu/xAYJxxdvt+QwBhaCXqKfhgrfmu0PuLerk5cZUkTD0b
         dY2vOzGl2fe0uvPDZlbBAs0iJ/01cxr25GSRWUvVDQPfc+ePwIro4OHoMU6C+nx2QGXa
         3QFteQ6MP4Y7t+K4WrkXCmcT3WcuJlZiQjQPiFbg2YqcN7++1ew05EF5IACfmrAlT65V
         d5MiYvAmek/iBgI/kAkJmP/pxQuhHkb/X4ZIpIIzGeCi2UehTe3q8V9rj8/mIFaOaNep
         0CFw==
X-Gm-Message-State: AJIora+kRkKcAxAT6vQdSV4v0bGB3ErHGI2UFa+kmSEryO+NQ2d/sCqe
        muJqZQQ/ylFby+CJWB2wfCyY2bnKlcA=
X-Google-Smtp-Source: AGRyM1sbBRIAhJuyEq51QH8QR6b58C71X/nJEKB2rkbi/zD/yuvR40wM1RL92y7YPa6JL9EQRSkl/Q==
X-Received: by 2002:a65:6a4f:0:b0:3fe:9ef:1c49 with SMTP id o15-20020a656a4f000000b003fe09ef1c49mr24383975pgu.229.1656925310171;
        Mon, 04 Jul 2022 02:01:50 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ef7eb39be1sm3135872pjo.55.2022.07.04.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:01:49 -0700 (PDT)
Date:   Mon, 4 Jul 2022 14:31:44 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 1/3] jbd2: Drop useless return value of submit_bh
Message-ID: <20220704090144.hdj3fpaaqyj35yt3@riteshh-domain>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
 <YrEhXYBeQz8kNuGo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrEhXYBeQz8kNuGo@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/06/21 02:39AM, Matthew Wilcox wrote:
> On Mon, Jun 20, 2022 at 11:28:40AM +0530, Ritesh Harjani wrote:
> > @@ -1636,14 +1636,12 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
> >  		sb->s_checksum = jbd2_superblock_csum(journal, sb);
> >  	get_bh(bh);
> >  	bh->b_end_io = end_buffer_write_sync;
> > -	ret = submit_bh(REQ_OP_WRITE, write_flags, bh);
> > +	submit_bh(REQ_OP_WRITE, write_flags, bh);
> >  	wait_on_buffer(bh);
> >  	if (buffer_write_io_error(bh)) {
> >  		clear_buffer_write_io_error(bh);
> >  		set_buffer_uptodate(bh);
> >  		ret = -EIO;
> > -	}
> > -	if (ret) {
> >  		printk(KERN_ERR "JBD2: Error %d detected when updating "
> >  		       "journal superblock for %s.\n", ret,
> >  		       journal->j_devname);
>
> Maybe rephrase the error message?  And join it together to match the
> current preferred style.
>
> 		printk(KERN_ERR "JBD2: I/O error when updating journal superblock for %s.\n",
> 				journal->j_devname);

Sure, I will update the printk message like above and send out a v3
(since I haven't receieved any other comments so I think v3 should be good to be
picked up now)

-ritesh

