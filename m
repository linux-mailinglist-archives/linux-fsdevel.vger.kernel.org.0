Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE885798441
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 10:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjIHIkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjIHIkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:40:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C11BEA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yVA95xW2Ie/ug2jQfFDc5ddfNVZM0aNIhd4I9iNmjSo=; b=Yy/12rCry74UVbjrJyam9lO4L9
        /3xDzBZnBjVcO2a1dg+qggwHeku+bmBsBw7Zo8RIaKDAkzZBAVdKvjlC+J2hyYUuImIMqZjujb0Ae
        NqnVXvCFBQefMufRawRd7XirecFiSioP0nWEWKo8Wh82SfDxULlJ7zsDw8+15KeUUhrUlpsGsizYH
        vl1VBz2Cd+EZGxco8FjIVfrXie4nyBYdC1W4JrqSQfL7TSQWY2+370K+qdzH+JIl7HfUPbX0U2l9+
        F36R5VWn12WhvBEdPEeFJ4cYfEFIgCTXnRPBwkpKpEPlPZDRcKyunuYaD3r14D7oiGCob2GDzXJJQ
        iezPy3Qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qeX1r-00DKhb-09;
        Fri, 08 Sep 2023 08:39:51 +0000
Date:   Fri, 8 Sep 2023 01:39:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPrd1yAVdm9Yjw9B@infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906215327.18a45c89@gandalf.local.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:53:27PM -0400, Steven Rostedt wrote:
> Anyway, what about just having read-only be the minimum for supporting a
> file system? We can say "sorry, due to no one maintaining this file system,
> we will no longer allow write access." But I'm guessing that just
> supporting reading an old file system is much easier than modifying one
> (wasn't that what we did with NTFS for the longest time?)

read-only is just as annoying, because all our normal test infrastruture
doesn't work for that at all.  So you'd need not only a test harness
for that, but also a lot of publically shared images and/or a tool
to generate filled images.
