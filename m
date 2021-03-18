Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8B33FCCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 02:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCRBs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 21:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229973AbhCRBsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616032086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4TOrwZJWsiNz4CEVzeZz1ih5ruY+oU/SWw8uRd/Q4vs=;
        b=SHeZgBVduhgcwu5Ypt0CTX7KS/2beeRww0f6mG8oHhZfaYh98EpLMFCabOuDI/XnYNljUN
        SgVqcSlDz+KvJ4s6gOF6sz6xxEo7kPR90vgiNIFTeK52qe+sZPN07FFQGRdD+4gBtENIP4
        3TXqIqeYp94wwU1aPYgMbqa5gMVVORE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-uKdTOWT2Mky-sB0-uWKc3Q-1; Wed, 17 Mar 2021 21:48:02 -0400
X-MC-Unique: uKdTOWT2Mky-sB0-uWKc3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87AD881744F;
        Thu, 18 Mar 2021 01:48:00 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E882D4C;
        Thu, 18 Mar 2021 01:47:48 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] audit: add support for openat2
Date:   Wed, 17 Mar 2021 21:47:16 -0400
Message-Id: <cover.1616031035.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The openat2(2) syscall was added in v5.6.  Add support for openat2 to the
audit syscall classifier and for recording openat2 parameters that cannot
be captured in the syscall parameters of the SYSCALL record.

Supporting userspace code can be found in
https://github.com/rgbriggs/audit-userspace/tree/ghau-openat2

Supporting test case can be found in
https://github.com/linux-audit/audit-testsuite/pull/103

Richard Guy Briggs (2):
  audit: add support for the openat2 syscall
  audit: add OPENAT2 record to list how

 arch/alpha/kernel/audit.c          |  2 ++
 arch/ia64/kernel/audit.c           |  2 ++
 arch/parisc/kernel/audit.c         |  2 ++
 arch/parisc/kernel/compat_audit.c  |  2 ++
 arch/powerpc/kernel/audit.c        |  2 ++
 arch/powerpc/kernel/compat_audit.c |  2 ++
 arch/s390/kernel/audit.c           |  2 ++
 arch/s390/kernel/compat_audit.c    |  2 ++
 arch/sparc/kernel/audit.c          |  2 ++
 arch/sparc/kernel/compat_audit.c   |  2 ++
 arch/x86/ia32/audit.c              |  2 ++
 arch/x86/kernel/audit_64.c         |  2 ++
 fs/open.c                          |  2 ++
 include/linux/audit.h              | 10 ++++++++++
 include/uapi/linux/audit.h         |  1 +
 kernel/audit.h                     |  2 ++
 kernel/auditsc.c                   | 19 +++++++++++++++++++
 lib/audit.c                        |  4 ++++
 lib/compat_audit.c                 |  4 ++++
 19 files changed, 66 insertions(+)

-- 
2.27.0

