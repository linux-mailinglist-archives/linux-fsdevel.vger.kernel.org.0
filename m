Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE47B59E9F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiHWRlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiHWRkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:40:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB3E96774;
        Tue, 23 Aug 2022 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LVn3okWCPixSaF/sLJscnWdb4hR5AjxVtymdhuNXQZE=; b=MAuankf2Ata/zK+W3LJw0BlGjh
        tk3HkSzIzMe7tBq1t11agUkUEIfUKI5PPCbJvsu34JWWksYpdhvN9IAeayAu1yQr6/oCh+ZeOh1xM
        uA8t3EBy3gFw2R4kITE9yn2bYl5bnG2d8MartTEVeRwgiTHw7aiiN/1iBgLHRlkJ+lmHOIz9C9H2y
        CToXqHV5UadCOkF3Kt5CqOZfAGGtj8GluEifrvUs8S4phZEZkabRInosWxJPUeAtdoKaGlwrFp+pf
        smBsBoRsTA50e515p74CqZBexyNHrJVSioflqm5g2eh9EVmaHOdnSJXrlFvgcDBcnmEvuwCs2BBeD
        4shBS68Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQVpr-00FOSe-Km; Tue, 23 Aug 2022 15:28:59 +0000
Date:   Tue, 23 Aug 2022 16:28:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     david@fromorbit.com, djwong@kernel.org, fgheet255t@gmail.com,
        hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in iomap_iter
Message-ID: <YwTyO0yZmUT1MVZW@casper.infradead.org>
References: <182c6137693.20a934d213186.5712495322312393662@siddh.me>
 <20220823152101.165538-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823152101.165538-1-code@siddh.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 08:51:01PM +0530, Siddh Raman Pant wrote:
> +	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0 || lo->lo_flags < 0)

The lo_flags check is still there?

> +		return -EOVERFLOW;
> +
>  	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
>  	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
>  	lo->lo_flags = info->lo_flags;
> -- 
> 2.35.1
> 
> 
