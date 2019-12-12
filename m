Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E8611CB4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 11:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfLLKuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 05:50:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:57136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728688AbfLLKuV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:50:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2362BAE6F;
        Thu, 12 Dec 2019 10:50:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 014F81E0B8F; Thu, 12 Dec 2019 11:50:19 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     reiserfs-devel@vger.kernel.org
Cc:     <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] reiserfs: Two small fixes
Date:   Thu, 12 Dec 2019 11:50:16 +0100
Message-Id: <20191212105018.910-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

these two patches fix two small issues in reiserfs, one of them spotted by
syzbot (which made me look into the code and find the second). If nobody
objects, I'll merge these through my tree.

								Honza
