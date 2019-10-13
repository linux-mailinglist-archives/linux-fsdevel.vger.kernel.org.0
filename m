Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429BED54C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 08:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfJMGHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 02:07:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:35966 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbfJMGHS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 02:07:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2019 23:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,290,1566889200"; 
   d="scan'208";a="185176274"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Oct 2019 23:07:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iJX2B-0002nc-L4; Sun, 13 Oct 2019 14:07:15 +0800
Date:   Sun, 13 Oct 2019 14:07:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] fs: vboxsf_parse_monolithic() can be static
Message-ID: <20191013060702.ll5koqqba5bh4ujc@332d0cec05f4>
References: <20191003180858.497928-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003180858.497928-2-hdegoede@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Fixes: 4de97a2666c6 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index f53d5ce823c48..65363c4d49e55 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -379,7 +379,7 @@ static int vboxsf_setup(void)
 	return err;
 }
 
-int vboxsf_parse_monolithic(struct fs_context *fc, void *data)
+static int vboxsf_parse_monolithic(struct fs_context *fc, void *data)
 {
 	char *options = data;
 
