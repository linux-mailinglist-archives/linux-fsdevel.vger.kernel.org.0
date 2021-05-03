Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469BE371371
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 12:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhECKNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 06:13:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:34940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232960AbhECKNc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 06:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA76EB2A2
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 10:12:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DAB891F2B6B; Mon,  3 May 2021 12:12:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] udf: Better LVID checking and VLA cleanup
Date:   Mon,  3 May 2021 12:12:27 +0200
Message-Id: <20210503100931.5127-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this series adds better checking of LVID structure to address syzbot report
of invalid access on corrupted filesystem and also cleanup usage of variable
length arrays in UDF. I plan to queue it to my tree unless someone objects.

								Honza
