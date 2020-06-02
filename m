Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD361EB7AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 10:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFBIvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 04:51:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29435 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbgFBIvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:51:55 -0400
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="93649971"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Jun 2020 16:51:51 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 7007A4BCC8B1;
        Tue,  2 Jun 2020 16:51:50 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 2 Jun 2020 16:51:50 +0800
Message-ID: <5ED61324.6010300@cn.fujitsu.com>
Date:   Tue, 2 Jun 2020 16:51:48 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <ira.weiny@intel.com>, <fstests@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xfs/XXX: Add xfs/XXX
References: <20200413054419.1560503-1-ira.weiny@intel.com> <20200413163025.GB6742@magnolia>
In-Reply-To: <20200413163025.GB6742@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 7007A4BCC8B1.AB2BC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/4/14 0:30, Darrick J. Wong wrote:
> This might be a good time to introduce a few new helpers:
>
> _require_scratch_dax ("Does $SCRATCH_DEV support DAX?")
> _require_scratch_dax_mountopt ("Does the fs support the DAX mount options?")
> _require_scratch_daX_iflag ("Does the fs support FS_XFLAG_DAX?")
Hi Darrick,

Now, I am trying to introduce these new helpers and have some questions:
1) There are five testcases related to old dax implementation, should we 
only convert them to new dax implementation or make them compatible with 
old and new dax implementation?

2) I think _require_xfs_io_command "chattr" "x" is enough to check if fs 
supports FS_XFLAG_DAX.  Is it necessary to add 
_require_scratch_dax_iflag()? like this:
_require_scratch_dax_iflag()
{
	_require_xfs_io_command "chattr" "x"
}

Best Regards,
Xiao Yang


