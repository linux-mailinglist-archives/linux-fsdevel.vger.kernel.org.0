Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5761565BA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 18:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBHRUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 12:20:43 -0500
Received: from mailomta27-re.btinternet.com ([213.120.69.120]:57081 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727341AbgBHRUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 12:20:42 -0500
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200208172038.BMBT11384.re-prd-fep-046.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sat, 8 Feb 2020 17:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1581182438; 
        bh=SQGGd7pCz0QNM/xCfWMGg5jZjGOlMbW41Mdy5Xlbc1k=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=sxX5FfdxBUYQYakJUk1I2PZ6uJnoE5GU+/zp7neB2y7OCQaRlKeZupt6lT5EoWD9F98yEa2XC0hIKYJq0eg3AqpLJNYLXHMIHudm58vIDgp0J+tu/oIyLPxU6MadYM4G5DoWyXOQyp3PP7IaKQVKA6KJqoRy08lZfOvkzxE8kXK0cDfQ4CVlukUZ3/d/qFWx0u8uWKVhUs2L7++ZowqLnR3Z3kEm9Hdu4Bo74A51QEEn894EpjFIQbiYDGcoLUaGzAJiH9q28XIkbXZ6e2AqASu+bZiYEeBCIVWK/1bRQF04N9ud7q42G7efPdnt4e719f5Nb6b9UtvANuZvRArzYw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.212]
X-OWM-Source-IP: 86.134.6.212 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrheejgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddufeegrdeirddvuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrvdduvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeolhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthht
        ohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.212) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A16DE0093E35D; Sat, 8 Feb 2020 17:20:38 +0000
Message-ID: <afa57a834d8643886f6e0d743c3ee04eecd85fe9.camel@btinternet.com>
Subject: Re: Test to trace kernel bug in fsconfig(2) with nfs
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     selinux@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, sds@tycho.nsa.gov, paul@paul-moore.com,
        omosnace@redhat.com
Date:   Sat, 08 Feb 2020 17:20:37 +0000
In-Reply-To: <a9a96ab099d6799f67a087910ba8b707d3b87add.camel@btinternet.com>
References: <a9a96ab099d6799f67a087910ba8b707d3b87add.camel@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-06 at 10:12 +0000, Richard Haines wrote:
> The test program 'fsmount.c' sent in [1], can be used along with the
> test script below to show a kernel bug when calling fsconfig(2) with
> any valid option for an nfs mounted filesystem.
> 
> This problem is not related to the btrfs bug I reported in [1],
> however
> I suspect that once vanilla NFS options can be set, it may uncover
> the
> same issue as in [1].
> 
> [1] 
> https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/T/#u
> 
> Copy the statements below into nfs-test.sh and run.
> 
> MOUNT=/home # must be a top-level mount
> TESTDIR=$MOUNT/MOUNT-FS-MULTI/selinux-testsuite
> systemctl start nfs-server
> exportfs -orw,no_root_squash,security_label localhost:$MOUNT
> mkdir -p /mnt/selinux-testsuite
> # mount works:
> #mount -t nfs -o
> "vers=4.2,rootcontext=system_u:object_r:unconfined_t:s0"
> localhost:$TESTDIR /mnt/selinux-testsuite
> # Both of these give: Failed fsconfig(2): Invalid argument
> (nfsvers=4.2
> or vers=4.2 fail)
> ./fsmount nfs localhost.localdomain:$TESTDIR /mnt/selinux-testsuite
> "nfsvers=4.2"
> #./fsmount nfs localhost.localdomain:$TESTDIR /mnt/selinux-testsuite
> "nfsvers=4.2,rootcontext=system_u:object_r:unconfined_t:s0"
> umount /mnt/selinux-testsuite
> exportfs -u localhost:$MOUNT
> systemctl stop nfs-server
> 
> 

The first reason fsconfig(2) would not work in the above test is
because it does not call any helpers. mount(8) uses the mount.nfs(8)
helper to extract further NFS options that need to be used. In the
above example it requires options:
"proto=tcp,clientaddr=127.0.0.1,addr=127.0.0.1" to be added, therefore
the updated script below will resolve that problem. However, there is
still the same issue that affects the btrfs filesystem detailed in [1].

It is that the "rootcontext=.." option will also fail on NFS with a log
message:
"SELinux: mount invalid.  Same superblock, different security settings
for (dev 0:44, type nfs4)"


Update script:
MOUNT=/home # must be a top-level mount
TESTDIR=$MOUNT/MOUNT-FS-MULTI/selinux-testsuite
systemctl start nfs-server
exportfs -orw,no_root_squash,security_label localhost:$MOUNT
mkdir -p /mnt/selinux-testsuite

# mount(8) works:
#mount -t nfs -o
"vers=4.2,rootcontext=system_u:object_r:unconfined_t:s0"
localhost:$TESTDIR /mnt/selinux-testsuite

# This will pass as it has options that would be applied by
mount.nfs(8) helper
./fsmount nfs localhost.localdomain:$TESTDIR /mnt/selinux-testsuite
"nfsvers=4.2,proto=tcp,clientaddr=127.0.0.1,addr=127.0.0.1"

# This will fail with fsconfig(2): Invalid argument
#./fsmount nfs localhost.localdomain:$TESTDIR /mnt/selinux-testsuite
"nfsvers=4.2,proto=tcp,clientaddr=127.0.0.1,addr=127.0.0.1,rootcontext=
system_u:object_r:unconfined_t:s0"
# The rootcontext= entry give the following log message: "SELinux:
mount invalid.  Same superblock,
#     different security settings for (dev 0:44, type nfs4)"

umount /mnt/selinux-testsuite
exportfs -u localhost:$MOUNT
systemctl stop nfs-server




