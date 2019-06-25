Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B242D55272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfFYOr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 10:47:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfFYOr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:47:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PEdNRQ167283;
        Tue, 25 Jun 2019 14:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=tVz8kO2gLLHtnMQan5xim91ffyHoI4bPRMULVju7siQ=;
 b=yEWHk7koXcYLvNUFHCQOzZnDhasDLXBZbbvf8R5hJN3XakAgl0CmyBUReSsw49cr/l3D
 c9+hdlZXXhQadF2mlLFL1UaSgNSDIKnsSvK1HDlirE7A1UZjF/v3vcR30y7c/mc5TKv4
 WzrxkMYl1oin4mukoAdj1d1bQYQgZ9zZs4tV5PGMS1nfyxZ7XCpIK7iW5bjfd/VzmEcS
 rm0QC5qdLFnSWTF862B9EuEk9s2H4GT6kA2DtBFRE+YNYZypzFRRaIxoDuqSvRMfbcGu
 TSW6ub+a7IzXE18YHSi9XpdEQbVb1hR4Wt6qo3cSSioMNTZ4oYWWYy9FEP1KWpz5l3eb tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brt4vqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 14:47:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PEjPs2036229;
        Tue, 25 Jun 2019 14:47:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7c9bgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 14:47:09 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PEl8qd002530;
        Tue, 25 Jun 2019 14:47:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 07:47:08 -0700
Date:   Tue, 25 Jun 2019 07:47:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] iomap: add tracing for the address space operations
Message-ID: <20190625144707.GC5379@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-13-hch@lst.de>
 <20190624234921.GE7777@dread.disaster.area>
 <20190625101515.GL1462@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625101515.GL1462@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:15:15PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 09:49:21AM +1000, Dave Chinner wrote:
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM iomap
> > 
> > Can you add a comment somewhere here that says these tracepoints are
> > volatile and we reserve the right to change them at any time so they
> > don't form any sort of persistent UAPI that we have to maintain?
> 
> Sure.  Note that we don't have any such comment in xfs either..

I think we ought to add a comment to both of the tracepoint header files
in xfs then...

--D
