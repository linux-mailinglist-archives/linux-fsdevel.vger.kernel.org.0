Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9204012EB6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 22:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgABVgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 16:36:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41366 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgABVgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:36:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002LYO4A092326;
        Thu, 2 Jan 2020 21:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=WdbEvlXPNO8UciqSpYhraRuue7z62HSL2d4h0PKjj0M=;
 b=Pic/0AmyVOQqpaJP47OGOE+N+YaQDgPmPN3c1FN3MrPAtdgvL2Zx9zq+KsgjSNS0XU7/
 mQXD4+g7v1Fwm4ircbhTWiMnox+0G1TSz1v/rBhtX2Va3fH8/kCGCdUDtmRfsDuGvihQ
 X23FUNrMdSKX42iBqugsOGJ/pLr+M2cWBjv3XIGT+FW6D6wuOd5OaYbrODgA/sZE22aO
 IBCCzBcmxRJIfHLMoIOLLNjLdu6XCGXHFtrIYbp5dRldN+fIhh6ThDL8/KjoCiTqohCI
 7uvvbjqUiyeg8KPUHixyffgQqHkaRmtkOzQxs4pcRkCiOy1+/dLVmCqOp19sN4Kxl5xj xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2x5xftsprx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jan 2020 21:36:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002LXoXD033160;
        Thu, 2 Jan 2020 21:36:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2x8gut8g6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jan 2020 21:36:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 002LaE0S011410;
        Thu, 2 Jan 2020 21:36:14 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 13:36:14 -0800
Date:   Thu, 2 Jan 2020 13:36:12 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/2] fs: New zonefs file system
Message-ID: <20200102213612.GD1508633@magnolia>
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-2-damien.lemoal@wdc.com>
 <20191224044001.GA2982727@magnolia>
 <BYAPR04MB5816B3322FD95BD987A982C1E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58167AD3E7519632746CDE72E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58160982BF645C23505BA085E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58160982BF645C23505BA085E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001020174
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 25, 2019 at 08:21:58AM +0000, Damien Le Moal wrote:
> On 2019/12/25 16:20, Damien Le Moal wrote:
> > On 2019/12/25 15:05, Damien Le Moal wrote:
> >>>> +		inode->i_mode = S_IFREG;
> >>>
> >>> i_mode &= ~S_IRWXUGO; ?
> >>
> >> Yes, indeed that is better. checkpatch.pl does spit out a warning if one
> >> uses the S_Ixxx macros though. See below.
> > 
> > Please disregard this comment. checkpatch is fine. For some reasons I
> > had warnings in the past but they are now gone. So using the macros
> > instead of the harder to read hard-coded values.
> 
> Retracting this... My apologies for the noise.
> 
> Checkpatch does complain about the use of symbolic permissions:
> 
> WARNING: Symbolic permissions 'S_IRWXUGO' are not preferred. Consider
> using octal permissions '0777'.
> #657: FILE: fs/zonefs/super.c:400:
> +               inode->i_mode &= ~S_IRWXUGO;
> 
> I do not understand why this would be a problem. I still went ahead and
> used the macros as I find the code more readable using them. Please let
> me know if that is not recommended (checking the code, not surprisingly,
> many FS use these macros).

/me shrugs, I guess we're not supposed to use S_* in code.  Sorry about
the unnecessary churn. :/

--D

> > 
> >>
> >>>
> >>> Note that clearing the mode flags won't prevent programs with an
> >>> existing writable fd from being able to call write().  I'd imagine that
> >>> they'd hit EIO pretty fast though, so that might not matter.
> >>>
> >>>> +		zone->wp = zone->start;
> >>>> +	} else if (zone->cond == BLK_ZONE_COND_READONLY) {
> >>>> +		inode->i_flags |= S_IMMUTABLE;
> >>>> +		inode->i_mode &= ~(0222); /* S_IWUGO */
> >>>
> >>> Might as well just use S_IWUGO directly here?
> > 
> > Yes, I did in v4.
> > 
> >> Because checkpatch spits out a warning if I do. I would prefer using the
> >> macro as I find it much easier to read. Should I just ignore checkpatch
> >> warning ?
> > 
> > My mistake. No warnings :)
> > 
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
