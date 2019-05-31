Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F73078A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 06:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaEEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 00:04:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbfEaEE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 00:04:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4V41kgD097917
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 00:04:28 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stv279dq3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 00:04:28 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 31 May 2019 05:04:28 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 May 2019 05:04:25 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4V44Ohl57737250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 04:04:24 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 203AC7805E;
        Fri, 31 May 2019 04:04:24 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F108978060;
        Fri, 31 May 2019 04:04:22 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.152.203])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 31 May 2019 04:04:22 +0000 (GMT)
Subject: Re: [WIP RFC PATCH 0/6] Generic Firmware Variable Filesystem
To:     Daniel Axtens <dja@axtens.net>, nayna@linux.ibm.com,
        cclaudio@linux.ibm.com, linux-fsdevel@vger.kernel.org,
        greg@kroah.com, linuxppc-dev@lists.ozlabs.org
References: <20190520062553.14947-1-dja@axtens.net>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Fri, 31 May 2019 00:04:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190520062553.14947-1-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19053104-0036-0000-0000-00000AC50EB1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011188; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01211044; UDB=6.00636315; IPR=6.00992081;
 MB=3.00027126; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-31 04:04:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053104-0037-0000-0000-00004C01D585
Message-Id: <316a0865-7e14-b36a-7e49-5113f3dfc35f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310024
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 05/20/2019 02:25 AM, Daniel Axtens wrote:
> Hi all,
>
> As PowerNV moves towards secure boot, we need a place to put secure
> variables. One option that has been canvassed is to make our secure
> variables look like EFI variables. This is an early sketch of another
> approach where we create a generic firmware variable file system,
> fwvarfs, and an OPAL Secure Variable backend for it.

Is there a need of new filesystem ? I am wondering why can't these be 
exposed via sysfs / securityfs ?
Probably, something like... /sys/firmware/secureboot or 
/sys/kernel/security/secureboot/  ?

Also, it sounds like this is needed only for secure firmware variables 
and does not include
other firmware variables which are not security relevant ? Is that 
correct understanding ?

Thanks & Regards,
       - Nayna


