Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D14C1633A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBRVA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:00:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Db5Tv9QPSLWEp6hIOmUm/anZ+fX4a1oKAZ5UIIaAzvo=; b=gTwCHH/Tvu6k6rRREy3v5UkES+
        4IEb47qPGJ/xat82QBR+cZqHMD4T0EKw2XoyxqMSAHJgtVPDVVjILFr4YES46oU/9/GkGK1OM5pBU
        a5n2QFeQ8eddXu6II7ZXDX5m3KJ3EDeaFGrh22duExtaCPVQ6nlCPZv2wxEEbk7R7VEYOlE7FYX4x
        VkFy9bL0mkfuBHx1Y/0JG1BzCeF4GDVKO7WGB9NXe8e5o3Tg2IxPnvXe1PvY8oK3FXA2YyarA1BMw
        QXpAJ2540Jp4LL01gJQuxwn7fG5VgYc8kQuyB94mmgarV5tOxz7zlLwJYAjbRQN2OGvI7LaD6qoFv
        pbH353Tw==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j49yj-0007K5-Js; Tue, 18 Feb 2020 21:00:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: remove the di_uid/di_gid fields from the XFS icdinode
Date:   Tue, 18 Feb 2020 13:00:17 -0800
Message-Id: <20200218210020.40846-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes the duplicate di_uid/di_gid fields in the XFS
icdinode and alwasys uses the VFS inode fields.  It also matches the
user namespace used by other file systems instead of always using
init_user_ns.  For now that change is mostly theoretical, but it might
be more useful with some of the pending VFS changes in that area.
