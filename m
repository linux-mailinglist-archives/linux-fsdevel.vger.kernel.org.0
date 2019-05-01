Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B498109C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 17:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfEAPHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 11:07:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56058 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEAPHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 11:07:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x41ExMG3168304;
        Wed, 1 May 2019 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Q8eGFCnQ0LTZ5owUi28FCcA36LPqeTtkuqRUrAAOMqQ=;
 b=QPg18rZz1fDX726lTOySzky3amPtJJUw6SD7G0DDF5/b/Q8BdfUVQdFCD+qjAme3MQBQ
 35uCtb22qCOLQsVnPL8Ne9MPtoTpPCoyJxKtSc2M2NvnV3p/QGMJl5AQPD1om2PPT0l1
 wLm3GwTRyF/HTKS8nMrL3+md+IPUgf4sv1xtXb74snMNqeqmo9A0IBTVc1hhot5M7bvX
 QIxWFgDF39qDaWsa89ROith7S4en1arnd4ozOqg+ZgtrVQnPjLiTjHkZHu7kk7ESdMLO
 qEqxPLDUG6Z7zFPwzHyIF4OVPK/7qpNOe1HQxzLTRhOmrT3XQK2AgEdjKaM0+A7ki+st yA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2s6xhyb4wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 May 2019 15:06:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x41F535g143581;
        Wed, 1 May 2019 15:06:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s6xhgj8bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 May 2019 15:06:41 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x41F6cto020498;
        Wed, 1 May 2019 15:06:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 May 2019 08:06:38 -0700
Date:   Wed, 1 May 2019 08:06:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/5] iomap and gfs2 fixes
Message-ID: <20190501150637.GG5217@magnolia>
References: <20190429220934.10415-1-agruenba@redhat.com>
 <20190430025028.GA5200@magnolia>
 <20190430212146.GL1454@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430212146.GL1454@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905010096
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905010096
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 07:21:46AM +1000, Dave Chinner wrote:
> On Mon, Apr 29, 2019 at 07:50:28PM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 30, 2019 at 12:09:29AM +0200, Andreas Gruenbacher wrote:
> > > Here's another update of this patch queue, hopefully with all wrinkles
> > > ironed out now.
> > > 
> > > Darrick, I think Linus would be unhappy seeing the first four patches in
> > > the gfs2 tree; could you put them into the xfs tree instead like we did
> > > some time ago already?
> > 
> > Sure.  When I'm done reviewing them I'll put them in the iomap tree,
> > though, since we now have a separate one. :)
> 
> I'd just keep the iomap stuff in the xfs tree as a separate set of
> branches and merge them into the XFS for-next when composing it.
> That way it still gets plenty of test coverage from all the XFS
> devs and linux next without anyone having to think about.
> 
> You really only need to send separate pull requests for the iomap
> and XFS branches - IMO, there's no really need to have a complete
> new tree for it...

<nod> That was totally a braino on my part -- I put the patches in the
iomap *branch* since now we have a separate *branch*. :)

(and just merged that branch into for-next)

--D

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
