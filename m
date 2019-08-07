Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2E850C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbfHGQNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 12:13:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388257AbfHGQNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:13:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77GBRYs022104;
        Wed, 7 Aug 2019 16:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ZAW+qcuaCE1QOFrpMarNcFKwi4miSTEyYBSJ1Z1pMMo=;
 b=ytvRKMU4JrdLH+P2Qpr5e/GAf+QNJfpkol+hG4wyPdle5/EBnL2xO8+zS1R9VJErqz4a
 jwu3KuyWqAMyWFsaFmq4Ym0e642N/SrYSnnEjSUbVxuQvXfnU/IImCp4LPu6bqRZwACz
 mggOyJY34FIVI8XFRUdAKqr821vlRndnF+nKSQNLSknXLnovBqzxvuGGur6yTHFrVPvQ
 bhx/V9SFnQYtxN/VOl7i2f1Yz5iT9bAaZLuckIxJat7FIBfZP1vRD6Wo4auTOLuw5vAB
 BQrnqUJVM5fCVGRsgN2AVya8QenCb0819QeuBoOmxK9/SEYDViKivoH/kKvJGPG/MvOo eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u52wrdbth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 16:12:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77G3KaH158235;
        Wed, 7 Aug 2019 16:12:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u7578384q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 16:12:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x77GCgiY023566;
        Wed, 7 Aug 2019 16:12:42 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 09:12:42 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3570.1\))
Subject: Re: [PATCH v3 2/2] mm,thp: Add experimental config option
 RO_EXEC_FILEMAP_HUGE_FAULT_THP
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190806111210.7xpmjsd4hq54vuml@box>
Date:   Wed, 7 Aug 2019 10:12:35 -0600
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <452E819C-894D-40C5-B680-CC5A02C599AA@oracle.com>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
 <20190731082513.16957-3-william.kucharski@oracle.com>
 <20190801123658.enpchkjkqt7cdkue@box>
 <c8d02a3b-e1ad-2b95-ce15-13d3ed4cca87@oracle.com>
 <20190805132854.5dnqkfaajmstpelm@box.shutemov.name>
 <19A86A16-B440-4B73-98FE-922A09484DFD@oracle.com>
 <20190806111210.7xpmjsd4hq54vuml@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3570.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070163
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 6, 2019, at 5:12 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> IIUC, you are missing ->vm_pgoff from the picture. The newly allocated
> page must land into page cache aligned on HPAGE_PMD_NR boundary. In =
other
> word you cannout have huge page with ->index, let say, 1.
>=20
> VMA is only suitable for at least one file-THP page if:
>=20
> - (vma->vm_start >> PAGE_SHIFT) % (HPAGE_PMD_NR - 1) is equal to
>    vma->vm_pgoff % (HPAGE_PMD_NR - 1)
>=20
>    This guarantees right alignment in the backing page cache.
>=20
> - *and* vma->vm_end - round_up(vma->vm_start, HPAGE_PMD_SIZE) is equal =
or
>   greater than HPAGE_PMD_SIZE.
>=20
> Does it make sense?

It makes sense, but what I am thinking was say a vma->vm_start of =
0x1ff000
and vma->vm_end of 0x400000.

Assuming x86, that can be mapped with a PAGESIZE page at 0x1ff000 then a
PMD page mapping 0x200000 - 0x400000.

That doesn't mean a vma IS or COULD ever be configured that way, so you =
are
correct with your comment, and I will change my check accordingly.

>> In the current code, it's assumed it is not exposed, because a single =
read
>> of a large page that does no readahead before the page is inserted =
into the
>> cache means there are no external users of the page.
>=20
> You've exposed the page to the filesystem once you call ->readpage().
> It *may* track the page somehow after the call.

OK, thanks again.

I'll try to have a V4 available with these changes soon.


