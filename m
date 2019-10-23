Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAAE1B63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391876AbfJWMxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:53:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:49390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391852AbfJWMxO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76FE6B67A;
        Wed, 23 Oct 2019 12:53:12 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/8] docs: cdrom: Add autoclose IOCTL
Date:   Wed, 23 Oct 2019 14:52:44 +0200
Message-Id: <50579dae04d209c6fec62388c596d0e459fe56de.1571834862.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571834862.git.msuchanek@suse.de>
References: <cover.1571834862.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This IOCTL will be used internally by the sr driver but there is no
reason to not document it for userspace.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Documentation/ioctl/cdrom.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/ioctl/cdrom.rst b/Documentation/ioctl/cdrom.rst
index 3b4c0506de46..9372ff1b2b47 100644
--- a/Documentation/ioctl/cdrom.rst
+++ b/Documentation/ioctl/cdrom.rst
@@ -60,6 +60,7 @@ are as follows:
 	CDROM_LOCKDOOR		lock or unlock door
 	CDROM_DEBUG		Turn debug messages on/off
 	CDROM_GET_CAPABILITY	get capabilities
+	CDROM_AUTOCLOSE 	If autoclose enabled close the tray
 	CDROMAUDIOBUFSIZ	set the audio buffer size
 	DVD_READ_STRUCT		Read structure
 	DVD_WRITE_STRUCT	Write structure
@@ -1056,6 +1057,30 @@ CDROM_GET_CAPABILITY
 
 
 
+CDROM_AUTOCLOSE
+	Close the tray if the device has one, and autoclose is enabled.
+	Wait for drive to become ready.
+
+
+	usage::
+
+	  ioctl(fd, CDROM_AUTOCLOSE, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		The ioctl return value is 0 or an error code.
+
+
+	error return:
+	  - ENOMEDIUM	No medium found or drive error.
+	  - ERESTARTSYS	Received a signal while waiting for drive to become ready.
+
+
+
 CDROMAUDIOBUFSIZ
 	set the audio buffer size
 
-- 
2.23.0

