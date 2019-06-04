Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179CD3508A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 22:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFDUB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 16:01:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfFDUB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:01:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54JvXVM101932
        for <linux-fsdevel@vger.kernel.org>; Tue, 4 Jun 2019 16:01:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swvp66qve-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2019 16:01:55 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 4 Jun 2019 21:01:55 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 21:01:52 +0100
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x54K1oM718219464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 20:01:50 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 261A0136059;
        Tue,  4 Jun 2019 20:01:50 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93A9D136055;
        Tue,  4 Jun 2019 20:01:48 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.215.159])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 20:01:48 +0000 (GMT)
Subject: Re: [WIP RFC PATCH 0/6] Generic Firmware Variable Filesystem
To:     Daniel Axtens <dja@axtens.net>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, nayna@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, cclaudio@linux.ibm.com,
        Matthew Garrett <mjg59@google.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>
References: <20190520062553.14947-1-dja@axtens.net>
 <316a0865-7e14-b36a-7e49-5113f3dfc35f@linux.vnet.ibm.com>
 <87zhmzxkzz.fsf@dja-thinkpad.axtens.net> <20190603072916.GA7545@kroah.com>
 <87tvd6xlx9.fsf@dja-thinkpad.axtens.net>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Tue, 4 Jun 2019 16:01:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87tvd6xlx9.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19060420-0016-0000-0000-000009BE132A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011215; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01213253; UDB=6.00637657; IPR=6.00994320;
 MB=3.00027184; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-04 20:01:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060420-0017-0000-0000-0000437EE022
Message-Id: <b2312934-42a6-f2e7-61d2-3d95222a1699@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 06/03/2019 07:56 PM, Daniel Axtens wrote:
>
>> I would just recommend putting this in sysfs.  Make a new subsystem
>> (i.e. class) and away you go.
>>
>>> My hope with fwvarfs is to provide a generic place for firmware
>>> variables so that we don't need to expand the list of firmware-specific
>>> filesystems beyond efivarfs. I am also aiming to make things simple to
>>> use so that people familiar with firmware don't also have to become
>>> familiar with filesystem code in order to expose firmware variables to
>>> userspace.
>>> fwvarfs can also be used for variables that are not security relevant as
>>> well. For example, with the EFI backend (patch 3), both secure and
>>> insecure variables can be read.
>> I don't remember why efi variables were not put in sysfs, I think there
>> was some reasoning behind it originally.  Perhaps look in the linux-efi
>> archives.
> I'll have a look: I suspect the appeal of efivarfs is that it allows for
> things like non-case-sensitive matching on the GUID part of the filename
> while retaining case-sensitivity on the part of the filename
> representing the variable name.

It seems efivars were first implemented in sysfs and then later 
separated out as efivarfs.
Refer - Documentation/filesystems/efivarfs.txt.

So, the reason wasn't that sysfs should not be used for exposing 
firmware variables,
but for the size limitations which seems to come from UEFI Specification.

Is this limitation valid for the new requirement of secure variables ?

Copying Matthew who can give us more insights...

Thanks & Regards,
      - Nayna

