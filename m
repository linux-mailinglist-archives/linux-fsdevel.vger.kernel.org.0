Return-Path: <linux-fsdevel+bounces-5667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E880E9D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343C8281E0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA345EE88;
	Tue, 12 Dec 2023 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJ6uHUik";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pyH1PPxV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0BBD5;
	Tue, 12 Dec 2023 03:09:52 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hogf021829;
	Tue, 12 Dec 2023 11:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=QcY9RC3avw9MZfKu9dEVIMCBEpzsZPmmKQ9DTJpxijE=;
 b=LJ6uHUikqTXbPTwwh/2ovIBVg3HUZGRiY6Qyk+fBcLt10gOELVYnV6Kyn00ss7VPP2GC
 nlU6kJwM9kPlMgmDtJUn1V0WlKM7Ka/q/ht45SCl7kw0+zpknz78ahUDhYLzDddTs5Nw
 qBvAgMFGd2tSxDCLpBeyBc6aSTfT/yfvujieLVlJmnn6t6Z7EDQedD9J+ulv8VwE0pal
 hx7jZh7fssPEUuEvtHeusGYHs3INa7RhFXTv3QuwVl58Tgj4dz6mszm3gEBHv14JGOQK
 k5xwu0on2sySlTLmvR19e97RE59td5B7Kf6dFjF12g7DXh530L/um2uGFCC3fiy7qqrR hQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3kna1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAZCiq018664;
	Tue, 12 Dec 2023 11:09:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6d56w-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1pyMqDL65J8SY9lXuq4aqDD1WPyu6YGPCybq2cmnmKniN3DeLsfE6runWVsHFK6FWOM8LYHEevusK4byz6LC2Zxs/q23EPyugExYg36awNFGlxXhAAF90OlWOBzU7ju585W1ws6qg6T1MVMqEvBHh0TB+0JrSVuJJJlxq/utiBP53QNMEemFENEVjMNZ2zZzw/Od2VC83tV5Ix2xGPY9qED2Q6f8+u3WIpBY4vPEXQFM0gcUcA8nMBVsK3l45+YQwSTu5Mpm9kwI7rbV/Z91l8udzIANo9cX6uW/FvC9yS0uDdrs1BlTmh+MbjrjNqyihy2/sCPZZNglFjjd6Jq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcY9RC3avw9MZfKu9dEVIMCBEpzsZPmmKQ9DTJpxijE=;
 b=LyyvWAbm66nYSigl/fiUiosiY2iN7T7q+L6gB4M7mnyy9WZptUWgpe6Bx3ndP/8jbakM9Okhlu1fVgb1Osj3dGb1qIbRSbQGNE35OfrY6xpdE0mz+MY2btB+2R7Foxin4vCI3Ul4MZLW+KcnHR2SnHVjfD5GeW+zTsaRjpuWV05UKG0BFdUyjavi1mUldfNDtj6yd1HscxXmb9YrhWzCB0fRB5QYC4GR2FJz9buvmjskci0CCfvdYtiwuPVw04asGrDeFcpg6IusdewoEtq8W2/xtruzHwqTSVzzIXp5p3IVJZDDExBnKPelVxRq3Wymc2t3tvJKikzxk0ED68Hnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcY9RC3avw9MZfKu9dEVIMCBEpzsZPmmKQ9DTJpxijE=;
 b=pyH1PPxVFtdOMMCBuIBzsJj1RNFIF3xVAQq6n8LI9U8LGXUZL8+HznNOPpyKweSyv5mpCfaRT0PFeW02qxrlIR1SKSkcQocqwiUijOwoi3MZxGQRem3cGbR4aQ9sJIoP9sINRchO9Xt7OnN1QRgvvqig2lZbQ4vDeW9fNLpqgSU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 09/16] block: Error an attempt to split an atomic write bio
Date: Tue, 12 Dec 2023 11:08:37 +0000
Message-Id: <20231212110844.19698-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 809b23a5-acf0-4b67-5e01-08dbfb02cc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ElZv+vnwItvXhM9NQ3AWMNkEFei2AyEvkJQNJE8PHdMVq2YwDJVatBqziV9KYpk0n4x+T7F/7yu4FLuCtLVTjCv1Deh9BLHbk5k2KNvrQygf983rScqqlnEX0cPPk0/MKV0xjGqMADD7DAmQSNGOeaLDcFOKsrgCSilRkVrWM1ZttmRI2hTDQk772iCIWmBDH1G9S+mSR0WB0BPTpY5x6QDPg72HXddkB0NNgkckSSm/qgzlBPQlCR37c6GIS7f6Hxe4iJu/sRTGgWx7Q++7MatTm8s2ZJqk/WD21fxn14sS4M8BhdAVBWqYg5vPDCS22Wav6cPv9jG5scOPH6hhWr9hPM/aMUWvJ6of4u5ubB8Ye5WcUGFuSaP+vg5qec9GrMZ8hM1Fijpf78DLLuIVo7nLgjQfqmoCMEvntWQWqwNsw+9IS2Q0Ow1lPHWybccH5ulwbQO/BrVH8hrY39xGapqnAZpAgV6YsoSaDXsa9tduwPcvAq7MCaOFi/ukFtlkMvZ7rWDXadTgzFnKe2OMGiBa6mH0cPxVQ1GU3xfvEP/MYMh9JdtMtX2Kvreem9U2yFbKP8q44Ae2dBGdsYB8BQ8Hx7fhnqZWnTtNJGZ1HRs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(4744005)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5jWhRlyWq4JkCLK9oEjRLMCTuZBvw/fU3kytPjc+3noKN0mHT31jYSTbp48e?=
 =?us-ascii?Q?zmj6DyCumKl4ANY9eA0UJaiMmyU3V0MghIe/87H8bGdm9Ea+r7gUaC4eHSjx?=
 =?us-ascii?Q?h/JAXGOKH95FGKL5m0fWmlTW3wztocHRVNUizUq1dS4X9k77cnBGTifSWr0P?=
 =?us-ascii?Q?Qby2yCZiNKakonYyGOQ3Aou4g2ayTVFkDxKayTVluVo+N3SY2Y0GUtlad8mH?=
 =?us-ascii?Q?uwj88kkyWWwgmwIXUzh2fLvXIDPoHbFRc3Xe3yyL4gumldiT0SWJ8BqMFCjd?=
 =?us-ascii?Q?7fv/tAkeiCBM8M4UPUGksO+hNxA8bP2G7219M4jiF/Q441d/2G1gl+fKoihi?=
 =?us-ascii?Q?jNJ13zX0/hmYuhqf1IDjj5M4EP8rfuTI0p4Z10X6H9+ddP0wwWm2saaQAMi+?=
 =?us-ascii?Q?hmNDGj+SyO9VXPkehfWrQdHPHDyRANiDGRGcnXAVgoYXWXBrKv5aR/8Gr6IA?=
 =?us-ascii?Q?oPhHjxp+R/OoN01AmEPc2thKFk/y7A5F+mQbArmuAv6mJBBxAbSAcLgxyr+N?=
 =?us-ascii?Q?Boh+p8WmQVddAzvBKvTGMP7GxgvnCd7z6CjzHbqo0nyrLot/fSvbUvkYC5gx?=
 =?us-ascii?Q?Tt4ROR3kT0RJHt7Fq5apgP0u7Jc0+ZWesXRZ8KmUNgC6DfVf6PkPHQO8yy+h?=
 =?us-ascii?Q?h0i+HXb2pCtBU0oBbzxEWCKOXVNfMbN1KHyzsC+B/Kxt22JKZFDD+Z4rNuD8?=
 =?us-ascii?Q?1IQ2xYx7NrbyQsM4zofbxzQI9GTDBxlKHxpX8clrgXf94nEpKwvvyDHAZahe?=
 =?us-ascii?Q?6m/s0H/soK7eqdXoAFKa1GcCKqawFHXEXnfY/mS54qm6WJJCQtSSqxCwkYqp?=
 =?us-ascii?Q?Fwws8m4MHTgu8WFoGp6aMHoGyELREUX2jXTFSVXptYp28uXJqno46bUMcbTZ?=
 =?us-ascii?Q?Mdp8IgEzKqRsgtACVkHx8jM9MyKJLuuTEGOOG3VhAx4V49lEFavf8tCE8YwB?=
 =?us-ascii?Q?HGV5PUeZibFmIm1UCV+TLN7n9MnIHrR56YmAR+8oDGxen8KmC8kqlqhfz8rz?=
 =?us-ascii?Q?RXO057XZG5Ylb1iUxMzHjjMx4z2nYgT+QvhNX3PYeqmxS1zsbeCSlWlxAezR?=
 =?us-ascii?Q?MQQ+ESJu4EYQYa7poQfRJkJJVp3FdqArBsqY9OG0ebrWIM62+awWee2TImAb?=
 =?us-ascii?Q?OrpZwmUdtZdgW+vJUy2VKNi6PI/izLz1zwtftyUeIUW+enn+8dpBttIVawly?=
 =?us-ascii?Q?T1mAykgre0DxpHbCLGUEde60Lj4gzEgHf2v5n9mVI13Ko2LxYvYUtUeMNURg?=
 =?us-ascii?Q?ypWvutcaZOXwf5ZEyeheG56YpR59smJslDnVOAPKQurCpg/1ZwKV9envUtLi?=
 =?us-ascii?Q?KURiQMNko0JNa9CzI1WFOM5PmzDfh+XY5F1J6Q7Vknygrr51iFkaObNZx04A?=
 =?us-ascii?Q?dyI/h4HLuIvkOn3F6LEkZfkHBajQUq9iXWU7vRLBHMCufhc0tJfMDl00Fxdi?=
 =?us-ascii?Q?9xCGwnBg/BpQm3CdttVZZqJ1Yl5hML6Etj+JeDb/AA18Oe6i2xcKUA72W1X/?=
 =?us-ascii?Q?vN8EHLe+LAICT0ItjDiFSc2KnWYmxsVB9VK4vhLxfjk6xh08IhP+QFrUdUh1?=
 =?us-ascii?Q?EEeuJBSu9WVdgQhzH+eAJ+Gif140fNT5tgdqSxFdVJ+GDz/5yOBIDsI+aaGQ?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nOT/esikKOMFcIHsVs+2/809kSYnH4clK3ho60jO58iDWJeFArQNWSYcqPA13/nCNUV9MBCSzdFo0TMLNfjvmMNpJfs+6+2FLUaMMSccG4Z7C6WBwPMo0tTvr17aU3aVN9Yas9nsBBsYIpyoEQRX5XXa1ElcpWRFgkUzTcor3PGfiiIu3vVB864ywirhYisSwkIfsw/MC61YW/VFMihtrXqMOtlo9vemiFjLDzYyDxfbIR3oMDwMmk+0VEPG1m0Orqi47r5l4RLQwa8VHTODnsWyURbKM9HcrdH1AFFoU61u+VFBZlBlmOIcYAAsdqb3F5qTLVYL5NAPkRlE6/51TZ50mo8ueMILJ2S4RdxDjCFUWsM3lEmCDNYYoT02BSW5mG2251AUDLey35A5D8ieFQElQbxiA5C2yKeXEhaBDe2xyxe7OAdgA07VafHzdffV8dK/i0LO6dnwOmqpcZp7H/SXTiJKQOVRpIECqeMdVQkG5FyV8Pljv7IIQCM1DUtwtYdX7B014/r9J8PnWbr24BzLRAKrRiOkI9abNH9BiZB2VKlvHdqTCv6nTYtOfxP2IV/8OVVNU3esProWbXWTtfqUH7dZ3HOJi63U4yMMeBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809b23a5-acf0-4b67-5e01-08dbfb02cc58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:24.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQakJvdJMvasrKfyyp1dAimmYggIpla4ZFwaSUejn7CvCnU4dvGea6LiMilpWtlPp4tqOpF6GPYNjD2NR/6UzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: DMgOnbWTaz44WN15Adm_VKhvivd5NfaK
X-Proofpoint-GUID: DMgOnbWTaz44WN15Adm_VKhvivd5NfaK

As the name suggests, we should not be splitting these.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8d4de9253fe9..bc21f8ff4842 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -319,6 +319,11 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	*segs = nsegs;
 	return NULL;
 split:
+	if (bio->bi_opf & REQ_ATOMIC) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		return ERR_PTR(-EIO);
+	}
 	/*
 	 * We can't sanely support splitting for a REQ_NOWAIT bio. End it
 	 * with EAGAIN if splitting is required and return an error pointer.
-- 
2.35.3


