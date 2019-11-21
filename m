Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9BE1056C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKUQPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 11:15:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:55652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbfKUQPk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:15:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65877B392;
        Thu, 21 Nov 2019 16:15:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D6F161E484C; Thu, 21 Nov 2019 17:15:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Eric Biggers <ebiggers@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] iomap: Fix leakage of pipe pages while splicing
Date:   Thu, 21 Nov 2019 17:15:33 +0100
Message-Id: <20191121161144.30802-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

here is a fix and a cleanup for iomap code. The first patch fixes a leakage
of pipe pages when iomap_dio_rw() splices to a pipe, the second patch is
a cleanup that removes strange copying of iter in iomap_dio_rw(). Patches
have passed fstests for ext4 and xfs and fix the syzkaller reproducer for
me.

								Honza
