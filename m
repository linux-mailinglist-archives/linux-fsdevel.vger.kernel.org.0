Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16BA64B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfICJIl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 3 Sep 2019 05:08:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbfICJIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:08:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8393Lvi002591
        for <linux-fsdevel@vger.kernel.org>; Tue, 3 Sep 2019 05:08:39 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usjjswh3k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 05:08:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <sachinp@linux.vnet.ibm.com>;
        Tue, 3 Sep 2019 10:08:37 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 10:08:34 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8398XTO44499362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 09:08:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AFB7A4054;
        Tue,  3 Sep 2019 09:08:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67AD8A405F;
        Tue,  3 Sep 2019 09:08:32 +0000 (GMT)
Received: from [9.199.196.129] (unknown [9.199.196.129])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 09:08:32 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <CA+G9fYvOUch79HoBiJbuod2bTGS5h8se5EB5LRJAwTCfPQr2ow@mail.gmail.com>
Date:   Tue, 3 Sep 2019 14:38:31 +0530
Cc:     Qian Cai <cai@lca.pw>, Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <CA+G9fYvOUch79HoBiJbuod2bTGS5h8se5EB5LRJAwTCfPQr2ow@mail.gmail.com>
To:     linux-fsdevel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 19090309-0020-0000-0000-00000367064C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090309-0021-0000-0000-000021BC6E98
Message-Id: <FB310917-04B3-4263-8033-8D10428D119D@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=27 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030096
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On 03-Sep-2019, at 1:43 PM, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> 
> On Tue, 3 Sep 2019 at 09:51, Qian Cai <cai@lca.pw> wrote:
>> 
>> The linux-next commit "fs/namei.c: keep track of nd->root refcount status” [1] causes boot panic on all
>> architectures here on today’s linux-next (0902). Reverted it will fix the issue.

Similar problem is seen on ppc64le arch.

[    0.493235] BUG: Kernel NULL pointer dereference at 0x00000cc0
[    0.493241] Faulting instruction address: 0xc0000000003e9260
[    0.493245] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.493250] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
[    0.493254] Modules linked in:
[    0.493260] CPU: 1 PID: 1 Comm: systemd Not tainted 5.3.0-rc6-next-20190902-autotest-autotest #1
[    0.493265] NIP:  c0000000003e9260 LR: c0000000003e925c CTR: 00000000000001fc
[    0.493270] REGS: c0000004f85038c0 TRAP: 0300   Not tainted  (5.3.0-rc6-next-20190902-autotest-autotest)
[    0.493274] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28002842  XER: 00000000
[    0.493282] CFAR: c00000000000df44 DAR: 0000000000000cc0 DSISR: 40000000 IRQMASK: 0 
[    0.493282] GPR00: c0000000003e925c c0000004f8503b50 c000000001458e00 0000000000000000 
[    0.493282] GPR04: c0000004f8503ce0 0000000000000000 0000000000000064 0000000000000000 
[    0.493282] GPR08: 0000000000000000 c000000000ff7a65 0000000000000000 c0000004f70100c0 
[    0.493282] GPR12: 0000000000002200 c00000001ecaee00 0000000000000000 0000000000000000 
[    0.493282] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[    0.493282] GPR20: 0000000000077624 0000000000000000 0000000000000000 00007fffa1099e20 
[    0.493282] GPR24: 0000000000000000 000000010f9572a4 0000000000000000 0000000000000001 
[    0.493282] GPR28: 0000000000080060 0000000000080040 0000000000000000 0000000000000cc0 
[    0.493327] NIP [c0000000003e9260] dput+0x70/0x4e0
[    0.493332] LR [c0000000003e925c] dput+0x6c/0x4e0
[    0.493334] Call Trace:
[    0.493338] [c0000004f8503b50] [c0000000003e925c] dput+0x6c/0x4e0 (unreliable)
[    0.493345] [c0000004f8503bc0] [c0000000003d5da4] terminate_walk+0x104/0x130
[    0.493351] [c0000004f8503c00] [c0000000003da9d8] path_lookupat+0xe8/0x2b0
[    0.493356] [c0000004f8503c70] [c0000000003dd668] filename_lookup+0xa8/0x1c0
[    0.493362] [c0000004f8503da0] [c00000000046c4d4] sys_name_to_handle_at+0xe4/0x2d0
[    0.493369] [c0000004f8503e20] [c00000000000b378] system_call+0x5c/0x68
[    0.493373] Instruction dump:
[    0.493376] f8010010 f821ff91 7c7f1b79 41820050 3d200008 3b600001 613c0060 613d0040 
[    0.493383] 3b400000 3b000000 48707b11 60000000 <813f0000> 3bdf0058 7fc3f378 71390008 
[    0.493391] ---[ end trace 7701d360352c734d ]—

Reverting the mentioned commit allows next to boot.

Thanks
-Sachin
