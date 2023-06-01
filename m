Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9678071974A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjFAJmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjFAJml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:42:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1EC194;
        Thu,  1 Jun 2023 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3+RUlEcH7isxmCbBECCgL7PXEN7SbmbY/NdmfbT6nys=; b=p0JM4MuYi5TkD5n3cXWVUHjZOb
        49pavEgExMCfQshxhKuFN7udrK3bv1HQC1zQx+ByhSW8NImLciqnTbqzyE1+A0fpF5GcK7gWM9ErS
        53nutqJcnGZ11HhRiVl4HmiHLNtJ+gH/D+i0r/0DmHN30poeEnbd1BQ3fHf9+ozM5Jz6I1OSnKeQW
        KH8rLn7G/xuW7sUdITIrG4gBf8z2KsO6WrsF8otk9bZKPk4cplULkR2ZJ6MBJGR72I+uQOWV7RHAX
        oKeEnxtTkImR6qayqyfNZ24MKqFyrma24+SPHrJDC8IeD4tbHumGLqzajhR6u3logeQ6aWiYXK0c4
        36eMATRw==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4ep9-002lYP-0Z;
        Thu, 01 Jun 2023 09:42:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: add device removal test
Date:   Thu,  1 Jun 2023 11:42:22 +0200
Message-Id: <20230601094224.1350253-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

Hi all,

this series adds two tests for removing a device underneath the
file system.  This covers the new shutdown handling series I'm
posting.
