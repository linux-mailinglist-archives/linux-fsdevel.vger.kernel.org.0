Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45607D6493
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbfJNOCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 10:02:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35280 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732349AbfJNOCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:02:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EDwYKK056094;
        Mon, 14 Oct 2019 14:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=U4Ap3qX4222IhzvGvT6XRHvbQ/1R+kRuwOXgwxPQee8=;
 b=aIa2stPu5UKaHj7gDAL/swT8Be11gfKezLOGWiK9NTguJgt1dSOxTPu7vkDEuGlf7QoY
 kZVS9J6pYtirh5oioVPyCsb/UkZVXQ5ihKML9PMA9jzvKiH6eiBX3iLoomVhoGbIp37Y
 cxQpBnrIMTdVO3AZEv0sXIzVqsi7Wu/iyBr+7NoLwuEXYjfChKepna292qjbX/os1+VU
 BQd2qaHImWJaYIFjpVP7Y/GrUcQBk6xSzEIp9Vid4aiQtcezQS/tNMESlY6d34yDguiV
 ljPXtTt/KMAK3JXzEZ76iAs78AGIAJLAp17IJFhtEnLhg8rM4q/Zy946jzp4AUgW8KRb tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vk68u94uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 14:02:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EDhIje038365;
        Mon, 14 Oct 2019 14:02:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vks06u8vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 14:02:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9EE2FAF013833;
        Mon, 14 Oct 2019 14:02:17 GMT
Received: from dhcp-10-175-191-179.vpn.oracle.com (/10.175.191.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 14:02:15 +0000
Date:   Mon, 14 Oct 2019 15:02:03 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-191-179.vpn.oracle.com
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        joe.lawrence@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        schowdary@nvidia.com, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, changbin.du@intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 linux-kselftest-test 0/3] kunit: support building
 core/tests as modules
In-Reply-To: <20191014092051.GZ16384@42.do-not-panic.com>
Message-ID: <alpine.LRH.2.20.1910141452470.6620@dhcp-10-175-191-179.vpn.oracle.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com> <20191014092051.GZ16384@42.do-not-panic.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 14 Oct 2019, Luis Chamberlain wrote:

> On Tue, Oct 08, 2019 at 03:55:43PM +0100, Alan Maguire wrote:
> > The current kunit execution model is to provide base kunit functionality
> > and tests built-in to the kernel.  The aim of this series is to allow
> > building kunit itself and tests as modules.  This in turn allows a
> > simple form of selective execution; load the module you wish to test.
> > In doing so, kunit itself (if also built as a module) will be loaded as
> > an implicit dependency.
> > 
> > Because this requires a core API modification - if a module delivers
> > multiple suites, they must be declared with the kunit_test_suites()
> > macro - we're proposing this patch as a candidate to be applied to the
> > test tree before too many kunit consumers appear.  We attempt to deal
> > with existing consumers in patch 1.
> 
> This is neat and makes sense to me.

Thanks for taking a look!

> However the ordering of the patches
> seems odd. If modules depend on kunit module, then shouldn't that go
> first? Ie, we want this to be bisectable in proper order.
> 

The reasoning here is it seemed a more likely scenario that users mught  
build kunit built-in (CONFIG_KUNIT=y) along with test suites built as 
modules (CONFIG_KUNIT_TEST=m). So the intermediate state after patch 2 - 
tests buildable as modules while kunit is still built-in-only - made more 
sense to me as something users might do in practice so that's why I 
ordered things that way.  I'm working on a new revision of the patchset
though, so if you feel strongly about this shout and I'll try and accommodate
the alternative ordering.

Thanks!

Alan  

>   Luis
> 
