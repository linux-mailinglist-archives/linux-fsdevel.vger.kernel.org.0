Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B805B06B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfF3P2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 11:28:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726646AbfF3P2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 11:28:00 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5UFR0qf025961
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jun 2019 11:27:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2temyxp5s9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jun 2019 11:27:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 30 Jun 2019 16:27:56 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 30 Jun 2019 16:27:50 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5UFRnW946596282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jun 2019 15:27:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B55842041;
        Sun, 30 Jun 2019 15:27:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF8CF4203F;
        Sun, 30 Jun 2019 15:27:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 30 Jun 2019 15:27:46 +0000 (GMT)
Subject: Re: [PATCH v4 3/3] gen_init_cpio: add support for file metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, bug-cpio@gnu.org,
        zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com,
        dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com,
        hpa@zytor.com, arnd@arndb.de, rob@landley.net,
        james.w.mcmechan@gmail.com, niveditas98@gmail.com
Date:   Sun, 30 Jun 2019 11:27:36 -0400
In-Reply-To: <20190523121803.21638-4-roberto.sassu@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
         <20190523121803.21638-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19063015-4275-0000-0000-00000347BAA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19063015-4276-0000-0000-00003857CB02
Message-Id: <1561908456.3985.23.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906300198
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-05-23 at 14:18 +0200, Roberto Sassu wrote:

> diff --git a/usr/Kconfig b/usr/Kconfig
> index 43658b8a975e..8d9f54a16440 100644
> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -233,3 +233,11 @@ config INITRAMFS_COMPRESSION
>  	default ".lzma" if RD_LZMA
>  	default ".bz2"  if RD_BZIP2
>  	default ""
> +
> +config INITRAMFS_FILE_METADATA
> +	string "File metadata type"
> +	default ""
> +	help
> +	  Specify xattr to include xattrs in the image.
> +
> +	  If you are not sure, leave it blank.
> 	fi

Instead of having to specify the metdata type, let's make this a
choice.

Mimi

