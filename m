Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36495B818C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392402AbfISTkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 15:40:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34556 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389763AbfISTkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:40:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JJdtZ1129699;
        Thu, 19 Sep 2019 19:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=eoBFyeHnqRPVXd6r1Kl8LOxweom0QXkdhaTP9ZYMu/4=;
 b=jQ9sq3FXVe/QF3ey7wddzaWO2rjQI3OOaEJn1n9iEIk4Nk60GK4zLHqOg09kTCUaMSc4
 Zpjzl2++hHsDV1+VDCMu7vqjOLb/VivHta71zXVaPQiKFbodK3ol85llwBkhYZ8ZmN3H
 7NB2QzuHSjek3iRj87a7ajqFUbjLr6RoVJ16DzcmS8yAFiEXmFfIMHtDvlrR5pYiZKKX
 h1msXSS6t0Rz1mWZPlJtvEzJLl2QkeE/iWVowIFmZknCD25U2amE/4CDE/U0lj3+sqFc
 h+0CzcXPW/OqYeYDi7U6OKfTa2+PUsjXP34vpUtYmeTZdvxsR6KpxREBxwrkoSgkg3DG wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v3vb4p6cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 19:40:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JJci4t168492;
        Thu, 19 Sep 2019 19:40:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2v3vbb5bfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 19:40:13 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8JJeCQc002801;
        Thu, 19 Sep 2019 19:40:12 GMT
Received: from localhost (/10.145.179.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 12:40:12 -0700
Date:   Thu, 19 Sep 2019 12:40:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [ANNOUNCE] xfs-linux: iomap-5.4-merge rebased to 1b4fdf4f30db
Message-ID: <20190919194011.GN2229799@magnolia>
References: <20190919153704.GK2229799@magnolia>
 <BYAPR04MB581608DF1FDE1FDC24BD94C6E7890@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190919170804.GB1646@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919170804.GB1646@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190165
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:08:04AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 19, 2019 at 04:19:37PM +0000, Damien Le Moal wrote:
> > OK. Will do, but traveling this week so I will not be able to test until next week.
> 
> Which suggests zonefs won't make it for 5.4, right?  At that point
> I wonder if we should defer the whole generic iomap writeback thing
> to 5.5 entirely.  The whole idea of having two copies of the code always
> scared me, even more so given that 5.4 is slated to be a long term
> stable release.
> 
> So maybe just do the trivial typo + end_io cleanups for Linus this
> merge window?

I for one don't mind pulling back to just these three patches:

iomap: Fix trivial typo
iomap: split size and error for iomap_dio_rw ->end_io
iomap: move the iomap_dio_rw ->end_io callback into a structure

But frankly, do we even need the two directio patches?  IIRC Matthew
Bobrowski wanted them for the ext4 directio port, but seeing as Ted
isn't submitting that for 5.4 and gfs2 doesn't supply a directio endio
handler, maybe I should just send the trivial typo fix and that's it?

I hate playing into this "It's an LTS but Greg won't admit it" BS but
I'm gonna do it anyway -- for any release that's been declared to be an
LTS release, we have no business pushing new functionality (especially
if it isn't going to be used by anyone) at all.  It would have been
helpful to have had such a declaration as a solid reason to push back
against riskier additions, like I did for the last couple of LTSes.

(And since I didn't have such a tool, I was willing to push the
writeback bits anyway for the sake of zonefs since it would have been
the only user, but seeing as Linus rejected zonefs for lack of
discussion, I think that (the directio api change; iomap writeback; and
zonefs) is just going to have to wait for 5.5.)

<frustrated>

--D
