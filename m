Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320191A4846
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJQMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 12:12:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50238 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgDJQMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:12:33 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AG9JtI007696;
        Fri, 10 Apr 2020 09:12:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KDNfhckYWP49Ui+2lXtDPnFRmlDB4xKR7zRugAqpZmg=;
 b=RlSz1zaDCO45xRBtbKbUYcgwHrA87BSOJYoAHephwTT2OPYNjA/wkQ7hBveNvDYq5fHa
 M46YwDa01yQAzh4ciYUmKc8TMJ7jYQL/Qcg7ShPMs9XKWg881wHD2giG5wpOoepbMyxM
 9UC2L+VJi72G+yPskcuJs3c03S6518FTfQo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 309sgx1phh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Apr 2020 09:12:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 10 Apr 2020 09:12:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6FWivsx5ZFXbh74Jn7uc8aKw8QX3G+T4IPaHyk62Uaq8pKLpgxrX1k1A5I75FH5B0XPdrfSAGnbvBAZhb6SbmYdzwlV1PGB4Skrd6M5yEJJuuoD1yrt8hl17ZbDF2piVfq+2ZRBR/q9hUWoz8Lc+FVMgdW1X3UBt1ndqDWOwqfw8iOMDa1ryZYzCgkS7luAaMwyCuxTk3ujVbWrcnbq/acKnBLnOqwWDBOGcbvVm2dz5JZSTX8EPL6+5yg3oYLclXaGmHQB2YSkMKLtd994kT09avkTmnqGeLu05jQH6s5AW701iSvm3FEcu3865qX2HwEg9dl6N9308GztSkfHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDNfhckYWP49Ui+2lXtDPnFRmlDB4xKR7zRugAqpZmg=;
 b=kHM0bFhTZ5wKKJxmHgCJCKocBadAEIV11UgiFlZ+kfETZ9jutqsaZES4oNBKUy4vtROYgCfKndKtgPuNa6ZF6mVgjtfPyAjeiVrW/xFXMhkXrg71PeJtqFLtXfLta1yJVpyOPlGSq6cPf/xuM5bZ+xJsk72+pjDSyojhK9l9MfA2o3A38CUKKVuMcgkBl3DKc39FUKPKrq3moG+onPj8ZxA7L/lAZ+qYZyTez0s5tN+2RZ82GssY2yr5HgmT9UucDgEQauY2KHUcw7nEdnvx1CGV1hKfBiZvjGq9h8V/ZMIRspyPoJZuph+1+c2ORZT8IIxKeLR9h76HvQ6OCdArYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDNfhckYWP49Ui+2lXtDPnFRmlDB4xKR7zRugAqpZmg=;
 b=HGwljF9zDo845dVSkULgZNueGd8UXCWP7BQb4QR6ktrDkt2EZfapbJybdWTpE5A3JIjvImV3gGxi0VAcClKckfr915RcBGKWV4Ye//Cu6Dn7LpW982h+pUztkecK5bnP6pGqngX+lP6pPxx4Rk40976ZZn9Ci7e3WZtmyvkRTic=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3224.namprd15.prod.outlook.com (2603:10b6:a03:105::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Fri, 10 Apr
 2020 16:12:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2878.023; Fri, 10 Apr 2020
 16:12:22 +0000
Date:   Fri, 10 Apr 2020 09:12:18 -0700
From:   Roman Gushchin <guro@fb.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Gioh Kim <gioh.kim@lge.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] ext4: use non-movable memory for superblock readahead
Message-ID: <20200410161218.GA14685@carbon.lan>
References: <20200229001411.128010-1-guro@fb.com>
 <20200410032344.GI45598@mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410032344.GI45598@mit.edu>
X-ClientProxiedBy: MWHPR10CA0069.namprd10.prod.outlook.com
 (2603:10b6:300:2c::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:438e) by MWHPR10CA0069.namprd10.prod.outlook.com (2603:10b6:300:2c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20 via Frontend Transport; Fri, 10 Apr 2020 16:12:21 +0000
X-Originating-IP: [2620:10d:c090:400::5:438e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 954499bb-389c-49af-6efb-08d7dd69f370
X-MS-TrafficTypeDiagnostic: BYAPR15MB3224:
X-Microsoft-Antispam-PRVS: <BYAPR15MB322438599EF0E67FFCCFCF3FBEDE0@BYAPR15MB3224.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(136003)(478600001)(16526019)(186003)(36756003)(8676002)(8936002)(52116002)(7696005)(6666004)(6506007)(86362001)(81156014)(5660300002)(8886007)(316002)(54906003)(2906002)(4326008)(55016002)(9686003)(1076003)(6916009)(33656002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blpYXd2+pnODBa1xTRFfvsc+17HVfB+Dxc6i0YK+gAI+3ixXDKlO3+6vyccpwtgei+hm0Rng0QuZmKzAk6EPLirSDPNdAF5d9Vol1ryg93uMe3M2S06Zw8owwcO8et3CLvQ7dfAuBzcaKc0MbjzYx4KPTdnubTj17Dv+fbhca/l6jxUCIi8Er+/JnF6MGr1sa1AYage5EdtQN7qOoNhAS1VsTTniZRzNhL+Ns8FzHkFay0b9NoiGBGbazp5GqIfFcbS+5Zh4+kf8H31nHfmqqazCDdvf9RWuoded8Feo3Ccvrru+oHWkH+xocJ5m6ZOoL4CNCKftOkidwoEw3yHii8BT9eg8DAbTLMZwkTmfwJkmxSnn6z2+dbsMgFq7vF3X5cwqXWrzLLhnqOXwB/ZeofTE1vl32WC6pxg6avxG3YblRVNIK33bKlEoIt3Wvc5Z
X-MS-Exchange-AntiSpam-MessageData: TLAtU8QAQBoUtjaLFTFC7HNyOIDRaQqBoGWv1/a2Z4Nh7eQMzZXY0+8ESpqngxLnOXEZTU3ZvCYqVg9JZbnBdFhxxl03d99NcpkFzXy7klf4MLyyRW3L7wdGHdvHtBnru12nqhTTqQjY5dnaPtvOCnKdB1OkBYWNoCmIqLy/P101MsHctYh5vQJXtlWPwz53
X-MS-Exchange-CrossTenant-Network-Message-Id: 954499bb-389c-49af-6efb-08d7dd69f370
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 16:12:22.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqXsgfbj7BMEimCYAu8dqvvPzp8vnB0W1oT5IKAGEAQpH91F95PnorbTHhf1PHpp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3224
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_06:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=935
 clxscore=1011 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100135
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:23:44PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Feb 28, 2020 at 04:14:11PM -0800, Roman Gushchin wrote:
> > Since commit a8ac900b8163 ("ext4: use non-movable memory for the
> > superblock") buffers for ext4 superblock were allocated using
> > the sb_bread_unmovable() helper which allocated buffer heads
> > out of non-movable memory blocks. It was necessarily to not block
> > page migrations and do not cause cma allocation failures.
> > 
> > However commit 85c8f176a611 ("ext4: preload block group descriptors")
> > broke this by introducing pre-reading of the ext4 superblock.
> > The problem is that __breadahead() is using __getblk() underneath,
> > which allocates buffer heads out of movable memory.
> > 
> > It resulted in page migration failures I've seen on a machine
> > with an ext4 partition and a preallocated cma area.
> > 
> > Fix this by introducing sb_breadahead_unmovable() and
> > __breadahead_gfp() helpers which use non-movable memory for buffer
> > head allocations and use them for the ext4 superblock readahead.
> 
> Applied, thanks.  Apologies for not picking this up earlier.
> 
> 	 	  	    	    	    - Ted

Thank you!

Roman
