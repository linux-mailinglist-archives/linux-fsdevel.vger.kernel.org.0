Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B661B588
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfEMMJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 08:09:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729670AbfEMMJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 08:09:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DC7XCW113686
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 08:09:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sf6gmmrng-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 08:09:46 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 13 May 2019 13:08:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 May 2019 13:08:45 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4DC8iT146268554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 12:08:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0727A405B;
        Mon, 13 May 2019 12:08:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9BA3A4054;
        Mon, 13 May 2019 12:08:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.35])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 May 2019 12:08:43 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Rob Landley <rob@landley.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Arvind Sankar <niveditas98@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
Date:   Mon, 13 May 2019 08:08:33 -0400
In-Reply-To: <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
         <20190512194322.GA71658@rani.riverdale.lan>
         <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
         <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051312-4275-0000-0000-0000033434AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051312-4276-0000-0000-00003843B06F
Message-Id: <1557749313.10635.309.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130086
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-05-13 at 04:07 -0500, Rob Landley wrote:

> > Allowing a kernel with integrity enforcement to parse the CPIO image
> > without verifying it first is the weak point.
> 
> If you don't verify the CPIO image then in theory it could have anything in it,
> yes. You seem to believe that signing individual files is more secure than
> signing the archive. This is certainly a point of view.

Nobody is claiming that signing and verifying individual files is more
secure.  We are saying that in some environments BOTH are needed.  In
many environments today the initramfs IS being signed and verified.

Unfortunately not all environments can sign the initramfs today,
because the initramfs is not distributed with the kernel image, but
generated on the target system.

Mimi

