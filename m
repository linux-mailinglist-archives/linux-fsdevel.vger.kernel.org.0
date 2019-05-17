Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F33220D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 01:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfEQXvo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 19:51:44 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:39774 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfEQXvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 19:51:44 -0400
Received: from [173.71.191.49] (helo=[192.168.0.98])
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1hRmda-0008UF-T1; Fri, 17 May 2019 19:51:42 -0400
Date:   Fri, 17 May 2019 19:51:40 -0400
In-Reply-To: <20190517162951.79c957039dd6cbb9b7d5b791@linux-foundation.org>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu> <bb11378cef94739f2cf89425dd6d302a52c64480.1558117389.git.jaharkes@cs.cmu.edu> <20190517162951.79c957039dd6cbb9b7d5b791@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Autocrypt: addr=jaharkes@cs.cmu.edu; keydata=
 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
Subject: Re: [PATCH 16/22] coda: remove uapi/linux/coda_psdev.h
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     linux-fsdevel@vger.kernel.org
From:   Jan Harkes <jaharkes@cs.cmu.edu>
Message-ID: <B41F3799-491C-48C6-8F9C-40EAF832CCD6@cs.cmu.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

patch #15 moves include/linux/coda_psdev.h to fs/coda/coda_psdev.h and patch #16 removes include/uapi/linux/coda_psdev.h.

Maybe #15 wasn't applied yet?

Jan


On May 17, 2019 7:29:51 PM EDT, Andrew Morton <akpm@linux-foundation.org> wrote:
>On Fri, 17 May 2019 14:36:54 -0400 Jan Harkes <jaharkes@cs.cmu.edu>
>wrote:
>
>> Nothing is left in this header that is used by userspace.
>> 
>>  fs/coda/coda_psdev.h            |  5 ++++-
>>  include/uapi/linux/coda_psdev.h | 10 ----------
>
>Confused.  There is no fs/coda/coda_psdev.h.  I did this.  It compiles
>OK...
>
>
>From: Jan Harkes <jaharkes@cs.cmu.edu>
>Subject: coda: remove uapi/linux/coda_psdev.h
>
>Nothing is left in this header that is used by userspace.
>
>Link:
>http://lkml.kernel.org/r/bb11378cef94739f2cf89425dd6d302a52c64480.1558117389.git.jaharkes@cs.cmu.edu
>Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>---
>
> include/linux/coda_psdev.h      |    5 ++++-
> include/uapi/linux/coda_psdev.h |   10 ----------
> 2 files changed, 4 insertions(+), 11 deletions(-)
>
>--- a/include/linux/coda_psdev.h~coda-remove-uapi-linux-coda_psdevh
>+++ a/include/linux/coda_psdev.h
>@@ -3,8 +3,11 @@
> #define __CODA_PSDEV_H
> 
> #include <linux/backing-dev.h>
>+#include <linux/magic.h>
> #include <linux/mutex.h>
>-#include <uapi/linux/coda_psdev.h>
>+
>+#define CODA_PSDEV_MAJOR 67
>+#define MAX_CODADEVS  5	   /* how many do we allow */
> 
> struct kstatfs;
> 
>--- a/include/uapi/linux/coda_psdev.h
>+++ /dev/null
>@@ -1,10 +0,0 @@
>-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>-#ifndef _UAPI__CODA_PSDEV_H
>-#define _UAPI__CODA_PSDEV_H
>-
>-#include <linux/magic.h>
>-
>-#define CODA_PSDEV_MAJOR 67
>-#define MAX_CODADEVS  5	   /* how many do we allow */
>-
>-#endif /* _UAPI__CODA_PSDEV_H */
>_
