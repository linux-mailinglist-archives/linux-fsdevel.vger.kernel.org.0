Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0139CA7941
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 05:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfIDDYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 23:24:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50890 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfIDDYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:24:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x843Mauu178986;
        Wed, 4 Sep 2019 03:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=THg7OdVe+H13Wicp3Cku/2yXM5fjaUIJKiClqu9N+6k=;
 b=ml+1imRv3FyfRRKBibYB55RAT0zuUhxlyxyxn5PfjBciWwyXB/CGi7rRpmQCSoic2nwt
 X6hs2+7Ib5gpGV6DrkZ8lo+16HG/GTj/g5XxhPt4UkOZKO9nu7mDt7T4S13BWfbGHpJK
 xCK9T9UpiQRtu5nkpuOMef4VgoK5jrjyK/rPwSX5+b3RH51Pat8P+uBjq6d3UJv03e00
 7PkyIJTkqHkba9FNUaQnsfNVy6gxKRQO716wX5+jeVBMVtCWF+NdtgPbpcf0LK1D/nu7
 iQM/oqJiii79c8WrluV84b+fIEr1Rv0ANQLhc2S7icP40mWjnTZtszpaNz8V28tpH9N1 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ut5a6r08x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 03:23:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x843NguE082969;
        Wed, 4 Sep 2019 03:23:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ut1hmrf4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 03:23:42 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x843NamI026386;
        Wed, 4 Sep 2019 03:23:36 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 20:23:35 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3578.1\))
Subject: Re: [PATCH v5 2/2] mm,thp: Add experimental config option
 RO_EXEC_FILEMAP_HUGE_FAULT_THP
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190903191528.GC14028@dhcp22.suse.cz>
Date:   Tue, 3 Sep 2019 21:23:34 -0600
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>
Content-Transfer-Encoding: 7bit
Message-Id: <4AB1ABA7-B659-41B7-8364-132AD3608FA6@oracle.com>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-3-william.kucharski@oracle.com>
 <20190903121424.GT14028@dhcp22.suse.cz>
 <20190903122208.GE29434@bombadil.infradead.org>
 <20190903125150.GW14028@dhcp22.suse.cz>
 <20190903151015.GF29434@bombadil.infradead.org>
 <20190903191528.GC14028@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3578.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040034
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 3, 2019, at 1:15 PM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> Then I would suggest mentioning all this in the changelog so that the
> overall intention is clear. It is also up to you fs developers to find a
> consensus on how to move forward. I have brought that up mostly because
> I really hate seeing new config options added due to shortage of
> confidence in the code. That really smells like working around standard
> code quality inclusion process.

I do mention a good deal of this in the blurb in part [0/2] of the patch,
though I don't cover the readpage/readpages() debate. Ideally readpage()
should do just that, read a page, based on the size of the page passed,
and not assume "page" means "PAGESIZE."

I can also make the "help" text for the option more descriptive if
desired.

Thanks for your comments!
