Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9AE96F03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 03:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfHUBnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 21:43:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHUBnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:43:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L1dBKU019489;
        Wed, 21 Aug 2019 01:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=w6b8o4+pJHqTlJ40Y3niZtVtKkdml7k+mWU6xWb/k6c=;
 b=kHnc+Vs/JCCvvwXdC2NsmG/8wr9DWrJN585WmzJJZSMimRi4aSl9+zrt3/7pGht+7hW5
 VLC/3Ja0/EfrzBFDHejds6nQN7JFMCfonAiF4ayuo2URi/0pGHX2F6WrMLBTGO/gaFU0
 dh5yQMSLKcggugBeER5gQpCGxxIdHkqAwnQnxlrqpnHsRMEa374srWoeqEd7jU+zCnd1
 o8lzK+TJxd+e6gdB4P0NovTV8ZZWXXmHDryCONyELbqO9/syodQDOeJwlISkwAUVdVGP
 e8NV6S8A2vTY3r6qtc4joe6FLg+lRH/uNdkJxpbk1Ac1rhWKjwm9NgdY+YfCQjdNboM3 rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ue9hpj2qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 01:43:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L1hes1186949;
        Wed, 21 Aug 2019 01:43:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ug269dbb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 01:43:40 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7L1hYGo025974;
        Wed, 21 Aug 2019 01:43:35 GMT
Received: from localhost (/10.159.156.31)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Aug 2019 18:43:34 -0700
Date:   Tue, 20 Aug 2019 18:43:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V2] fs: New zonefs file system
Message-ID: <20190821014333.GD1037350@magnolia>
References: <20190820081249.27353-1-damien.lemoal@wdc.com>
 <20190820152638.GA1037422@magnolia>
 <BYAPR04MB58160FB257F05BB93D3367BFE7AA0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58160FB257F05BB93D3367BFE7AA0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210013
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 01:05:56AM +0000, Damien Le Moal wrote:
> Darrick,
> 
> On 2019/08/21 0:26, Darrick J. Wong wrote:
> [...]
> >> +/*
> >> + * Read super block information from the device.
> >> + */
> >> +static int zonefs_read_super(struct super_block *sb)
> >> +{
> >> +     struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> >> +     struct zonefs_super *super;
> >> +     struct bio bio;
> >> +     struct bio_vec bio_vec;
> >> +     struct page *page;
> >> +     int ret;
> >> +
> >> +     page = alloc_page(GFP_KERNEL);
> >> +     if (!page)
> >> +             return -ENOMEM;
> >> +
> >> +     bio_init(&bio, &bio_vec, 1);
> >> +     bio.bi_iter.bi_sector = 0;
> >> +     bio_set_dev(&bio, sb->s_bdev);
> >> +     bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> >> +     bio_add_page(&bio, page, PAGE_SIZE, 0);
> >> +
> >> +     ret = submit_bio_wait(&bio);
> >> +     if (ret)
> >> +             goto out;
> >> +
> >> +     ret = -EINVAL;
> >> +     super = page_address(page);
> >> +     if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
> >> +             goto out;
> >> +     sbi->s_features = le64_to_cpu(super->s_features);
> >> +     if (zonefs_has_feature(sbi, ZONEFS_F_UID)) {
> >> +             sbi->s_uid = make_kuid(current_user_ns(),
> >> +                                    le32_to_cpu(super->s_uid));
> >> +             if (!uid_valid(sbi->s_uid))
> >> +                     goto out;
> >> +     }
> >> +     if (zonefs_has_feature(sbi, ZONEFS_F_GID)) {
> >> +             sbi->s_gid = make_kgid(current_user_ns(),
> >> +                                    le32_to_cpu(super->s_gid));
> >> +             if (!gid_valid(sbi->s_gid))
> >> +                     goto out;
> >> +     }
> >> +     if (zonefs_has_feature(sbi, ZONEFS_F_PERM))
> >> +             sbi->s_perm = le32_to_cpu(super->s_perm);
> > 
> > Unknown feature bits are silently ignored.  Is that intentional?  Will
> > all features be compat features?  I would find it a little annoying to
> > format (for example) a F_UID filesystem only to have some old kernel
> > driver ignore it.
> 
> Good point. I will add checks for unknown feature bits.
> 
> >> +/*
> >> + * On-disk super block (block 0).
> >> + */
> >> +struct zonefs_super {
> >> +
> >> +     /* Magic number */
> >> +     __le32          s_magic;
> >> +
> >> +     /* Features */
> >> +     __le64          s_features;
> >> +
> >> +     /* 128-bit uuid */
> >> +     uuid_t          s_uuid;
> >> +
> >> +     /* UID/GID to use for files */
> >> +     __le32          s_uid;
> >> +     __le32          s_gid;
> >> +
> >> +     /* File permissions */
> >> +     __le32          s_perm;
> >> +
> >> +     /* Padding to 4K */
> >> +     __u8            s_reserved[4056];
> > 
> > Hmm, I noticed that fill_super doesn't check that s_reserved is actually
> > zero (or any specific value).  You might consider enforcing that so that
> > future you can add fields beyond s_perm without having to burn a
> > s_features bit every time you do it.
> 
> Indeed. Will fix that.
> 
> > Also a little surprised there's no checksum field here to detect bit
> > flips and such. ;)
> 
> Yep. I did have that on my to-do list but forgot to actually do it... Will fix
> everything and send a v3.
> 
> Thank you for the comments. One more question: should I rebase on your
> iomap-for-next branch or on iomap-5.4-merge branch ? Both branches look
> identical right now.

Generally, *-for-next is the branch you want, particularly if you decide
at some point to add your zonedfs tree to the for-next zoo.

--D

> Best regards.
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
