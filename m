Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73A01BD3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEMSgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 14:36:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbfEMSgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 14:36:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DIWLcC122347
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 14:36:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sfawwr3pg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 14:36:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 13 May 2019 19:36:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 May 2019 19:36:37 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4DIaaZE48169038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 18:36:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04BB4A406E;
        Mon, 13 May 2019 18:36:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5484A4059;
        Mon, 13 May 2019 18:36:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 May 2019 18:36:34 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Arvind Sankar <niveditas98@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org
Date:   Mon, 13 May 2019 14:36:24 -0400
In-Reply-To: <20190513175250.GC69717@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
         <20190512194322.GA71658@rani.riverdale.lan>
         <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
         <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
         <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
         <20190513172007.GA69717@rani.riverdale.lan>
         <20190513175250.GC69717@rani.riverdale.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051318-0012-0000-0000-0000031B3DE0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051318-0013-0000-0000-00002153D1F8
Message-Id: <1557772584.4969.62.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=975 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> > How does this work today then? Is it actually the case that initramfs
> > just cannot be used on an IMA-enabled system, or it can but it leaves
> > the initramfs unverified and we're trying to fix that? I had assumed the
> > latter.
> Oooh, it's done not by starting IMA appraisal later, but by loading a
> default policy to ignore initramfs?

Right, when rootfs is a tmpfs filesystem, it supports xattrs, allowing
for finer grained policies to be defined.  This patch set would allow
a builtin IMA appraise policy to be defined which includes tmpfs.

Mimi

