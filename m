Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D58365B56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhDTOkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 10:40:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64568 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232726AbhDTOkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:40:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KEYEU4188508;
        Tue, 20 Apr 2021 10:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1jeherxRnMSg7FyeAYqHTi4W24TU1khc9Hr7Df89RfE=;
 b=juxvMo1jK+pFf2jaH/XC6Rka4oXBMv1yDd1B51lvkBAiG56tu+fPwJHFU2uPfZ0fNnhq
 Vc44rm6i81iuSzwIYf/lyB5sHqAC+ndaeTbvqFTtwI8KV1dmQucr2qtZRD7XUHcXYp9I
 C7f59zN1Em0LrvLuj0aoKREFsUKfrzdDNZM5kFroLE295BPDu45TBSrcThDEE5NS5j8P
 FpH7W/+VqooxruuN/WP9USkapzkT7IqSR2ONrYmSyAk5fnMRzoD3BPYBqqLY0p4AB5Wf
 5iyRWZDIT3we0SsohCyq5WErJbsCwoFZlOLTwQHZGGdwUKQDcAWZzfPs8faV1EV4/DxH AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 381w1aravg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 10:38:51 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KEZHSI193231;
        Tue, 20 Apr 2021 10:38:50 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 381w1arau7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 10:38:50 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KEcEuD028074;
        Tue, 20 Apr 2021 14:38:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 37yqa88yr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 14:38:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KEcL4D24707424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 14:38:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A536B4C04E;
        Tue, 20 Apr 2021 14:38:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42ABE4C040;
        Tue, 20 Apr 2021 14:38:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.82.136])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Apr 2021 14:38:40 +0000 (GMT)
Date:   Tue, 20 Apr 2021 17:38:38 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 0/2] secretmem: optimize page_is_secretmem()
Message-ID: <YH7nbrF1/AAYl83C@linux.ibm.com>
References: <20210420131611.8259-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420131611.8259-1-rppt@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ykIKx2v24XcE8hdhy3CCJKBREf-GjgWi
X-Proofpoint-GUID: Pj2aG0WuO0RRhchqs65IoRlcq6udec95
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_06:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=931 adultscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It seems I've messed this posting entirely :(

Please ignore it, sorry for the noise.

On Tue, Apr 20, 2021 at 04:16:07PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is an updated version of page_is_secretmem() changes.
> This is based on v5.12-rc7-mmots-2021-04-15-16-28.
> 
> @Andrew, please let me know if you'd like me to rebase it differently or
> resend the entire set.
> 
> v2:
> * move the check for secretmem page in gup_pte_range after we get a
>   reference to the page, per Matthew.
> 
> Mike Rapoport (2):
>   secretmem/gup: don't check if page is secretmem without reference
>   secretmem: optimize page_is_secretmem()
> 
>  include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
>  mm/gup.c                  |  6 +++---
>  mm/secretmem.c            | 12 +-----------
>  3 files changed, 29 insertions(+), 15 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 
Sincerely yours,
Mike.
