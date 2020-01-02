Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5A12E610
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgABM1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 07:27:25 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:48274 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgABM1Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:27:24 -0500
X-Greylist: delayed 1518 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jan 2020 07:27:23 EST
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id 002Bxd4D065936;
        Thu, 2 Jan 2020 14:01:37 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 2x9egur3n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 14:01:37 +0200
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Jan
 2020 14:01:37 +0200
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
CC:     Anton Altaparmakov <anton@tuxera.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 0/3] erofs: remove tags of pointers stored in a radix tree
Date:   Thu, 2 Jan 2020 14:01:15 +0200
Message-ID: <20200102120118.14979-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=838
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020108
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The changeset simplifies a couple of internal interfaces and removes
excessive tagging and untagging of workgroup pointers stored in a radix
tree.

All the changes in the series are non-functional.

Vladimir Zapolskiy (3):
  erofs: remove unused tag argument while finding a workgroup
  erofs: remove unused tag argument while registering a workgroup
  erofs: remove void tagging/untagging of workgroup pointers

 fs/erofs/internal.h |  4 ++--
 fs/erofs/utils.c    | 15 ++++-----------
 fs/erofs/zdata.c    |  5 ++---
 3 files changed, 8 insertions(+), 16 deletions(-)

-- 
2.20.1

