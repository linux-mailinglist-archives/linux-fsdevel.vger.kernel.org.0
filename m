Return-Path: <linux-fsdevel+bounces-8772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7258983AC1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978DE1C21286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A312DD99;
	Wed, 24 Jan 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nmlNib+Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MH73LyKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA27E76A;
	Wed, 24 Jan 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106627; cv=fail; b=eXv1QtsJa08FxPEkUgspKh8n5Ng2+k1VKDdoCCjurBzfJ+dspduvFJaUs80qWXSGSRvkZErbn8+EBHYRxVP2q9yvlbFBTzDIdcELIwIBQkiXB3jaFs24d3XEUSknVrxb437C7vzbR1AMiEnwnVok0lYU2vi48nsRyXDE3+DO3Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106627; c=relaxed/simple;
	bh=m11x9zr2c7WAhARSL2qIIW4lHdhAo1t4TpvvwwO/1wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fI3D2vuDVYAtY7DQHeOI8jnwgvO/eIQ9akAv4sM6L+Y4D0/eEJ7omCgC8FU3OD9ZCPk5dwQzXM+FuBOvX2rMGQR1+80k0bG7A5PwUc3B9fX/cLyBJS3nXPkHSaxszxHfTVTJMYJRDm3Vz2QxJcs5qJh7EhHlLOqtjgqJXqBHwRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nmlNib+Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MH73LyKk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEEIJZ013249;
	Wed, 24 Jan 2024 14:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Q4L4YDsjacLh2GjC22A+cQl0QZfjcK9EBUSZdxONXKk=;
 b=nmlNib+Q1Zc4g2+1OMVXGnJ3ipY+UVGpttYaOGwZGfE6cg00cOnV8MuMEs/5vysEj9SI
 2eL7Qa1AwGIK/Od/OYlVMv7VWAxrlKoeZWDE0b3lC8z3+bQC2F42j2fGXfYHj8lko/ZI
 wTeqv3RMRNdW+gGaOSFFsTzoIST8aAcDXHKLSA9BiLyICHq1VQyog5e8O7Fl5Nlnvfv0
 UVGqSLPIBeZFiZCKRdl4Wdr8S4nRfIU9i3dXkpnIZkAo4BYndjUN0DCMNNTsC+oZ1u7C
 0DvYlVjVyMy0rWsGTz6UrF4AYL5tysVYfIP7S55YFF5gctWZFhTl0qiZSX3eFY6mN+v3 Kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7anuqd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OE1L2B029572;
	Wed, 24 Jan 2024 14:27:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372rr2v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfFylqEL8h4Vs+GlM7msK5hDYvEydfD+HkHuJNIX4SfSBgejCVwrDb342mfO8jmUDk7sulKRvaTooTTr0nZ3eX6y0zygxrd3BaiX9+rf380PMH9O798h3VQwoPT1I9jrUEqOq3YlBiZXw+rj2Brfyd9IkXi3M9uSe89Vxpdxqr8wxxp8hN5UyTe0kriwFoUMWHQtwHufYJSv+J1ErQbTc656dCcirTjyKJx/ZkhwxC3Eiz2uTX4a31Q355d6hvNFugqCABk5As//qkLBUsPN53uHYnpOIR9+cP2dfKXFjxfgqxcNu06csJ+TxBhY/a0MlvGAK13ZjbWg7npFB/+rYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4L4YDsjacLh2GjC22A+cQl0QZfjcK9EBUSZdxONXKk=;
 b=Gk7HmD7XSSEcYlqAlndRX7Ur5BhPFBXcjQu+iKLZciawNGaBMg0NRNlLRK6D35g+XG8BYxGCXRPWnUt4YEsXK4KrHUzV2lAzbhjTrspH1snMqw495SKuw+8HpVjxGk1ttzX/v6Ju/JtrU6sUqrpLQzrfI0E8MtWypqO/D9Z4LlQV1Un2xq0Ys8vAjEIU09C/psrWB4fXpPZqA70sIBzTQ8UIif2hGn3Vre+9/ThDYrQjlzHDgNWRbi0+CeZccQ6unRa5nPmpCQXCb/okqo8rOepSwJ7n6+/aCTO73XNZZvw8OOprS3pUMJ72ubtgaj9wJ7rC3XXXuNLxbZ4nElKaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4L4YDsjacLh2GjC22A+cQl0QZfjcK9EBUSZdxONXKk=;
 b=MH73LyKkL4jGYcLl8WzvVkdXS04yIfznOSd2gqNMvZRB112HOetBB6FQAigKwdPIsCNWR4ocwvqmnkqgJw9IsbaT3sb5dOL4L+ULqUY1Kk7fJj6J5jnlwwwy1GTUIupsAWv8me4lw9Es3oFFbOYYUBT8Dugmye+fk0rlsJKczN4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 14:27:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:27:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/6] fs: xfs: Support FS_XFLAG_ATOMICWRITES for rtvol
Date: Wed, 24 Jan 2024 14:26:42 +0000
Message-Id: <20240124142645.9334-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: cee4928c-3ff8-4d0f-dda2-08dc1ce889f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R6hIdhv+0ZK9tr2J0pjYpT0zzFLmj1VQJ3GNwsQu54aPFenpUMaPyQY5DSJZz0oyFcjcCRSe9/xmYoVKq36E9LKLxawF73G6DVKbLZhgCYeIH7hISUGYy9BUOfg2sk9WUEsClf8XHfOTHn/lVp09yg1GZRL1q7JY8+ZFsx6APUcNNtYmgbZsS1zEELVi+tRhHtqxCnv/PKQiA7Nou6rPLa1R/2VOSfXvvONNKMqIn/jFb/XVOX1IzAX0jlcY13GbzpMm+AeD9dzsIbn06zuwJkfxrfjj6ZMggWqVdmaz26VWx3RBIqh14A+1BSeu3bc+xMD/C0gS170B5z46wLTO+Pn/7yZ/HCScAVbwvmFTDpRTNG/sbeiQDkaBlZ2d1wtmmT6hsrvXU0TEhcdahbqoi9/lg++IdoW+6ajuKTEFoplRR6ECRNRQT4MqaSyzNseH3h70n5HdnsYgQScdXm20ZntvNdVZcLyUOl7Bigs7MJQrHyef+cqXIy6HvijPJ1OObnjP/5c1djTBojATOxKDP/tXDmHHPzaPMA0wEK8lqzAk61nZkH0z8rOmEr6rTvwO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(41300700001)(36756003)(86362001)(103116003)(38100700002)(107886003)(2616005)(26005)(6512007)(6486002)(1076003)(6506007)(2906002)(478600001)(6636002)(316002)(66946007)(66556008)(66476007)(6666004)(4326008)(8676002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YaeAlV1ZnRBJ54cuROUr59TrK8vygcZdRZw68YHXkb4iMKWJURgMyijIR41w?=
 =?us-ascii?Q?GkbMAZZLS7mhTonXrMOJEvOWbDt+4Kdm9pP6XymgVCt8ySN3iWZYbQ24ns/j?=
 =?us-ascii?Q?DlmBJPAOoztXP0aSGTygIjQPszAfceHNR2BKTR9eFZcwtah8MP1KxOYAqk2/?=
 =?us-ascii?Q?NufKZG6jTl8Hw3CbvmnbsH+A2OTjegvNFKhhWVm0kZ1wDelfXq9VQqIabM7H?=
 =?us-ascii?Q?LOJOmYPT4LXaZo0Fa6vEDHp++m/LJEa4fViO4f5YWKi4Xcj5o4zk4V0ic7MM?=
 =?us-ascii?Q?IE4urxKPx17ERfwPuvrSDSFY9hiKD8ObtGa0N/ahimHPiRkZPWWQ9uMYZS42?=
 =?us-ascii?Q?wfsArD63D3Z440xxqOpMlSLQfcFimq3H1u4kdaCH2Zuuc2myPgKEY/q5qgo0?=
 =?us-ascii?Q?m1jzY1bZ+E8ed+vKQPhcZMWuf0ig1cAwZQcjj9PbQ06CW1PAXh909JtlUcXF?=
 =?us-ascii?Q?BXlXsYm9DMFWwvhmlbBZONSVbgG+XOpnhD2R53tEpUDajv7WIkNooZSgB43h?=
 =?us-ascii?Q?7sS566Y/p4eL3vjTu5vy4fUWF46jLj8c1b9JMH0eth1KxdbOhBGQOWfvJQGg?=
 =?us-ascii?Q?C3fUAySFplhSwVni8cYlnjKFRCFw6ouJgCLW5sUPJiS9hvtHBV+NvJ/mbUPZ?=
 =?us-ascii?Q?06UQV5a0QneGyNEJHgkbv4Eohr/uV/Gb/u924a/MQqrTsmlhZU4axYa/JPSr?=
 =?us-ascii?Q?uDcuLeE461k2PmAVO6Msmb38cK0JH5fAa/eFRKCY+fVan6kmom0BaWZk0Kyi?=
 =?us-ascii?Q?VDU3rLxWKI7JKX3gLRyo8VooPS3+d2avTxS/NiBar8IFBREVKTBJsTSA2KPJ?=
 =?us-ascii?Q?J5c3JSvbl5EGeBO5uI++Wch3OrgY556uIz5fAQG5iGKgpEjdNqkGTds1i2Nq?=
 =?us-ascii?Q?WXzoWNLRnZAHvvXLfTiLKyUMPWj6ty+j1vaMyNHbCRf78aywLeYFaP/PtWr0?=
 =?us-ascii?Q?KKGW/BFKyyB0zwQphDwxM+OAmeTzkpLY5tRltCWlV1XJ35Drd7HGjh27ynk+?=
 =?us-ascii?Q?kvjhWx/iinTlMZwrrwoITgopeKAM82A71fb9GfhuBKC6fOIIMpnkJJEXlmDn?=
 =?us-ascii?Q?c/wlTfdzIQKezyDFOp8IkNtvJSh2msiH/KHy3kHRN8RrLg8VcjIvGBB34lgP?=
 =?us-ascii?Q?zKFhceV1f8/wGCuv/8ga/Bhexr9OSvXXb6iZyc0gbjVYNb5aYJXONg6XZ/n0?=
 =?us-ascii?Q?LVzw4nFk9Wnlm0wcJ4kNxk35gM7aVqbJqe9tekAq8NvJIjdCu9/E4J5RGHlV?=
 =?us-ascii?Q?gJoDKJIK37fqn4m7Y20gfov2E/WI1RdJKiov9LX/WhboR8cCA2ljSXuKjH1d?=
 =?us-ascii?Q?wrIe+XehERCXTsnwapNNchajpXbGpf6tLdDHWMdd/URAVw46lbpOohYkWc+i?=
 =?us-ascii?Q?gmbSdJrG3wEr6BG2uKaQW6ydHAxFm7F9A/2rwF4cJXkECrJjzC/zH93/Nhdj?=
 =?us-ascii?Q?yWU626md8ZJpoZ7/BHYAjSSFzEII2xvVw4OCdR0laecCsLRzUq1GnXPKlHDk?=
 =?us-ascii?Q?s5f0vDWhTuqQ0boYiNynf+7kILj0IrkbGoelJw3w1uA5z57h2U8HSy64u7aH?=
 =?us-ascii?Q?9zk30cSCzh+8mpWXw+alQA3mJjGjbXI50j+vmupDzN57ftAnWzLXUUsGmj/E?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZAToKMDu68o9KWEYBqbPHgNOMbvXIJhrkp4vOzEy3A/TMJ66STs0BR37IoRxVsh/9R8NUelE0XntBRMxr2uf5mxad3jMUz3sNvE4KlySenRyEA1N3Ap+XdfGDXHtqfWOVIf8Llj/Tk5pdkwooHo/gFzDurzXvg6H5w6s13nJeSk80c7yUnWydSIQylW+vyaPSc/k5vs916q0PTS/ImFR19oecxMLBuFaAwcPYpkLC/sCWp+ztJQnkvRnhASNkfC3SiKnTBq0/ilz1a8Dt7g+peu/nz0UxT7rGpqg8XGq4q//W5s+1NNtm2uKfAuHUyVPkGCkr1+66gRNwrqWeskr7ONZYR6VKzM8jPv5CY/DL0l9EmtKKrGgxevABG+dBAnHYdPL2pBntXUr3UVyMCTxFGQzzVJEKtfpdXUo8Yxlx/fQmZZVmumCtMkZKmg5D3RC49yjLK1wNTpnL09sTzJkCmP7fIa6YF91fRUmMcjeNHdmx0/wtHJ5vy3BQy8N7zBnG4kY3uJeXkuuJhbclsOfXHItJSaHXC9WtOtaxr9BQnTuIbctPLpjGiZ7J9lTYNd0WOa0p0oI+zbA1rM247esGMTUohjzjb6q+H4ihKLuosg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee4928c-3ff8-4d0f-dda2-08dc1ce889f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:27:05.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +W6KHBZBdrmBPaOvjQSsNF5hzS5Q5w6h9P1H97uxlNnxocXnHkR6v2TJvcn7K4NcrAqI6v6ZjwreXXkIZ1KN5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240104
X-Proofpoint-GUID: 8eC4GhOFVKISfos8lGd7FbO_2AOZmmvo
X-Proofpoint-ORIG-GUID: 8eC4GhOFVKISfos8lGd7FbO_2AOZmmvo

Add initial support for FS_XFLAG_ATOMICWRITES in rtvol.

Current kernel support for atomic writes is based on HW support (for atomic
writes). As such, it is required to ensure extent alignment with
atomic_write_unit_max so that an atomic write can result in a single
HW-compliant IO operation.

rtvol already guarantees extent alignment, so initially add support there.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h |  8 ++++++--
 fs/xfs/libxfs/xfs_sb.c     |  2 ++
 fs/xfs/xfs_inode.c         | 22 ++++++++++++++++++++++
 fs/xfs/xfs_inode.h         |  7 +++++++
 fs/xfs/xfs_ioctl.c         | 19 +++++++++++++++++--
 fs/xfs/xfs_mount.h         |  2 ++
 fs/xfs/xfs_super.c         |  4 ++++
 7 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 382ab1e71c0b..79fb0d4adeda 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,11 +353,13 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 29)	/* aligned file data extents */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
@@ -1085,16 +1087,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_ATOMICWRITES)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 4a9e8588f4c9..28a98130a56d 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -163,6 +163,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+		features |= XFS_FEAT_ATOMICWRITES;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 1fd94958aa97..0b0f525fd043 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -65,6 +65,26 @@ xfs_get_extsz_hint(
 	return 0;
 }
 
+/*
+ * helper function to extract extent size
+ */
+xfs_extlen_t
+xfs_get_extsz(
+	struct xfs_inode	*ip)
+{
+	/*
+	 * No point in aligning allocations if we need to COW to actually
+	 * write to them.
+	 */
+	if (xfs_is_always_cow_inode(ip))
+		return 0;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		return ip->i_mount->m_sb.sb_rextsize;
+
+	return 1;
+}
+
 /*
  * Helper function to extract CoW extent size hint from inode.
  * Between the extent size hint and the CoW extent size hint, we
@@ -629,6 +649,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+			flags |= FS_XFLAG_ATOMICWRITES;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 97f63bacd4c2..0e0a21d9d30f 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -305,6 +305,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_atomicwrites(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */
@@ -542,7 +547,9 @@ void		xfs_lock_two_inodes(struct xfs_inode *ip0, uint ip0_mode,
 				struct xfs_inode *ip1, uint ip1_mode);
 
 xfs_extlen_t	xfs_get_extsz_hint(struct xfs_inode *ip);
+xfs_extlen_t	xfs_get_extsz(struct xfs_inode *ip);
 xfs_extlen_t	xfs_get_cowextsz_hint(struct xfs_inode *ip);
+xfs_extlen_t	xfs_get_atomicwrites_size(struct xfs_inode *ip);
 
 int xfs_init_new_inode(struct mnt_idmap *idmap, struct xfs_trans *tp,
 		struct xfs_inode *pip, xfs_ino_t ino, umode_t mode,
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index f02b6e558af5..c380a3055be7 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1110,6 +1110,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_ATOMICWRITES)
+		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	return di_flags2;
 }
@@ -1122,10 +1124,12 @@ xfs_ioctl_setattr_xflags(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
+	bool			atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
 	uint64_t		i_flags2;
 
-	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
-		/* Can't change realtime flag if any extents are allocated. */
+
+	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
+	    atomic_writes != xfs_inode_atomicwrites(ip)) {
 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
 			return -EINVAL;
 	}
@@ -1146,6 +1150,17 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	if (atomic_writes) {
+		if (!xfs_has_atomicwrites(mp))
+			return -EINVAL;
+
+		if (!rtflag)
+			return -EINVAL;
+
+		if (!is_power_of_2(mp->m_sb.sb_rextsize))
+			return -EINVAL;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 503fe3c7edbf..bcd591f52925 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -289,6 +289,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
+#define XFS_FEAT_ATOMICWRITES	(1ULL << 28)	/* atomic writes support */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -352,6 +353,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
 __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
+__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index aff20ddd4a9f..263404f683d6 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1696,6 +1696,10 @@ xfs_fs_fill_super(
 		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
+	if (xfs_has_atomicwrites(mp))
+		xfs_warn(mp,
+"EXPERIMENTAL atomic writes feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
-- 
2.31.1


