Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A67132C8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGRHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:07:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60494 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgAGRHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:07:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007Gxs1i108694;
        Tue, 7 Jan 2020 17:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=TonZdKs5flBwONqESEptkzUdNDu8nb8volKmuzA6Cz0=;
 b=Dg5eAnULbmvdHQzXt/MZgtHB0R/zWD0HQ+5s3azeZp8EEZ34ay8U8IXHjZGsgK27rehS
 bb8ffV2JEBwuogOZg4wcANMgdMBKS97CpXpWk7KU7SVlPQgFUWlVHu1DAfnGryIv1LKI
 M5AvVllmupEsFvrHYTNamVFhNzc87ByL1gWOw0iTmEuPoX1/m7tYqFY+EvYYNZUwGLxG
 1Lo8F+6TNJ6Q1EeRhKR2XXV7l75GPDLV1kYwFuGmzfY9nlZh5W1Im1qMYi7elyFGtzp+
 gnwn6VDCbHk8N4C5wW46kKsyxAWes1ui6aXftOTsyPgLj2wHtLqD0FgPkvrqcDbM/whH 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xajnpxvme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 17:07:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007GxqZk067504;
        Tue, 7 Jan 2020 17:07:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xcpamx72e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 17:07:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 007H7XOT027070;
        Tue, 7 Jan 2020 17:07:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 09:07:33 -0800
Date:   Tue, 7 Jan 2020 09:07:31 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200107170731.GA472641@magnolia>
References: <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com>
 <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > Agree. In retrospect it was my laziness in the dax-device
> > > > implementation to expect the block-device to be available.
> > > >
> > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > dax_device could be dynamically created to represent the subset range
> > > > indicated by the block-device partition. That would open up more
> > > > cleanup opportunities.
> > >
> > > Hi Dan,
> > >
> > > After a long time I got time to look at it again. Want to work on this
> > > cleanup so that I can make progress with virtiofs DAX paches.
> > >
> > > I am not sure I understand the requirements fully. I see that right now
> > > dax_device is created per device and all block partitions refer to it. If
> > > we want to create one dax_device per partition, then it looks like this
> > > will be structured more along the lines how block layer handles disk and
> > > partitions. (One gendisk for disk and block_devices for partitions,
> > > including partition 0). That probably means state belong to whole device
> > > will be in common structure say dax_device_common, and per partition state
> > > will be in dax_device and dax_device can carry a pointer to
> > > dax_device_common.
> > >
> > > I am also not sure what does it mean to partition dax devices. How will
> > > partitions be exported to user space.
> >
> > Dan, last time we talked you agreed that partitioned dax devices are
> > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > devices and then remove them after a cycle or two?
> 
> That does seem a better plan than trying to force partition support
> where it is not needed.

Question: if one /did/ have a partitioned DAX device and used kpartx to
create dm-linear devices for each partition, will DAX still work through
that?

--D
