Return-Path: <linux-fsdevel+bounces-8771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B461583ACB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2AFB3085A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F17E76F;
	Wed, 24 Jan 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4HOEWWE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SXLlG3XA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83C7E764;
	Wed, 24 Jan 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106625; cv=fail; b=QcxAvnibUhokQxI2F6qu9iIvHiL666amc/M0qn/ZfjgFN+YR449IW4eum+ShOPQ2zkP02Cb35ubDbX1/T3cK41MqGuq6iolMQlDiejkrofOTawQaUSw8r0z+uROT7AmjVm/00pCpYaV3HCBLk+QNNAgZViqIXWBhMYNrmPYHnQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106625; c=relaxed/simple;
	bh=GhFifFt9FWk6ZwIrbs9DhO1V370WT6JFptX5Wb4lMuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lZ64B56vDtAp+aY7o1BFtCxyub1BgO41FNRMtMQBY9YQ+XVc9XshtPspXVkLGL/dxAQCWqw2Vp1hzPgoVY2bAj4EZI/Tc9xDE7SsHLNUPes45pXul6L4vrZmW8B7QJOuPQ+LUBUqDKbWaVo8UcwcoXnTfyHPaXYeCMnuhwwV3to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h4HOEWWE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SXLlG3XA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEDsVo031403;
	Wed, 24 Jan 2024 14:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=gRit1FkUpM7m21bu50u4YAlWDNP8DZtcb4CByWbP72g=;
 b=h4HOEWWEVIXxCoLvrnhgr1n68yEFiLkgC7jali/a1aF+Qf7qG4uPmFuLgTDEGVzSCKcM
 o+NUOmgyoUrYzPSkH9dhmoY7OLmM2ziibf6CZR0YFzvvdyvrxqF+rQl6bRr/Ljt3D8H4
 ZJ/xz6ldXAu60BxGISK3SDyUviqaDiJ95EDdjmvPqDfLxHhHbGcJujLGWE4re0GQHqQz
 VtfnlXiwAsEJF670TuJjXH5fRtM1ZvZv74DTUhlyhZDrObP/NIxiz8B57pYHuM8/t/8F
 b9GTKSDRAL9wnEPeaUVUpuulhjaIQLYgqLC1QccDcPKPrYL2IjLMf0dpuJsFt0Z1HiCc Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w3txq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:26:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OE4ql3029643;
	Wed, 24 Jan 2024 14:26:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372rqmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGft+wvvh1G9cAiK9GcsVS0QvUKdcdAHEbVDxJy+/nYJXgjOn4LgtcnjbSAOSNetJgjMv/CGZQJTazpFkc7n+5/7lT3Izt1fDQXjfhtOZZY4W4eJYG01B/z/2l6PtEGIP0SfV1764XU/mxuHomt/kA86m19J+tLjz4DlFGlYqYzK9zV2yDiKtcWeo031iVK49JIC/ENrsGUb8uXp6o7jEd99L+YpuDyvtjpP8yOQhkwoxQd2M6EGWVS/4Jdg7xGK3o5RdZlBXa7191fkeU3m2OqVbQLJbMeTId439s4Yp3TdbCyZ472jvIZvNppAXaDPSgJSyaZIseH7T4epU2eHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRit1FkUpM7m21bu50u4YAlWDNP8DZtcb4CByWbP72g=;
 b=bGeT7sWWwg8HDaAoRUKGYMhS4Du4JWAbrFTP9kBoWfcP2jMY5D2C2MZtmEve5un70lwSz31yKI5eaplakFuL3CdTXIk0GQe9NH6LAEA3QGqI7jHKc3NvFEa0ohnCPrl5Vs46QDQfDbZWSs/spLdzi2s6Tv5jY8G/QZGdjRnHVcW9nwWaf7Fld3vCr7fjU02t9pPBi/cfqednxn7ccHSljtirCB/RqoQs4NyWEZzsb24NiPMm6Uj7Utn+S4HrbGhUf0Yd1R32XR2qyB4dGwzpMS54igOXhv+z3yc9iOSxi8Xwl/sGrMl9wuXK3y/DAW1WDbmRAjWKARI3BhIrZDdHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRit1FkUpM7m21bu50u4YAlWDNP8DZtcb4CByWbP72g=;
 b=SXLlG3XAH35Z42LFGaaO9/qTX5eT7Hgf+BdkMdxHrZ4nWt/IbrZpmlb1Mq7SQSeG5tfkElEYaGPh18GzIEPa5DvPHp9nFzysRzcoVhIPvssvT+jc2n44tzAft27Y39RBXwmTKA65DjvifPZe8B2JUWJ+cxjFJ2V8dnp03Nbq+80=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 14:26:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:26:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/6] block atomic writes for XFS
Date: Wed, 24 Jan 2024 14:26:39 +0000
Message-Id: <20240124142645.9334-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0652.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5312cc-d1ed-4354-2472-08dc1ce883ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DUCjfBCnTwt4w0ffMxZ8VkUFCxxrgIoacM6IdjsRcotsJK81OopnK6liNFfl9e+TSgwB3bpqNGYD9jl2tZJSUG3bFP9zC1jxZcpOxfeD1sQgJUXxSGgBLXuAcNBBL0MN23tJmoSbPEwzvhFybeGKEYMmSC8v4UT2hJJvxyVXslqeAQfwyTMFkIiGajHwjiegNs3EaN2mt6lFdbzTAYNvMSnBKFK6qRcTgjlSag3k2Dum7loj+AY8/ZNedgGOFdk0bqbqSgjFYfsHUgLzyD0R0PNgyqTSctzOrPe/tM1TcplVY1um36C+csDIBZ5WA3HRz199hRcGJ3BBDCoyDctobiEbtKkTpKdrpJ0qyAha5iMTFCZ8NIROMCZmX73XsoxP1kgHjbLHGLd6PqBc+mAhhQw6mdwtxwvSUNBW+9JGtcurGBla+6LBaLrKIAJIB1zggqn0hw/DOhVx0BWpvEp1msyCgDk2DgeF1I40E6vD4WcME/Nx2zxOlWaeblo+JII8sqa80/vc+9HkXZR+nNo1CDD76BwQWENyN8nd3TexicVsIHXYpC4dQNRC2pLTpIUu9+32DXFFA1lRyPSbvEKEoA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(41300700001)(36756003)(86362001)(103116003)(38100700002)(107886003)(2616005)(26005)(6512007)(6486002)(1076003)(966005)(6506007)(2906002)(478600001)(6636002)(316002)(66946007)(66556008)(66476007)(6666004)(4326008)(8676002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AvfSb+L89kRi0ErTNYfCtsLshpb3tbMFLdm90/tQ8y6vANQrn6F/iytJxLND?=
 =?us-ascii?Q?GWzA/hlXfsZF0sluHIQkliJn/E2kgnZ0m7KzZ8qPaFz7pyNMxqeKKtzJERSu?=
 =?us-ascii?Q?p9hi53QGl9jhCTbWYM8GFu5IsD8TtfKqJq31IlQoEvKmd3g5Hyayigc/Ob7Q?=
 =?us-ascii?Q?2IKciP6UC4lqEJuMBn9cVnfuixr4qP5l++JCbIofbKJUG5fWd6d47sspMvos?=
 =?us-ascii?Q?ZMCAEz/JbULSvQS8/+bG6DgKYV1GH+k/FIvmOW4ZmQ308Z5B61K2F2NkOwSB?=
 =?us-ascii?Q?Pbn9kvFG+jDO1rVgWGlaf0iuXXgt/qv6ZWe/n2pAO93nnH3WUdYffjVyCher?=
 =?us-ascii?Q?dz+jwMUQ6kdGT8/XOStsXt3tS6lJyOixphAVk5+tTXLeGgRpID8dX+zFg/mi?=
 =?us-ascii?Q?t9SI1P9RmXI/pbmUGGdFBzhxqvozmkgIvUwBAcNi3jgIOimKLuq+d+PBXb6B?=
 =?us-ascii?Q?rO6/y9W0MKCiFQRBubH89bNeJmy7aIpohmIkG8rI+/hUbyacYj/WOK63GB/I?=
 =?us-ascii?Q?71mz1e5bfcmepywgPI4v7Xmb4wA8fkenBLydrBkQGr1ShDvi/83+BtjTpjuc?=
 =?us-ascii?Q?6iBN4l78HuHnCry862UPB+nDxCPn1xJ/j7RnoF6ePr1dtc4jFCNFi5WuJYsh?=
 =?us-ascii?Q?osyriHTPeBpcPZFoXMEA0HMQFDQf+YChqkcyn/u+HtxTFNyABKB04JP27NMO?=
 =?us-ascii?Q?e3qy+0y0+yXgdbYXMOmvuRX/whMejajB8IN4PdeuyO4d4KvNfyKTIwhJm256?=
 =?us-ascii?Q?YaO7QUkt/o74lZ1iAynFAI4dFyLEqg1sf96Kle73ya0xdewUcf3YZHoi3eoY?=
 =?us-ascii?Q?dKNzt+cLD03ct7MKRdp5drI6RpamUB0kXKD+GaPKl8gHBm2eSkWcIQOnSTPF?=
 =?us-ascii?Q?F30JC3v6uxAZ+Bi/CvovSk9fn6g6j5qXI91pkqkH/tWA7tpeeT2Uxle0jnwN?=
 =?us-ascii?Q?QZRM8dZuH5EcXh5HxJI+kOJJDPrszoCuzPosGPOnCmviP0L5y9rZ8WjU+BDZ?=
 =?us-ascii?Q?m59ZNX+PeGeyKpoedM5rTSb6Zh1InYNhAvn0ILldIpKlEcWJBnbs1FcemuJ7?=
 =?us-ascii?Q?M/g03oAw9jc8ABc0Dya7r2N8q5f6diG0XISDzROhvU/PT9G1SKFE81n5lMhj?=
 =?us-ascii?Q?t2mG7ZBqagXslGTojodzCd/MwnGXhNdScyuXCZ7j6j4tYsBhdR80CBWkttwl?=
 =?us-ascii?Q?UiH39IBb4+Vgsd1x3QyKrTxdX3kSuz6efijVxs9GMl7tmkp0YDBzfjPJ0k9L?=
 =?us-ascii?Q?dtyts641ctd/Y1Ex8upM2/6PaUoF19LEGVutTaOov2Zdiv1HlFxGVd4ZgmH3?=
 =?us-ascii?Q?XJwCIIeo1TgfS4pGmN+dL6C41x3EN44JMT9wigKrgabg/tBDOYIe/OeS8J6c?=
 =?us-ascii?Q?MwHjCohlLgkfmJz3O4CcGnVAexidoHalqVCIDAM8epYm+x/dSVO63naEDHJA?=
 =?us-ascii?Q?XaM2+ftkXEcnkaAA6fkK/1Vqr4SYNie4M7JQt4HIW8tAv9sgFKTTC2eoSygw?=
 =?us-ascii?Q?yMx+Q9pKM2yxQC2zV0KdbstRuj1E4AMfgbce243CEEnCPm+JJzmVoXDuNztM?=
 =?us-ascii?Q?79wATr2gzgErYYHnqKiPNY6J5UqVyAmq1LC6B0izLEy3UGMEqCls6ZGvuPfx?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3fJaMtZl0qWhtpWDbRYHNQLhtGL8TZNvclr7Kk37cTwBsEJ8B5GONHvNXaRGykPfL53k44lyR+FuKMOVaihVsqHD+/SK4f5G9iGIHgXioILQc3BBQCX0zFbNxCwIztCh1ixNZ2QRJ62VZLuMr4/1j0D8T2xJrcHG4nVNQ6SqHmSNGLxj94MxC42avTlL2j6401ssvYsOObYH6cYoSmHeE5TPBSKBa3JIR3gh/yi1B77eAwlp7ArT6bVURK1kBCCGFXJCPzitH/w9oyuuVtmSqPfiYk8404g0H5tN671ZTXH3fU1bPJ1rLkxSaONoW4urXGtvVnbuSfGzB+NZJCIizzRuSlNxEFYNOKzRQj8zX1kZKozh6zd/UppisfBwocXP5NE5bTwm+5E0JDrweJ+7Lb4O5ixqqLLit76TmYnSSAuFdE/XZ1nGItz8JcxHHRHBPur8x1+wjcDx83UOoth9Dar7GYL2cGZCipL/7AtQRq8tc8gkbP8MtCBtjx8U1XTUQRucbX2+rjPWColnf+NjJfR6hSWJJBSqpyVMHIQSkkVniA1xClSqCn7AE1Mq94dclY/k7AFTpUT+huolaVP5/RhM9YccuUX3WPkG+I3vxlw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5312cc-d1ed-4354-2472-08dc1ce883ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:26:54.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WotJWPaHyVa6oDJJAwr+v8bxN5FKT5EhDop3+ht9y7ZTnh3NuGk3hrLJ58ytVEEu0LN64a+L9AbbMlSUKFVDDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240104
X-Proofpoint-GUID: M0NIBwgqVvBzRrWqtxVNYwtEXVCcUB-a
X-Proofpoint-ORIG-GUID: M0NIBwgqVvBzRrWqtxVNYwtEXVCcUB-a

This series expands atomic write support to filesystems, specifically
XFS. Since XFS rtvol supports extent alignment already, support will
initially be added there. When XFS forcealign feature is merged, then we
can similarly support atomic writes for a non-rtvol filesystem.

Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.

For XFS rtvol, support can be enabled through xfs_io command:
$xfs_io -c "chattr +W" filename
$xfs_io -c "lsattr -v" filename
[realtime, atomic-writes] filename

The FS needs to be formatted with a specific extent alignment size, like:
mkf.xfs -r rtdev=/dev/sdb,extsize=16K -d rtinherit=1 /dev/sda

This enables 16K atomic write support. There are no checks whether the
underlying HW actually supports that for enabling atomic writes with
xfs_io, though, so statx needs to be issued for a file to know atomic
write limits.

For supporting non-rtvol, we will require forcealign enabled. As such, a
dedicated xfs_io command to enable atomic writes for a regular FS may
be useful, which would enable FS_XFLAG_ATOMICWRITES, enable forcealign,
and set an extent alignment hint.

Baseline is following series (which is based on v6.8-rc1):
https://urldefense.com/v3/__https://lore.kernel.org/linux-nvme/20240124113841.31824-1-john.g.garry@oracle.com/T/*m4ad28b480a8e12eb51467e17208d98ca50041ff2__;Iw!!ACWV5N9M2RV99hQ!PKOcFzPtVYZ9uATl1BrTJmYanWxEtCKJPV-tTPDYqeTjuWmChXn08ZcmP_H07A9mxPyQ8wwjdSzgH0eYU_45MaIOJyEW$ 

Basic xfsprogs support at:
https://urldefense.com/v3/__https://github.com/johnpgarry/xfsprogs-dev/tree/atomicwrites__;!!ACWV5N9M2RV99hQ!PKOcFzPtVYZ9uATl1BrTJmYanWxEtCKJPV-tTPDYqeTjuWmChXn08ZcmP_H07A9mxPyQ8wwjdSzgH0eYU_45MTapy6qp$ 

John Garry (6):
  fs: iomap: Atomic write support
  fs: Add FS_XFLAG_ATOMICWRITES flag
  fs: xfs: Support FS_XFLAG_ATOMICWRITES for rtvol
  fs: xfs: Support atomic write for statx
  fs: xfs: iomap atomic write support
  fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for FS_XFLAG_ATOMICWRITES set

 fs/iomap/direct-io.c       | 21 +++++++++++++++++-
 fs/iomap/trace.h           |  3 ++-
 fs/xfs/libxfs/xfs_format.h |  8 +++++--
 fs/xfs/libxfs/xfs_sb.c     |  2 ++
 fs/xfs/xfs_file.c          |  2 ++
 fs/xfs/xfs_inode.c         | 22 +++++++++++++++++++
 fs/xfs/xfs_inode.h         |  7 ++++++
 fs/xfs/xfs_ioctl.c         | 19 ++++++++++++++--
 fs/xfs/xfs_iomap.c         | 41 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iops.c          | 45 ++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iops.h          |  4 ++++
 fs/xfs/xfs_mount.h         |  2 ++
 fs/xfs/xfs_super.c         |  4 ++++
 include/linux/iomap.h      |  1 +
 include/uapi/linux/fs.h    |  1 +
 15 files changed, 176 insertions(+), 6 deletions(-)

-- 
2.31.1


