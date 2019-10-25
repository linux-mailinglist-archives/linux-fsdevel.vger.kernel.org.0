Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880F4E4190
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbfJYCgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 22:36:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sbVwvQRBZuxZmZrkOieMzrYY+vICCqPfKVmCZfSKrw0=; b=cjrpAj6xCiL9R6fLLwArZdFbS
        kMxkUVtyWeZW+3KV14FgporTFTZrfOTQAvknZQdC1P9nuTu/tAgMkCkm3mAbg1O0USQGbxrYYw/Ur
        As6e/lYr13MHWhvjyOsEJwp69VFixX4RYrc6Gowxran58GFd7ZJCCuSRpi/Bj15v4OuWiWzLjXONk
        rTqV35LQ2rfZw7uTNUrrIVZit20UgkRTVZ2EpmGMyEfvUIR7Yih+lWEkhucefc9j1837cKwWQR0AN
        D9p14UgSm7zRHjOORdrzzvuSvBiHmKo3mZredywdFeX8ViCQwyMedYPuAodmyqqtBgkDoobSwUJ03
        JRli4gsrQ==;
Received: from p91006-ipngnfx01marunouchi.tokyo.ocn.ne.jp ([153.156.43.6] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNpSW-0003cU-8p; Fri, 25 Oct 2019 02:36:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: clean up xfs space management interfaces
Date:   Fri, 25 Oct 2019 11:36:05 +0900
Message-Id: <20191025023609.22295-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series cleans up the XFS space management interfaces, and also
lifts two more of XFS-specific ioclts to common code, reusing the
existing infrastructure to map the XFS ioctls to ->fallocate.
