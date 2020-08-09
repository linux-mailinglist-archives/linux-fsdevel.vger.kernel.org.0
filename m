Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398B323FC35
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Aug 2020 04:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgHICkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 22:40:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49881 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726058AbgHICkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 22:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596940820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ZWmNdmE9mXz97K5KedK2xTYBcMa+8BCG/iCLTDYqd8=;
        b=W0fQ0Mla4rwuXSOfnHd2FoRFoM7MTQspVotuuLTNWIfbLJNANVn/V8FvzH8urwSqnGKKu6
        TmNk5ZTbWFaKUMFpVpLlKk7EGxd0gRg7WUnvWHsRzNWLeJunqHXPcl5JPt8VOWvTT/NIux
        zzArmnnKLUWCIVH+WsgdpoVdzkc6DyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-ZN91v3kLN4eIyNUc3Cyx1A-1; Sat, 08 Aug 2020 22:40:18 -0400
X-MC-Unique: ZN91v3kLN4eIyNUc3Cyx1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22B9459;
        Sun,  9 Aug 2020 02:40:17 +0000 (UTC)
Received: from T590 (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F67E2C26B;
        Sun,  9 Aug 2020 02:40:10 +0000 (UTC)
Date:   Sun, 9 Aug 2020 10:40:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Very slow qemu device access
Message-ID: <20200809024005.GC2134904@T590>
References: <20200807174416.GF17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807174416.GF17456@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew,

On Fri, Aug 07, 2020 at 06:44:16PM +0100, Matthew Wilcox wrote:
> 
> Everything starts going very slowly after this commit:
> 
> commit 37f4a24c2469a10a4c16c641671bd766e276cf9f (refs/bisect/bad)
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Tue Jun 30 22:03:57 2020 +0800
> 
>     blk-mq: centralise related handling into blk_mq_get_driver_tag

Yeah, the above is one known bad commit, which is reverted in
4e2f62e566b5 ("Revert "blk-mq: put driver tag when this request is completed")

Finally the fixed patch of 'blk-mq: centralise related handling into blk_mq_get_driver_tag'
is merged as 568f27006577 ("blk-mq: centralise related handling into blk_mq_get_driver_tag").

So please test either 4e2f62e566b5 or 568f27006577 and see if there is
such issue.


Thanks,
Ming

