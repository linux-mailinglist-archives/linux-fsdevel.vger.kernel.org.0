Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0896F1EA0CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgFAJTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgFAJTG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B1E2AEF5;
        Mon,  1 Jun 2020 09:19:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D99121E0948; Mon,  1 Jun 2020 11:19:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Martijn Coenen <maco@android.com>,
        tj@kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] writeback: Lazytime handling fix and cleanups
Date:   Mon,  1 Jun 2020 11:18:54 +0200
Message-Id: <20200601091202.31302-1-jack@suse.cz>
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
Review is welcome!

								Honza
