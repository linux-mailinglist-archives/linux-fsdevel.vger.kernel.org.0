Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF19537203
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 12:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFFKqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 06:46:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFFKqb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:46:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F39A6308FEE2;
        Thu,  6 Jun 2019 10:46:22 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B8E767C70;
        Thu,  6 Jun 2019 10:46:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v11 0/1] fs: Add VirtualBox guest shared folder (vboxsf) support
Date:   Thu,  6 Jun 2019 12:46:17 +0200
Message-Id: <20190606104618.28321-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 06 Jun 2019 10:46:31 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Everyone,

Here is the 11th version of my cleaned-up / refactored version of the
VirtualBox shared-folder VFS driver.

This version hopefully addresses all issues pointed out in David Howell's
review of v10 (thank you for the review David):

Changes in v11:
-Convert to the new Documentation/filesystems/mount_api.txt mount API
-Fixed all the function kerneldoc comments to have things in the proper order
-Change type of d_type variable passed as type to dir_emit from int to
 unsigned int
-Replaced the fake-ino overflow test with the one suggested by David Howells
-Fixed various coding style issues

For changes in older versions see the change log in the patch.

This version has been used by several distributions (arch, Fedora) for a
while now, so hopefully we can get this upstream soonish, please review.

Regards,

Hans

