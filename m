Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0681F634D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgFKIMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 04:12:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:58472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgFKIMF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:12:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B88C4ABC7;
        Thu, 11 Jun 2020 08:12:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 92CE11E1283; Thu, 11 Jun 2020 10:12:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Martijn Coenen <maco@android.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4 v2] writeback: Lazytime handling fix and cleanups
Date:   Thu, 11 Jun 2020 10:11:51 +0200
Message-Id: <20200611075033.1248-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this patch series fixes an issue with handling of lazy inode timestamp
writeback which could result in missed background writeback of an inode
or missed update of inode timestamps during sync(2). It also somewhat
simplifies the writeback code handling of lazy inode timestamp updates.

Changes since v1:
* Split off locking change for i_io_list manipulation to a separate patch
* Renamed older_than_this to dirtied_before
* Renamed __redirty_tail() to redirty_tail_locked()
* Other minor style fixes

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20200601091202.31302-1-jack@suse.cz
