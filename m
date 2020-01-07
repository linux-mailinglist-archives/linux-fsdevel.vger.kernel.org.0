Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC46B133725
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 00:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgAGXPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 18:15:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAGXPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:15:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007N9a7f042422;
        Tue, 7 Jan 2020 23:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=WpsBbFX5r44G2/iXWy3Z8/bfxahWOQDAfZxzk6WB/Zg=;
 b=YAQSC9O3UeFeLreC1t7t1YB5cIL/Kimf3vX9z/bc4Gjw0ePD5kjKp5ENHmbOcUIwGTaQ
 xu5A3y5C7veYMqyyOHx76znLqVKFsfknzZTfKtZnTry5kF5rK+7A9NfWBVsZrsl7kfx2
 D7xD4a6k8Gkzfa3k6tZXSI6t5unm2gD2zSGX5/PjMKGrE+64nglNagYTEO/BqfheHMil
 fR8JBbz9z/4b3z+FEMB7IG+4k3B319IV+uT5WjDTPZfZx/HCGiTor+sDgIuoSYODgtHX
 5XezPBdmeSxWRJ0RFshS3SPNeADi07HoO5bb04chMppLRLFLy0F8nLDickKvVqzNR5ID 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xaj4u0s82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 23:15:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007NE9M3074156;
        Tue, 7 Jan 2020 23:15:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xcjve77yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 23:15:26 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 007NFOSG001342;
        Tue, 7 Jan 2020 23:15:24 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 15:15:24 -0800
Date:   Tue, 7 Jan 2020 15:15:22 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
Message-ID: <20200107231522.GC472641@magnolia>
References: <20191228143651.bjb4sjirn2q3xup4@pali>
 <517472d1-c686-2f18-4e0b-000cda7e88c7@redhat.com>
 <20200101181054.GB191637@mit.edu>
 <20200101183920.imncit5sllj46c22@pali>
 <20200102215754.GA1508646@magnolia>
 <20200102220800.nasrhtz23xkqxxkg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102220800.nasrhtz23xkqxxkg@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070185
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 02, 2020 at 11:08:00PM +0100, Pali Rohár wrote:
> On Thursday 02 January 2020 13:57:54 Darrick J. Wong wrote:
> > On Wed, Jan 01, 2020 at 07:39:20PM +0100, Pali Rohár wrote:
> > > On Wednesday 01 January 2020 13:10:54 Theodore Y. Ts'o wrote:
> > > > On Tue, Dec 31, 2019 at 04:54:18PM -0600, Eric Sandeen wrote:
> > > > > > Because I was not able to find any documentation for it, what is format
> > > > > > of passed buffer... null-term string? fixed-length? and in which
> > > > > > encoding? utf-8? latin1? utf-16? or filesystem dependent?
> > > > > 
> > > > > It simply copies the bits from the memory location you pass in, it knows
> > > > > nothing of encodings.
> > > > > 
> > > > > For the most part it's up to the filesystem's own utilities to do any
> > > > > interpretation of the resulting bits on disk, null-terminating maximal-length
> > > > > label strings, etc.
> > > > 
> > > > I'm not sure this is going to be the best API design choice.  The
> > > > blkid library interprets the on disk format for each file syustem
> > > > knowing what is the "native" format for that particular file system.
> > > > This is mainly an issue only for the non-Linux file systems; for the
> > > > Linux file system, the party line has historically been that we don't
> > > > get involved with character encoding, but in practice, what that has
> > > > evolved into is that userspace has standardized on UTF-8, and that's
> > > > what we pass into the kernel from userspace by convention.
> > > > 
> > > > But the problem is that if the goal is to make FS_IOC_GETFSLABEL and
> > > > FS_IOC_SETFSLABEL work without the calling program knowing what file
> > > > system type a particular pathname happens to be, then it would be
> > > > easist for the userspace program if it can expect that it can always
> > > > pass in a null-terminated UTF-8 string, and get back a null-terminated
> > > > UTF-8.  I bet that in practice, that is what most userspace programs
> > > > are going to be do anyway, since it works that way for all other file
> > > > system syscalls.
> > 
> > "Null terminated sequence of bytes*" is more or less what xfsprogs do,
> > and it looks like btrfs does that as well.
> > 
> > (* with the idiotic exception that if the label is exactly 256 bytes long
> > then the array is not required to have a null terminator, because btrfs
> > encoded that quirk of their ondisk format into the API. <grumble>)
> > 
> > So for VFAT, I think you can use the same code that does the name
> > encoding transformations for iocharset= to handle labels, right?
> 
> Yes I can! But I need to process also codepage= transformation (details
> in email <20191228200523.eaxpwxkpswzuihow@pali>). And I already have
> this implementation in progress.

<nod>

> > > > So for a file system which is a non-Linux-native file system, if it
> > > > happens to store the its label using utf-16, or some other
> > > > Windows-system-silliness, it would work a lot better if it assumed
> > > > that it was passed in utf-8, and stored in the the Windows file system
> > > > using whatever crazy encoding Windows wants to use.  Otherwise, why
> > > > bother uplifting the ioctl to one which is file system independent, if
> > > > the paramters are defined to be file system *dependent*?
> > > 
> > > Exactly. In another email I wrote that for those non-Linux-native
> > > filesystem could be used encoding specified in iocharset= mount
> > > parameter. I think it is better as usage of one fixing encoding (e.g.
> > > UTF-8) if other filesystem strings are propagated to userspace in other
> > > encoding (as specified by iocharset=).
> > 
> > I'm confused by this statement... but I think we're saying the same
> > thing?
> 
> Theodore suggested to use UTF-8 encoding for FS_IOC_GETFSLABEL. And I
> suggested to use iocharset= encoding for FS_IOC_GETFSLABEL. You said to
> use for VFAT "same code that does the name encoding", so if I'm
> understanding correctly, yes it is the same thing (as VFAT use
> iocharset= and codepage= mount options for name encoding). Right?

Right.

--D

> -- 
> Pali Rohár
> pali.rohar@gmail.com


