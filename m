Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21B319FB51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 19:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgDFRVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 13:21:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53688 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728634AbgDFRVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:21:50 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036HKqKp019092;
        Mon, 6 Apr 2020 10:20:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gIBIaZgdtmerVDU58JBeQ83Y+T/JnjlqXqtVi45k8f4=;
 b=I8zkg3wJXVRRm4Q2CiDsI/VYyu6CqxLtTa9nu/E7oqTmdqvWUMasNqrr6l7POxw4QFRC
 b9v/G6X4/jIOhNSN2i+B1wLC9LXa5kdbS4RG9z5fCGKMSPUDduY3fYOwMELvBtpCfpAJ
 e9xhK0Yxk0UBflnelZNTC7QYtegqBQn0NSE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 307a8q3rs6-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Apr 2020 10:20:55 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 6 Apr 2020 10:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVL4c6F102FcNmacvideHaeiPHWhcvpKmA84qtDLjOyrPQFb4mqvj+i0HBZhrIlYbRpKMGyOOS/tzZY+LlrzVYDuc+vEMXw2XUBI4UfGS08jB3r2GlEZkVUw22MPzifU8Af+EMH5KLKKcY8P+iRuBQRILB8LS9B9PA83LR5/1LKYZ73oOWaYrhAx6F1palTcGEwT77CPiCOvLrqiowt5yyxvQej4Ws6INrx5Qhe/cjug6Epkqxo/Gn1UzQRd/awxOr0yzPeK2ZrbgGxtfb2qVG7XvxpHrzloNgbhAC/tQ1mXrVxbuchyME9Z/XKAVbwh8DLHWow27s5CW1kD0RxDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIBIaZgdtmerVDU58JBeQ83Y+T/JnjlqXqtVi45k8f4=;
 b=ciQLlFmNbIYOt/IJu8zGGUBOKb4u6ZmRNI7QAcSs5yUAxAvWYXKmiAwQG++ekrxia3NYj5avBcyzlP1uznqy/nOCvSrQrzFG3DDozV/TokCmePw21hr5FtU0FE5S7/XamCHxxuBXshw7LJp1yh/Bv+/7A6s0MDPzp7Nt5GBoQYoGcVZo2LdsblPU7ZvMm458JDlTTW+hnXvkKAlk+4kT/cV5JXPGDSjrWGdSJj17z0yGA7WldfsMkBAwbH4Pi1tLbtZjGyhpfkZrsVeUC1nzCR9LJ7KwFZA13ikU5x6ja0A7SLbMyHgroT9irbFqSy4oYhcsq8baYlhWXudh7rnq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIBIaZgdtmerVDU58JBeQ83Y+T/JnjlqXqtVi45k8f4=;
 b=kafzyQnkQx5ubfY6Cn+XX1O1z2qEc9O0XF+dW7AIytGVI25DfZuJeNTx3VDEbQuXVcT5OGGTnkC2BXAycXPZ52wMaU2plo19jKXB3lWt5J4EhaeEpEwe4A25WeIPfF031VrVfqBbqfnTtgMaOZ7Y04o8O+mATywKfx2mRnbqOl0=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3239.namprd15.prod.outlook.com (2603:10b6:a03:10f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Mon, 6 Apr
 2020 17:20:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 17:20:42 +0000
Date:   Mon, 6 Apr 2020 10:20:33 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        <adilger@dilger.ca>, Gioh Kim <gioh.kim@lge.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] ext4: use non-movable memory for superblock readahead
Message-ID: <20200406172033.GA336570@carbon.DHCP.thefacebook.com>
References: <20200229001411.128010-1-guro@fb.com>
 <26E49EB9-DAD4-4BAB-A7A7-7DC6B45CD2B8@dilger.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26E49EB9-DAD4-4BAB-A7A7-7DC6B45CD2B8@dilger.ca>
X-ClientProxiedBy: CO2PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:104:5::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:e5af) by CO2PR04CA0185.namprd04.prod.outlook.com (2603:10b6:104:5::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Mon, 6 Apr 2020 17:20:41 +0000
X-Originating-IP: [2620:10d:c090:400::5:e5af]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4caa3b2f-d011-4856-3e9d-08d7da4ed591
X-MS-TrafficTypeDiagnostic: BYAPR15MB3239:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3239716167578B7E29C39AAEBEC20@BYAPR15MB3239.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(136003)(366004)(346002)(396003)(39860400002)(478600001)(9686003)(55016002)(8676002)(81156014)(81166006)(1076003)(8936002)(16526019)(54906003)(33656002)(5660300002)(6666004)(186003)(66556008)(66476007)(2906002)(66946007)(52116002)(7696005)(4326008)(316002)(86362001)(53546011)(6506007)(6916009);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2F7qk8bFCe/ina5aGqJ7cg3q6H9lDTGj0L3NpO2OMwetefzRMHkIT5d1fDqciCAD/bsK+22bYliRN5naeJAFwPAEfdhe2THporWgzS6wPLykBQlOKSbPAsx2youSmsT4afCyIh+9TcQhLlJEzn9qSQ++hIpS3FHXoPp5OzoIi8mZ2bAu9HuUaVh+8oFRtLqXxdxOYNy8CIkL3YpAqUf8Lah9qu09W+ByhjN85bWpxpxhxoSzy7Mde6zKyGiuZRl3F7Kryvi8qpfwMffBR27vq7m8rzpWg3NoG1z3PZVUwyeBup4ID7l7snv71XaXp1peS0YGfBcweuqIuD36BCk1QVoDV+qgBweMJnRtD6ggKoYj1bXlcMZwwmD2JqRUfBUWINFnIr5BfTDdQNYwXmLdawreVZFKP27h8/dW/tJZA0ZMpk2z71bceygvZXGWmihB
X-MS-Exchange-AntiSpam-MessageData: CdKe9L0rWBdwf2JnCNUjuKrHtXRW4YS71lVt7S8cVZxIKsSM6IRLPk9QlolX+iK2W44ol6/wqnB1UUru1uZ1ftNWwOSkkFkDUfHy8xJEiuKnJhzXqh/5WOi+FH9DsN7VAjcv0JSnOBgrB1NUkTknhIieCZ2cH+6btLsH70Popz/V3k66I0tNm80gBVlVnwMF
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caa3b2f-d011-4856-3e9d-08d7da4ed591
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:20:42.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPzOa/IIwoscrcXhVq1KziXzPWnw9wb5llFtxgfLEiLap6BgpwHpg/8YmlPOW8Mu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3239
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_08:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=1 mlxlogscore=965 priorityscore=1501 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060137
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

Hello, Theodore!

Can you, please, pick this patch?

We've some changes on the mm side (more actively using a cma area for movable
allocations), which might bring a regression without this ext4 change.

Thank you!

Roman
