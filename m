Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1275A625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 08:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGTGQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 02:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGTGQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:16:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8513C1734;
        Wed, 19 Jul 2023 23:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=11xMnwQRwvXHQT5a/YEI+VXa6HL9U2T3MXAdwDg1m5U=; b=hHFssfszejeHiVIAZ0Ab+bcULg
        kEmmb3iv1Q5fiKeZIxK9g7yIe65iGCmaTZZVNVsH9Pd1eSlT+fZSuUxdULBY8MYG3vBYWtEeuX9QW
        FSgz2zjuHz9r9QQMAhWtZqnpp+QUEodjoOP+3SIVpQCvlZhKqh+6f8lVNnIV21yOvkVhTQF0CohzC
        OT/tP2MTnXXP/6EkTAgcjqyPCWn6352KlJBkED4haprYzZdJxYZ6UU1OrPRXIwuF/pry0MSp0T+Fs
        pCCnCCRhOLIGcPal1Nx6H+5p0NqXv9zq81y5Qk0zcfE87sqhIdgGNNmXD0XAjvdWfmLfV+Ooko1jf
        6kJBqFLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMMxr-009ulL-04;
        Thu, 20 Jul 2023 06:16:39 +0000
Date:   Wed, 19 Jul 2023 23:16:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org,
        jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
Message-ID: <ZLjRR0xJZUWXXRf/@infradead.org>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
 <822909b0-abd6-4e85-b739-41f8efa6feff@t-8ch.de>
 <6168e4d5-efc3-0c84-66c7-aea460c9fcaa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6168e4d5-efc3-0c84-66c7-aea460c9fcaa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:53:54AM +0200, Sergei Shtepa wrote:
> > Seems a bit weird to have a signed error code that is always negative.
> > Couldn't this be an unsigned number or directly return the error from
> > the ioctl() itself?
> 
> Yes, it's a good idea to pass the error code as an unsigned value.
> And this positive value can be passed in case of successful execution
> of ioctl(), but I would not like to put different error signs in one value.

Linux tends to use negative error values in basically all interfaces.
I think it will be less confusing to stick to that.

