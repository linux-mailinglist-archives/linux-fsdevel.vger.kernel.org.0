Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72ED7DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbfJORgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:36:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbfJORgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:36:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHYT01087197;
        Tue, 15 Oct 2019 17:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=PDeSdvy/oIndXs7UGXVKV0ZUil/c7Hc7iYCtmUUCAKY=;
 b=o3BEaVJ+4vxDX6h4zeRVCNBr8SN/jmwKGJe9E7wxD78NkCrcY9IkpIFwDqfkRjNkTUho
 CO1rY4CbrkW0VGY8L6veHUP/3wu5+FVyH9Mjmn3Nq+d32QZwIy/N/M8jkCuo6654uSL/
 6Hy4sfxi+REtM2ofM1+bzUcSm8zxYbV22CMLYVRmiOaYYeGQJ2amgGm0I1AKZ0LNQd4Z
 M/3eivNzGOWM9VyxZ5sFfYA7mFMzOV4o8q/tfHW93Ge+03xTGTL0ICnp9Grs5edSWYi8
 WWrWxa7q7SoQsktSiwLVTcoeln6TKiPthlxoH2J/wpAxTvttCVuOqAwtKNAiGJJiR5rV eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68uhq8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 17:36:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHSsfh026247;
        Tue, 15 Oct 2019 17:36:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vn8enke1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 17:36:20 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FHaIxE005003;
        Tue, 15 Oct 2019 17:36:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 17:36:18 +0000
Date:   Tue, 15 Oct 2019 10:36:16 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>, mbobrowski@mbobrowski.org
Subject: Re: [ANNOUNCE] xfs-linux: iomap-5.5-merge updated to c9acd3aee077
Message-ID: <20191015173616.GM13108@magnolia>
References: <20191015164901.GF13108@magnolia>
 <20191015165554.GA10728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015165554.GA10728@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=831
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=919 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:55:54AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 15, 2019 at 09:49:01AM -0700, Darrick J. Wong wrote:
> > 
> > Jan Kara (2):
> >       [13ef954445df] iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
> >       [c9acd3aee077] xfs: Use iomap_dio_rw_wait()
> 
> The second commit seems to be mis-titled as there is no function
> called iomap_dio_rw_wait in that tree.

Yeah.  Jan, can I fix that and repush?

--D
