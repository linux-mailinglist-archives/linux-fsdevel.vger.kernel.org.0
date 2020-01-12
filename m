Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEE6C1385DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 11:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgALKf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 05:35:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:29129 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732600AbgALKf4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 05:35:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 02:35:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,424,1571727600"; 
   d="scan'208";a="255550008"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2020 02:35:54 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iqab4-000EVl-5c; Sun, 12 Jan 2020 18:35:54 +0800
Date:   Sun, 12 Jan 2020 18:35:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [RFC PATCH] fs: bind: to_bind_data() can be static
Message-ID: <20200112103539.g3u26n5ejq2dvjce@f53c9c00458a>
References: <20200104201432.27320-7-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104201432.27320-7-James.Bottomley@HansenPartnership.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Fixes: 9f2fd15ca3f4 ("fs: bind: add configfs type for bind mounts")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 bind.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bind.c b/fs/bind.c
index eea4e6cd51087..c335fef21db4a 100644
--- a/fs/bind.c
+++ b/fs/bind.c
@@ -25,7 +25,7 @@ struct bind_data {
 	struct file	*retfile;
 };
 
-struct bind_data *to_bind_data(const struct configfd_context *cfc)
+static struct bind_data *to_bind_data(const struct configfd_context *cfc)
 {
 	return cfc->data;
 }
