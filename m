Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7367A6C32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfICPG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 11:06:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44788 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICPG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:06:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83F51XX143119;
        Tue, 3 Sep 2019 15:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=mb7r7IpLcqFfuHiQdoaLa2PH8+6dTWhoBQ+QnFEmC5I=;
 b=gvucVr9HSCaL6SaEx1frp7802m/s3eaIztzLFO7UYp8BbowQA3XEqWMsfgbaQmjx8Gw+
 aoA5LqQ7005Z4RoAHfWym+498wDA1ZKjxIzbdzgrV0Skj6MtnPGl1vQrFGIcDUqjs3cm
 AsI3NeiRmExSAHc+jiTekLacNr4MJ2sVXW2fjFbTY6OBAjzT4IcGHF1vJ8MEvIm9bAN8
 NAZzJuaEOncxNViqiBb8euNU1qsoUi4sxzuO4hCzupcL0R/rs1i745YcPN70TAHciq1U
 g73+su6qfcmS/4d3tus/moj3jivJvBHr6/MbLa1FAUWp7KZUXEz+qwxF6sRCiRgrFTTL 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ustgc00yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 15:06:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83F3V8h011814;
        Tue, 3 Sep 2019 15:06:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2usk7dxagd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 15:06:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83F6cnc004679;
        Tue, 3 Sep 2019 15:06:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 08:06:37 -0700
Date:   Tue, 3 Sep 2019 08:06:36 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/15] iomap: Introduce CONFIG_FS_IOMAP_DEBUG
Message-ID: <20190903150636.GF5340@magnolia>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190901200836.14959-2-rgoldwyn@suse.de>
 <20190902162934.GA6263@lst.de>
 <20190902170916.GE568270@magnolia>
 <20190902171800.GA7201@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902171800.GA7201@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 07:18:00PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 10:09:16AM -0700, Darrick J. Wong wrote:
> > On Mon, Sep 02, 2019 at 06:29:34PM +0200, Christoph Hellwig wrote:
> > > On Sun, Sep 01, 2019 at 03:08:22PM -0500, Goldwyn Rodrigues wrote:
> > > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > 
> > > > To improve debugging abilities, especially invalid option
> > > > asserts.
> > > 
> > > Looking at the code I'd much rather have unconditional WARN_ON_ONCE
> > > statements in most places.  Including returning an error when we see
> > > something invalid in most cases.
> > 
> > Yeah, I was thinking something like this, which has the advantage that
> > the report format is familiar to XFS developers and will get picked up
> > by the automated error collection stuff I put in xfstests to complain
> > about any XFS assertion failures:
> > 
> > iomap: Introduce CONFIG_FS_IOMAP_DEBUG
> > 
> > To improve debugging abilities, especially invalid option
> > asserts.
> 
> I'd actually just rather have more unconditional WARN_ON_ONCE calls,
> including actually recovering from the situation by return an actual
> error code.  That is more
> 
> 	if (WARN_ON_ONCE(some_impossible_condition))
> 		return -EIO;

Oh, right, WARNings actually do spit out the file and line number.
Let's do that. :)

--D
