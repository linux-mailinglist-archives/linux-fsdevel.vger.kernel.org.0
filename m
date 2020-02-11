Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B641593BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 16:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBKPuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 10:50:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728655AbgBKPuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:50:11 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BFmwIu047949
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 10:50:10 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn3yj3u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 10:50:09 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Tue, 11 Feb 2020 15:50:00 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Feb 2020 15:49:57 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01BFnusZ53411946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 15:49:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27AD9A4051;
        Tue, 11 Feb 2020 15:49:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCA2DA404D;
        Tue, 11 Feb 2020 15:49:55 +0000 (GMT)
Received: from thinkpad (unknown [9.152.96.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Feb 2020 15:49:55 +0000 (GMT)
Date:   Tue, 11 Feb 2020 16:49:54 +0100
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 4/7] s390,dcssblk,dax: Add dax zero_page_range
 operation to dcssblk driver
In-Reply-To: <20200211151114.GA8590@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
        <20200207202652.1439-5-vgoyal@redhat.com>
        <20200210215315.27b7e310@thinkpad>
        <20200211151114.GA8590@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021115-0008-0000-0000-00000351EC9C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021115-0009-0000-0000-00004A728E57
Message-Id: <20200211164954.4df79b8b@thinkpad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_04:2020-02-10,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Feb 2020 10:11:14 -0500
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Feb 10, 2020 at 09:53:15PM +0100, Gerald Schaefer wrote:
> > On Fri,  7 Feb 2020 15:26:49 -0500
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > Add dax operation zero_page_range for dcssblk driver.
> > > 
> > > CC: linux-s390@vger.kernel.org
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  drivers/s390/block/dcssblk.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> > > index 63502ca537eb..331abab5d066 100644
> > > --- a/drivers/s390/block/dcssblk.c
> > > +++ b/drivers/s390/block/dcssblk.c
> > > @@ -57,11 +57,28 @@ static size_t dcssblk_dax_copy_to_iter(struct dax_device *dax_dev,
> > >  	return copy_to_iter(addr, bytes, i);
> > >  }
> > >  
> > > +static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev, u64 offset,
> > > +				       size_t len)
> > > +{
> > > +	long rc;
> > > +	void *kaddr;
> > > +	pgoff_t pgoff = offset >> PAGE_SHIFT;
> > > +	unsigned page_offset = offset_in_page(offset);
> > > +
> > > +	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> > 
> > Why do you pass only 1 page as nr_pages argument for dax_direct_access()?
> > In some other patch in this series there is a comment that this will
> > currently only be used for one page, but support for more pages might be
> > added later. Wouldn't it make sense to rather use something like
> > PAGE_ALIGN(page_offset + len) >> PAGE_SHIFT instead of 1 here, so that
> > this won't have to be changed when callers will be ready to use it
> > with more than one page?
> > 
> > Of course, I guess then we'd also need some check on the return value
> > from dax_direct_access(), i.e. if the returned available range is
> > large enough for the requested range.
> 
> I left it at 1 page because that's the current limitation of this
> interface and there are no callers which are zeroing across page
> boundaries.
> 
> I prefer to keep it this way and modify it when we are extending this
> interface to allow zeroing across page boundaries. Because even if I add
> that logic, I can't test it.

OK, fine with me.

Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>

