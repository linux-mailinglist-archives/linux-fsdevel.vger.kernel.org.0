Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB44C4364A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJUOtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUOtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:49:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928AC0613B9;
        Thu, 21 Oct 2021 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+8n4cpY5LuFlx85ZjXXbllJghKIUwt7Uc6uXkpKGh8Q=; b=U+I20vSWI85htnedCO/8fM86d5
        AE39SBJduLpbQEUmK7Kf7DFivvK5g+8Db/9dgI3aAAGbiIoimu41Nc9DXeA+7MqTyl7OB3Ii7I8vD
        JVRjOo7to4CwyjgalqQ1XFcQc0Lx6oEYnDxgPlfItajvTLr2KvJ/bbN+uTavflaH3M6Uqa4GSjoId
        w5yTv3CNv0pp6SW9BXOGyx+OkozfPPRmKEKSUYv5IKCo5Gc0H+uXjANmd78+jRaTvxaot4gzgi2cy
        ttbtA/NRMjTI/wKekazV3ggnD9kYifscDcHyRz1uL56J2bn6MYO0b222EU3KpR06BktKIBov9IDfb
        zmbP9ruw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdZLR-007tV6-44; Thu, 21 Oct 2021 14:47:01 +0000
Date:   Thu, 21 Oct 2021 07:47:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments
 with a single argument
Message-ID: <YXF9ZQcrfTnWix2j@infradead.org>
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org>
 <YXFHgy85MpdHpHBE@infradead.org>
 <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
 <YXF8X3RgRfZpL3Cb@infradead.org>
 <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 08:44:16AM -0600, Jens Axboe wrote:
> On 10/21/21 8:42 AM, Christoph Hellwig wrote:
> > On Thu, Oct 21, 2021 at 08:34:38AM -0600, Jens Axboe wrote:
> >> Incremental, are you happy with that comment?
> > 
> > Looks fine to me.
> 
> OK good, can I add your ack/review? I can send out a v3 if needed, but
> seems a bit pointless for that small change.

Reviewed-by: Christoph Hellwig <hch@lst.de>
