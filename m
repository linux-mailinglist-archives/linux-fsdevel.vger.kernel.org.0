Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFED4E6DE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 06:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348902AbiCYFt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 01:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiCYFtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:49:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7DC1DA65;
        Thu, 24 Mar 2022 22:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rf4dvwOsbsAYpIJA+Dg22ovotBWKHUQicqS4Pq4xfxk=; b=hXTkVQtYwhF3Gyf6ZE/hPLIsrS
        Yxa8xaFPXb/m6/cd+N0ROLasFgcmDI/wnVvfwlLNGitcEZHbqZg+uxFhkUSeA32E81XVoYwhy6Jgb
        2Yxt5KKFRoQsWkhs/8SjvFw5HUzKCW3RhXgpWge/hbb+t/QEsGhroe2yR7iA27aYna69VRsbvwhCH
        4hix8Nv/oZs8oMj5PakIHJvVVsT592FSagk42QJS0Wboff0Gvzx4eldVltfXuvaEhKPBt6kcszIpa
        FA4A+vANmuquMSv+G+MRPe8ukHFht3aQpWV1Nl2SucR96zM/7FJ+b3IPbGs5THNmDKa4qRxCnFIM+
        K67mHxbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXcny-001CpB-8m; Fri, 25 Mar 2022 05:48:10 +0000
Date:   Thu, 24 Mar 2022 22:48:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: Re: [PATCH] exfat: reduce block requests when zeroing a cluster
Message-ID: <Yj1Xmr/3GTd41p/e@infradead.org>
References: <HK2PR04MB38915D9ABDC81F7D5463C4E4811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR04MB38915D9ABDC81F7D5463C4E4811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
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

On Fri, Mar 25, 2022 at 03:00:55AM +0000, Yuezhang.Mo@sony.com wrote:
> +#include <linux/blk_types.h>

blk_types.h is not a header for public use.  What do you want it for?

