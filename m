Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5246B14ECE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 14:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgAaNFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 08:05:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:9750 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgAaNFR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:05:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 05:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; 
   d="scan'208";a="262540186"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2020 05:05:16 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ixVz1-0001uT-On; Fri, 31 Jan 2020 21:05:15 +0800
Date:   Fri, 31 Jan 2020 21:04:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] fs_param_bad_value() can be static
Message-ID: <20200131130421.26qcmfvgaspqdqjr@f53c9c00458a>
References: <202001312114.IkYUPqKR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001312114.IkYUPqKR%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Fixes: 2552e0ea2d71 ("turn fs_param_is_... into functions")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 fs_parser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 834e0902fe7d3..5e059592d4b6c 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -188,7 +188,7 @@ int fs_lookup_param(struct fs_context *fc,
 }
 EXPORT_SYMBOL(fs_lookup_param);
 
-int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
+static int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
 {
 	return inval_plog(log, "Bad value for '%s'", param->key);
 }
