Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F26708439
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEROtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjEROtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 10:49:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0461E0;
        Thu, 18 May 2023 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/rZIKyG/cHa7vpcfFP9wQ60duoyRLV0zgGQZjGMbrCI=; b=ZDbyB05R8h9mfB6GL2+Iu2ohGM
        OINSz24NEumyirl/yD89J7PkuU8gv2TUBq0e2LIx1H4OIxPoyTgJcvHdimM/2cR2pusoEKMmtPjHN
        GmEc2p1Kr2n01kWrZy25et6jqBLfSJ9F6/p9CT/xDzFTt88DmJahLGYAsyrgIZPmobDr6ht/4U3Hz
        vw1kszfHeLHfg0udtmpxciaOm+t/+ykuOZetYqOt5ihEh64WW4r+rU5eu+DWPo3tUzW718Q3H4z6c
        C0nBBmfZdceylTqfW8XnIojFTHt2ciCWVOIZLT3G/rMYORhTcebIJ8tzG1lbatjyB+32t7dH896xz
        0jDQF/4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzew2-00DEDE-0j;
        Thu, 18 May 2023 14:48:54 +0000
Date:   Thu, 18 May 2023 07:48:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     corbet@lwn.net, jake@lwn.net, hch@infradead.org, djwong@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH] Documentation: add initial iomap kdoc
Message-ID: <ZGY61jQfExQc2j71@infradead.org>
References: <20230518144037.3149361-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518144037.3149361-1-mcgrof@kernel.org>
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

> +**iomap** allows filesystems to query storage media for data using *byte ranges*. Since block
> +mapping are provided for a *byte ranges* for cache data in memory, in the page cache, naturally

Without fixing your line length I can't even read this mess..

