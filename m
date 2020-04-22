Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF151B435D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgDVLga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 07:36:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54522 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgDVLga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:36:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MBWSUR048449;
        Wed, 22 Apr 2020 11:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=p0RVzc+WnEu1YNWU0XnqAO1VOpep+QDM8/eMCEip/YY=;
 b=UMHVE5JLM8wd8wB6q2qC7PH8gxSMk6W2lZhEbNs7WPB1uO9uQU3icY/ygTpE9xIhha1b
 JknhmQVEq8oUNKcQOT/RJTNcuA9q00cBNHrgWFKT6/isP69YrL0vWJSypJq8GMLxb7lu
 BR/UPAbNmR1K98fI49S4M6SHbC63DVsjorEEHAj6+ak3a86ospOh1aGZUDfFD3VWOqKX
 sGDFIfhUBh3hKIX9pqIV5QRcJ61RCKVRbSN/dU3bd4bvV+ZnB7JGiAmDE+OD9U9mm73J
 8N8UcBbIslKq+S59a9JjJo0U6bpTFMBnw7nlhw+FFJI1b15upfhbFVRryptUVAFONjaZ Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30fsgm28e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 11:36:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MBVf4r068288;
        Wed, 22 Apr 2020 11:36:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30gb3tsdmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 11:36:17 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03MBaA9L013317;
        Wed, 22 Apr 2020 11:36:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 04:36:09 -0700
Date:   Wed, 22 Apr 2020 14:35:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        bjorn.andersson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        kbuild-all@lists.01.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200422113558.GJ2659@kadam>
References: <20200420162809.17529-7-scott.branden@broadcom.com>
 <202004221945.LY6x0DQD%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004221945.LY6x0DQD%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 07:17:34PM +0800, kbuild test robot wrote:
> Hi Scott,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on driver-core/driver-core-testing]
> [also build test WARNING on next-20200421]
> [cannot apply to char-misc/char-misc-testing kselftest/next linus/master v5.7-rc2]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Scott-Branden/firmware-add-partial-read-support-in-request_firmware_into_buf/20200422-114528
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 55623260bb33e2ab849af76edf2253bc04cb241f
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-191-gc51a0382-dirty
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
                                           ^^^^^^^^^^^^^^^^^^^

Sorry, you asked me about this earlier.  You will need to add
-D__CHECK_ENDIAN__ to enable these Sparse warnings.

regards,
dan carpenter

