Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7F17601E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 17:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgCBQhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 11:37:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14740 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbgCBQhf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:37:35 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022GSaOC030965;
        Mon, 2 Mar 2020 08:37:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WoUX/60DheMZbX42aOT2xbiF5PpB2ZnorIewmLS9sjM=;
 b=R+7XVkko8eQhiyjOdIXtCidriNXJLhAGpe8AcDD/O2BLIflwe5HzW8FcqtYh4zDAZK4y
 uriG6AtXcfug5osI8WV9VUroAq+TtXoImJW0N4w88AWyfxuYj0e/ZEYBvZuka+1obsdU
 h/u5xpnTwiZt5QKyjkCBaH3Jj95oi90VjEw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yg8kwdgbc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 02 Mar 2020 08:37:23 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 2 Mar 2020 08:37:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU0p1xkhtsEaebL3K/9TK11069b9+ZwegM+CD0r3JFDgf3NQ/ww0lGcFYqlAqwz2Pu/kHp4Cz1vppqXAw31WmnS3B8cqQ2xNcqBEizs8+aSoIe5pwACn66sh3Z7yCiJDw3t/d6fxGO17DAmE1qgJ1NN5E2eJAOOxENQtoi3MUWRZF2/xQm13tRl+m/GhXFlxYmZQXyUP/LGA4mzKm+yPjtuokGMFxagiPzJHI0QeHFYw9d+4MmHO6815qHHzP8l8mxu2iQKR65WEOGVhUeDbXsVb+f++7Ldq1ftrN/fmUYlo6EeRk+Mdcqnv39xZDYLt1+YTufMn2MUpOXtsvlXfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoUX/60DheMZbX42aOT2xbiF5PpB2ZnorIewmLS9sjM=;
 b=g8bVwCAiJXpopO0TX8nPPbOObOL9F3d4XCRBAmsBFSB5JEeIaVdjIo8wfd2QEzLz2unrNDHJsjs4RlW2N2eDcJJp6TT08lgXV+QW+HyP6FRvyO9A8ugMlXyaCRzPFMMicd+hPxn04HibaCxugo9HRr1fIPJHXPH9dZ6i8+Y2hcFWg9BJn8KO0uN15m/97zc9/ECIonRg29inuNHp3bov2Mhz0RzYJcOVzXy6QbaIps2xn9ALBLORhDtQNACfDuK1m8J28hyD6wxNaOSiJs+oBvyMjCB9Z9p48HpBmme7nHIROqoM5gwfe+ZUFFu6DTWgnomIKtmUIQ/wzpjJqBjKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoUX/60DheMZbX42aOT2xbiF5PpB2ZnorIewmLS9sjM=;
 b=DnVgyYTMVgGNcQgo1+1C0uAWl/j+COt5C8JpaUtzJVJ97JnU1T9fRQP5/bocuQaqRjiAYje5XNyj0dKTiaPiz83A78gZJb8WMDjUaG3T4bqR/1FZqFJLOFpwmFmzbd9S8DQ4p0u6TSlBerl3er5RDmIJOJrG6CzdlIeskAR+4j0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB3288.namprd15.prod.outlook.com (2603:10b6:a03:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:37:21 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:37:20 +0000
Date:   Mon, 2 Mar 2020 08:37:16 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Theodore Ts'o <tytso@mit.edu>, Gioh Kim <gioh.kim@lge.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] ext4: use non-movable memory for superblock readahead
Message-ID: <20200302163716.GA506192@carbon.dhcp.thefacebook.com>
References: <20200229001411.128010-1-guro@fb.com>
 <26E49EB9-DAD4-4BAB-A7A7-7DC6B45CD2B8@dilger.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26E49EB9-DAD4-4BAB-A7A7-7DC6B45CD2B8@dilger.ca>
X-ClientProxiedBy: CO1PR15CA0077.namprd15.prod.outlook.com
 (2603:10b6:101:20::21) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:500::7:54ca) by CO1PR15CA0077.namprd15.prod.outlook.com (2603:10b6:101:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Mon, 2 Mar 2020 16:37:19 +0000
X-Originating-IP: [2620:10d:c090:500::7:54ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49df30d7-e4e9-4bfb-4b9d-08d7bec7fa2e
X-MS-TrafficTypeDiagnostic: BYAPR15MB3288:
X-Microsoft-Antispam-PRVS: <BYAPR15MB328862C504D8D82A8539858EBEE70@BYAPR15MB3288.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(136003)(189003)(199004)(54906003)(316002)(8936002)(478600001)(86362001)(81156014)(81166006)(8676002)(2906002)(66556008)(66946007)(66476007)(55016002)(6666004)(5660300002)(1076003)(9686003)(6916009)(6506007)(33656002)(7696005)(52116002)(4326008)(16526019)(186003)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3288;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuI9K+LrIqejx4P0CzpPoQzolxjkrhviq0JQzxk2srXlIK8B3sjyfOsTsdD5rePS9KO5JGyjIPzPVW18zhQMDrbuXTcvoFAvBvBdYjS5TRubl+QF79cNuKGHPcjMTI0HpbrbkRhqxoNVfAp1NiWgwpt0PBmL8zviMEwrQ8sP1dSoLZT0TA585+OqdbOjTUa7QsxQ+tvLb9luvlv/lCZrTwdEXuqqWKWze8bucsG8Mb882xa86cmoYMXjhH2+agDvKsJI6XP5qMxMnPV8wDj/jd1wGoMexn6nciH8icr5rrSieHfT+HHxaHawErUSAZnv709uuCCUz9gqnzV3bvDIHttjbYP9EDYRRf5GNUEG85ttRfy4UCnnjSuqKP+b3jcUtBZd4dOlfWGVLPBb8uGM4GY73M9Wu7GyQcNlqxa71/wlYY2/vgyaM52RFzGupQt1
X-MS-Exchange-AntiSpam-MessageData: H5GoJGHGY1kB2x1TANkvSMWTffKipaOVg/UnaUxV3ESI25bGPl/rmI0YaDVMFDRLa+WNAKSQDcf7xihpqiQSzHW6WV99M+wLD9cee3LYenWOI9QspHoFPZjT3WbD+zH6fNALBMnL1BmuslYry7zlKqqopQJWlQxQIMGwWNDXBZfmG65zI9+wpJ3aBEFojHlZ
X-MS-Exchange-CrossTenant-Network-Message-Id: 49df30d7-e4e9-4bfb-4b9d-08d7bec7fa2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:37:20.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdEe4o9B0aLfhBrMpSUarcIUznZ/7qTQPvSdetPcCCRztz2+KdCUC8Ih6V2qnr9q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3288
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_06:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=833 mlxscore=0 spamscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=1 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020114
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 12:49:13AM -0700, Andreas Dilger wrote:
> On Feb 28, 2020, at 5:14 PM, Roman Gushchin <guro@fb.com> wrote:
> > 
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
> > 
> > v2: found a similar issue in __ext4_get_inode_loc()
> > 
> > Fixes: 85c8f176a611 ("ext4: preload block group descriptors")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thank you!
