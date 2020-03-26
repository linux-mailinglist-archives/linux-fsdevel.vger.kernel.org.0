Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1792D19450B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCZRHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 13:07:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZRHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5peKgPAOIgDsB7OdsjooA9F7ULofAH7Tv5lWvuuxPdQ=; b=cAA+jDacoun0eJYipzHcWd5pyi
        CeCvQKVZZaeDAd3DehDrp3XdPLx98uLvmAFouTNSkkIwYK/l/TYt9D5ZR0SUhvIVerpjgBYj1oYme
        e54EomVm7TYA2mfsoTTXSzm/6ckQokCLtK0oXzHXAhTjitR180tn4FnE89UQl8vMpgWy86iQi+fkv
        /kQ+SB0Ix8fZ7t//sGrTrvr+AMmN9D7AGleXNBTPP270KGew+b8b/sFaROci2WbEYN2CsI06laE+T
        mUI84OykN5NEAN3Kgby9tytE4IuFOCDsq5aNL75X4Kj4IX/Fmy55sZJkvHPml6buoZm4soKZIYcA0
        GsszmeIg==;
Received: from [2001:4bb8:18c:2a9e:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHVyG-00018n-9d; Thu, 26 Mar 2020 17:07:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Cc:     devel@lists.orangefs.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: orangefs fixes
Date:   Thu, 26 Mar 2020 18:07:03 +0100
Message-Id: <20200326170705.1552562-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike and Martin,

this fixes a pretty grave bug in the ->read_iter and ->flush interaction,
and also removes some copy and pasted code that isn't needed (and out of
date already)
