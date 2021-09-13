Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219CE4093F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbhIMO0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 10:26:07 -0400
Received: from ipmail04.adl3.internode.on.net ([150.101.137.10]:61777 "EHLO
        ipmail04.adl3.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344114AbhIMOXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:23:22 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2021 10:23:22 EDT
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3Aj2aOgaIA5b6Jcb/YFE+RVZclxSXFcZb7ZxGr2?=
 =?us-ascii?q?PjKsXjdYENS1mEAzGpLW2yFMqnfY2v3fI8jaYWw/UpS6pTRzNEyQAJvrylhE?=
 =?us-ascii?q?ngTpZOdD9+UdhuvYX2efpLIQUk7tZUXY9WQcek5HyTWzvuPGuGx9SMmiclkZ?=
 =?us-ascii?q?VZd5NYpiUmdfCc8IMscoUsLd9AR0tYAbeeRW2thifuqyyHuEAfNNwxcawr42?=
 =?us-ascii?q?IrbwP9bh8kejRtD1rAIiVGni3eF/5UdJMp3yahctBIUSKEMdgKxb76rIL1UY?=
 =?us-ascii?q?grkExkR5tONyt4Xc6Hkrrz6ZFHezCAPAu7z314Y/XZaPqUTbZLwbW9ekSmJg?=
 =?us-ascii?q?so3zdxXrpyYSAE1M7fKn+gQFR5eVSdzIcWq/Zeefing75HDlxGun3zEmK01X?=
 =?us-ascii?q?BtsbOX04N1fH2BU8tQKJTYMcFaHhuSr0PS8UOYqm8dLBM3qOp4P/397wTzHA?=
 =?us-ascii?q?PIOX5/OWePJ6MVe0TN2gdpBdd7aZswEeX9sYQ7GbhlnJFgaEtQ9kf2ui325d?=
 =?us-ascii?q?CdXwHqcv7Y3/nKVyQVry7jFMdzJd8aMQslY2EGe4GTL4wzE7rsyXDCE4WPco?=
 =?us-ascii?q?jT237aJzH69AtlIfIBUP8VC2DW7rlH/wjVNPbdjncSEtw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AJngJT62OWVauaxZkU9MuyQqjBKckLtp133?=
 =?us-ascii?q?Aq2lEZdPWaSKylfrOV88jzsiWE7Qr5OUtQ++xoV5PrfZqxz/9ICOoqUItKPj?=
 =?us-ascii?q?OMhILAFugL0WKI+UyCJ8SRzIBgPOtbH5RDNA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DRBQBHXD9h/+hf03ZaHQEBPAEFBQE?=
 =?us-ascii?q?CAQkBFQmBUAKBHIIEVmyER60agXwLASMCHQ0BAgQBAYQDcIJFASU0CQ4BAgQ?=
 =?us-ascii?q?VAQEGAQEBAQEGBIEkhWgNhmwVQRgQBwYCHwcCXw0IAQGCbQGDBqxpgTEaAmW?=
 =?us-ascii?q?EaoMqgWOBECoBjX03gVVEgRUnD4Myh1uCZASJPjdudZFzjG6BLl2BKYlZkRt?=
 =?us-ascii?q?XLQeDLoExBguIfpQKBhQslXgDAZEJLZMFommHOmaBLjMaLoMuCUiOVBYViE+?=
 =?us-ascii?q?FWjQwOAIGCwEBAwmFQQEeCBOJeAEB?=
Received: from unknown (HELO localhost) ([118.211.95.232])
  by ipmail04.adl3.internode.on.net with ESMTP; 13 Sep 2021 23:46:38 +0930
Message-ID: <ad3d1354-59d6-2f1a-adf9-e09644ce9769@internode.on.net>
Date:   Mon, 13 Sep 2021 23:46:31 +0930
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Content-Language: en-AU
To:     Alexander Viro <viro@zeniv.linux.org.uk>
From:   Arthur Marsh <arthur.marsh@internode.on.net>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arthur Marsh <arthur.marsh@internode.on.net>
Subject: VFAT mounting / sharing issue after: d_path: make 'prepend()' fill up
 the buffer exactly on overflow
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

On recent kernels a VFAT filesystem mounted on my i686 system started 
behaving weirdly:

The /etc/fstab entry was:

UUID=7417-5AFF       /victoria      vfat 
defaults,uid=65534,gid=65534,umask=000        0     2

After boot-up the filesystem had previously been mounted as:

# mount|grep vic
/dev/sdb6 on /victoria type vfat 
(rw,relatime,uid=65534,gid=65534,fmask=0000,dmask=0000,allow_utime=0022,codepage=437,
iocharset=utf8,shortname=mixed,errors=remount-ro)

On more recent kernels after the boot-up I saw the mount name truncated:

# mount|grep vic
  /dev/sda6 on /vict type vfat 
(rw,relatime,uid=65534,gid=65534,fmask=0000,dmask=0000,allow_utime=0022,codepage=437,
iocharset=utf8,shortname=mixed,errors=remount-ro)

I could cd to /victoria and access the filesystem locally, but samba 
sharing of the filesystem failed.

After a long git-bisect session I found the commit that caused it:

commit b0cfcdd9b9672ea90642f33d6c0dd8516553adf2
Author: Linus Torvalds @linux-foundation.org>
Date:   Fri Jul 16 14:01:12 2021 -0700

     d_path: make 'prepend()' fill up the buffer exactly on overflow

Reverting the commit resolved the issue, including on kernel 5.15.0-rc1

I'm at a loss as to why the patch caused the problem with the reported 
mount name and samba sharing.

Build was on i686 using gcc-11 and:

make -j2 menuconfig bindeb-pkg

I'm happy to supply .config and run tests.

Arthur.


