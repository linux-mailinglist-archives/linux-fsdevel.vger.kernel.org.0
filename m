Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5750144203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 17:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUQUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 11:20:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59042 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:20:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LGIW37090200;
        Tue, 21 Jan 2020 16:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=uYOd+zHwSnCegpRyovimgiqkKiE/fLMFwlZb71GkrV0=;
 b=NlgALHKCbQnNULjVWBDPgXCetYybue2MFM8shQNzXgnuaBd8IhkucTrRD50jyEYSV4ab
 FMo/l9pPRRV39j7K3LUJlBcmjmKNkmneiYXdaKT+f0NGk/wM43Hp29KjFVdHNsGbZ+WH
 w9ryK8cWGt8Wd988iCGS/6McezTQzA715UJm1AqyEAAVeyeQoEOc7vYyWu1tcUAOBohK
 RWTHXlzAS2exahRDvZjZJidt3IVVnhWyfJtao7pO+nPpc3jVjwk/DOLmuGhxIJdKKPRc
 Lo0sWTlyukCDgx6ekEa4Crg9pQUO8JIY5QPnj8NObYSH/KjiZP/O4lEhYJSUfkU27hdj aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xkseue764-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 16:18:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LGIU8F184360;
        Tue, 21 Jan 2020 16:18:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2xnpfp9wyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jan 2020 16:18:44 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00LGIhTt185837;
        Tue, 21 Jan 2020 16:18:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xnpfp9wyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 16:18:43 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00LGIfPe029401;
        Tue, 21 Jan 2020 16:18:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 08:18:41 -0800
Date:   Tue, 21 Jan 2020 08:18:40 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        xfs <xfs@e29208.dscx.akamaiedge.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [Lsf-pc] [LFS/MM TOPIC] fs reflink issues, fs online
 scrub/check, etc
Message-ID: <20200121161840.GA8236@magnolia>
References: <20160210191715.GB6339@birch.djwong.org>
 <20160210191848.GC6346@birch.djwong.org>
 <CAH2r5mtM2nCicTKGFAjYtOG92TKKQdTbZxaD-_-RsWYL=Tn2Nw@mail.gmail.com>
 <0089aff3-c4d3-214e-30d7-012abf70623a@gmx.com>
 <CAOQ4uxjd-YWe5uHqfSW9iSdw-hQyFCwo84cK8ebJVJSY_vda3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjd-YWe5uHqfSW9iSdw-hQyFCwo84cK8ebJVJSY_vda3Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=986 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210131
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:35:22AM +0200, Amir Goldstein wrote:
> On Tue, Jan 21, 2020 at 3:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> > Didn't see the original mail, so reply here.
> 
> Heh! Original email was from 2016, but most of Darrick's wish list is
> still relevant in 2020 :)

Grumble grumble stable behavior of clonerange/deduperange ioctls across
filesystems grumble grumble.

> I for one would be very interested in getting an update on the
> progress of pagecache
> page sharing if there is anyone working on it.

Me too.  I guess it's the 21st, I should really send in a proposal for
*this year's* LSFMMBPFLOLBBQ.

--D

> Thanks,
> Amir.
