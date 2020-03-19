Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5370A18B292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCSLuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 07:50:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42364 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCSLuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:50:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JBgsVq127221;
        Thu, 19 Mar 2020 11:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=v7zEP7RtOUJktHuCXePFovWTz/T8i1lu/X2pjX1Hbbo=;
 b=q1IDVvl5ksTsjXMbCDWj+a3knqn+SAHj/kDVhAi11PV27RLxJ7D84msk3su8F04N1ajL
 VtqrcyTWBH0XhNSdSJ+JoSXHTgADauE0jfg1mDGVKuEw3I+JKcprJZAQNJ67JazR1VfE
 s3nm4Mf2oLZniCcfJJdP7T/ANyYbU4s+dxO14S5bHxqvtm+OOPUw9aIFsxOexf+QnfE4
 nS1BcO0nXJUGlSbAjYbOp8Kg+MDPXQTVBjY8E/fEVMcttJpKG8oLSAmAMwFBF0da2i3V
 rtwh4u6bTlBb4uIs0HtIYHl1MWNpOrxuuhyAWktvecikT5IAiVm05EkMOiaYi9QZ7L5m CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2yrpprfua2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 11:49:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JBgha2113568;
        Thu, 19 Mar 2020 11:49:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 2ys8rkw5nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 11:49:43 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02JBngEO129865;
        Thu, 19 Mar 2020 11:49:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ys8rkw5mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 11:49:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02JBnfQm014664;
        Thu, 19 Mar 2020 11:49:41 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 04:49:41 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v8 00/25] Change readahead API
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
Date:   Thu, 19 Mar 2020 05:49:38 -0600
Cc:     linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <09A89B86-9F2E-4829-9180-AA81320CE2FE@oracle.com>
References: <20200225214838.30017-1-willy@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=768 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190054
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
