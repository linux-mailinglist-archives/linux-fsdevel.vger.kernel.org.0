Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4A55607
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfFYRfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 13:35:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731942AbfFYRfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:35:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PHWFis062918
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 13:35:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbnw1p0s4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 13:35:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 25 Jun 2019 18:35:50 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 18:35:45 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5PHZjvB52625554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 17:35:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2AF35204E;
        Tue, 25 Jun 2019 17:35:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.8])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BCB9952059;
        Tue, 25 Jun 2019 17:35:43 +0000 (GMT)
Subject: Re: [PATCH v4 00/14] ima: introduce IMA Digest Lists extension
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        dmitry.kasatkin@huawei.com, mjg59@google.com,
        Rob Landley <rob@landley.net>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Tue, 25 Jun 2019 13:35:33 -0400
In-Reply-To: <88d368e6-5b3c-0206-23a0-dc3e0aa385f0@huawei.com>
References: <20190614175513.27097-1-roberto.sassu@huawei.com>
         <9029dd14-1077-ec89-ddc2-e677e16ad314@huawei.com>
         <88d368e6-5b3c-0206-23a0-dc3e0aa385f0@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062517-0012-0000-0000-0000032C52A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062517-0013-0000-0000-000021658924
Message-Id: <1561484133.4066.16.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc'ing Rob Landley]

On Tue, 2019-06-25 at 14:57 +0200, Roberto Sassu wrote:
> Mimi, do you have any thoughts on this version?

I need to look closer, but when I first looked these changes seemed to
be really invasive.  Let's first work on getting the CPIO xattr
support upstreamed.  Rob Landley said he was going to review and test
them.  Do you have any documentation on how to set up a test
environment?  I'd really appreciate if others would also help with
reviewing the CPIO patches.

thanks!

Mimi

