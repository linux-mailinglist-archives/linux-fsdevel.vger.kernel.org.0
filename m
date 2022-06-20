Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4155107C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 08:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiFTGkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 02:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiFTGkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:40:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47909DEF8;
        Sun, 19 Jun 2022 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PL1Y7gAb9eOoJ8JMhqnLNDt8qQnWB+FdJ+JxX+JXHSM=; b=oMqPvA/DxDGGVRGb8TJX2AxzIC
        Iahb7RB1vCAdiFQTFWUujtF5oKDwdKWD1HOHdtz8rel4nJj9GXK8XXvlQUwf/iRm3iw/v5KoWQW6g
        JpgejTd5PBKa3JkHGofm9UZvPYWKtd7MPruq4qd+M9U40fMp3gByCn1Ulvq1C1/7oabso54qkvMxY
        zJwYvi1AfknOJojUykpB8hAcYVsn6o+CHezz1wMvHjasIvd7gFNvhfgFGbL6IyEKTmp7YsDJZqkUx
        /RlM8aY5Nx95NtwpiOEcR30p2RnokSHPaanIn3vLPdMS9uoYN2WeLuWAYrLEeg3zXfNnKdptvTUGY
        ueKQSmew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3B5E-00GSZb-S8; Mon, 20 Jun 2022 06:40:24 +0000
Date:   Sun, 19 Jun 2022 23:40:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 3/3] fs/buffer: Make submit_bh & submit_bh_wbc return type
 as void
Message-ID: <YrAWWGL2HZbTR9LL@infradead.org>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <ba89f469a59cfaca49478ee391e6bc9dde456e19.1655703467.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba89f469a59cfaca49478ee391e6bc9dde456e19.1655703467.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:28:42AM +0530, Ritesh Harjani wrote:
> submit_bh/submit_bh_wbc are non-blocking functions which just submits

s/submits/submit/

> the bio and returns. The caller of submit_bh/submit_bh_wbc needs to wait

s/retuns/return/

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
