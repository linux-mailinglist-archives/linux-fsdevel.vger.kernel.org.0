Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945F4C57D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiBZT1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 14:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiBZT1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 373C9D5562
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645903638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sautZp78bp1zZn5HE5LQAe/g0BTsOX/w5SupO4dw9Bw=;
        b=CJ0ZmTCiI1V+kcOCYYNrR3wkOTWG3Opyaja2rZlxnjjUXtLv3TBziwi8DsZ7STj+VBCy8O
        7yKOHNvKPH34hSx0umdkRzhIF0aIYONnY7Us6zh/jBi9WAlMOWSWe/FhjUj50PYr64tzeb
        gQ1euXOTYmnsTXUIFYdY9/+Yzi+2AUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-oi5vl-Q1Nru1O3uUm9oL6w-1; Sat, 26 Feb 2022 14:27:15 -0500
X-MC-Unique: oi5vl-Q1Nru1O3uUm9oL6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0EB8145F6;
        Sat, 26 Feb 2022 19:27:13 +0000 (UTC)
Received: from localhost (unknown [10.64.242.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9737641BE;
        Sat, 26 Feb 2022 19:27:08 +0000 (UTC)
Date:   Sun, 27 Feb 2022 04:27:07 +0900 (JST)
Message-Id: <20220227.042707.2131548399286487704.yamato@redhat.com>
To:     zeha@debian.org
Cc:     matorola@gmail.com, kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20220206164734.cgdrkcuvwzy76pyy@zeha.at>
References: <20220202.232106.1642450897216370276.yamato@redhat.com>
        <20220205.030324.1280110384368183671.yamato@redhat.com>
        <20220206164734.cgdrkcuvwzy76pyy@zeha.at>
Organization: Red Hat Japan, Inc.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for being late.

> Hello Masatake YAMATO,
> 
> Thank you for the followup.
> 
> * Masatake YAMATO <yamato@redhat.com> [220204 19:03]:
>> > Could you tell me what kind of file system for /etc/passwd do you use for testing?
> 
> sbuild/schroot can use different mechanisms, but in this case / is
> overlayfs (the underlying fs is ext4):
>    unstable-amd64-sbuild on / type overlay (rw,relatime,...)
> 
> ls -la /etc/passwd
> -rw-r--r-- 1 root root 2397 Feb  6 16:41 /etc/passwd
> stat /etc/passwd
>   File: /etc/passwd
>   Size: 2397            Blocks: 8          IO Block: 4096   regular file
> Device: 33h/51d Inode: 1311528     Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-02-06 16:41:26.880589326 +0000
> Modify: 2022-02-06 16:41:26.720591039 +0000
> Change: 2022-02-06 16:41:26.720591039 +0000
>  Birth: -
> mount

Thank you. I found this one was a critical hint for fixing.
The failure reports a bug of the test case, not a bug of lsfd command.

I made a new pull request for this bug: https://github.com/util-linux/util-linux/pull/1611.

Quoted from the pull request:

    The original test cases depended on a wrong assumption; if M and M'
    are the same, D and D' are the same, too. Here, M is a mnt_id in
    /proc/$pid/mountinfo. D is the device number for M in
    /proc/$pid/mountinfo. M' is the mnt_id value in
    /proc/$pid/fdinfo/$fd. D' is the device number reported by stat
    syscall for /proc/$pid/fd/$fd.

      # ../../lsfd -oCOMMAND,PID,MNTID,DEV,NAME -p 2972623 -Q '(ASSOC =~ "^[0-9]+$") and (TYPE == "REG")'
      COMMAND     PID MNTID  DEV NAME
      a.out   2972623  1578 0:98 /home/jet/var/util-linux/o/merged/y
      # stat -c %d /home/jet/var/util-linux/o/merged/y
      98
      # grep 1578 /proc/2972623/mountinfo
      1578 91 0:91 / /home/jet/var/util-linux/o/merged rw,relatime shared:724 - overlay overlay rw,seclabel,lowerdir=lower-base/lower,upperdir=upper-base/upper,workdir=upper-base/work

    The original test compared the device numbers reported by findmnt and
    lsfd. findmnt retrieves a device number from /proc/$pid/mountinfo.
    lsfd retrieves a device number from stat syscall.

    This assumption is not correct for a file on an overlay file system
    whose block devices behind lowerdir and upperdir are different.
    Using findmnt is not suitable for comparing device numbers.

I expect the bug is fixed with the pull request.

Masatake YAMATO

>> As I commented on GitHub, I made a pull request for fixing this issue.
>> I found a bug in the test case, not in lsfd itself.
>> 
>> https://github.com/util-linux/util-linux/pull/1595
>> https://github.com/util-linux/util-linux/pull/1595/commits/abd93fcecfbb1a1fac7032fac9d2903c5d2d3a38
>>
>> > When trying to reproduce the bug, could you applying the following change?
> 
> I have applied abd93fcecfbb1a1fac7032fac9d2903c5d2d3a38 alone, which
> does not help in my case (DEV[STR] is 0 instead of 1).
> 
> I have also applied #1595 in full in a second build, see output
> below.
> 
> Many thanks,
> Chris
> 
> 
> 
>      script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file
>    commands: /<<PKGBUILDDIR>>/
>     helpers: /<<PKGBUILDDIR>>/
>     sub dir: /<<PKGBUILDDIR>>/tests/ts/lsfd
>     top dir: /<<PKGBUILDDIR>>/tests
>        self: /<<PKGBUILDDIR>>/tests/ts/lsfd
>   test name: mkfds-ro-regular-file
>   test desc: read-only regular file
>   component: lsfd
>   namespace: lsfd/mkfds-ro-regular-file
>     verbose: yes
>      output: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file
>   error log: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.err
>   exit code: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.exit_code
>    valgrind: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.vgdump
>    expected: /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file{.err}
>  mountpoint: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file-mnt
> 
>          lsfd: read-only regular file         ... FAILED (lsfd/mkfds-ro-regular-file)
> ========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file =================
> ================= OUTPUT =====================
>      1	ABC         3  r--  REG /etc/passwd   1
>      2	COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
>      3	PID[RUN]: 0
>      4	PID[STR]: 0
>      5	INODE[RUN]: 0
>      6	INODE[STR]: 0
>      7	UID[RUN]: 0
>      8	UID[STR]: 0
>      9	USER[RUN]: 0
>     10	USER[STR]: 0
>     11	SIZE[RUN]: 0
>     12	SIZE[STR]: 0
>     13	MNTID[RUN]: 0
>     14	DEV[RUN]: 0
>     15	FINDMNT[RUN]: 0
>     16	DEV[STR]: 1
>     17	MNTID: 312
>     18	DEV: 0:50
>     19	MNTID DEV: 312 0:50
>     20	FINDMNT_MNTID_DEV: 312 0:48
> ================= EXPECTED ===================
>      1	ABC         3  r--  REG /etc/passwd   1
>      2	COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
>      3	PID[RUN]: 0
>      4	PID[STR]: 0
>      5	INODE[RUN]: 0
>      6	INODE[STR]: 0
>      7	UID[RUN]: 0
>      8	UID[STR]: 0
>      9	USER[RUN]: 0
>     10	USER[STR]: 0
>     11	SIZE[RUN]: 0
>     12	SIZE[STR]: 0
>     13	MNTID[RUN]: 0
>     14	DEV[RUN]: 0
>     15	FINDMNT[RUN]: 0
>     16	DEV[STR]: 0
> ================= O/E diff ===================
> --- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file	2022-02-06 16:37:28.111146267 +0000
> +++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file	2022-01-31 14:57:47.000000000 +0000
> @@ -13,8 +13,4 @@
>  MNTID[RUN]: 0
>  DEV[RUN]: 0
>  FINDMNT[RUN]: 0
> -DEV[STR]: 1
> -MNTID: 312
> -DEV: 0:50
> -MNTID DEV: 312 0:50
> -FINDMNT_MNTID_DEV: 312 0:48
> +DEV[STR]: 0
> ==============================================
> 
>      script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-rw-character-device
>    commands: /<<PKGBUILDDIR>>/
>     helpers: /<<PKGBUILDDIR>>/
>     sub dir: /<<PKGBUILDDIR>>/tests/ts/lsfd
>     top dir: /<<PKGBUILDDIR>>/tests
>        self: /<<PKGBUILDDIR>>/tests/ts/lsfd
>   test name: mkfds-rw-character-device
>   test desc: character device with O_RDWR
>   component: lsfd
>   namespace: lsfd/mkfds-rw-character-device
>     verbose: yes
>      output: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device
>   error log: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.err
>   exit code: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.exit_code
>    valgrind: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.vgdump
>    expected: /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-rw-character-device{.err}
>  mountpoint: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device-mnt
> 
>          lsfd: character device with O_RDWR   ... FAILED (lsfd/mkfds-rw-character-device)
> ========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-rw-character-device =================
> ================= OUTPUT =====================
>      1	    3  rw-  CHR /dev/zero  mem:5   0     1:5    mem    char  1:5
>      2	ASSOC,MODE,TYPE,NAME,SOURCE,POS,MAJ:MIN,CHRDRV,DEVTYPE,RDEV: 0
>      3	MNTID[RUN]: 0
>      4	DEV[RUN]: 0
>      5	FINDMNT[RUN]: 0
>      6	DEV[STR]: 1
>      7	MNTID: 312
>      8	DEV: 0:50
>      9	MNTID DEV: 312 0:50
>     10	FINDMNT_MNTID_DEV: 312 0:48
> ================= EXPECTED ===================
>      1	    3  rw-  CHR /dev/zero  mem:5   0     1:5    mem    char  1:5
>      2	ASSOC,MODE,TYPE,NAME,SOURCE,POS,MAJ:MIN,CHRDRV,DEVTYPE,RDEV: 0
>      3	MNTID[RUN]: 0
>      4	DEV[RUN]: 0
>      5	FINDMNT[RUN]: 0
>      6	DEV[STR]: 0
> ================= O/E diff ===================
> --- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device	2022-02-06 16:37:28.675140230 +0000
> +++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-rw-character-device	2022-01-31 14:57:47.000000000 +0000
> @@ -3,8 +3,4 @@
>  MNTID[RUN]: 0
>  DEV[RUN]: 0
>  FINDMNT[RUN]: 0
> -DEV[STR]: 1
> -MNTID: 312
> -DEV: 0:50
> -MNTID DEV: 312 0:50
> -FINDMNT_MNTID_DEV: 312 0:48
> +DEV[STR]: 0
> ==============================================
> 

