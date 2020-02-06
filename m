Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D515419A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgBFKM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:12:59 -0500
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:61720 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727864AbgBFKM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:12:58 -0500
X-Greylist: delayed 1329 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 05:12:57 EST
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200206101255.QDR16397.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 6 Feb 2020 10:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580983975; 
        bh=LfeypBNiqzzaMzbEcIUFIRZRTd+WhpIbUIZyDxiZC1E=;
        h=Message-ID:Subject:From:To:Cc:Date:MIME-Version;
        b=TjoHl9JSibaMqfkP0DDQ1UXRT8a49Ku7nd3Jc77T+lh9pMUsyEZEylPhdVH/ztckaMt861FquU3Su9VYFPRZ4hGeon6exEGtKOErBeLixIgTsjBaEk9tp8VAT0zwNwIIORfvmr6gqa19SoFOwLaGcZzyCtBWrByUCjSETeqKaDKvn3/y+sv9mqLoaosjMjAUDqtJVFcfiCHzjkVflk+FnI53zRbb/FpTKo5t3eLxvm/BUvd45dxZ1ohktFUKFOdZMEoHlIih/Ajmp7TVvSeflaRWVfm3WsIiBOvqywa/2grLPlKqyI9aVmfh/y2i+3q+s8nZaIb9NYaRU6M1T6hR+Q==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.5.31]
X-OWM-Source-IP: 86.134.5.31 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrheefgdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvffftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedrhedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrhedrfedupdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgu
        shesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeovhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.5.31) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A290C003AEDC8; Thu, 6 Feb 2020 10:12:55 +0000
Message-ID: <a9a96ab099d6799f67a087910ba8b707d3b87add.camel@btinternet.com>
Subject: Test to trace kernel bug in fsconfig(2) with nfs
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     selinux@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, sds@tycho.nsa.gov, paul@paul-moore.com,
        omosnace@redhat.com
Date:   Thu, 06 Feb 2020 10:12:54 +0000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The test program 'fsmount.c' sent in [1], can be used along with the
test script below to show a kernel bug when calling fsconfig(2) with
any valid option for an nfs mounted filesystem.

This problem is not related to the btrfs bug I reported in [1], however
I suspect that once vanilla NFS options can be set, it may uncover the
same issue as in [1].

[1] 
https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/T/#u

Copy the statements below into nfs-test.sh and run.

MOUNT=/home # must be a top-level mount
TESTDIR=$MOUNT/MOUNT-FS-MULTI/selinux-testsuite
systemctl start nfs-server
exportfs -orw,no_root_squash,security_label localhost:$MOUNT
mkdir -p /mnt/selinux-testsuite
# mount works:
#mount -t nfs -o
"vers=4.2,rootcontext=system_u:object_r:unconfined_t:s0"
localhost:$TESTDIR /mnt/selinux-testsuite
# Both of these give: Failed fsconfig(2): Invalid argument (nfsvers=4.2
or vers=4.2 fail)
./fsmount nfs localhost.localdomain:$TESTDIR /mnt/selinux-testsuite
"nfsvers=4.2"
#./fsmount nfs localhost.localdomain:$TESTDIR /mnt/selinux-testsuite
"nfsvers=4.2,rootcontext=system_u:object_r:unconfined_t:s0"
umount /mnt/selinux-testsuite
exportfs -u localhost:$MOUNT
systemctl stop nfs-server


