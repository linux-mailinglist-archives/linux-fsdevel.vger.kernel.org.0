Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB18A3039B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 22:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfE3Uyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 16:54:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54950 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Uyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 16:54:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UKsBcM108403;
        Thu, 30 May 2019 20:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ODypozAerLNV/qGeHJPqtJFJozABAAaZHRXDF3WkeeE=;
 b=H1VqQ8Mbp0VXzmkHQ4b5+kN0x7UMsTziL9j2TPr4OvwEe5RtZIrLNRWCBAzhPDrmvtY+
 LneSmuhyriW7u/fRnYl07QeEdAWpU9X2J6ZnqXAimhArpziTJa6LxS18sVe3SIcjFZly
 1lB8qnkhxFsp40rO2F2O6ix/gBh3o9xFTX5Qb9JvKeT6Ut/6zATvBAn1jj7OCtNH5cP/
 nZGwjLFPV0MViT9cUc7ylXDiMfNRbrh9iO+PKBgnegFkPpC8vhw3zQfeKSMl9aAc39D2
 HNWbf6jcazqGJkuIGdURnF3W841tAIFanqF+0omrr8820kRMMn3UnOWnTzokauspVqiK EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2spw4ttnyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 20:54:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UKs4aL156896;
        Thu, 30 May 2019 20:54:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31w3qbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 20:54:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4UKs9TR011670;
        Thu, 30 May 2019 20:54:09 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 13:54:08 -0700
Subject: Re: mmotm 2019-05-29-20-52 uploaded
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20190530035339.hJr4GziBa%akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fac5f029-ef20-282e-b0d2-2357589839e8@oracle.com>
Date:   Thu, 30 May 2019 13:54:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530035339.hJr4GziBa%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=703
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=729 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/19 8:53 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-05-29-20-52 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 

With this kernel, I seem to get many messages such as:

get_swap_device: Bad swap file entry 1400000000000001

It would seem to be related to commit 3e2c19f9bef7e
> * mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch

-- 
Mike Kravetz
