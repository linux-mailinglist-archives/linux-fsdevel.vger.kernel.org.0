Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C645220BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfEQX3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 19:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfEQX3w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 19:29:52 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89522133D;
        Fri, 17 May 2019 23:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558135791;
        bh=NmbUuscx59CfadwUd23QBlhl8is95u2Oj8HWFBMhEbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U6GLauxmpRczGzYlNr7q8KJrt+Ti272cRkxNRV/X57oEkThW6V+ms+Xg3MO9xA65V
         TQudL9DU9blwi0o+Ll2a4c8K3AwH6TbLNUHuBezvyGq/212DlFxiQ9ti1I+sz1Ssit
         xn2ScRkJEn3ycG1XvNhzLpobg6TNHlj1kpI2Sa8s=
Date:   Fri, 17 May 2019 16:29:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/22] coda: remove uapi/linux/coda_psdev.h
Message-Id: <20190517162951.79c957039dd6cbb9b7d5b791@linux-foundation.org>
In-Reply-To: <bb11378cef94739f2cf89425dd6d302a52c64480.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
        <bb11378cef94739f2cf89425dd6d302a52c64480.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 17 May 2019 14:36:54 -0400 Jan Harkes <jaharkes@cs.cmu.edu> wrote:

> Nothing is left in this header that is used by userspace.
> 
>  fs/coda/coda_psdev.h            |  5 ++++-
>  include/uapi/linux/coda_psdev.h | 10 ----------

Confused.  There is no fs/coda/coda_psdev.h.  I did this.  It compiles
OK...


From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: coda: remove uapi/linux/coda_psdev.h

Nothing is left in this header that is used by userspace.

Link: http://lkml.kernel.org/r/bb11378cef94739f2cf89425dd6d302a52c64480.1558117389.git.jaharkes@cs.cmu.edu
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/coda_psdev.h      |    5 ++++-
 include/uapi/linux/coda_psdev.h |   10 ----------
 2 files changed, 4 insertions(+), 11 deletions(-)

--- a/include/linux/coda_psdev.h~coda-remove-uapi-linux-coda_psdevh
+++ a/include/linux/coda_psdev.h
@@ -3,8 +3,11 @@
 #define __CODA_PSDEV_H
 
 #include <linux/backing-dev.h>
+#include <linux/magic.h>
 #include <linux/mutex.h>
-#include <uapi/linux/coda_psdev.h>
+
+#define CODA_PSDEV_MAJOR 67
+#define MAX_CODADEVS  5	   /* how many do we allow */
 
 struct kstatfs;
 
--- a/include/uapi/linux/coda_psdev.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI__CODA_PSDEV_H
-#define _UAPI__CODA_PSDEV_H
-
-#include <linux/magic.h>
-
-#define CODA_PSDEV_MAJOR 67
-#define MAX_CODADEVS  5	   /* how many do we allow */
-
-#endif /* _UAPI__CODA_PSDEV_H */
_

