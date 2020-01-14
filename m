Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309D913A134
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 07:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgANG7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 01:59:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57750 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgANG7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:59:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E6wuax189199;
        Tue, 14 Jan 2020 06:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Um3aq13bt3KE8FaQoSHBOGx9xF1pyNNvuGHu3EV01Lg=;
 b=bwSScmx96s4yKtSNq2SZAalf38tHkEjLxLXLH0i7GgzsalBbDpDbuafNPtg9OBNw5hHD
 +Wnqy3cZbhidEUkZpVIuSO+O5p3AshrjC8HTQekJ4Egk7cov7XSfWPxkX+Xq6Sv/Y2JO
 xeRojrUAJyP2rFn4hCvDwkTawdb7rhsRrrfUuylEjLqmoltt9pGiSuXxIwc7YmOqF/Yu
 KZl5Yq7PWzxhpz4TZi4UK9aTsNaDgBGn6je5Emo5QjGOqXwCgieyKqAgzDnvHJxznHhF
 IMl/cdc8vk8m+ufDSsbmp4OsurT2tZiR6h2EA+VDdufYHfeaznprgga8tUF9Soiri2dl 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74s3xdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:59:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E6xJo4074324;
        Tue, 14 Jan 2020 06:59:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xh8ergxrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:59:28 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00E6x2HU012071;
        Tue, 14 Jan 2020 06:59:02 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 22:59:01 -0800
Date:   Tue, 14 Jan 2020 09:58:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     syzbot <syzbot+79eb0f3df962caf839ed@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: kernel BUG at fs/namei.c:LINE!
Message-ID: <20200114065854.GA3719@kadam>
References: <00000000000008132d059c13c47b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000008132d059c13c47b@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=742
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=803 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140060
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:33:10PM -0800, syzbot wrote:
> ------------[ cut here ]------------
> kernel BUG at fs/namei.c:684!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 9764 Comm: syz-executor.0 Not tainted

> 5.5.0-rc5-next-20200113-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011

> RIP: 0010:unlazy_walk+0x306/0x3b0 fs/namei.c:684

>  path_mountpoint.isra.0+0x1d5/0x340 fs/namei.c:2788
>  filename_mountpoint+0x181/0x380 fs/namei.c:2809
>  user_path_mountpoint_at+0x3a/0x50 fs/namei.c:2839
>  ksys_umount+0x164/0xef0 fs/namespace.c:1683

  2289  static const char *path_init(struct nameidata *nd, unsigned flags)
  2290  {
  2291          int error;
  2292          const char *s = nd->name->name;
  2293  
  2294          if (!*s)
  2295                  flags &= ~LOOKUP_RCU;
                        ^^^^^^^^^^^^^^^^^^^^
My guess is that LOOKUP_RCU gets cleared out here.  Maybe the problem
was introduced in commit e56b43b971a7 ("reimplement path_mountpoint()
with less magic") because before we checked LOOKUP_RCU before calling
unlazy_walk().

-       /* If we're in rcuwalk, drop out of it to handle last component */
-       if (nd->flags & LOOKUP_RCU) {
-               if (unlazy_walk(nd))

  2296          if (flags & LOOKUP_RCU)
  2297                  rcu_read_lock();
  2298  

regards,
dan carpenter

