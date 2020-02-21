Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476F9168344
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 17:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBUQ1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 11:27:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48476 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUQ1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:27:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LGIwcx053579;
        Fri, 21 Feb 2020 16:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cJdVhpaS83UqPdlhm3OcGKgICsyiB6IZqLKasmn4brM=;
 b=hcHFpHlQAhdMyb5ODWJhaLjbxIpe7q26O1sXF2xcjiK3IoYep4gxbcljPVQ/+QSswa38
 XR5Yovwr+fozgj5AVR1+kMmHgg93z9KCJF4k7JjxJ1mRQ+0z0TMz5EIoYLK4DJi5DVt4
 6VDCu5AXyKYHnILgXu8lD4jjFkRcMAGrj6HXyzlMIQrwfmpzRlWnNA1JtBhlP8RY+CCP
 DN4FpghX/NVMgUsm6hZbJ8ZGE2ZwjSoqbORPq77ohe/8f0Kgmsdym4kbKLgvJuQMCI7a
 HmYIU3bb5xL7J/kyg9yZWrTZapaysbrFybP1tlmb5uhWVwksqm5dg4QoOz35wGWU+0fw 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8uddhjt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 16:27:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LGIAkS015199;
        Fri, 21 Feb 2020 16:27:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y8udnrapf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 16:27:00 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01LGQxQQ015939;
        Fri, 21 Feb 2020 16:26:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 08:26:58 -0800
Date:   Fri, 21 Feb 2020 08:26:57 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] ext4: Add example fsinfo information [ver #16]
Message-ID: <20200221162657.GG9496@magnolia>
References: <20200219170421.GD9496@magnolia>
 <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204563445.3299825.13575924510060131783.stgit@warthog.procyon.org.uk>
 <1899516.1582296185@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1899516.1582296185@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:43:05PM +0000, David Howells wrote:
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
> > > +	memcpy(ctx->buffer, es->s_volume_name, sizeof(es->s_volume_name));
> > 
> > Shouldn't this be checking that ctx->buffer is large enough to hold
> > s_volume_name?
> 
> Well, the buffer is guaranteed to be 4KiB in size.

Ah, ok.

> > > +	return strlen(ctx->buffer);
> > 
> > s_volume_name is /not/ a null-terminated string if the label is 16
> > characters long.
> 
> And the buffer is precleared, so it's automatically NULL terminated.

<nod>

> > > +#define FSINFO_ATTR_EXT4_TIMESTAMPS	0x400	/* Ext4 superblock timestamps */
> > 
> > I guess each filesystem gets ... 256 different attrs, and the third
> > nibble determines the namespace?
> 
> No.  Think of it as allocating namespace in 256-number blocks.  That means
> there are 16 million of them.  If a filesystem uses up an entire block, it can
> always allocate another one.  I don't think it likely that we'll get
> sufficient filesystems to eat them all.

Ah.  In that case I declare that we would like to reserve 0x5800-0x58FF
for XFS. :)

--D

> David
> 
