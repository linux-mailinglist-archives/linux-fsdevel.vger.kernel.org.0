Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A934E3B7F47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 10:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhF3Isz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 04:48:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60818 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232984AbhF3Isx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:48:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U8aNTM027030;
        Wed, 30 Jun 2021 08:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZPomLQAFZCkwiyOJhcgSezeMBSZX9HRfUq00n5eZbf4=;
 b=ppjeV1fXDgeHCRYygHGdELwaLUmK+O/RsHLO5H2uwtjYe8CVHK5dTdEvrZgz6dJMz3+j
 c5HSeU+lY9Hc1cl41u+Uf6UpxSTxSqGdhxLPdXSgzIJaG0QRMPZkWmL8MyFS5Bm3TE75
 HOQxC/Rdr6erI0vd6x6ntYulR/gNF8bnEugY3S0WTn2Og1CL21gv2drk1gbvBzlaTbjA
 EZdlMkld6xR7wPMpXoDfmOOpOzDXpIQRX3HCY4d7OX2PRNiujULUQPRASSFxaKtjkL8T
 QQ3TddBXDhj0sOV/bWX31AHjwVsfv+7PwINNGzHn11Q7htS7kLflSts2wcGaydHn/mhy uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gb2t0wa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 08:46:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U8k4t1062672;
        Wed, 30 Jun 2021 08:46:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39ee0ws9wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 08:46:09 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15U8k96u063052;
        Wed, 30 Jun 2021 08:46:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 39ee0ws9ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 08:46:09 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15U8k5tA008899;
        Wed, 30 Jun 2021 08:46:05 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jun 2021 08:46:05 +0000
Date:   Wed, 30 Jun 2021 11:45:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild@lists.01.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in
 struct fsnotify_event_info
Message-ID: <20210630084555.GH1983@kadam>
References: <20210629191035.681913-8-krisman@collabora.com>
 <202106300707.Xg0LaEwy-lkp@intel.com>
 <CAOQ4uxgRbpzo-AvvBxLQ5ARdFuX53RG+JpPOG8CDoEM2MdsWQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgRbpzo-AvvBxLQ5ARdFuX53RG+JpPOG8CDoEM2MdsWQQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 9uQdJBCNH4cs_bRRnuM5ZCKt0hG5FzLD
X-Proofpoint-ORIG-GUID: 9uQdJBCNH4cs_bRRnuM5ZCKt0hG5FzLD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:35:32AM +0300, Amir Goldstein wrote:
> 
> Do you have feeling of dejavu? ;-)
> https://lore.kernel.org/linux-fsdevel/20200730192537.GB13525@quack2.suse.cz/ 

That was a year ago.  I have trouble remembering emails I sent
yesterday.

> 
> We've been through this.
> Maybe you silenced the smach warning on fsnotify() and the rename to
> __fsnotifty()
> caused this warning to refloat?

Yes.  Renaming the function will make it show up as a new warning.  Also
this is an email from the kbuild-bot and last years email was from me,
so it's a different tool and a different record of sent messages.

(IMO, you should really just remove the bogus NULL checks because
everyone looking at the warning will think the code is buggy).

regards,
dan carpenter
