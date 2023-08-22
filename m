Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76D7783A9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjHVHMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 03:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjHVHMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76117CFF;
        Tue, 22 Aug 2023 00:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CD9B64DAC;
        Tue, 22 Aug 2023 07:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099ABC433BD;
        Tue, 22 Aug 2023 07:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692688271;
        bh=YTKKyNGQ+Tv8wDS6XyoyNckBezSPa1ShICIvZHky2JA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NT+zgFsl55tylkic31ue3bL3wmFJmEAHoKnIxjlc8h+pAm8FOYbOIuVtaDnwrvOHB
         EKbfxjWpieN2QwlozxINNa9MhVPPe9Yj8E33z6fxy4JZpgri6qA18UCg0pIz1ABj2Z
         f+uUyN+GpTByCcPJTIJsWmh40YgS/Ic4rTkPXRMc=
Date:   Tue, 22 Aug 2023 09:08:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5.4 0/1] mm: allow a controlled amount of unfairness in
 the page lock
Message-ID: <2023082248-parting-backed-2ab0@gregkh>
References: <20230821222547.483583-1-saeed.mirzamohammadi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821222547.483583-1-saeed.mirzamohammadi@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 03:25:45PM -0700, Saeed Mirzamohammadi wrote:
> We observed a 35% of regression running phoronix pts/ramspeed and also 16%
> with unixbench. Regression is caused by the following commit:
> dd0f194cfeb5 | mm: rewrite wait_on_page_bit_common() logic

That is not a valid git id in Linus's or in the linux-stable repo that I
can see.  Are you sure that it is correct?

thanks,

greg k-h
