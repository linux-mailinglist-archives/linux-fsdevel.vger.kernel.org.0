Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585165337C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 09:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiEYHtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 03:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbiEYHtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 03:49:45 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085A7A464;
        Wed, 25 May 2022 00:49:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w14so34631043lfl.13;
        Wed, 25 May 2022 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lt8k9K2KA1UoNzPTqNHW6qCt9JmIf/2CxYFA0xls5w=;
        b=CfVSjrQvck8vA31E2hsBpi6h670x34m7ft7yCObkg7qf7beHCrH3SGu6oHC997qOPu
         4mSXsXFxEQfD93KdNCo2jw9XKSzfdXOu8jClV5pqVLSwo+MioeJ4lB1EJtrEw6YMsYZf
         SS6OFE7MSVyagxIKABg1tmOiWKzyAxO1zvDaskeWjQmwlJilmB4TJFmOhmkKhAl8354K
         um+tTO+J31ehacSxb71M5XWP0v2Q0bi0dVURma+Bv4JcLlnz6TSQZSed84ERj4iQFzNl
         aHOpbUaivbWryKUd+DcIX6eImCVN9C/GHJgWVGk1g1pgk2DGAMjj8pE1sWHww/mpqUN9
         0zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lt8k9K2KA1UoNzPTqNHW6qCt9JmIf/2CxYFA0xls5w=;
        b=1oKzRWSp1N86uAYJgT9Sxu1Y7kTcL7WoJc2FRij3fZwLMfWVqE5EMV5N97iW8UARkG
         8KQi1VxxvJDCOfsndCzQsClhez5NbhROPt4LYLn38uHnmFSHz5UdzgqeCGgLXpzb3YCa
         TWUtw5YJ48cxaR74lSED7a0wGqjhPKpGuGZTltM37xqkGM15MIAVTkCsWD2bNzXKMHjq
         Y/ScDKfBgg5x7/Z/Ohy0KwWfMNvHw5SJEj3floyRzpPfZ08E+OhgpucJt2v+DL61jjtb
         V5DXnO0NTNqlRN4JgXdyyG+GVPXNmqaYhf3Acgjl0rMH7dBGhqp6cDCthLoQq3yjXffN
         6mDw==
X-Gm-Message-State: AOAM533WI0eaZidbYSW+xbCbPQBNToZIQN0ISWQ1kJLCVSXV/xOQjoHN
        PLwZPMeIXFHyeaZpjOoW4Kk=
X-Google-Smtp-Source: ABdhPJxA905EhstCxny+fZM9fEKL7H9BHS5faz6etePJul9Gm/eDBlyaZ94GS+SAE51ckRyHznRS1A==
X-Received: by 2002:a05:6512:3e26:b0:478:5972:54b7 with SMTP id i38-20020a0565123e2600b00478597254b7mr16559490lfv.646.1653464982986;
        Wed, 25 May 2022 00:49:42 -0700 (PDT)
Received: from localhost (87-49-45-243-mobile.dk.customer.tdc.net. [87.49.45.243])
        by smtp.gmail.com with ESMTPSA id f11-20020ac2532b000000b00477cae4880fsm2840295lfh.260.2022.05.25.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:49:42 -0700 (PDT)
Date:   Wed, 25 May 2022 09:49:41 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Message-ID: <20220525074941.2biavbbrjdjcnlsd@quentin>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-2-kbusch@fb.com>
 <20220524141754.msmt6s4spm4istsb@quentin>
 <Yoz7+O2CAQTNfvlV@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoz7+O2CAQTNfvlV@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 24, 2022 at 09:38:32AM -0600, Keith Busch wrote:
> On Tue, May 24, 2022 at 04:17:54PM +0200, Pankaj Raghav wrote:
> > On Mon, May 23, 2022 at 02:01:14PM -0700, Keith Busch wrote:
> > > -	if (WARN_ON_ONCE(!max_append_sectors))
> > > -		return 0;
> > I don't see this check in the append path. Should it be added in
> > bio_iov_add_zone_append_page() function?
> 
> I'm not sure this check makes a lot of sense. If it just returns 0 here, then
> won't that get bio_iov_iter_get_pages() stuck in an infinite loop? The bio
> isn't filling, the iov isn't advancing, and 0 indicates keep-going.
Yeah but if max_append_sectors is zero, then bio_add_hw_page() also
returns 0 as follows:
....
	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
		return 0;
....
With WARN_ON_ONCE, we at least get a warning message if it gets stuck in an
infinite loop because of max_append_sectors being zero right?

-- 
Pankaj Raghav
