Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837FE27976D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 09:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgIZHED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 03:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZHED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:04:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276DCC0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HLqS14toauvGE+EjD3iAav6c2tcw8U4eP51w6oRFl7I=; b=rg0lhw0LU23dXiTyfK5jIdZXT+
        PABfIeMr0nS09X311XcsM4K7f4zemxo95y0q6tQoDJ2G4znWUWIgrlUbLQ8lTQx5DVcFU32xU1MFi
        p0f7scJLoOY7IJS2JzcGerFEd/1BmS1iIVta/tEvYCRDFt4Q5m5DJ9WWEZWXpNIK/dsTaydKatCY3
        mJTECCLyrTKheoVYBkWjUijIm3hV2j0L2xJHq1a72jGKGjyD0WNTsO+c6fYhVQIq5pIdvuAjW7MPC
        Ed0nFTDCebQkm9vHIqdElsoBIDrA/DARKdFQFLhnCwEni0pD01IbVNBWGZsrVZ/5Wr2YkdQd3cYOe
        ySEkYgoA==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM4FV-0003vX-MS; Sat, 26 Sep 2020 07:04:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: stat cleanups (resend)
Date:   Sat, 26 Sep 2020 09:03:56 +0200
Message-Id: <20200926070401.11816-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

a bunch of cleanups to untangle our mess of state related helpers.

Diffstat:
 fs/stat.c            |   70 +++++++++++++++++++++------------------------------ include/linux/fs.h   |   22 +++-------------
 include/linux/stat.h |    2 -
 3 files changed, 34 insertions(+), 60 deletions(-)
