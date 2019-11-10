Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C81F6962
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 15:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfKJORC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 09:17:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfKJORC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 09:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fVmVEbEUawJP+2+xjtt5g4dGUc3Ync4wEewM8s7BWYg=; b=Defp8JuExBSKtlwz0CPfQZaKbN
        ECVZJJwBIck+9HoH/47uXa7BCHZvfMr6ro9WerGEs/hAEkw1gDHjTJGZWD+pDBh/zU6vkglLdbQjs
        aHzce1pNwwbpyA0UMUiZpsYBkY62oXLUmNGyeKYuN91eFqP1wt9JDXcKNQp9R/XmgfHT8KhkYkH5m
        Ck1KAV6whVlG9yQpMPv93uMCuY6KgQrj/XuGg8bqMhtlknqt8egsYY6ETe0e8GBgjS2uIzsWGBmKc
        43V9Bva4yQKCJHuPylo++WYbUgop14fU23xqX2QyVxKR4gnCu5SB6i8K4Y+5s2p/TNQyWm9zQZ2cv
        3lWNwnfg==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTo1V-0005HE-Ge; Sun, 10 Nov 2019 14:17:01 +0000
Date:   Sun, 10 Nov 2019 15:16:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs regression fix for 5.4-rc
Message-ID: <20191110141648.GA23526@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 26bc672134241a080a83b2ab9aa8abede8d30e1c:

  Merge tag 'for-linus-2019-11-05' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux (2019-11-05 09:44:02 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.4-2

for you to fetch changes up to e2f238f7d5a1fa69ff1884d37acf9a2a3a01b308:

  configfs: calculate the depth of parent item (2019-11-06 18:36:01 +0100)

----------------------------------------------------------------
configfs regression fix for 5.4-rc

 - fix a regression from this merge window in the configfs
   symlink handling (Honggang Li)

----------------------------------------------------------------
Honggang Li (1):
      configfs: calculate the depth of parent item

 fs/configfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
