Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444553AB7A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhFQPjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhFQPjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:39:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB7EC061574;
        Thu, 17 Jun 2021 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=P7kLv1oVP+rhYg9WCt73Sf/4lVoZblgwQfVI0MV7Vnk=; b=pU/rzvdZunzXrnpBlSL9c6CMBr
        BtpU5QE4CjRZsy1haF46aBQyBWJcbogZHsI/CRX7I3pn//wRJM12uizbGjvFHZ9rDTGu5zUGanT3c
        r4ePeJdNDThruUeJiU6Ymbh8FNIeKfUUEevpQuhht9a9GXUlrpVL7t4tKMzDzXL2app4BQN405/am
        VLLAI6Rs9l6bEyzB2Z3jQ5kDGegxmdcPufoxK6iD47QVSSnP78NDGtalgLt1nvRY7OycNDklItnNJ
        rfkVcx036pRnY8y2n3QX4SPLH5u99DxNllgbWnkF9v6XjePBJ9o3JO4yBZhRj/7AAn5s511OU9EtO
        jYMm6R1A==;
Received: from [2001:4bb8:19b:fdce:dccf:26cc:e207:71f6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltu4Z-009HvP-8R; Thu, 17 Jun 2021 15:36:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: support booting of arbitrary non-blockdevice file systems
Date:   Thu, 17 Jun 2021 17:36:47 +0200
Message-Id: <20210617153649.1886693-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series adds support to boot off arbitrary non-blockdevice root file
systems, based off an earlier patch from Vivek.
