Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9422F44F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgG0QHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgG0QHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:07:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27034C061794;
        Mon, 27 Jul 2020 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2aQmIJDaFTj/Kf9z4Bfaajb+6jbNo420+J7NaCJSi0E=; b=Jzs4m41kN5iL1/gualbsul8T/y
        cw4AZk4oqI7HMAnzxgjm5NiBMUORs3Q1BHldhz8+BUZ7DOuVz4VjJum57i6TOXIWZvjSl64osO29N
        zutaD/Sp9RREubVIBg54Nelz22OU6LYT4kXCt4AsQoMJH9xay8IDCZtgPLn7xB5tN8Scve560/oWh
        SnBwPBbhLFOsQIDOWKLTqhGqfj4mca2E84r8gD66FzBvJbofThKrI1uwWtg/TlKlhZfuN9OdSfe5u
        KMILkhmtCx5VJy6RKXJK6zUOhjE+iPwOw2UOcDgEIn/on55e7XeUsBWOq1EBTWNSXTld5k9Y7yPUw
        TbG0y9cw==;
Received: from [2001:4bb8:18c:2acc:aa45:8411:1fb3:30ec] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k05fH-0002mL-1O; Mon, 27 Jul 2020 16:07:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: fixes for: decruft the early init / initrd / initramfs code v2
Date:   Mon, 27 Jul 2020 18:07:41 +0200
Message-Id: <20200727160744.329121-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series fixes up a few issues found in my

    git://git.infradead.org/users/hch/misc.git init-user-pointers

tree.  The patches are relative to it.
