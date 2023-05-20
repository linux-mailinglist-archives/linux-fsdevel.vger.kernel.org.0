Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3770A597
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 07:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjETFLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 01:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjETFKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 01:10:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F33E52;
        Fri, 19 May 2023 22:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IZDwpSbAMestbxTLBfVfseHT/Ao1tda2Hw4YjCVMEYs=; b=cHkX9gDilxrMdUT4jG8u5OaHR4
        L649r4BgCX/pLuYAkhtU7SfafGHxxnrkUHEgT73x1yGjbRqyAlVK21YJ9K37RG+dA6B4QsRCgDg5u
        AMOqipYZn/a8zn8pcotnMu0xnrY0QfgL3AWKEk2bB7uEqQdxqWYQHjtC3u8IGIjc9BW/mC34TmmPK
        4hfhEzqh4EWdQQP0Rk18v7/YSyzKzOWnHuAu/JZ6gwW/k/cKdTLVGCvGU/aHKgYJaGyj+c4eypG3x
        qMaW3NS65gjbl/lOfjSfziIpL+N28MVHooIGIOoavwJekn2IMwGE+x/KxENxInlUVJdZ6dLPQSnzT
        K0XEfMPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q0Er9-000kTk-0P;
        Sat, 20 May 2023 05:10:15 +0000
Date:   Fri, 19 May 2023 22:10:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-crypto@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fsverity: use shash API instead of ahash API
Message-ID: <ZGhWN6zohGXQvPNv@infradead.org>
References: <20230516052306.99600-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516052306.99600-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm not really an expert on fsverify, but the rationale of not using
clumsy external crypto offloads from the file system makes sense, and
the code looks much nicer now:

Reviewed-by: Christoph Hellwig <hch@lst.de>
