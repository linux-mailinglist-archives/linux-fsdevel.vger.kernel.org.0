Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B21891DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfHKNi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 09:38:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfHKNi7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 09:38:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D3153C938;
        Sun, 11 Aug 2019 13:38:59 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-19.ams2.redhat.com [10.36.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3B225D9C9;
        Sun, 11 Aug 2019 13:38:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 resend 0/1] fs: Add VirtualBox guest shared folder (vboxsf)
Date:   Sun, 11 Aug 2019 15:38:51 +0200
Message-Id: <20190811133852.5173-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 11 Aug 2019 13:38:59 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Everyone,

Here is a resend of the 12th version of my cleaned-up / refactored version
of the VirtualBox shared-folder VFS driver. It seems that for some reason
only the cover letter of my initial-posting of v12 has made it to the list.

This version hopefully addresses all issues pointed out in David Howell's
review of v11 (thank you for the review David):

Changes in v12:
-Move make_kuid / make_kgid calls to option parsing time and add
 uid_valid / gid_valid checks.
-In init_fs_context call current_uid_gid() to init uid and gid
-Validate dmode, fmode, dmask and fmask options during option parsing
-Use correct types for various mount option variables (kuid_t, kgid_t, umode_t)
-Some small coding-style tweaks

For changes in older versions see the change log in the patch.

This version has been used by several distributions (arch, Fedora) for a
while now, so hopefully we can get this upstream soonish, please review.

Regards,

Hans

