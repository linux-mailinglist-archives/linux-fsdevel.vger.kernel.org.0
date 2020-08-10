Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB7240C81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHJR6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 13:58:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgHJR6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:58:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07AHXinG131454;
        Mon, 10 Aug 2020 13:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=r63m5wPatlVGKXEVci7ekmXKuv/hOL947q5faQjq6d0=;
 b=aKMxF9VaYwBEUx++kNulk45CXmo5nFHZhP216H5AMH+kT9qR1elHYXlnc93zuKW0/5MZ
 ARceEHihTQplOjWEuNeJ8Toi6i4uu07vD/Q2icmqMUsA+4yjkqEw9bySuY1CsK+D4kdT
 Smlqo7y3/rIzbkDbmIHFczCzKK5ISOJFxzUyro6ruIkRVFZNI6o27fwDjK+mCo2a42OW
 684c37R6TmviOefDaZiviwHAPVOvJ5/+BDuzhdYR7WZBL/eXFbzjEz1eoZALwrNa8fpN
 EKHoKmxXB8d4iuPZx0BeJRRBbmWvH0znKaM+nSbJzZHu+GwLbWHIU/7FMwrI4a1PsRqC 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sr8kkcaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 13:57:52 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07AHsL8R028934;
        Mon, 10 Aug 2020 13:57:51 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sr8kkc9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 13:57:51 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07AHtPub026448;
        Mon, 10 Aug 2020 17:57:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 32skp8agfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 17:57:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07AHvkLX30736720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 17:57:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5633E11C052;
        Mon, 10 Aug 2020 17:57:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BFA511C04C;
        Mon, 10 Aug 2020 17:57:41 +0000 (GMT)
Received: from sig-9-65-241-154.ibm.com (unknown [9.65.241.154])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Aug 2020 17:57:41 +0000 (GMT)
Message-ID: <8565b1430d5244eba95fc1fe0ed470b886747aaa.camel@linux.ibm.com>
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Chuck Lever <chucklever@gmail.com>,
        James Morris <jmorris@namei.org>
Cc:     Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, nramas@linux.microsoft.com,
        serge@hallyn.com, pasha.tatashin@soleen.com,
        Jann Horn <jannh@google.com>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, mdsakib@microsoft.com,
        open list <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Date:   Mon, 10 Aug 2020 13:57:40 -0400
In-Reply-To: <1597079586.3966.34.camel@HansenPartnership.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
         <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
         <20200802143143.GB20261@amd>
         <1596386606.4087.20.camel@HansenPartnership.com>
         <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
         <1596639689.3457.17.camel@HansenPartnership.com>
         <alpine.LRH.2.21.2008050934060.28225@namei.org>
         <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
         <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
         <da6f54d0438ee3d3903b2c75fcfbeb0afdf92dc2.camel@linux.ibm.com>
         <1597073737.3966.12.camel@HansenPartnership.com>
         <4664ab7dc3b324084df323bfa4670d5bfde76e66.camel@linux.ibm.com>
         <1597079586.3966.34.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_14:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 suspectscore=3
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-10 at 10:13 -0700, James Bottomley wrote:
> On Mon, 2020-08-10 at 12:35 -0400, Mimi Zohar wrote:
> > On Mon, 2020-08-10 at 08:35 -0700, James Bottomley wrote:
> [...]
> > > > Up to now, verifying remote filesystem file integrity has been
> > > > out of scope for IMA.   With fs-verity file signatures I can at
> > > > least grasp how remote file integrity could possibly work.  I
> > > > don't understand how remote file integrity with existing IMA
> > > > formats could be supported. You might want to consider writing a
> > > > whitepaper, which could later be used as the basis for a patch
> > > > set cover letter.
> > > 
> > > I think, before this, we can help with the basics (and perhaps we
> > > should sort them out before we start documenting what we'll do).
> > 
> > I'm not opposed to doing that, but you're taking this discussion in a
> > totally different direction.  The current discussion is about NFSv4
> > supporting the existing IMA signatures, not only fs-verity
> > signatures. I'd like to understand how that is possible and for the
> > community to weigh in on whether it makes sense.
> 
> Well, I see the NFS problem as being chunk at a time, right, which is
> merkle tree, or is there a different chunk at a time mechanism we want
> to use?  IMA currently verifies signature on open/exec and then
> controls updates.  Since for NFS we only control the client, we can't
> do that on an NFS server, so we really do need verification at read
> time ... unless we're threading IMA back to the NFS server?

Yes.  I still don't see how we can support the existing IMA signatures,
which is based on the file data hash, unless the "chunk at a time
mechanism" is not a tree, but linear.

Mimi

> 
> > > The first basic is that a merkle tree allows unit at a time
> > > verification. First of all we should agree on the unit.  Since we
> > > always fault a page at a time, I think our merkle tree unit should
> > > be a page not a block. Next, we should agree where the check gates
> > > for the per page accesses should be ... definitely somewhere in
> > > readpage, I suspect and finally we should agree how the merkle tree
> > > is presented at the gate.  I think there are three ways:
> > > 
> > >    1. Ahead of time transfer:  The merkle tree is transferred and
> > > verified
> > >       at some time before the accesses begin, so we already have a
> > >       verified copy and can compare against the lower leaf.
> > >    2. Async transfer:  We provide an async mechanism to transfer
> > > the
> > >       necessary components, so when presented with a unit, we check
> > > the
> > >       log n components required to get to the root
> > >    3. The protocol actually provides the capability of 2 (like the
> > > SCSI
> > >       DIF/DIX), so to IMA all the pieces get presented instead of
> > > IMA
> > >       having to manage the tree
> > > 
> > > There are also a load of minor things like how we get the head
> > > hash, which must be presented and verified ahead of time for each
> > > of the above 3.
> > 
> >  
> > I was under the impression that IMA support for fs-verity signatures
> > would be limited to including the fs-verity signature in the
> > measurement list and verifying the fs-verity signature.   As fs-
> > verity is limited to immutable files, this could be done on file
> > open.  fs-verity would be responsible for enforcing the block/page
> > data integrity.   From a local filesystem perspective, I think that
> > is all that is necessary.
> 
> The fs-verity use case is a bit of a crippled one because it's
> immutable.  I think NFS represents more the general case where you
> can't rely on immutability and have to verify at chunk read time.  If
> we get chunk at a time working for NFS, it should work also for fs-
> verity and we wouldn't need to have two special paths.
> 
> I think, even for NFS we would only really need to log the open, so
> same as you imagine for fs-verity.  As long as the chunk read hashes
> match, we can be silent because everything is going OK, so we only need
> to determine what to do and log on mismatch (which isn't expected to
> happen for fs-verity).
> 
> > In terms of remote file systems,  the main issue is transporting and
> > storing the Merkle tree.  As fs-verity is limited to immutable files,
> > this could still be done on file open.
> 
> Right, I mentioned that in my options ... we need some "supply
> integrity" hook ... or possibly multiple hooks for a variety of
> possible methods.

