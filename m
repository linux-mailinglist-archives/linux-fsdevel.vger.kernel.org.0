Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243CD166168
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBTPud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:50:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56066 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgBTPua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:50:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KFlMjw131260;
        Thu, 20 Feb 2020 15:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Nh6KSsarEW9/V+kkBNnDZtjqVZw3+i+jcahmnpQEaA0=;
 b=hxDaJUbtUmjfCwXIvXx4KhNIzLG024XpKk+R6RKvE8JeLldnUZAOYWEvhoB4DR5UEazA
 JRRUrWICo1pRdlfux+56HR1+fvYoFysCBWMbX6vHQib4fVLTnPIl3teoS26kHPwXnYts
 L9K2CJg1rElbAksbQt9zVsWlBYcvjpwUy+4qWUXmKAxrthbIl4nV398N1QvjdE9O6QsE
 MNejQoZKIZxU1fiXPemcJrgg3MlJ21M4ztudg0AbshTkZQY8b+JHfZpb99RpNFIcE6W0
 Xin+U/Dv2Uhstf/bW4VXvsaurubti7tlfin0bnxeoWxa8Dna19ga6tXkFnRcDjBMLOoK Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y8udkjky5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:50:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KFlsUb058913;
        Thu, 20 Feb 2020 15:48:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y8uddrata-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:48:23 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01KFmLKP017963;
        Thu, 20 Feb 2020 15:48:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 07:48:20 -0800
Date:   Thu, 20 Feb 2020 07:48:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #16]
Message-ID: <20200220154819.GF9496@magnolia>
References: <20200219163128.GB9496@magnolia>
 <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
 <542411.1582194875@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542411.1582194875@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:34:35AM +0000, David Howells wrote:
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
> > > +	p->f_blocks.hi	= 0;
> > > +	p->f_blocks.lo	= buf.f_blocks;
> > 
> > Er... are there filesystems (besides that (xfs++)++ one) that require
> > u128 counters?  I suspect that the Very Large Fields are for future
> > expandability, but I also wonder about the whether it's worth the
> > complexity of doing this, since the structures can always be
> > version-revved later.
> 
> I'm making a relatively cheap allowance for future expansion.  Dave Chinner
> has mentioned at one of the LSFs that 16EiB may be exceeded soon (though I
> hate to think of fscking such a beastie).  I know that the YFS variant of AFS
> supports 96-bit vnode numbers (which I translate to inode numbers).  What I'm

Aha, you /already/ have a use for larger-than-64bit numbers.  Got it. :)

> trying to avoid is the problem we have with stat/statfs where under some
> circumstances we have to return an error (ERANGE?) because we can't represent
> the number if someone asks for an older version of the struct.
> 
> Since the buffer is (meant to be) pre-cleared, the filesystem can just ignore
> the high word if it's never going to set it.  In fact, fsinfo_generic_statfs
> doesn't need to set them either.
> 
> > XFS inodes are u64 values...
> > ...and the max symlink target length is 1k, not PAGE_SIZE...
> 
> Yeah, and AFS(YFS) has 96-bit inode numbers.  The filesystem's fsinfo table is
> read first so that the filesystem can override this.
> 
> > ...so is the usage model here that XFS should call fsinfo_generic_limits
> > to fill out the fsinfo_limits structure, modify the values in
> > ctx->buffer as appropriate for XFS, and then return the structure size?
> 
> Actually, I should export some these so that you can do that.  I'll export
> fsinfo_generic_{timestamp_info,supports,limits} for now.

Thank you.

> > > +#define FSINFO_ATTR_VOLUME_ID		0x05	/* Volume ID (string) */
> > > +#define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
> > > +#define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
> > 
> > I think I've muttered about the distinction between volume id and
> > volume name before, but I'm still wondering how confusing that will be
> > for users?  Let me check my assumptions, though:
> > 
> > Volume ID is whatever's in super_block.s_id, which (at least for xfs and
> > ext4) is the device name (e.g. "sda1").  I guess that's useful for
> > correlating a thing you can call fsinfo() on against strings that were
> > logged in dmesg.
> >
> > Volume name I think is the fs label (e.g. "home"), which I think will
> > have to be implemented separately by each filesystem, and that's why
> > there's no generic vfs implementation.
> 
> Yes.  For AFS, for example, this would be the name of the volume (which may be
> changed), whereas the volume ID is the number in the protocol that actually
> refers to the volume (which cannot be changed).
> 
> And, as you say, for blockdev mounts, the ID is the device name and the volume
> name is filesystem specific.
> 
> > The 7 -> 0 -> 1 sequence here confused me until I figured out that
> > QUERY_TYPE is the mask for QUERY_{PATH,FD}.
> 
> Changed to FSINFO_FLAGS_QUERY_MASK.
> 
> > > +struct fsinfo_limits {
> > > +...
> > > +	__u32	__reserved[1];
> > 
> > I wonder if these structures ought to reserve more space than a single u32...
> 
> No need.  Part of the way the interface is designed is that the version number
> for a particular VSTRUCT-type attribute is also the length.  So a newer
> version is also longer.  All the old fields must be retained and filled in.
> New fields are tagged on the end.
> 
> If userspace asks for an older version than is supported, it gets a truncated
> return.  If it asks for a newer version, the extra fields it is expecting are
> all set to 0.  Either way, the length (and thus the version) the kernel
> supports is returned - not the length copied.
> 
> The __reserved fields are there because they represent padding (the struct is
> going to be aligned/padded according to __u64 in this case).  Ideally, I'd
> mark the structs __packed, but this messes with the alignment and may make the
> compiler do funny tricks to get out any field larger than a byte.
> 
> I've renamed them to __padding.
> 
> > > +struct fsinfo_supports {
> > > +	__u64	stx_attributes;		/* What statx::stx_attributes are supported */
> > > +	__u32	stx_mask;		/* What statx::stx_mask bits are supported */
> > > +	__u32	ioc_flags;		/* What FS_IOC_* flags are supported */
> > 
> > "IOC"?  That just means 'ioctl'.  Is this field supposed to return the
> > supported FS_IOC_GETFLAGS flags, or the supported FS_IOC_FSGETXATTR
> > flags?
> 
> FS_IOC_[GS]ETFLAGS is what I meant.
> 
> > I suspect it would also be a big help to be able to tell userspace which
> > of the flags can be set, and which can be cleared.
> 
> How about:
> 
> 	__u32	fs_ioc_getflags;	/* What FS_IOC_GETFLAGS may return */
> 	__u32	fs_ioc_setflags_set;	/* What FS_IOC_SETFLAGS may set */
> 	__u32	fs_ioc_setflags_clear;	/* What FS_IOC_SETFLAGS may clear */

Looks good to me.  At some point it'll be good to add another fsinfo
verb or something to query exactly what parts of struct fsxattr can be
set, cleared, or returned, but that can wait.

> > > +struct fsinfo_timestamp_one {
> > > +	__s64	minimum;	/* Minimum timestamp value in seconds */
> > > +	__u64	maximum;	/* Maximum timestamp value in seconds */
> > 
> > Given that time64_t is s64, why is the maximum here u64?
> 
> Well, I assume it extremely unlikely that the maximum can be before 1970, so
> there doesn't seem any need to allow the maximum to be negative.  Furthermore,
> it would be feasible that you could encounter a filesystem with a u64
> filesystem that doesn't support dates before 1970.
> 
> On the other hand, if Linux is still going when __s64 seconds from 1970 wraps,
> it will be impressive, but I'm not sure we'll be around to see it...  Someone
> will have to cast a resurrection spell on Arnd to fix that one.

I fear we /all/ will be around, having forcibly been uploaded to The
Cloud because nobody else knows how to maintain the Linux kernel, and we
can't have the drinks dispenser on B deck going bonkers twice per stardate.
(j/k)

> However, since signed/unsigned comparisons may have issues, I can turn it into
> an __s64 also if that is preferred.

It /would/ be more consistent with the rest of the kernel, and since the
kernel & userspace don't support timestamps beyond 8Es, there's no point
in advertising a maximum beyond that.

--D

> David
> 
