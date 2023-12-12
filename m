Return-Path: <linux-fsdevel+bounces-5719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF080F242
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3B61F2134D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7A177F1B;
	Tue, 12 Dec 2023 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L2qBcSZh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aQYqzDAx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA303D7D;
	Tue, 12 Dec 2023 08:17:31 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDimT7007192;
	Tue, 12 Dec 2023 16:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Kq7AxS6eWVJSJwrwBdSKG9tboWRxT8c2Uxd77iPT/Xg=;
 b=L2qBcSZh81lI/OsRPtEkQ90P0xUoTrb0RWGN7M0WgcqnY0grue+szSCCvX6bxCnvFPos
 6WUtYIJlGSWGLZddSN4JRlYNyUp9n/2UHXf0O2eGV7Uui8t4T6/sra91OY34/AJuvD5D
 ufU9C/rS3GxwgexUdl0GvaKVOPBI2PgsFlWgbXHJ1dGCq11YxRLA0cPakNGCQNs7VT5Q
 FRWqByJQ6wmsX2Kx1/JejPfzwxBNdHgZId/tnQOLySozUD7riBsb3smHLL9IlCnooJe+
 78vQmJvhIYq867T9XxyXe28879kCtw4Ew/gvBQX3CRch/aiCKNboV5Sdk2Ng1Jyph+oh kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3mahm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 16:17:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCFj8xq018606;
	Tue, 12 Dec 2023 16:17:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6sxan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 16:17:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPq/JxzFV882yIMyyTD5wPaM8tmj1c0A/l5JvqeEe+v39jUZJ2oJzQ6yfdKA/P+aJcfjuOSHXjgU2zAIebnbNOAX91GhxIF11F9KHmL19qnD1Shes5z6TwRYr+C//3MEl43Zzw5LGVWmidzZemtUBu3qJDOqxKQZ5NuYCQVJ8mY74u0z/h6M2IPlwzBc8xH+0QtV/xtLvsdQsDyZsX/h8BQV3tv4PQz6+zbbBhOOF5YFb9AdNtJcGzcBVdOujXH74xrv8XYdAkZnPMow+6X4EJ3ts1U1wspWjiIvxaDm5MJZtAGz2tk37KbBz4N2vMpw21gGlE34B14/JEsA38U47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq7AxS6eWVJSJwrwBdSKG9tboWRxT8c2Uxd77iPT/Xg=;
 b=DSrk364886HCdGgfXjkHCVB8k8OutFSp2t24Zsz+4gX1nfYYSMILRGTS4D8cGU8SN0jPqW4lhdQSDNS9a4jynx9aReIBucDoqFvVHuXYfL77/KLoxzWj7GS12S2gh8Xd/x9pAya6Gchp8hVuRHhhn/AgAtAsepLqO2gEMWwJFROchoz8XlHoLbRLukh9OeaZ89ZMxzRrsYSe5pgqa175cinAbpiL9LI2+djcrqbNkRRHl7nWhZnEvFs3ZGMNwCwPGAw5u51cJ/cBnj9kWW/BdLB0xv9310nfXTXITkHlHdI213Awbq0rqQbdCI1YgU7+vnB9HOSqq/to2XPMuKtCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq7AxS6eWVJSJwrwBdSKG9tboWRxT8c2Uxd77iPT/Xg=;
 b=aQYqzDAx33RB9NV4yF+8CsynErG/X7T5U9t+8A/Fr0LwWmxUQJy9IMITmz5GhwvTGb+67P3WlXFPNRRjCqZX/zNdadOkER4QktlzGD07Dh7JgoxsaLzMsma/HHOG6XJNDDIxV7hJlCfM0GsPG9PLBLcrQ3c14NVgNrlwzkktwCA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7807.namprd10.prod.outlook.com (2603:10b6:610:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 16:17:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 16:17:16 +0000
Date: Tue, 12 Dec 2023 11:17:13 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Message-ID: <ZXiHiZFn5pVTiU+9@tissot.1015granger.net>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>
 <ZXdck2thv7tz1ee3@tissot.1015granger.net>
 <170233229855.12910.12943965536699322442@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170233229855.12910.12943965536699322442@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:610:59::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f16c928-4e01-4349-9306-08dbfb2dcee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	71e5V4yQ1swl6XB4ANOJX/IH0lokrgM8C/mqSNrHZNXULPhFyBmux/MskPH4VxDbnvZk1BQnKSqgs/gXOQH0R177gWYTyXSFe5XyQoQwi1jxUI9S3P8n/htcio6Qgwwdw1jL/y/JJDAel45P9poCglDR5Vbs97icBp0HSyITNOvDqYlxRjwpnm6AjTLH0MW59eiecbOuK0zax3R6kDVhdsuJmoAwyHTcmKospu6KceIpjquqBUYPvPzr4HAtx/YtXHgjepAn02Sq+zL+kdPeuh7JKodRgnX5jj7f6qCIDVpddWv1eKSPh7qMc4lGfB2q/E5EaMiFlGPmOKttW9Dp2twp399+h73qLjDuO9arIQC8kPfNyUoguAdGvWmmPmKt8wpQa4v8pDZd+jrNvkMjdnI82cCerPZvCZ3eSUkdCwDWrwfGi1K7zXR5DA0Nxv7GkBXL3PTyk1bowZX5tQiZR/4MNJ7UOeMGvN05uw7J8DYhMEO9FBfyQtfNZZfiQqMy9xyj6HVuDPfThLEEt1MJRyof+qMG9mXbL7lXFVdBFH1kyOr2kcizNx0XxvK1LiUZmj7lc00FO4GrXAtzjfPTf8UGbBdT9V+zdfo5XJVt+1Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6506007)(6512007)(6666004)(66946007)(2906002)(66476007)(6916009)(54906003)(66556008)(9686003)(86362001)(38100700002)(8936002)(8676002)(316002)(4326008)(44832011)(5660300002)(478600001)(6486002)(41300700001)(26005)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fFHz4U0RGZ52ZcRJglVil4pZ6bJhug0QGjYM7sc181hyWaFbk9hgdhq2cDRx?=
 =?us-ascii?Q?V8qSsVgO58C7kpHGVnCP406/q1yITp7wIYRVgKdQLhauGZBEeEJitCfFXFwF?=
 =?us-ascii?Q?4+k10YMcX766YVU3MZEcaX0/6rxNqFRMxEoq1/Xdm4TRN8/LxS593jHV0WcB?=
 =?us-ascii?Q?Ht+9tnkFuPH1ctHEKbCGx16gztBThCzuIF1ocO4lZljKv7ME+FLl96+w+fti?=
 =?us-ascii?Q?acl08zdkUKYuGADub10t0KCnjUs4MEAihGIZierb2ovmlzWs7bTLDxI9qmvR?=
 =?us-ascii?Q?okPl/HuGoGYx0FBaLepWD7RGVO2m1dwRFRNBjcuusHMltlXprl2xJzpQ/hBS?=
 =?us-ascii?Q?qMmOBCM/0KjRRHgZ2MZN6t5Ql7Xp5h9Vh90NUXRfq8fHiEhgwBkqlC/vYoWg?=
 =?us-ascii?Q?fxwsCNytb7hNXkPvF7LRl6R47oWSdgvMvwr8J7n85zKfM0/4LbJSa3xMGyaE?=
 =?us-ascii?Q?eF/ZS7nR4JXpuInafW/d18uBeMQS+J686hhHdqfjQPhrJ83s96ZOgbIOqQ56?=
 =?us-ascii?Q?sOBIUlN4C3NCxRJlTX+3gy8agjwasZh18BwXmvpNUYO5Sf8lI7EGQm24Q/FS?=
 =?us-ascii?Q?N4A7Td3CQyneDgzssKuY90Kqdhqj74tjNrDFKhuF+RdsP+5E2v/ZbWIWS7YA?=
 =?us-ascii?Q?qzn4KqEoodsGTyxcYgXuq1awpX9tzqKXtsgxDfYHxi58bT99X2kO0KEX1KN1?=
 =?us-ascii?Q?jRoHSvS9axpZ14YrX15oyRNTazL9ad4pNKTCTcm77AzVvmqmxEAsZreCFmY+?=
 =?us-ascii?Q?Ie8y8x1Kw2ohozvYPD+idmBQ/bhA1fNqLz2hiVQBAMiFWPP5NK+PbJ0Ack+1?=
 =?us-ascii?Q?ESn91i0fmxAIAiq6L4y5OyrRy9sTg62D+8T5e42hL75YuuDgly+SnxPIESkW?=
 =?us-ascii?Q?1vURqlh6bMsHYEnIeC0Gg2sz7aITXPHa/UYnXRchLNxjg8Yszl7eb23i/IPe?=
 =?us-ascii?Q?SNd5q1v43RcFjpI5JmIFFIl2rFbDSA+NAYHcrOsm/u4iUw1Hg8Q84zqQpaqk?=
 =?us-ascii?Q?n58u7563V3UkBVzlYzpBB2c9PgtrefhmTko8mqZyI20cJrfkTco2NATFLded?=
 =?us-ascii?Q?aUtAaq2CDTUE//9j5dmxjxxNuzPf84kcBOPmKRGr5mmq0M0ALyLuLmm4H5Fi?=
 =?us-ascii?Q?W3w2PYsV0ey+DsS8Nxe9IX1OKkPl+7hLkhrIGTnHA7zXfHi+aGbO+aH7FnH7?=
 =?us-ascii?Q?lkwgoKs4BCBhyrL18VHqx7O8d2i3pzum9XcWTqXJ+gao6W3VFvlZk9la4ko7?=
 =?us-ascii?Q?6g5ztw06k8aSMsNYxvGr6bQw6Ehpt5h5cY7gSkG5R0L7VzR8Lbst3wFW16xu?=
 =?us-ascii?Q?I4+uuFwTk5KsT9UXVTQLgL6wuYQxYq5H5c4i7OGwflS7gdwRsyhe9IcJKDFz?=
 =?us-ascii?Q?egxMdZpv8fsDIFFdBNhHN+kxpzKvpPnMEZ1IMKgz4DULYK8VbIdDzl4dSqeW?=
 =?us-ascii?Q?/mlIbEHkYvsCYUehiFCmpKcvd4DehHMaNpVSiDkGeYGLTCesOdGa5GAAm2Yn?=
 =?us-ascii?Q?rf57nRowx6Kbi3P6rYqYigRYaQHlxEEfw6kSxU2XIL0bN5voFN3lTziQ8mIV?=
 =?us-ascii?Q?9Ls6D1kiWy7nJL4kObJLB3E3/EWxjmXwflEZEVsBUsTVSCr50tSyr81DFt0V?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NaA9fWw/Rqaknzelq3bVC8/ztuijN0hXRa0wLCpgML0R6vdRgc9DupsXoHW4UFfzqRG/K54XmwWo9ORBJmfdL5tFS1MKhLcQrAWlIQmIdDBxEpgQG7bUfIebx/4V479WJAr+GWi8YNr72UnEW6qWPiAkXQaP119zKl8zFu3MSTLVa+a5SH9ov0WZ6ASOmsTTxWmmA2G5+UgLNH51f4fOFHnkDsRraphMnhThv7jEjRLgtx2d6Yh8whEFv0gz1ROo1CgvZD7PB/ZcOqg5lotcGEblL//E1jxJzH8/j6h1XE29Q8ODKvqwb1GcP6hH8OYqfb+TexfZS6ObQJL0EZ7pyV1JkjG5804fI42mFePA4HSq+3eVOZzHI5cBBUUB7ZT6BObqVFZI5xpW14JVoet8L+l+qIuUJd6rSDLcSy/spb9ZYnFNT9RQiichNYsiALsiJYzm21/zpbuo+/ZxOmp2MUWKVP5KrljKEHGt5Z/+NtvlFE9ClQyxRI9CfkZiMhjEZ1EZOA5vZlQpy3xGv+TjrEqWCjz8khAUEB6wVKB7nAxzuTHFPsuQ3mIsozAs9YmYZdS0xZxYkrL1b7NeGGorJfTg6yaEL1R1j8kd5rzVktNQTeKfd+esLXjwwYWtwTD+woM7uRiwZVNv1tdaXCEHlwmlX5j+Gjlw/+MVNQPtyOO9X/8f5u4GoimoiU1n30bMa6AWRe36hZylPpJ1+GT2TfYgg5SE0+QwWbpCix45qHzNAujLezRInOVuI+ZWkuFsLTp+2n4YYYKDdAaiijNWZ2Cw0En1s/YYR8c1yKyIf8AoRJMUyOEqGGKhJCRFuDjL2RGqxnTfLTWCdEn6OoSsmYZPZdSjB7Vt6LbihPnpJdS0tDL1pTC3MD69JGV1lyRiV6ssZmqgwuHYO+QvE8xSLYP9HOibYVIl6Ao3G5OqIEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f16c928-4e01-4349-9306-08dbfb2dcee1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:17:16.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6EdhNo14oZSjCbkKHDOVzskA+hwx9GZ0uY5/cXoLXNuxE4EwhjbYSu4oFrhFa080Z8F3hBQWwvZ4OT/xFBZkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_10,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120125
X-Proofpoint-ORIG-GUID: 30mQDGOg3ogN-Dzo5QxiMNJMDMUHSKYX
X-Proofpoint-GUID: 30mQDGOg3ogN-Dzo5QxiMNJMDMUHSKYX

On Tue, Dec 12, 2023 at 09:04:58AM +1100, NeilBrown wrote:
> On Tue, 12 Dec 2023, Chuck Lever wrote:
> > On Mon, Dec 11, 2023 at 09:47:35AM +1100, NeilBrown wrote:
> > > On Sat, 09 Dec 2023, Chuck Lever wrote:
> > > > On Fri, Dec 08, 2023 at 02:27:26PM +1100, NeilBrown wrote:
> > > > > Calling fput() directly or though filp_close() from a kernel thread like
> > > > > nfsd causes the final __fput() (if necessary) to be called from a
> > > > > workqueue.  This means that nfsd is not forced to wait for any work to
> > > > > complete.  If the ->release of ->destroy_inode function is slow for any
> > > > > reason, this can result in nfsd closing files more quickly than the
> > > > > workqueue can complete the close and the queue of pending closes can
> > > > > grow without bounces (30 million has been seen at one customer site,
> > > > > though this was in part due to a slowness in xfs which has since been
> > > > > fixed).
> > > > > 
> > > > > nfsd does not need this.
> > > > 
> > > > That is technically true, but IIUC, there is only one case where a
> > > > synchronous close matters for the backlog problem, and that's when
> > > > nfsd_file_free() is called from nfsd_file_put(). AFAICT all other
> > > > call sites (except rename) are error paths, so there aren't negative
> > > > consequences for the lack of synchronous wait there...
> > > 
> > > What you say is technically true but it isn't the way I see it.
> > > 
> > > Firstly I should clarify that __fput_sync() is *not* a flushing close as
> > > you describe it below.
> > > All it does, apart for some trivial book-keeping, is to call ->release
> > > and possibly ->destroy_inode immediately rather than shunting them off
> > > to another thread.
> > > Apparently ->release sometimes does something that can deadlock with
> > > some kernel threads or if some awkward locks are held, so the whole
> > > final __fput is delay by default.  But this does not apply to nfsd.
> > > Standard fput() is really the wrong interface for nfsd to use.  
> > > It should use __fput_sync() (which shouldn't have such a scary name).
> > > 
> > > The comment above flush_delayed_fput() seems to suggest that unmounting
> > > is a core issue.  Maybe the fact that __fput() can call
> > > dissolve_on_fput() is a reason why it is sometimes safer to leave the
> > > work to later.  But I don't see that applying to nfsd.
> > > 
> > > Of course a ->release function *could* do synchronous writes just like
> > > the XFS ->destroy_inode function used to do synchronous reads.
> > 
> > I had assumed ->release for NFS re-export would flush due to close-
> > to-open semantics. There seem to be numerous corner cases that
> > might result in pile-ups which would change the situation in your
> > problem statement but might not result in an overall improvement.
> 
> That's the ->flush call in filp_close().
> 
> > > I don't think we should ever try to hide that by putting it in
> > > a workqueue.  It's probably a bug and it is best if bugs are visible.
> > 
> > 
> > I'm not objecting, per se, to this change. I would simply like to
> > see a little more due diligence before moving forward until it is
> > clear how frequently ->release or ->destroy_inode will do I/O (or
> > "is slow for any reason" as you say above).
> > 
> > 
> > > Note that the XFS ->release function does call filemap_flush() in some
> > > cases, but that is an async flush, so __fput_sync doesn't wait for the
> > > flush to complete.
> > 
> > When Jeff was working on the file cache a year ago, I did some
> > performance analysis that shows even an async flush is costly when
> > there is a lot of dirty data in the file being closed. The VFS walks
> > through the whole file and starts I/O on every dirty page. This is
> > quite CPU intensive, and can take on the order of a millisecond
> > before the async flush request returns to its caller.
> > 
> > IME async flushes are not free.
> 
> True, they aren't free.  But some thread has to pay that price.
> I think nfsd should.

An async flush can be as expensive as a synchronous flush in some
cases. I'm not convinced that simply because a flush happens to be
asynchronous, that makes it harmless to do at scale in the
foreground.

Our original desire way back when was to insert tactical async
flushes during UNSTABLE WRITEs to get the server writing dirty data
to storage sooner. It had an immediate negative throughput and
latency impact.

I have no philosophical disagreement about nfsd threads doing more
work during a file close. I'm just saying that moving even an async
flush from a worker to an nfsd thread might be visible to a client
workload.


> You might argue that nfsd should wait to pay the price until after it
> has sent a reply to the client.  My patches already effectively do that
> for garbage-collected files.  Doing it for all files would probably be
> easy. But is it really worth the (small) complexity?  I don't know.
>
> > > The way I see this patch is that fput() is the wrong interface for nfsd
> > > to use, __fput_sync is the right interface.  So we should change.  1
> > > patch.
> > 
> > The practical matter is I see this as a change with a greater than
> > zero risk, and we need to mitigate that risk. Or rather, as a
> > maintainer of NFSD, /I/ need to see that the risk is as minimal as
> > is practical.
> > 
> > 
> > > The details about exhausting memory explain a particular symptom that
> > > motivated the examination which revealed that nfsd was using the wrong
> > > interface.
> > > 
> > > If we have nfsd sometimes using fput() and sometimes __fput_sync, then
> > > we need to have clear rules for when to use which.  It is much easier to
> > > have a simple rule: always use __fput_sync().
> > 
> > I don't agree that we should just flop all these over and hope for
> > the best. In particular:
> > 
> >  - the changes in fs/nfsd/filecache.c appear to revert a bug
> >    fix, so I need to see data that shows that change doesn't
> >    cause a re-regression
> 
> The bug fix you refer to is
>   "nfsd: don't fsync nfsd_files on last close"
> The patch doesn't change when fsync (or ->flush) is called, so
> it doesn't revert this bugfix.

If the async flush is being done directly by nfsd_file_free instead
of deferred to a work queue, that will slow down file closing, IMO,
in particular in the single-threaded GC case.

Again, not an objection, but we need to be aware of the impact of
this change, and if it is negative, try to mitigate it. If that
mitigation takes the form of patch 2/3, then maybe that patch needs
to be applied before this one.


> >  - the changes in fs/lockd/ can result in long waits while a
> >    global mutex is held (global as in all namespaces and all
> >    locked files on the server), so I need to see data that
> >    demonstrates there won't be a regression
> 
> It's probably impossible to provide any such data.
> The patch certainly moves work inside that mutex and so would increase
> the hold time, if only slightly.  Is that lock hot enough to notice?
> Conventional wisdom is that locking is only a tiny fraction of NFS
> traffic.  It might be possible to construct a workload that saturates
> lockd, but I doubt it would be relevant to the real world.

I have seen, in the past, customer workloads that are nothing but a
stream of NLM lock and unlock requests, and the business requirement
was that those need to go as fast as possible. Inserting I/O (even
occasional asynchronous I/O) would result in an unwanted regression
for that kind of workload.


> Maybe we should just break up that lock so that the problem becomes moot.

Let's drop this hunk for now until we (I) have a way to assess this
change properly. I'm just not convinced this hunk is going to be a
harmless change in some cases, and overall it doesn't appear to be
necessary to address the close back-pressure concern.

Replacing fput() here might be done after the file table data
structure becomes more parallel. Maybe an rhashtable would be
suitable.


> >  - the other changes don't appear to have motivation in terms
> >    of performance or behavior, and carry similar (if lesser)
> >    risks as the other two changes. My preferred solution to
> >    potential auditor confusion about the use of __fput_sync()
> >    in some places and fput() in others is to document, and
> >    leave call sites alone if there's no technical reason to
> >    change them at this time.
> 
> Sounds to me like a good way to grow technical debt, but I'll do it like
> that if you prefer.

Yes, I prefer a helper with an explanation of why nfsd uses
__fput_sync() for certain cases. I'm going to take the admonition
in __fput_sync()'s kdoc comment seriously.


-- 
Chuck Lever

