Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13E3130CA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 04:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgAFD67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 22:58:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:64168 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgAFD67 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:58:59 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2020 19:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,401,1571727600"; 
   d="scan'208";a="302768187"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2020 19:58:57 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ioJXc-000Fng-OZ; Mon, 06 Jan 2020 11:58:56 +0800
Date:   Mon, 6 Jan 2020 11:58:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [RFC PATCH] configfd: configfd_context_fops can be static
Message-ID: <20200106035830.6ok7ehpfcenns2hl@f53c9c00458a>
References: <20200104201432.27320-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104201432.27320-3-James.Bottomley@HansenPartnership.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Fixes: 74148c8fa2fc ("configfd: add generic file descriptor based configuration parser")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 configfd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/configfd.c b/fs/configfd.c
index 7f2c750ac7e30..a0ca741718704 100644
--- a/fs/configfd.c
+++ b/fs/configfd.c
@@ -50,7 +50,7 @@ static int configfd_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-const struct file_operations configfd_context_fops = {
+static const struct file_operations configfd_context_fops = {
 	.read		= configfd_read,
 	.release	= configfd_release,
 	.llseek		= no_llseek,
@@ -93,8 +93,8 @@ static struct configfd_type *configfd_type_get(const char *name)
 	return cft;
 }
 
-struct configfd_context *configfd_context_alloc(const struct configfd_type *cft,
-						unsigned int op)
+static struct configfd_context *configfd_context_alloc(const struct configfd_type *cft,
+						       unsigned int op)
 {
 	struct configfd_context *cfc;
 	struct logger *log;
