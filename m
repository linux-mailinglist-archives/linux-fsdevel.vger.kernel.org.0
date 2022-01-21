Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5E496619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 20:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiAUT4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 14:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiAUT4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:56:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC3C06173B
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jan 2022 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CjxP6+rwS7p2f0m/qjqbDtRBOJw27BqczbPNssx+q0o=; b=ZGU+j3iTavE8CM1Vat31KnKxMW
        RwK7DSPZej8XraKlHKxS+6slf+Gj49zr35NovV6Ydrao0e4DxNDrt17wEwfr9HvYtCzRX+ceIbVlV
        /OrWIgH2RoBzmoIv3xfx1w3EVFDLh8qNTAp8Xqzhmgx+b44MyQtlqeLDz3/KgSOaMe2HjcwJAUhZF
        JJ/huSVajND/w1XxvKALS0qD8t1e3qAVR8aELsp+9qlt0nWaCXj9AcPMebjaoYhHLS8rStqZXuRCR
        xQlyGpuq3ptnW8Md8xC6HbuJUv4kkR1YbVSdq8xSj5oZpDeUatk0u4yT8Ct03NQOowNqjuf/OWKVq
        QMHgqVwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nB01i-00FsFC-NJ; Fri, 21 Jan 2022 19:56:50 +0000
Date:   Fri, 21 Jan 2022 19:56:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Folio meeting video on youtube
Message-ID: <YesQAu5R9SA6xcto@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This week's meeting: https://www.youtube.com/watch?v=7aFTBe1GQro
