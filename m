Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C42279825
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 11:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIZJU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZJU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:20:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA96CC0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+JfeD/tctNfJ5HtNJXoRGvW+p9Hy2erKLdABNWw8g/I=; b=cWgpp+CnyzBs2vKlUkIpK5VKZj
        HS880x+3vmJLmNEU5ure310LtEcsBF5pENsjt4EdQrhL2gj54SUeJXnDB83WtXhCCurFpKGwK//pl
        +hPMqHCudIFFBU+/BrDHd4RUU0bNdIQGZA7NCpSXDkUxMR6AXa3mSuwoVz9i7kG4Dj2PI+VaCIiNC
        7EdqWfFPo1LgJY5uXCk0IsMRt10sk7RSNXuOZ95t6bo5E8KjMSHsW/+gJFO9uJBxB6u2/iSaf3v0B
        H18+kuWDqOQ/xxv8LaUArdqcaodJahaCnMu0jrFcVgdhhSUIoX1Sivcu9VD7hCwZ1FHeDWb0ljQ3H
        ozzBqrlw==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM6Ny-0002FQ-O1; Sat, 26 Sep 2020 09:20:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: small pathname lookup cleanups
Date:   Sat, 26 Sep 2020 11:20:47 +0200
Message-Id: <20200926092051.115577-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

this series contains a few minor lookup cleanups.
