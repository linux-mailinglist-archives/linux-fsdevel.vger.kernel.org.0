Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5B5788F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiGRRzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 13:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGRRzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:55:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD861183D;
        Mon, 18 Jul 2022 10:55:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k19so9708206pll.5;
        Mon, 18 Jul 2022 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=goGeGWfSudpBrURR0rpx5qnIWVMo9CXFrKo1cxYRTwM=;
        b=U5u4w3HozoNCJA9Vzv6SU9xg/nViurNu9lWdL/qQ6porl//Mq8g4ZkPchQ+Mc3l3M0
         /DZP5duAJeiZwjxwZ3KFQ1sj7BE4FLuXldGAyfmpurKV6TS7iUfXl6Ipxtm+5MOOLuS9
         DcffbLdwtZy4/K9q9Otg1ofGVE0oghog5pzORx96vxaoQpZFVugHvQOaYr17o8NHVtsL
         3gjdIXW0ErN10RCqUD9/PeZWKhZdQfjSJ2wXPjMwvelVLlSwfEHdntBgdVVoSwj0rkdG
         zwuzRN5Og76DH0J4HChoEtlW28aJSuRN8x420tFI+dEqQtJ7OuvvhOS5fiijL/uDPvnF
         36uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=goGeGWfSudpBrURR0rpx5qnIWVMo9CXFrKo1cxYRTwM=;
        b=S+XMeQpdSLgfnm111V/0nBzT46Qts+SE/61jJ0nop5cLfz58xdFKFdr6ZqCrf1s+UV
         /6AyE+qRgJ6jIYmBSlXPNYiyIwVAmGLqqZ824GQ4kRLntfjT74NGS4K49OP/JCdSwi3E
         6MfQKRy31GabZagFbkY3CiETi8xSt4FRYxdBCEpIgDb1tDqE0aSoHoNEGVbsp0R4rlhG
         h5E13jse9c1KLTwn2qal/BwdYeCZ0ZezNbuCCItvr69gqZ6IvOWy35Tixzxo4F5pk2de
         w4c7UVb/qkFKj9wVjbQkJAk2Rb0tKx5YhdgJ3nVhdYxcBQqOIIqI8rehukuUlmxoaXsd
         0jkQ==
X-Gm-Message-State: AJIora8If8Bl4iRaVq2OYHgGkys1i/16U6nrmpGw8RMgEN2bvxMYw5OD
        3qODwJJPUZXPwD3KKzeG6qMUm95MJ0s=
X-Google-Smtp-Source: AGRyM1sGOx+g+21IMVPhM4xSD1tVpNoM9u6DHJ+19lkbvv9da0F3512R1O0iV4jf9X03qQmgVcU64g==
X-Received: by 2002:a17:902:f683:b0:16c:3752:e332 with SMTP id l3-20020a170902f68300b0016c3752e332mr29124627plg.18.1658166952485;
        Mon, 18 Jul 2022 10:55:52 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709027fc900b0016bf4428586sm9769871plb.208.2022.07.18.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 10:55:52 -0700 (PDT)
Date:   Mon, 18 Jul 2022 23:25:46 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 1/3] jbd2: Drop useless return value of submit_bh
Message-ID: <20220718175546.zqrtnsuf72dgpexn@riteshh-domain>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
 <YrEhXYBeQz8kNuGo@casper.infradead.org>
 <20220704090144.hdj3fpaaqyj35yt3@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704090144.hdj3fpaaqyj35yt3@riteshh-domain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/07/04 02:31PM, Ritesh Harjani wrote:
> On 22/06/21 02:39AM, Matthew Wilcox wrote:
> > On Mon, Jun 20, 2022 at 11:28:40AM +0530, Ritesh Harjani wrote:
> > > @@ -1636,14 +1636,12 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
> > >  		sb->s_checksum = jbd2_superblock_csum(journal, sb);
> > >  	get_bh(bh);
> > >  	bh->b_end_io = end_buffer_write_sync;
> > > -	ret = submit_bh(REQ_OP_WRITE, write_flags, bh);
> > > +	submit_bh(REQ_OP_WRITE, write_flags, bh);
> > >  	wait_on_buffer(bh);
> > >  	if (buffer_write_io_error(bh)) {
> > >  		clear_buffer_write_io_error(bh);
> > >  		set_buffer_uptodate(bh);
> > >  		ret = -EIO;
> > > -	}
> > > -	if (ret) {
> > >  		printk(KERN_ERR "JBD2: Error %d detected when updating "
> > >  		       "journal superblock for %s.\n", ret,
> > >  		       journal->j_devname);
> >
> > Maybe rephrase the error message?  And join it together to match the
> > current preferred style.
> >
> > 		printk(KERN_ERR "JBD2: I/O error when updating journal superblock for %s.\n",
> > 				journal->j_devname);
>
> Sure, I will update the printk message like above and send out a v3
> (since I haven't receieved any other comments so I think v3 should be good to be
> picked up now)


We were planning to send this patch series via ext4 tree.
But it seems this might conflict with the below mentioned patches sitting in
linux-next. So let me rebase my patches on top of these and maybe hold to this
series until the current set of changes land in linux tree to avoid any merge
conflicts later.
But either ways do let me know if you would like to take any other preferred
route. Since this is not critical, so I am fine with either ways you suggest.


-ritesh

author Bart Van Assche <bvanassche@acm.org> Thu Jul 14 11:07:13 2022 -0700

fs/buffer: Combine two submit_bh() and ll_rw_block() arguments

Both submit_bh() and ll_rw_block() accept a request operation type and
request flags as their first two arguments. Micro-optimize these two
functions by combining these first two arguments into a single argument.
This patch does not change the behavior of any of the modified code.
