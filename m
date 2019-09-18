Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8AB6017
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 11:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfIRJ1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 05:27:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52220 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfIRJ1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:27:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8I98uK0036001;
        Wed, 18 Sep 2019 09:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=5W1fcvEd99/AIOIxEczHb9EgxxrI9ZKCVn9mLpgE1DY=;
 b=lMkuL9E22/fDHGZGYGdq4UeC5SmsvGJPm1jemC461wOrRlCJRuuu/+/JcgNExra+s8Mf
 Z/tF3XlJX6OyYs2M7n7ZaUo2Z5fZgUgou5AYx75K0JBluBD3nmV1ot/5EEKrIUJV6esR
 dD/0NnDsuB6Duc2+tQrLR79ZpIcpuENYTvDGuvJfYFVWswA5ALy/O9+jdGXfFzRo2raa
 4tv4hudsFVUcsQd47Wwf0ZX90JmZXCOtKpR/pWEp8zA2e/CqqoT0piBKKTps2IMbCvRA
 wjd4xIIL6HUeWEKOxR3ffNdvNazYCzbbkwvM2MM9y6mi9ZLva+mZ8s9zuW1GvvLMWWw1 fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v385dtj58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 09:27:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8I994QC176154;
        Wed, 18 Sep 2019 09:25:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v37mm8fts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 09:25:08 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8I9P56v026455;
        Wed, 18 Sep 2019 09:25:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 02:25:04 -0700
Date:   Wed, 18 Sep 2019 12:24:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ju Hyung Park <qkrwngud825@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linkinjeon@gmail.com, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190918092405.GC2959@kadam>
References: <8998.1568693976@turing-police>
 <20190917053134.27926-1-qkrwngud825@gmail.com>
 <20190917054726.GA2058532@kroah.com>
 <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
 <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
 <20190918061605.GA1832786@kroah.com>
 <20190918063304.GA8354@jagdpanzerIV>
 <20190918082658.GA1861850@kroah.com>
 <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180094
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 06:01:09PM +0900, Ju Hyung Park wrote:
> On Wed, Sep 18, 2019 at 5:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > He did?  I do not see a patch anywhere, what is the message-id of it?
> 
> I'm just repeating myself at this point, but again, I'm more than
> willing to work on a patch.
> I just want to make it clear on how should I.

Put it in drivers/staging/sdfat/.

But really we want someone from Samsung to say that they will treat
the staging version as upstream.  It doesn't work when people apply
fixes to their version and a year later back port the fixes into
staging.  The staging tree is going to have tons and tons of white space
fixes so backports are a pain.  All development needs to be upstream
first where the staging driver is upstream.  Otherwise we should just
wait for Samsung to get it read to be merged in fs/ and not through the
staging tree.

regards,
dan carpenter


