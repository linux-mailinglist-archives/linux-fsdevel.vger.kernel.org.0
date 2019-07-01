Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A015BCD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 15:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfGANXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 09:23:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727010AbfGANXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:23:39 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61DNVMD073799
        for <linux-fsdevel@vger.kernel.org>; Mon, 1 Jul 2019 09:23:38 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfh69q1bw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2019 09:23:33 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 1 Jul 2019 14:22:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 14:22:30 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61DMTCc61079606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 13:22:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C82BDAE053;
        Mon,  1 Jul 2019 13:22:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DB51AE04D;
        Mon,  1 Jul 2019 13:22:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.204])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 13:22:27 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
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
Date:   Mon, 01 Jul 2019 09:22:16 -0400
In-Reply-To: <20190523121803.21638-1-roberto.sassu@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070113-0028-0000-0000-0000037F5960
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070113-0029-0000-0000-0000243F8F3C
Message-Id: <1561987336.4067.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=997 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010165
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-05-23 at 14:18 +0200, Roberto Sassu wrote:
> This patch set aims at solving the following use case: appraise files from
> the initial ram disk. To do that, IMA checks the signature/hash from the
> security.ima xattr. Unfortunately, this use case cannot be implemented
> currently, as the CPIO format does not support xattrs.
> 
> This proposal consists in including file metadata as additional files named
> METADATA!!!, for each file added to the ram disk. The CPIO parser in the
> kernel recognizes these special files from the file name, and calls the
> appropriate parser to add metadata to the previously extracted file. It has
> been proposed to use bit 17:16 of the file mode as a way to recognize files
> with metadata, but both the kernel and the cpio tool declare the file mode
> as unsigned short.

Thanks, Roberto!

Victor, Taras, Rob, Arvind, Peter, if you're good with this latest
design, could we get some Reviewed-by, Acked-by, or Tested-by?

thanks!

Mimi

