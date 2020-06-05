Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3184B1F039F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 01:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgFEXsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 19:48:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728353AbgFEXsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:48:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055NVs6P100498;
        Fri, 5 Jun 2020 19:48:23 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31fjk6qc2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 19:48:22 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055Nk7os013978;
        Fri, 5 Jun 2020 23:48:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 31f2q415jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 23:48:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055NmIYH55378380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 23:48:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E2111C04C;
        Fri,  5 Jun 2020 23:48:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D582111C04A;
        Fri,  5 Jun 2020 23:48:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.234.64])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jun 2020 23:48:15 +0000 (GMT)
Message-ID: <1591400895.4615.45.camel@linux.ibm.com>
Subject: Re: [PATCH v6 8/8] ima: add FIRMWARE_PARTIAL_READ support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 05 Jun 2020 19:48:15 -0400
In-Reply-To: <824407ae-8ab8-0fe3-bd72-270fce960ac5@broadcom.com>
References: <20200605225959.12424-1-scott.branden@broadcom.com>
         <20200605225959.12424-9-scott.branden@broadcom.com>
         <1591399166.4615.37.camel@linux.ibm.com>
         <824407ae-8ab8-0fe3-bd72-270fce960ac5@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 cotscore=-2147483648 mlxlogscore=999 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050170
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-06-05 at 16:31 -0700, Scott Branden wrote:
> Hi Mimi,
> 
> On 2020-06-05 4:19 p.m., Mimi Zohar wrote:
> > Hi Scott,
> >
> > On Fri, 2020-06-05 at 15:59 -0700, Scott Branden wrote:
> >> @@ -648,6 +667,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
> >>   	enum ima_hooks func;
> >>   	u32 secid;
> >>   
> >> +	if (!file && read_id == READING_FIRMWARE_PARTIAL_READ)
> >> +		return 0;
> > The file should be measured on the pre security hook, not here on the
> > post security hook.  Here, whether "file" is defined or not, is
> > irrelevant.  The test should just check "read_id".
> OK, will remove the !file from here.

thanks!

> >
> > Have you tested measuring the firmware by booting a system with
> > "ima_policy=tcb" specified on the boot command line and compared the
> > measurement entry in the IMA measurement list with the file hash (eg.
> > sha1sum, sha256sum)?
> Yes, I enabled IMA in my kernel and added ima_policy=tsb to the boot 
> command line,
> 
> Here are the entries from 
> /sys/kernel/security/ima/ascii_runtime_measurements of the files I am 
> accessing.
> Please let me know if I am doing anything incorrectly.
> 
> 10 4612bce355b2dbc45ecd95e17001636be8832c7f ima-ng 
> sha1:fddd9a28c2b15acf3b0fc9ec0cf187cb2153d7f2 
> /lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
> 10 4c0eb0fc30eb7ac3a30a27f05c1d2a8d28d6a9ec ima-ng 
> sha1:b16d343dd63352d10309690c71b110762a9444c3 
> /lib/firmware/vk-boot2-bcm958401m2_a72.ecdsn
> 
> The sha1 sum matches:
> root@genericx86-64:/sys/kernel/security/ima# sha1sum 
> /lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
> fddd9a28c2b15acf3b0fc9ec0cf187cb2153d7f2 
> /lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
> 
> root@genericx86-64:/sys/kernel/security/ima# sha1sum 
> /lib/firmware/vk-boot2-bcm958401m2_a72.ecdsa.bin
> b16d343dd63352d10309690c71b110762a9444c3 
> /lib/firmware/vk-boot2-bcm958401m2_a72.ecdsa.bin

Looks good!

(FYI, a larger hash algorithm can be specified in the Kconfig or
"ima_hash=" on the boot command line.)

Mimi

