Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9620A55303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfFYPO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 11:14:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37326 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbfFYPO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:14:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PExNDK094537;
        Tue, 25 Jun 2019 15:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=IXbQMBUbtCIIr1mOjSVGL1BgfqSaXGiwUmB2FLObFYI=;
 b=ExMmb0/BrxogP4olWFPjlHSC5RDuwkGNovCXfcsezLYjME3UxEmEoz1g85Cn6R2pFf7+
 PRVZdHNDgSsOQNn6yZ1uW0bkyLoFEDJzmlxLdIKv6e+OMrhWkqZneM1Sj3jv6gLXOSuE
 BlUCMT6m1FmGRB1bl/SMC9p8XmBv8klBf5wWA83EMUX6NXShmld7MgENjb8wGeama4Ff
 bLaZUVoKHZQVZDsxzOMU+ttcj4+6JbJHh68XXcZH4VxcoGwdwaZoODd051Zd/Ioer+i/
 Qkh8VLqZcUhIhjSAFtvBJFJht4ulAOEHP8MoFPCZdTKTY4IDEYY84eJqYXOcf+LiT2wo /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pmyv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 15:14:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PFDOfw115391;
        Tue, 25 Jun 2019 15:13:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7c9u33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 15:13:59 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PFDwx7021960;
        Tue, 25 Jun 2019 15:13:58 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 08:13:58 -0700
Date:   Tue, 25 Jun 2019 08:13:57 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] xfs: initialize ioma->flags in xfs_bmbt_to_iomap
Message-ID: <20190625151357.GA2230847@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-5-hch@lst.de>
 <20190624145707.GH5387@magnolia>
 <20190625100701.GG1462@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625100701.GG1462@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=817
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=869 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:07:01PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 24, 2019 at 07:57:07AM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 24, 2019 at 07:52:45AM +0200, Christoph Hellwig wrote:
> > > Currently we don't overwrite the flags field in the iomap in
> > > xfs_bmbt_to_iomap.  This works fine with 0-initialized iomaps on stack,
> > > but is harmful once we want to be able to reuse an iomap in the
> > > writeback code.
> > 
> > Is that going to affect all the other iomap users, or is xfs the only
> > one that assumes zero-initialized iomaps being passed into
> > ->iomap_begin?
> 
> This doesn't affect any existing user as they all get a zeroed iomap
> passed from the caller in iomap.c.  It affects the writeback code
> once it uses struct iomap as it overwrites a previously used iomap.

Then shouldn't this new writeback code zero the iomap before calling
back into the filesystem, just to maintain consistent behavior?

--D
