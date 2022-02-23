Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDB4C0CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 08:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiBWHGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 02:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiBWHGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:06:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A46E4DE
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 23:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=vGo1eSEDF3i3F3a6Dh+DhzLEvp
        A3BG7zeWzFCjEGOaJOW8Gn6lVUsBqfVJzs8/ABWtU5/Db7g5ukzhAkvVeEY139mZVoGbFkHazV6px
        39QtsVNMLOdkT/urm6gCd7YLjv/GpGgy5SS92fsoQiuBXEhTg+ST0grzeGAKD0Xx291r1YS0FOZar
        VbLWH6knxYh1KCmc7epfja+41RYxjMWMwcPQ7FjiAijX07Ww8Nc28DcbADCLDfczzU9vZGDTlSE66
        FqxuI6r5/U4WBGdiAcTJi/+tFVfLIWNSpGt1VPccBtSbgqgsv4B8YUW2aDYCVGtSqjtD9o/rovZkq
        j53U6TNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlij-00D4SV-Ks; Wed, 23 Feb 2022 07:05:53 +0000
Date:   Tue, 22 Feb 2022 23:05:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/22] fs: Remove aop flags parameter from
 nobh_write_begin()
Message-ID: <YhXc0QYkF1dn/A4h@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-22-willy@infradead.org>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
