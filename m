Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1190E111D07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 23:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfLCWtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 17:49:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33646 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbfLCWti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:49:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3MY79D110765;
        Tue, 3 Dec 2019 22:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=uYMuACAdoNAl6fAtZMdOLI9RRVa7NSCuglLVW02y4Vk=;
 b=qAfHc5tUR8AnZ+grEo2Tf/wPWys1CJCprYekENY6UUdzeO4NBXQsRnNdeoRnWFFAY71y
 zNME2blxqhZUPE1kvQ+Ihr5PD+qU8zi40EBdO3+d2s9gzDi4yLhHpTAVHa2IW+pgzXHi
 1keQKv7Vj9cq3uwGnik3I4uVN2DmKJkT9XP5WXbIuSs9aLwIPwgtb8bDGb+NXPlLJah5
 xY3pUyiGF3oZsrf/NO2W5d+wofNZtqqQM6/Hovpbg0z9eJlB6AQlFtFSBoKiW19uNezl
 t+PbFit8ec8x0s0tlaiTWXZIXEtIzrOWvio2wvKPxaMS116pu63FlYVcD2WY+yhmpxBg 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wkh2raqfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 22:49:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3MYHoO082700;
        Tue, 3 Dec 2019 22:49:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wnvqx4r8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 22:49:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB3MnHeU021188;
        Tue, 3 Dec 2019 22:49:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 14:49:17 -0800
Date:   Tue, 3 Dec 2019 14:49:15 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [GIT PULL] iomap: small cleanups for 5.5
Message-ID: <20191203224915.GK7335@magnolia>
References: <20191203160856.GC7323@magnolia>
 <CAHk-=wh3vin7WyMpBGWxZovGp51wa=U0T=TXqnQPVMBiEpdvsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3vin7WyMpBGWxZovGp51wa=U0T=TXqnQPVMBiEpdvsQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030165
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 01:21:01PM -0800, Linus Torvalds wrote:
> On Tue, Dec 3, 2019 at 8:09 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > Please pull this series containing some more new iomap code for 5.5.
> > There's not much this time -- just removing some local variables that
> > don't need to exist in the iomap directio code.
> 
> Hmm. The tag message (which was also in the email thanks to git
> request-pull) is very misleading.
> 
> Pulled, but please check these things.

Sorry about that sloppiness, I'll avoid that in the future.

--D

>            Linus
