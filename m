Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176A73322B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 11:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCIKNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 05:13:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229714AbhCIKMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:12:51 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129A3Tn8126439;
        Tue, 9 Mar 2021 05:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VLXXREKt32lTGhx5VSlCqI/r3ad7QYovQBLESPlSg1g=;
 b=JHoTDLey4dg5DpogyA3aPdDBsgtJ9oQbVxU0yNqHH6AxCs0k/hLqbURN9Pp05W9dCjIV
 oJ3IQOmpnHGG/+L0cyuvbVIVjqYPp4JhtXdlNoJNniwZtAR1tkcz/SbR3hpJUPhzVNjt
 Tvi/cR7xZXoRqWMR9g5Fri5UwreL+QHDXQyvSXCCG4F7b7xcBaUtc9pok+hBvRJumV8O
 O67FUpPgItTWV5Q3smsqawuz2HxZNmYtl9TT3HRmU7KZDIm97OxDHREAp3hOYIQ/zlYQ
 RScq9gC3nQkMxAe2cugXHyC9dedDDRUmoojbo3F3j6rNOgbx4OYe0uxkJEJD5yj1Hj3m AQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3762wqy07d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 05:12:33 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1299rlpi009357;
        Tue, 9 Mar 2021 10:12:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3741c8jmw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 10:12:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 129ACSuw48300516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 10:12:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BADF8A405F;
        Tue,  9 Mar 2021 10:12:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A6C8A4065;
        Tue,  9 Mar 2021 10:12:28 +0000 (GMT)
Received: from osiris (unknown [9.171.41.99])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Mar 2021 10:12:28 +0000 (GMT)
Date:   Tue, 9 Mar 2021 11:12:26 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, x86@kernel.org, linux-ia64@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] mm: some config cleanups
Message-ID: <YEdKCvxlFQa4noI8@osiris>
References: <1615278790-18053-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615278790-18053-1-git-send-email-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_09:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011
 mlxlogscore=465 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090048
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 02:03:04PM +0530, Anshuman Khandual wrote:
> This series contains config cleanup patches which reduces code duplication
> across platforms and also improves maintainability. There is no functional
> change intended with this series. This has been boot tested on arm64 but
> only build tested on some other platforms.
> 
> This applies on 5.12-rc2
> 
> Cc: x86@kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (6):
>   mm: Generalize ARCH_HAS_CACHE_LINE_SIZE
>   mm: Generalize SYS_SUPPORTS_HUGETLBFS (rename as ARCH_SUPPORTS_HUGETLBFS)
>   mm: Generalize ARCH_ENABLE_MEMORY_[HOTPLUG|HOTREMOVE]
>   mm: Drop redundant ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION
>   mm: Drop redundant ARCH_ENABLE_SPLIT_PMD_PTLOCK
>   mm: Drop redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE
> 
>  arch/arc/Kconfig                       |  9 ++------
>  arch/arm/Kconfig                       | 10 ++-------
>  arch/arm64/Kconfig                     | 30 ++++++--------------------
>  arch/ia64/Kconfig                      |  8 ++-----
>  arch/mips/Kconfig                      |  6 +-----
>  arch/parisc/Kconfig                    |  5 +----
>  arch/powerpc/Kconfig                   | 11 ++--------
>  arch/powerpc/platforms/Kconfig.cputype | 16 +++++---------
>  arch/riscv/Kconfig                     |  5 +----
>  arch/s390/Kconfig                      | 12 +++--------
>  arch/sh/Kconfig                        |  7 +++---
>  arch/sh/mm/Kconfig                     |  8 -------
>  arch/x86/Kconfig                       | 29 ++++++-------------------
>  fs/Kconfig                             |  5 ++++-
>  mm/Kconfig                             |  9 ++++++++
>  15 files changed, 48 insertions(+), 122 deletions(-)

for the s390 bits:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
