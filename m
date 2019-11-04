Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB8EDCE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfKDKwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:52:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:46588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727771AbfKDKwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:52:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 649CFB1CC;
        Mon,  4 Nov 2019 10:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1C9F61E43DA; Mon,  4 Nov 2019 11:52:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/7] quota: Allow quota support without quota files
Date:   Mon,  4 Nov 2019 11:51:48 +0100
Message-Id: <20191104091335.7991-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this patch series refactors quota enabling / disabling code and allows
filesystems to implement quota support without providing quota files (ubifs
wants to do this).

Patches have passed testing with fstests, review is welcome.

								Honza
