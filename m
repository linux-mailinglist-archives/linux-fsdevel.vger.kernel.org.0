Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409B24D0FBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 07:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbiCHGG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 01:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiCHGG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:06:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477533A3A;
        Mon,  7 Mar 2022 22:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bpT+5I8xuM/BQhhxbzXTx9c5lP4H5CbyPf1u6+XkCn0=; b=TJmWB6s//Rq3b0WH8uTXVwcSKg
        +i4vTvqjvhVzPNeVB4H1k9BGtb7Xr0U8KmOwMc++dpObZ6G/HTMfjyM604fVCrgcyaV2HP04Axso4
        GxCJSorXh7/1t78IbA3uNo+J5Eafcrgnp+oPtJxc9J/pMYGOy0W7MOPgQpi6Z9nEATi+pIEVsyPDf
        Fr9vnJpeEZk/PRnel1Enkh3INv2NJBZlLZX6gv5dnLVXOKH50NGfQhIlJRsr+ax7Jtmrzf+13x//e
        lYiqhIXvgGHdVyz8v2v3fAoGQqYHUr7QzZ+cPoB+/sP/rbbd/yp2RhDHVdc7sZJbBvAuLDWxHKQPp
        GIzVC6Sw==;
Received: from [2001:4bb8:184:7746:6f50:7a98:3141:c37b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRSyR-002kKp-Hk; Tue, 08 Mar 2022 06:05:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: remove write hint leftovers v2
Date:   Tue,  8 Mar 2022 07:05:27 +0100
Message-Id: <20220308060529.736277-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

this removes the other two fields and the two now unused fcntls
as pointed out by Dave.

Changes since v1:
 - better commit log
