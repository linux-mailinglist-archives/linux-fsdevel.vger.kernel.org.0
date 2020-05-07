Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB41F1C9635
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 18:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEGQQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbgEGQQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 12:16:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97A6C05BD43;
        Thu,  7 May 2020 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=A8uqttsFcU+RJDntrcBSCeABb5tI8iPtiiJqsyKDW04=; b=V1dxn1S+iYZZ/l2L4kNnzJsOKl
        D5sgSRXA0U8TWty4HMvZv5pQyvRFkETw7KoQyMOmXOYOT9gbPtC+T57mcLDqekS5INAW8E4PeuMg0
        HcNDr6JinkpcrJEcXTD7rSuLygBcrtYF/T4gLcpAtb3otJ+vJQpmct+098gJcFtL2Miz/2nTRhPPE
        MREnEiK5hUlCWueg/4gMRkwnd5oHgyvXn+c2VtjzQhobuZqzYJ/W5aOwWLggS+wCiNbWmt2Li7/+j
        /6JzjZCIEThKa3BrWMwMhf2jaDszjlexfq3EdRBNl9g05zYhjIAygk+X2ol2F7IcVI/3zJrlGItO8
        h3zci7YQ==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWjCI-0002gy-PH; Thu, 07 May 2020 16:16:31 +0000
Date:   Thu, 7 May 2020 18:16:28 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joel Becker <jlbec@evilplan.org>
Subject: [GIT PULL] configfs fix for 5.7
Message-ID: <20200507161628.GA440967@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.7

for you to fetch changes up to 8aebfffacfa379ba400da573a5bf9e49634e38cb:

  configfs: fix config_item refcnt leak in configfs_rmdir() (2020-04-27 08:17:10 +0200)

----------------------------------------------------------------
configfs fix for 5.7

 - fix a refcount leak in configfs_rmdir (Xiyu Yang)

----------------------------------------------------------------
Xiyu Yang (1):
      configfs: fix config_item refcnt leak in configfs_rmdir()

 fs/configfs/dir.c | 1 +
 1 file changed, 1 insertion(+)
