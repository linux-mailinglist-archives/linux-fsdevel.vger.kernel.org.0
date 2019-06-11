Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5649D3C0D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 03:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbfFKBLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 21:11:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34454 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389723AbfFKBLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:11:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B19VIQ022049;
        Tue, 11 Jun 2019 01:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lzmnRyVJuFqwl45UFunpqytAMq9T3uRA+URKP40OMIY=;
 b=33ZGoC/l5chmmKWpEWXTsFlnijGzGTpGhno0cpjPSW9yUvatjP9YGxG5wxTi+FYzkioC
 Kfth1XWU8vE9/qVqdgOX0+AJgpv1vLPKw41OqbKIkq5rhFiBgC2i+zvl6ilaDFaAVaKp
 2V3dFv9jarLwu6lrYeDhvMJNkCSrSlXoFfvDD9CIxZJQ9K0TtIwPj6Pr3TsUJHgZ0VTl
 rvvE4/Vr5i3PuTN2wKwmu0s/C+f3Rr/C6dtIw3TIH8TLMfscwtqTyBoGfMlfIrV4jsFT
 cVUCIUzQQxCdjzsW+0pytPuGLOOS+HtKz8BB49qD2sgMyniXkYt4Yf2YyhlTX9VkT3a1 eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t05nqhxqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 01:11:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B1ApE7109506;
        Tue, 11 Jun 2019 01:11:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t04hy2unr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 01:11:35 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5B1BYjU005890;
        Tue, 11 Jun 2019 01:11:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 18:11:34 -0700
Date:   Mon, 10 Jun 2019 18:11:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs-linux: copy-file-range-fixes updated to
 fe0da9c09b2d
Message-ID: <20190611011132.GP1871505@magnolia>
References: <20190610160624.GG1871505@magnolia>
 <CAOQ4uxhkE_TsN7XMBgzxVhEYDw+gZEOOCiZzn9otVwQtB-XHeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhkE_TsN7XMBgzxVhEYDw+gZEOOCiZzn9otVwQtB-XHeA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 08:14:08PM +0300, Amir Goldstein wrote:
> +CC affected maintainers
> 
> On Mon, Jun 10, 2019 at 7:06 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > Hi folks,
> >
> > The copy-file-range-fixes branch of the xfs-linux repository at:
> >
> >         git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> >
> > has just been updated.  This is a common branch from which everyone else
> > can create their own copy-file-range fix branches for 5.3.  When you
> > send your pull request to Linus please let him know that the fixes
> > stream out from here like some kind of hydra. :)
> 
> Thanks Darrick!
> Should we also request to include this branch in linux-next?

Yeah, I was going to do that after 24h (i.e. it'll be in Wednesday's
-next) to see if anyone had any last minute "ZOMG this patch has to be
changed" screaming.

> Attention nfs/cifs/fuse/ceph maintainers!
> This branch includes changes to your filesystems.
> At lease nfs/cifs/ceph have been tested with these changes and the
> new xfstests.
> 
> I think it would be preferred if you merge Darrick's branch into your
> 5.3 branch as soon as you have one ready to reduce chances of
> conflicts down the road.
> 
> I will be sending out 2 more patches to cifs/ceph, which depend on
> this branch directly to maintainers.

Noted.

--D

> Thanks,
> Amir.
