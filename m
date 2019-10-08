Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8971CFD5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfJHPQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:16:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36682 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfJHPQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:16:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FCpaM126200;
        Tue, 8 Oct 2019 15:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=G3hEXpcqfex8tKkgNX8GKdCKE+z2Dp/2HG2CbwOSfg0=;
 b=Y/UWuuHgnhvwYn3IWR4zKaD1rSQ/rjm71tVZQVCqYNZFNBNGrbgZVRCsTXxHEVR8yLOZ
 9aY11pb4lr+XCfrd8bN+lEIEX3L+ygZfdyZPCQFyyzYEZ9FPeYfpToKXs6VTE7yC7Nd/
 rFvt5K+lc0lSwAFSTBLtUF3tA/md7ZwZ6LIGXM1V9F5/znaFpzOBZGuL1XT0mD3efiBX
 5mazH27pI22iMWTifvxp5IJChrmIpXVCb/w0IhRF3xqbK8sW0GmDs40PPOz9e762czG+
 9tbefRrROSNUIVjhut6bj5p9qiHMbhdcTM7TM8WA/NrK+5i8RwCn7HNTAJ5P7XhAkMpZ JA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejkue1p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:15:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FFIKj143243;
        Tue, 8 Oct 2019 15:15:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vg206hdkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:15:32 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98FFJa2016720;
        Tue, 8 Oct 2019 15:15:19 GMT
Received: from dhcp-10-175-191-48.vpn.oracle.com (/10.175.191.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 15:15:18 +0000
Date:   Tue, 8 Oct 2019 16:15:09 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-191-48.vpn.oracle.com
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, changbin.du@intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Knut Omang <knut.omang@oracle.com>,
        rdunlap@infradead.org
Subject: Re: [PATCH linux-kselftest-test 2/3] kunit: allow kunit to be loaded
 as a module
In-Reply-To: <20191008145552.GS32742@smile.fi.intel.com>
Message-ID: <alpine.LRH.2.20.1910081611050.839@dhcp-10-175-191-48.vpn.oracle.com>
References: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com> <1570545832-32326-3-git-send-email-alan.maguire@oracle.com> <20191008145552.GS32742@smile.fi.intel.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Oct 2019, Andy Shevchenko wrote:

> On Tue, Oct 08, 2019 at 03:43:51PM +0100, Alan Maguire wrote:
> > Making kunit itself buildable as a module allows for "always-on"
> > kunit configuration; specifying CONFIG_KUNIT=m means the module
> > is built but only used when loaded.  Kunit test modules will load
> > kunit.ko as an implicit dependency, so simply running
> > "modprobe my-kunit-tests" will load the tests along with the kunit
> > module and run them.
> 
> > +#ifdef MODULE
> 
> > +#endif /* MODULE */
> 
> This is strange. Why do you need ifdef?
>

Ah, this was an incorrect assumption on my part; I thought that
declaring a module license for built-in code might trigger a warning 
during build. I'll remove the #ifdef MODULE around licenses in v3 (v2 has 
already gone out as I mistakenly initially sent the wrong version of the 
patches). I've verified that removing it triggers no warnings.

Thanks to you and Randy for spotting this!

Alan

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
