Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03221A69CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbgDMQWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:22:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52292 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731410AbgDMQWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:22:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DGJHgp083266;
        Mon, 13 Apr 2020 16:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5T9mPw8GB/r8H50I90kuMynWhnQTRHYwlj+Ng3RQM1Q=;
 b=J94TMoHe8uwQkg2/RnnzUFI2jtizrn97gsFY3wcgYDDDMvQNwPq3PnwEcnDPHEXPil7K
 hTlow0INHcy8Fx3YTBMg32CP3n6N0eMm3Td194KtH/wpuzAQ+SC9tJc2yh+roWLuZB4+
 HUBsBXClwI2oZwk/yl35K7/o9H59PdVq8uNWqZwyzZXJx01vMJj0HO204VF72i7b3fJ9
 9xd39ZMSu1wxN8TeOSsww4PldUCiP0QabcpgG0ThqVnxI3URsuKUlnzVOWgIf05XTJis
 Pcs4HclZRdBzgX/c7lcSVqzTQffyFigimlYROHP0NX8VWrmuk+zc0XDN6u1lNzIO/Ns8 sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30b6hpff0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:22:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DGHf4S083132;
        Mon, 13 Apr 2020 16:22:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30bqcehv4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:22:32 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03DGMUat008221;
        Mon, 13 Apr 2020 16:22:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 09:22:30 -0700
Date:   Mon, 13 Apr 2020 09:22:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xfs/XXX: Add xfs/XXX
Message-ID: <20200413162228.GA6742@magnolia>
References: <20200413054419.1560503-1-ira.weiny@intel.com>
 <CAOQ4uxguVRysAuVEtQmPj+x=RDtDnGCtNeGvbvXNuvppwagwDg@mail.gmail.com>
 <20200413155325.GA1560218@iweiny-DESK2.sc.intel.com>
 <CAOQ4uxg4Cr-vqA35TbhD5q7Jd1OgLUiL48nO_XNhkpMsCDW_UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg4Cr-vqA35TbhD5q7Jd1OgLUiL48nO_XNhkpMsCDW_UQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 07:11:46PM +0300, Amir Goldstein wrote:
> > >
> > > But the kernel patch suggests that there is an intention to make
> > > this behavior also applicable to ext4??
> > > If that is the case I would recommend making this a generic tests
> > > which requires filesystem support for -o dax=XXX
> >
> > I have a patch set for ext4 which is not quite passing this.  I'm not sure what
> > is going on yet.
> >
> > Once that is working I was going to move this to generic.  (The documentation
> > in the kernel patch set also reflects ext4 being different from xfs for the
> > time being.)
> 
> IMO, if ext4 maintainer is on board with the plan to make this behavior of
> ext4 then it is best to add this test as generic from the start.
> Any other filesystems that may tag along later?

I was under the impression that any test can go in generic/ so long as
it isn't using fs-specific interfaces (e.g. xfs error injection), even
if not all filesystems actually support the functionality being examined
by the test.

> >
> > This is mainly because I'm not sure if ext4 will make 5.8 or not.  Would you
> > prefer making this generic now?  I assume there is some way to mark generic
> > tests for a subset of FS's?  I have not figured that out yet.
> >
> 
> There is a way, _supported_fs, see the tests/shared/*,
> but the idea it to get rid of those in favor of feature tests such as
> _require_scratch_dax
> 
> I believe it should be trivial to implement
> _require_scratch_dax_never

Agreed, though I would name the helper to make it clear that it's
checking the dax mount options (e.g. "_require_scratch_dax_mountopt")
because "never" is a little subtle here.

> Thanks,
> Amir.
