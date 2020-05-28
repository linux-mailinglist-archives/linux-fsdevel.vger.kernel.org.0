Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1728C1E5DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbgE1LDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 07:03:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44826 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbgE1LDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 07:03:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SB2204028445;
        Thu, 28 May 2020 11:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=AbiKRX/dqvcBx3/Gr1Dt2VgVAqB6aC+uNXh9UFbdScg=;
 b=PcsbN6yDWZnVY8qqvNyrN9Cr9rObIpuLRgMNcImys3HhcW+qV/Avpg6h6QWF59CyfKh7
 7BdjLtCF0SEqS/iJieg4+TKNfNEO2eN1C+cwZFeb51yDB4Cu+EFcG5XecQuRrwbfMsWn
 cT4FP6jvdxfyki6Lcc2TeDZGvdtBK+N4LNO04E9yT9/JIb9Y81OF8U8gEueoJ5UdXD4/
 G9z6c4WNF14F4CD03Kw/rftnSryrX8r7nv0FhOlrGpzKss6AsnJd/wthhJ5jgVyXTwTK
 mJ+OwVMTaduKcTRE/pP/V6wwcHVviX8TKyl02m7mCQTiGMlNTeAytXxKNEUwmD86isHb 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 318xbk4cfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 11:02:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SAvc2V111379;
        Thu, 28 May 2020 11:00:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 317j5uxn1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 11:00:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04SB0MER019427;
        Thu, 28 May 2020 11:00:23 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 04:00:22 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4 00/36] Large pages in the page cache
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
Date:   Thu, 28 May 2020 05:00:20 -0600
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <ABDA7F4D-8CBA-4D29-A46C-2359DE271AE8@oracle.com>
References: <20200515131656.12890-1-willy@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280075
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Except for [PATCH v4 36/36], which I can't approve for obvious reasons:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
