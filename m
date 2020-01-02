Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D789612EB97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgABV6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 16:58:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34258 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgABV6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:58:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002LsRxn088500;
        Thu, 2 Jan 2020 21:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=c9CiFIyiVXzLlpT9+lnQQn3z7fPJn3E86zFXm4+hGo8=;
 b=l27tJV/1FLn856+Rp/OjZkzDW2jl7hotIb6XEilTNAo7KS7Rl39jaLx7IT3t5WgPzclf
 ZDGYMC/EgYCPjcwv1xhButdkXpUrfNMjVCX+99Kmg0aMg7pviO73tTWHYWxLqZFL16kV
 qxRYuaEwynUH+0BjB5fty3tIp/E4Ge6H2nsdSJWv28D5YVtPPtwIio8wHWudjFJyC8xz
 X+2Xl3m92k3NSGsQncZqrFDMttmje6oOGXnpjtj+bt4OXUwp+mEIm7aJW+Vkn9uj3EHB
 EWRA8bAlyfC4yIaFEPKoFSI6tFW/5spkqoPiUMqgIViXzZ/EhCZ31U1al+HsD89MLpqM Hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2x5ypqsku0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jan 2020 21:57:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002LmiPw101439;
        Thu, 2 Jan 2020 21:57:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2x9jm6n3tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jan 2020 21:57:56 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 002LvtAF000910;
        Thu, 2 Jan 2020 21:57:55 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 13:57:55 -0800
Date:   Thu, 2 Jan 2020 13:57:54 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
Message-ID: <20200102215754.GA1508646@magnolia>
References: <20191228143651.bjb4sjirn2q3xup4@pali>
 <517472d1-c686-2f18-4e0b-000cda7e88c7@redhat.com>
 <20200101181054.GB191637@mit.edu>
 <20200101183920.imncit5sllj46c22@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200101183920.imncit5sllj46c22@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001020177
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 01, 2020 at 07:39:20PM +0100, Pali Rohár wrote:
> On Wednesday 01 January 2020 13:10:54 Theodore Y. Ts'o wrote:
> > On Tue, Dec 31, 2019 at 04:54:18PM -0600, Eric Sandeen wrote:
> > > > Because I was not able to find any documentation for it, what is format
> > > > of passed buffer... null-term string? fixed-length? and in which
> > > > encoding? utf-8? latin1? utf-16? or filesystem dependent?
> > > 
> > > It simply copies the bits from the memory location you pass in, it knows
> > > nothing of encodings.
> > > 
> > > For the most part it's up to the filesystem's own utilities to do any
> > > interpretation of the resulting bits on disk, null-terminating maximal-length
> > > label strings, etc.
> > 
> > I'm not sure this is going to be the best API design choice.  The
> > blkid library interprets the on disk format for each file syustem
> > knowing what is the "native" format for that particular file system.
> > This is mainly an issue only for the non-Linux file systems; for the
> > Linux file system, the party line has historically been that we don't
> > get involved with character encoding, but in practice, what that has
> > evolved into is that userspace has standardized on UTF-8, and that's
> > what we pass into the kernel from userspace by convention.
> > 
> > But the problem is that if the goal is to make FS_IOC_GETFSLABEL and
> > FS_IOC_SETFSLABEL work without the calling program knowing what file
> > system type a particular pathname happens to be, then it would be
> > easist for the userspace program if it can expect that it can always
> > pass in a null-terminated UTF-8 string, and get back a null-terminated
> > UTF-8.  I bet that in practice, that is what most userspace programs
> > are going to be do anyway, since it works that way for all other file
> > system syscalls.

"Null terminated sequence of bytes*" is more or less what xfsprogs do,
and it looks like btrfs does that as well.

(* with the idiotic exception that if the label is exactly 256 bytes long
then the array is not required to have a null terminator, because btrfs
encoded that quirk of their ondisk format into the API. <grumble>)

So for VFAT, I think you can use the same code that does the name
encoding transformations for iocharset= to handle labels, right?

> > So for a file system which is a non-Linux-native file system, if it
> > happens to store the its label using utf-16, or some other
> > Windows-system-silliness, it would work a lot better if it assumed
> > that it was passed in utf-8, and stored in the the Windows file system
> > using whatever crazy encoding Windows wants to use.  Otherwise, why
> > bother uplifting the ioctl to one which is file system independent, if
> > the paramters are defined to be file system *dependent*?
> 
> Exactly. In another email I wrote that for those non-Linux-native
> filesystem could be used encoding specified in iocharset= mount
> parameter. I think it is better as usage of one fixing encoding (e.g.
> UTF-8) if other filesystem strings are propagated to userspace in other
> encoding (as specified by iocharset=).

I'm confused by this statement... but I think we're saying the same
thing?

--D

> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com


