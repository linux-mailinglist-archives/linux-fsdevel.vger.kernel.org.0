Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831FE2CDFD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgLCUni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 15:43:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLCUni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:43:38 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3KbOXh018207;
        Thu, 3 Dec 2020 15:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ybXvsEXpDXIPmjWji69f2jqfzYDCBrTeuqxrThnEBt4=;
 b=P+Fg+VX3FgHOMu96IW5NObPqdQ509iNLq8wC0VNI4bGj9l3pD2yohVCA+lxPLYH3M/o/
 36Fqs3O23tjBCwUoCzkSV0nkD+adF43uSAkYCVCFSzikr4iWQ6KC//PDLSpqgiKet5IJ
 9ASHVP1QZI58zqYIuBtKHSEFa/bJzU4dWsYYfmO15ncUzjEisLM0I8VTjXCW/HO0gYOO
 M8hVVYPw/vKzDfXyeBavfeOVWmoy0s08OdV8N8sulcZhSm9Zyb02gPqFY4QrK8zho9NL
 KpKlixtE9aFML68IcfJg6zm+fdcRe9FDaZXB+WfYYR1W89zPVrPckx+O7Q5SSZ4pd83+ qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35777c054u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 15:42:52 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B3Ke7A3029221;
        Thu, 3 Dec 2020 15:42:51 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35777c053w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 15:42:51 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B3KXiti008063;
        Thu, 3 Dec 2020 20:42:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 353e6889cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 20:42:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B3Kgls910093158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Dec 2020 20:42:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16F8F4203F;
        Thu,  3 Dec 2020 20:42:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E6A342047;
        Thu,  3 Dec 2020 20:42:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.43.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Dec 2020 20:42:45 +0000 (GMT)
Message-ID: <b9f1a31e9b2dfb7a7167574a39652932263488e8.camel@linux.ibm.com>
Subject: Re: [PATCH v3 06/11] evm: Ignore INTEGRITY_NOLABEL if no HMAC key
 is loaded
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Date:   Thu, 03 Dec 2020 15:42:44 -0500
In-Reply-To: <20201111092302.1589-7-roberto.sassu@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
         <20201111092302.1589-7-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_12:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030120
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

On Wed, 2020-11-11 at 10:22 +0100, Roberto Sassu wrote:
> When a file is being created, LSMs can set the initial label with the
> inode_init_security hook. If no HMAC key is loaded, the new file will have
> LSM xattrs but not the HMAC.
> 
> Unfortunately, EVM will deny any further metadata operation on new files,
> as evm_protect_xattr() will always return the INTEGRITY_NOLABEL error. This
> would limit the usability of EVM when only a public key is loaded, as
> commands such as cp or tar with the option to preserve xattrs won't work.
> 
> Ignoring this error won't be an issue if no HMAC key is loaded, as the
> inode is locked until the post hook, and EVM won't calculate the HMAC on
> metadata that wasn't previously verified. Thus this patch checks if an
> HMAC key is loaded and if not, ignores INTEGRITY_NOLABEL.

I'm not sure what problem this patch is trying to solve. 
evm_protect_xattr() is only called by evm_inode_setxattr() and
evm_inode_removexattr(), which first checks whether
EVM_ALLOW_METADATA_WRITES is enabled.

Mimi

