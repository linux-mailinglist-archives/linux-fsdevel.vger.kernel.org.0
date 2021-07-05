Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBB93BBC30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 13:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhGELa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 07:30:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230459AbhGELa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:30:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165B4Nvs083690;
        Mon, 5 Jul 2021 07:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=iozgYz3WDzDVrFAs/2BY4dE1AB02jqYMzRcCZKwkBvU=;
 b=B5k2BjWUOD+d3arlmW8C1qT5g+VvoAJSfJebll0IwS0dusJSUtAfo9TjivCVN5tMcWY5
 lh0pcDSXBXjRVTr14a55uTeakRnQEnIzcng89eT4pfb0n3AbLFJ48icZF3cf62+EDq+r
 om5iQbX5oErCX9m4qJQCtGsoK4DjRXw7z1meIYvoiobYlBHPaUYjxKbazYMetD54hBfZ
 LDY3NtrEP+Lh6ajdjhcjH7zidmPGb6E8i5J7CBRl9b07ZKY7iLfhZ/gd2Xq7We1BcPFI
 BIh3UZmi3HMTBSWrSn0Qjl09YmxEzm36jm52Knx5/BR6vaGzA8cgkrT2IbeAtdqHCJYz qg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39ky9d35ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 07:27:33 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 165BO4hV022245;
        Mon, 5 Jul 2021 11:27:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 39jfh8gdh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 11:27:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 165BRTdg30277962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jul 2021 11:27:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5DB542045;
        Mon,  5 Jul 2021 11:27:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D054204D;
        Mon,  5 Jul 2021 11:27:27 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.85.74.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jul 2021 11:27:27 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [powerpc][5.13.0-next-20210701] Kernel crash while running
 ltp(chdir01) tests
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <YOG/5ZY1AL05jumi@mit.edu>
Date:   Mon, 5 Jul 2021 16:57:26 +0530
Cc:     Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        linuxppc-dev@lists.ozlabs.org,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <42CECCCE-A338-408A-B392-F4E25E629D2A@linux.vnet.ibm.com>
References: <26ACA75D-E13D-405B-9BFC-691B5FB64243@linux.vnet.ibm.com>
 <bf1c5b38-92f1-65db-e210-a97a199718ba@linux.dev>
 <4cc87ab3-aaa6-ed87-b690-5e5b99de8380@huawei.com>
 <03f734bd-f36e-f55b-0448-485b8a0d5b75@huawei.com> <YN86yl5kgVaRixxQ@mit.edu>
 <36778615-86fd-9a19-9bc9-f93a6f2d5817@huawei.com> <YN/a70ucYXu0DqGf@mit.edu>
 <66fb56cd-f1ff-c592-0202-0691372e32f5@huawei.com> <YOG/5ZY1AL05jumi@mit.edu>
To:     "Theodore Ts'o" <tytso@mit.edu>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bf6gHb7P31BL35PpU7G_EfT05lKk5aY7
X-Proofpoint-ORIG-GUID: Bf6gHb7P31BL35PpU7G_EfT05lKk5aY7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_05:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 spamscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050059
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On 04-Jul-2021, at 7:34 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Sat, Jul 03, 2021 at 12:55:09PM +0800, Zhang Yi wrote:
>> Yeah, it sounds good to me. Do you want me to send the fix patch, or =
you
>> modify your commit 8f9e16badb8fd in another email directly?
>=20
> I've gone ahead and made the changes; what do you think?
>=20
> I like how it also removes 40 lines of code.  :-)
>=20
>     	  	    	     	      	   - Ted
>=20
> =46rom ef3130d1b0b8ca769252d6a722a2e59a00141383 Mon Sep 17 00:00:00 =
2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Fri, 2 Jul 2021 18:05:03 -0400
> Subject: [PATCH] ext4: inline jbd2_journal_[un]register_shrinker()
>=20
> The function jbd2_journal_unregister_shrinker() was getting called
> twice when the file system was getting unmounted.  On Power and ARM
> platforms this was causing kernel crash when unmounting the file
> system, when a percpu_counter was destroyed twice.
>=20
> Fix this by removing jbd2_journal_[un]register_shrinker() functions,
> and inlining the shrinker setup and teardown into
> journal_init_common() and jbd2_journal_destroy().  This means that
> ext4 and ocfs2 now no longer need to know about registering and
> unregistering jbd2's shrinker.
>=20
> Also, while we're at it, rename the percpu counter from
> j_jh_shrink_count to j_checkpoint_jh_count, since this makes it
> clearer what this counter is intended to track.
>=20
> Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release =
checkpointed buffers")
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

This patch fixes the reported problem. Test ran to completion
without any crash.

Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

-Sachin


