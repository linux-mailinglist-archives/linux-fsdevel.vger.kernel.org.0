Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D555F108CD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 12:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfKYLTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 06:19:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:50348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727608AbfKYLTE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:19:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D6F8B3E3;
        Mon, 25 Nov 2019 11:19:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E51051E0A63; Mon, 25 Nov 2019 12:19:01 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        <linux-fsdevel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v2] iomap: Cleanup of iomap_dio_rw()
Date:   Mon, 25 Nov 2019 12:18:56 +0100
Message-Id: <20191125083930.11854-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

here is the second version of the series. Since Darrick has already picked up
the patch fixing pipe page leakage, I'm resending only the updated cleanup
patch.

Changes since v1:
* Dropped fix patch as it is already in Darrick's tree
* Rebased cleanup patch on top of iomap tree (Christoph)
* Changed code in iomap_dio_rw() to reexpand the iter only in one place and
  jump there from elsewhere (Christoph)
* Expanded comment and moved 'orig_count' initialization (Christoph)

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20191121161144.30802-1-jack@suse.cz
