Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954CB40CB9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhIORYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:24:24 -0400
Received: from sandeen.net ([63.231.237.45]:33372 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhIORYY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:24:24 -0400
Received: by sandeen.net (Postfix, from userid 500)
        id 543AC85B; Wed, 15 Sep 2021 12:22:53 -0500 (CDT)
From:   Eric Sandeen <sandeen@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     dan.j.williams@intel.com
Subject: [PATCH 0/3 RFC] Remove DAX experimental warnings
Date:   Wed, 15 Sep 2021 12:22:38 -0500
Message-Id: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For six years now, when mounting xfs, ext4, or ext2 with dax, the drivers
have logged "DAX enabled. Warning: EXPERIMENTAL, use at your own risk." 

IIRC, dchinner added this to the original XFS patchset, and Dan Williams
followed suit for ext4 and ext2.

After brief conversations with some ext4 and xfs developers and maintainers,
it seems that it may be time to consider removing this warning.

For XFS, we had been holding out for reflink+dax capability, but proposals
which had seemed promising now appear to be indefinitely stalled, and
I think we might want to consider that dax-without-reflink is no longer
EXPERIMENTAL, while dax-with-reflink is simply an unimplemented future
feature.

For EXT4/EXT2, I'm not aware of significant outstanding concerns that would
continue to require the dire warning.

Thoughts?

Thanks,
-Eric
