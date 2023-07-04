Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0352746BA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGDIOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 04:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGDIOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA1BD
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 01:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49DAB61143
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 08:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ADFC433C7;
        Tue,  4 Jul 2023 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688458492;
        bh=1AP8B2ZQzGMZg+Ywsd+r2OQCmBZN+CrbD4CqHg/wQRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xu41iHBi+Amz7RAYNVF1ScGVLDYhdrSuyRDjK/6cUD7KNq011TzcQeaBJlNLqHmko
         Qcxy8/3LOnoBzKbwCDWB3HZ/CbjPlf3IEExVsMYbHTWlpZPaCo+pZ8eDU4Ww+S3c+c
         P2uiRYgfv4VGNONOJgeG+r46KsudEBp9kSVXNb/ZKr+oYUSNPjNTkmaFEEl7THXB9F
         WKNQpwQaXSugfgpY03EzW1jPkGupcWePji1CCXR/gEdXRONuaIzZPmW2ywyV+EQxOg
         5hzdyvzLGDTaGvs+ULyRpL9mJELhDkEKnsYjVUoEHSEDt1mrZdDEvJXLoJPjHxNU2K
         hpFny8DgUoPVA==
Date:   Tue, 4 Jul 2023 10:14:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 0/2] fs: rename follow-up fixes
Message-ID: <20230704-dankbar-zweihundert-c8b44d516e2a@brauner>
References: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
 <20230703162321.qqte5msavuijnu4l@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703162321.qqte5msavuijnu4l@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 03, 2023 at 06:23:21PM +0200, Jan Kara wrote:
> Hello Christian!
> 
> On Mon 03-07-23 16:49:10, Christian Brauner wrote:
> > Two minor fixes for the rename work for this cycle. First one is based
> > on a static analysis report from earlier today. The second one is based
> > on manual review.
> 
> Thanks! In fact I've sent you a very same patch as patch 1 just a while ago
> [1] and your patch 2 already back in June [2]. But feel free to use your
> fixups, they look good to me so also feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

I'll take yours and just massage the commit message. :)
