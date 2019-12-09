Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B5116C0E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfLILLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:48 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60248 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfLILLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iX4zsr+iymicwNFz/gQnc4ABt9wRNOcv+FLWcogSV4I=; b=eHyPXRRjyc5DY2pLCrilxf/jgG
        LuNNt9oQgtifTCTF17/LJGNhxfHQho4jwSQXH4dEkjgAxlR/TCm6n/OvLXFbngqDk9P7zAcjGmoZH
        a4AydVhYUvsdx3e6/8o/87cFWr+hdGK3126tF2jFYyi8Vlhh9LRtfxpF1zu2qnc7Ax/dmllCqI6kN
        1NPs9/0nn2HDX/ZvJ5R+1Xl2lBO8ss+o/aC0veR5i6xPS5C1IhJjS+lBlXQDjx0U1lSNtjlzR2WDu
        dzdy22n03fLMUswirr7ULBVehmJUWiK2H4OYTJ3fSC3r0wn0KCV+4g3rTX2nxetSqgWjvsg5ICusj
        XSBaFbJw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54126 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGx6-0002YG-GH; Mon, 09 Dec 2019 11:11:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGx5-0004ea-UW; Mon, 09 Dec 2019 11:11:43 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 41/41] Documentation: update adfs filesystem documentation
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGx5-0004ea-UW@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:43 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an introduction to adfs to its documentation detailing which formats
are supported by the module.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 Documentation/filesystems/adfs.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/filesystems/adfs.txt b/Documentation/filesystems/adfs.txt
index 5949766353f7..0baa8e8c1fc1 100644
--- a/Documentation/filesystems/adfs.txt
+++ b/Documentation/filesystems/adfs.txt
@@ -1,3 +1,27 @@
+Filesystems supported by ADFS
+-----------------------------
+
+The ADFS module supports the following Filecore formats which have:
+
+- new maps
+- new directories or big directories
+
+In terms of the named formats, this means we support:
+
+- E and E+, with or without boot block
+- F and F+
+
+We fully support reading files from these filesystems, and writing to
+existing files within their existing allocation.  Essentially, we do
+not support changing any of the filesystem metadata.
+
+This is intended to support loopback mounted Linux native filesystems
+on a RISC OS Filecore filesystem, but will allow the data within files
+to be changed.
+
+If write support (ADFS_FS_RW) is configured, we allow rudimentary
+directory updates, specifically updating the access mode and timestamp.
+
 Mount options for ADFS
 ----------------------
 
-- 
2.20.1

