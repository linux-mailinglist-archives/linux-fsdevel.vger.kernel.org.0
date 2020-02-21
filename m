Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA116832B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgBUQVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 11:21:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgBUQVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:21:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LGHT14124104;
        Fri, 21 Feb 2020 16:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6OK1qzpBtU3He/fmOW/gwQqOQoAUxm4yh/R2kR3W4SE=;
 b=ynY5p9xPWF1P9y9h8DVvni+FNg+Q1JPrsV4UB4VmZ6A7cXKHcbJzR65oGFPXPeZUkVkV
 +NCTxrkiTsZwBOUa+sXPuHN4U/UKE6JSdKAHyQA9Vf4V4wSZYNKJNU1/YWTQhGoyTGX7
 pdSkVi7OseuOqYgtaJnY9q6ziPhg+DnakRQW1qgvABAbEJo33T3vPka582+lM8ZJaerA
 XMMmXMrGd4dxY7nI5AlPwCxIJbijclGSIS8iB+yX2F/0/4lzZdtx4J9WDvrxLzeOdHhM
 NvXWtkbm7MvORCzl279YYRs81F5T+u84OrzjcbxC6esQ58bhiSxrAmeiHx21i9vrpQ4f Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y8udksgn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 16:21:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LGIKlP182258;
        Fri, 21 Feb 2020 16:19:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y8udferh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 16:19:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01LGJj1g031349;
        Fri, 21 Feb 2020 16:19:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 08:19:44 -0800
Date:   Fri, 21 Feb 2020 08:19:43 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: remove the kuid/kgid conversion wrappers
Message-ID: <20200221161943.GY9506@magnolia>
References: <20200218210020.40846-1-hch@lst.de>
 <20200218210020.40846-4-hch@lst.de>
 <20200221012616.GF9506@magnolia>
 <20200221155450.GA9228@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221155450.GA9228@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:54:50PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 05:26:16PM -0800, Darrick J. Wong wrote:
> > >  	to->di_format = from->di_format;
> > > -	inode->i_uid = xfs_uid_to_kuid(be32_to_cpu(from->di_uid));
> > 
> > Hmm.  I'm not up on my userns-fu, but right now this is effectively:
> > 
> > inode->i_uid = make_kuid(&init_user_ns, be32_to_cpu(from->di_uid));
> > 
> > > -	inode->i_gid = xfs_gid_to_kgid(be32_to_cpu(from->di_gid));
> > > +	i_uid_write(inode, be32_to_cpu(from->di_uid));
> > 
> > Whereas this is:
> > 
> > inode->i_uid = make_kuid(inode->i_sb->s_user_ns, be32_to_cpu(...));
> 
> Yes.  Which is intentional and mentioned in the commit log.
> 
> > 
> > What happens if s_user_ns != init_user_ns?  Isn't this a behavior
> > change?  Granted, it looks like many of the other filesystems use
> > i_uid_write so maybe we're the ones who are doing it wrong...?
> 
> In that case the uid gets translated.  Which is intentional as it is
> done everywhere else and XFS is the ugly ducking out that fails
> to properly take the user_ns into account.

Ok, we were doing it wrong.  Should this series have fixed that as the
first patch (so that we could push it into old kernels) followed by the
actual icdinode field removal?

(Granted nobody seems to have complained...)

> > > --- a/fs/xfs/xfs_acl.c
> > > +++ b/fs/xfs/xfs_acl.c
> > > @@ -67,10 +67,12 @@ xfs_acl_from_disk(
> > >  
> > >  		switch (acl_e->e_tag) {
> > >  		case ACL_USER:
> > > -			acl_e->e_uid = xfs_uid_to_kuid(be32_to_cpu(ace->ae_id));
> > > +			acl_e->e_uid = make_kuid(&init_user_ns,
> > > +						 be32_to_cpu(ace->ae_id));
> > 
> > And I'm assuming that the "gross layering violation in the vfs xattr
> > code" is why it's init_user_ns here?
> 
> Yes.  The generic xattr code checks if the attr is one of the ACL ones
> in common code before calling into the fs and already translates them,
> causing a giant mess.

Got it.

--D
