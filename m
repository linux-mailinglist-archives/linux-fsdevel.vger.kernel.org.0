Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7976D4E2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjDCQks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDCQkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9324B1BEC;
        Mon,  3 Apr 2023 09:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17868621CA;
        Mon,  3 Apr 2023 16:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18A2C433D2;
        Mon,  3 Apr 2023 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680540045;
        bh=TcSh5Xer/g/90hgj1a2nC1kMu8egZgxSewoXwwQbyNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGK4Iuycn8/uKX4FlDut1UDgJOfU5jgsVPyaCg4mhj2Uec8k9KJdUdsJ0uT14vyYb
         adF4n9tsNFRz63Srz4pc1OGMYILi0Mq6wmWmebIv8YSp3T0+Phq59bVK6V9DO5V8PB
         tFECGKvy8sjGurTzpk5oHCgiXEOBkPiwsB8GOFMvKfxAXXN9R105Uk0hV2yAJHcOuN
         KSsvJUuNdZ+2FQ0MRThqQzl31Vq0NtbgXqfadQDl/SuxQjbyH/cZmdadO5QTPjbFVl
         oyGNDns77jEhKGV2XgXdU5ht14oi2KoPwsgEauQY8NBEHQ/mdtTVXtija34w6qS6GE
         yurD9ObU9sCgw==
Date:   Mon, 3 Apr 2023 18:40:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] fs/buffer: Remove redundant assignment to err
Message-ID: <20230403-mammogram-grudging-4aa3773a32af@brauner>
References: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
 <20230403161043.tecfvgmhacs4j3qp@quack3>
 <20230403163802.jvwnxg4wsa3n5fpg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403163802.jvwnxg4wsa3n5fpg@quack3>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 03, 2023 at 06:38:02PM +0200, Jan Kara wrote:
> On Mon 03-04-23 18:10:43, Jan Kara wrote:
> > On Thu 23-03-23 10:32:59, Jiapeng Chong wrote:
> > > Variable 'err' set but not used.
> > > 
> > > fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.
> > > 
> > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4589
> > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > 
> > I don't think the patch is quite correct (Christian, please drop it if I'm
> > correct). See below:
> 
> Ah, sorry. I had too old kernel accidentally checked out. The patch is fine
> with current upstream. Sorry for the noise!

No problem at all. I'm very happy that you took the time to review this.
This is very much needed!

Christian
