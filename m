Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B165E2788BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgIYM5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 08:57:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgIYM5d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:57:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 598BBADE4
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2020 12:57:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 24F701E12E1; Fri, 25 Sep 2020 14:57:32 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] udf: Assorted fixes
Date:   Fri, 25 Sep 2020 14:57:27 +0200
Message-Id: <20200925125730.8496-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

patches in this series fix two issues syzbot has spotted during fuzzing and
there's also one small cleanup.

I plan to push these to my tree and send them to Linus for the next merge
window.

								Honza
