Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C78877F33B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 11:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349537AbjHQJ1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 05:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349624AbjHQJ1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C32724
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692264381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vy8dtGhzqDcz5ucd5nknZgVeybjCGfPqbK7ZBkVRslg=;
        b=FIkqmWRH03W6WQAIsu+8+ppb2fqyNPvkQTh4bZWKgMA9wTi/gFLfBsyKLW4eAj3z79NEAS
        tZUS7pgjG9gCv187KhXCGQGpcQVll6AI4cycUa2bCPnwr4VW9UqDNbmbomF/aL5AlfdxN/
        v5jVnmLC7CSMWj7pNyaZpssjdupp8Cc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-9nPJxTI2OG-dU-MEKcRn5Q-1; Thu, 17 Aug 2023 05:26:19 -0400
X-MC-Unique: 9nPJxTI2OG-dU-MEKcRn5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0CF18DC66B;
        Thu, 17 Aug 2023 09:26:18 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59BC040C6E8A;
        Thu, 17 Aug 2023 09:26:18 +0000 (UTC)
Date:   Thu, 17 Aug 2023 11:26:15 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux stable v2.39.2
Message-ID: <20230817092615.4bx57fpiyskednrw@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux release v2.39.2 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.39/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux v2.39.2 Release Notes
================================

Changes between v2.39.1 and v2.39.2
-----------------------------------

build-sys:
   - add AX_COMPARE_VERSION  [Thomas Weißschuh]
chrt:
   - (man) add note about --sched-period lower limit  [Karel Zak]
column:
   - fix -l  [Karel Zak]
docs:
   - update AUTHORS file  [Karel Zak]
github:
   - check apt-cache in more robust way  [Karel Zak]
include:
   - define pidfd syscalls if needed  [Markus Mayer]
libblkid:
   - fix topology chain types mismatch  [Karel Zak]
libmount:
   - (python)  work around python 3.12 bug  [Thomas Weißschuh]
   - (utils) fix statx fallback  [Thomas Weißschuh]
   - check for linux/mount.h  [Markus Mayer]
   - check for struct statx  [Markus Mayer]
   - cleanup --fake mode  [Karel Zak]
   - fix typo  [Debarshi Ray]
   - handle failure to apply flags as part of a mount operation  [Debarshi Ray]
   - ifdef statx() call  [Karel Zak]
   - improve EPERM interpretation  [Karel Zak]
   - update documentation for MNT_ERR_APPLYFLAGS  [Debarshi Ray]
   - use mount(2) for remount on Linux < 5.14  [Karel Zak]
   - use some MS_* flags as superblock flags  [Karel Zak]
lscpu:
   - Even more Arm part numbers (early 2023)  [Jeremy Linton]
meson:
   - add check for linux/mount.h  [Thomas Weißschuh]
   - add check for struct statx  [Thomas Weißschuh]
   - check for HAVE_STRUCT_STATX_STX_MNT_ID  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update ja.po (from translationproject.org)  [Takeshi Hamasaki]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
po-man:
   - merge changes  [Karel Zak]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
setarch:
   - add PER_LINUX_FDPIC fallback  [Karel Zak]
uuidd:
   - improve man page for -cont-clock  [Karel Zak]
wall:
   - do not error for ttys that do not exist  [Mike Gilbert]
zramctl:
   - add hint about supported algorithms  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

