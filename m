Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F231B238
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 20:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBNTWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 14:22:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52572 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhBNTWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:22:47 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11EJ2Rjv004234;
        Sun, 14 Feb 2021 14:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=2HSfs+PHnEoAspVggOn3BgvrrXw9WRy1/NNpdkKxiCQ=;
 b=AZF0XAteS7BybRomRYX1JsIb2ozox9iZcsuANYL0RXt1DOGpH5dDZncHkhOo1MmCqO6N
 bN9wDwYuysQC6qwZbZvf0iJ5XmeNG1OR+xeJIVS2mYsLLxHM6iTaq0y08eK4tADF0CEA
 fkKoOtagmhJTVKNKvvgmVoCVGUffCCrVq0F4GQp/Z4xrqebHU1nVIEsLWO+HWe+bCS6r
 bxMHJhhpU5/ixYri+C6GmE6c9iFjLYxsnQtsC23Dv5jV6sm/gZX8ewVelDj99njvNoVd
 /xsREIEyrQHhgvKq8L1FVYyY6/sCJqI4CmD3ZR5qi97i+5qF8aX1c+uVIqwzH+Ok2HJK Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36q9nk09b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 14:21:13 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11EJ2LTu003594;
        Sun, 14 Feb 2021 14:21:12 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36q9nk09ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 14:21:12 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11EJHkRa014564;
        Sun, 14 Feb 2021 19:21:11 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 36p6d8j9rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 19:21:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11EJLAVZ11862324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 19:21:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B369B7805E;
        Sun, 14 Feb 2021 19:21:10 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 372EB7805C;
        Sun, 14 Feb 2021 19:21:04 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.199.127])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 14 Feb 2021 19:21:03 +0000 (GMT)
Message-ID: <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Date:   Sun, 14 Feb 2021 11:21:02 -0800
In-Reply-To: <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
References: <20210214091954.GM242749@kernel.org>
         <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_06:2021-02-12,2021-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=828 clxscore=1015
 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140159
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-02-14 at 10:58 +0100, David Hildenbrand wrote:
[...]
> > And here we come to the question "what are the differences that
> > justify a new system call?" and the answer to this is very
> > subjective. And as such we can continue bikeshedding forever.
> 
> I think this fits into the existing memfd_create() syscall just fine,
> and I heard no compelling argument why it shouldn‘t. That‘s all I can
> say.

OK, so let's review history.  In the first two incarnations of the
patch, it was an extension of memfd_create().  The specific objection
by Kirill Shutemov was that it doesn't share any code in common with
memfd and so should be a separate system call:

https://lore.kernel.org/linux-api/20200713105812.dnwtdhsuyj3xbh4f@box/

The other objection raised offlist is that if we do use memfd_create,
then we have to add all the secret memory flags as an additional ioctl,
whereas they can be specified on open if we do a separate system call. 
The container people violently objected to the ioctl because it can't
be properly analysed by seccomp and much preferred the syscall version.

Since we're dumping the uncached variant, the ioctl problem disappears
but so does the possibility of ever adding it back if we take on the
container peoples' objection.  This argues for a separate syscall
because we can add additional features and extend the API with flags
without causing anti-ioctl riots.

James


