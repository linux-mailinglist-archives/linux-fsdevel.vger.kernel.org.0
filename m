Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E55623F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfFZGS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 02:18:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41346 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZGS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:18:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q69Fjf174599;
        Wed, 26 Jun 2019 06:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6BDe7KrSfyrk0N8EkoAe7mWONmbNyYLrrjOaqe/97HA=;
 b=nMJdl0t+x2/tZNVW0YDI5WB+O0ihE+k3c0h6G2X0R4MdKo07dpOkdeLEiy9pW1x3wqyE
 C+ZJPXNu+Fzeww0XC6pAJOi4mPyQWuMwQbrCZKddt6NSZ35fNNrvQHTViJblGmRIblG2
 dbjfkHxbwNh+xssYmXG/PUCZbYVPkjv+MZfE7ouYhiYVchVoy2rdDe1oqiu8EEav2KCD
 H2moyhLbbJlwr3y5loq2LvMaTKfMfgIZlEW9cvRYGhXy02Te9dPI/toLf55WMDD8vG2W
 hdzgzt5gbTjADmoN/7JaIxZa3WiTNgs0jaPYfgIc8mTusbybZS1DUAkFcIRozTWxN8o4 lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t9c9pr7nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 06:18:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q6Hten078114;
        Wed, 26 Jun 2019 06:18:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f49f97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 06:18:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q6I9fa014602;
        Wed, 26 Jun 2019 06:18:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 23:18:09 -0700
Date:   Wed, 26 Jun 2019 09:18:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] orangefs: remove redundant assignment to variable
 buffer_index
Message-ID: <20190626061801.GA18776@kadam>
References: <20190511132700.4862-1-colin.king@canonical.com>
 <CAOg9mSQt42NQu-3nwZOCGOPx45y7G8aaiDaVe4SwotGnD9iY1A@mail.gmail.com>
 <20190521150311.GL31203@kadam>
 <CAOg9mSQmV=BDMpTNLJvb4QBr=f96qg4Hr9qu=bB6xZubB+1LZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSQmV=BDMpTNLJvb4QBr=f96qg4Hr9qu=bB6xZubB+1LZQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260074
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:55:11PM -0400, Mike Marshall wrote:
> >> You often send these patches before they hit linux-next so I had skipped
> >> reviewing this one when you sent it.
> 
> I know Linus is likely to refuse pull requests for stuff that
> has not been through linux-next, so I make sure stuff has been
> there at least a few days before asking for it to be pulled.
> "A few days" is long enough for robots to see it, perhaps not
> long enough for humans. I especially appreciate the human review. One of
> the good things about Orangefs is that it is easy to install and configure,
> especially for testing. Documentation/filesystems/orangefs.txt has
> instructions for dnf installing orangefs on Fedora, and also how to download
> a source tarball and install from that.

No, no, that comment was to Colin.  It's good that he's sending patches
for all the trees as soon as possible like the zero day bot does.  But
it does make it hard to review at times.

regards,
dan carpenter

