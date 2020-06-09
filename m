Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1D1F47E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbgFIUPa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 9 Jun 2020 16:15:30 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:46029 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732949AbgFIUP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:15:29 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2020 16:15:28 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 49hLnV3PJyz7t8k;
        Tue,  9 Jun 2020 20:09:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id boU9HZAu7n_x; Tue,  9 Jun 2020 20:09:50 +0000 (UTC)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 49hLnV2Zw6z3wZ3;
        Tue,  9 Jun 2020 20:09:50 +0000 (UTC)
Received: from EXMBDFT11.ad.twosigma.com (172.23.162.14) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Jun 2020 20:09:49 +0000
Received: from EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9]) by
 EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9%19]) with mapi id
 15.00.1497.000; Tue, 9 Jun 2020 20:09:49 +0000
From:   Nicolas Viennot <Nicolas.Viennot@twosigma.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?iso-8859-2?Q?Micha=B3_C=B3api=F1ski?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        "Dirk Petersen" <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        "Casey Schaufler" <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Thread-Topic: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Thread-Index: AQHWOcN3xfkD1x0lZkq0sycHI+s5+KjQqLWAgAAGsYA=
Date:   Tue, 9 Jun 2020 20:09:49 +0000
Message-ID: <cda72e8402244a85862f95ea84ff9204@EXMBDFT11.ad.twosigma.com>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com> <20200609184517.GL134822@grain>
In-Reply-To: <20200609184517.GL134822@grain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.119.122]
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>  proc_map_files_get_link(struct dentry *dentry,
>>  			struct inode *inode,
>>  		        struct delayed_call *done)
>>  {
>> -	if (!capable(CAP_SYS_ADMIN))
>> +	if (!(capable(CAP_SYS_ADMIN) || capable(CAP_CHECKPOINT_RESTORE)))
>>  		return ERR_PTR(-EPERM);

> First of all -- sorry for late reply. You know, looking into this code more I think this CAP_SYS_ADMIN is simply wrong: for example I can't even fetch links for /proc/self/map_files. Still /proc/$pid/maps (which as well points to the files opened) test for ptrace-read permission. I think we need ptrace-may-attach test here instead of these capabilities (if I can attach to a process I can read any data needed, including the content of the mapped files, if only I'm not missing something obvious).

Currently /proc/pid/map_files/* have exactly the same permission checks as /proc/pid/fd/*, with the exception of the extra CAP_SYS_ADMIN check. The check originated from the following discussions where 3 security issues are discussed:
http://lkml.iu.edu/hypermail/linux/kernel/1505.2/02524.html
http://lkml.iu.edu/hypermail/linux/kernel/1505.2/04030.html

From what I understand, the extra CAP_SYS_ADMIN comes from the following issues:
1. Being able to open dma-buf / kdbus region (referred in the referenced email as problem #1). I don't fully understand what the dangers are, but perhaps we could do CAP_SYS_ADMIN check only for such dangerous files, as opposed to all files.
2. /proc/pid/fd/* is already a security hole (Andy says "I hope to fix that some day"). He essentially says that it's not because fds are insecure that map_files should be too. He seems to claim that mapped files that are then closed seems to be a bigger concern than other opened files. However, in the present time (5 years after these email conversations), the fd directory does not have the CAP_SYS_ADMIN check which doesn't convinces me that the holes of /proc/pid/fd/* are such a big of a deal. I'm not entirely sure what security issue Andy refers to, but, I understand something along the lines of: Some process gets an fd of a file read-only opened (via a unix socket for example, or after a chroot), and gets to re-open the file in write access via /proc/self/fd/N to do some damage.
3. Being able to ftruncate a file after a chroot+privilege drop. I may be wrong, but if privileges were dropped, then there's no reason that the then unprivileged user would have write access to the mmaped file inode. Seems a false problem.

It turns out that some of these concerns have been addressed with the introduction of memfd with seals, introduced around the same time where the map_files discussions took place. These seals allow one to share write access of an mmap region to an unsecure program, without fearing of getting a SIGBUS because the unsecure program could call ftruncate() on the fd. More on that at https://lwn.net/Articles/593918/ . Also, that article says "There are a number of fairly immediate use cases for the sealing functionality in general. Graphics drivers could use it to safely receive buffers from applications. The upcoming kdbus transport can benefit from sealing.". This rings a bell with problem #1. Perhaps memfd is a solution to Andy's concerns?

Overall, I think the CAP_SYS_ADMIN map_files/ extra check compared to fd/ does not improve security in practice. Fds will be given to insecure programs. Better security can be achieved with memfd seals, and sane permissioning on files, regardless if they were once closed.

I think Adrian added a CAP_CHECKPOINT_RESTORE on the map_files to avoid opening a can of worm. But I guess the cat is out of the bag now.

-Nico
