Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8EB01E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfIKQp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:34382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728896AbfIKQp0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FA22AF81;
        Wed, 11 Sep 2019 16:45:24 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@infradead.org, andres@anarazel.de, david@fromorbit.com,
        riteshh@linux.ibm.com, linux-f2fs-devel@lists.sourceforge.net
Subject: Fix inode sem regression for nowait
Date:   Wed, 11 Sep 2019 11:45:14 -0500
Message-Id: <20190911164517.16130-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This changes the way we acquire the inode semaphore when
the I/O is marked with IOCB_NOWAIT. The regression was discovered
in AIM7 and later by Andres in ext4. This has been fixed in
XFS by 942491c9e6d6 ("xfs: fix AIM7 regression")

I realized f2fs and btrfs also have the same code and need to
be updated.

Regards,

-- 
Goldwyn

