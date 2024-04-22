Return-Path: <linux-fsdevel+bounces-17397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610DB8ACFB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14561F219EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C44153504;
	Mon, 22 Apr 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OkHQtO8g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G3LlfBZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07B15253E;
	Mon, 22 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796861; cv=fail; b=kHJLavzEsvk11qWMDvKAW7MCyvMBgnlZc3h8ajMFRIcYETc+zKYis92dUWPus2eAZQQ1VzkStJQ14FlPsFdQBidgS4HtFRoe/nik34tIvzj7mLzZuWQ7wD2Oloh6GB1E9/qmn4boBYepVBz0xMvRcbKPN3f43nhzBkpf41o9J5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796861; c=relaxed/simple;
	bh=iLcDNBCQC8srq9O8pxwTW9BDBO3cLm7xAjfWN50o370=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nN7AlhLUepgtxoyJlgW7Am9CuH9A3+uoRXUZ1CYOLN9hdz8lEhki6W7pMvsgrKzNjqlI2aVzacRP5DbqDEky7iIffivdUuZ5pXCg/AVLvzB53NyrzST/S2cEmODRJb5XfD2q9gP+x5uSItrBSCK6uZP3qI4IG0u+6WJMpsbIw18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OkHQtO8g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G3LlfBZN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDXwTi005835;
	Mon, 22 Apr 2024 14:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XELkDrwjtIgN83zNlyuERDXyzS45Zbik1fqDp4B5GLA=;
 b=OkHQtO8g+75bO/f36KGvbd8uEXY5KfsUh7lMl92gTItIgIvcgBqwTORYRIwbyA307Cay
 cDjQF7+eBgO863ZX3My/Ud+/Y4heRUK8SnZOhMoiJv+BDbwnCwBVb2HhRYn3cQ+JKA2a
 qjyKmCb1SkRehCallGwXGxbNzEio95041rsw/1/dinw0QKEu9qCy+3UFD+uZt70gOY8D
 hesjgoTrITKAPnHdQ1n60XrBjRMnZCwZFpHXyCMPTNe7ciYhuqMUExympXesSZv+LW5U
 1DbTa1vEqdUPLoFgo+/Vcj9LdZw3s4ByqVI/tY+mg42xQT78bdL18Ea8/kbPhIdPHEUs dQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44ettkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDtjG0006759;
	Mon, 22 Apr 2024 14:40:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455qkvn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVEnRgc8Sj04+xf1fwa7AZJIsf4yQmiquiFDW6RGxuMNtRD3mHqslTmzwrOAxdbNqDNAKKZXZ9xRVMQAVpztFHqugm77KkSnTo+AdPKVfy4n4Ts/r7v9zpnzdhDmqhH+I8VvGGbSMbUG/f4WVvhG7lAIOKfMnJelFtIOsCikmmcWguxeYki9sy6IynIPhUx3oTERdSECDFNBDqfPJtKPLcepMrlRAhSndvwX/s1/wi+MiuVwIZHRdHbeGwCFKnLRrB6q6xKGZKReeH9ViGi3ebiBp/q2NMi2ogvX5ndbo3XEl0nyTHXLuWUQOnL+RhmfmIlBo394i7qazxOlSIM4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XELkDrwjtIgN83zNlyuERDXyzS45Zbik1fqDp4B5GLA=;
 b=CRzwHoIk0kBIDgcUlbbaIX+i3uKtwM9pHZwfvZ7ukVjz05ben4wf3g7dZXI3fnD0mzHbalWvbEJyqRJtUDbFgQshJtSss1CVb+Mpn8g5U7k9s8jJbpX103AU9N2738xHBYWEk1aMYNZlUTd8IuPPbowhaP6KMri0xW+lSP/3u4G02zYAvRaE74abySdbVGhbW+7YyIW1KjYsiuVBHMyMtGy4KCi8va/RvjzpUu0RGs32RXMFa5i2Pt61P8LD5TzgklzlQ2WDrh0DZDcCmZxwihPqhTVYXWchnESyxQCslRv1dAIgZr1jFfpPPoErvF+7tXUVQFLUznlUeJKlpKm8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XELkDrwjtIgN83zNlyuERDXyzS45Zbik1fqDp4B5GLA=;
 b=G3LlfBZNaRMu8owOzDUukxf6adlkrtbbolVYpl4yIEzLeXzCa92j1QlzqityCjQ6d5E7W3VMmht61JtZLx+TUFuY/DaQ63AU9n2PEhbizBLbbAabS5pLnH1tDxvH21JTEy6LoEnA6I0uXgqjANbGpU7gpMwacYMgqM8h4+9kzVA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
        jbongio@google.com, okiselev@amazon.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 0/7] buffered block atomic writes
Date: Mon, 22 Apr 2024 14:39:16 +0000
Message-Id: <20240422143923.3927601-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b9bbd7-1a97-49a1-3bc3-08dc62da1eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?paQb6fX/A7nCT8DRG70Gz1W32XfTVSJcItd96xrpcHaJliNVTK7Nu9ZhrPyT?=
 =?us-ascii?Q?uvrRWOexOVOzju2rPGGC4qv//bOiLM5jyCv2NfVh3ToVSI1FeiP8mbJmeIqN?=
 =?us-ascii?Q?5niOHnu/7JsLORLxyCGAVPSjSoMxyZ2y031Iwa4cRgRyulxT6zptRP7Ck+bj?=
 =?us-ascii?Q?6rtNmNN2yeXSqRlSH94tEtr+p2PuO6XCMhT0VXdpRH7TGsDAbAtpWwd+6USS?=
 =?us-ascii?Q?UFiwVMkDwbsnfBeqVhqVN6Tud0iLtAl4FFwz5hQnhl40UgRDxld/QkR1bVg2?=
 =?us-ascii?Q?exJHKm3KHRZBUfivRaJiy4lnZGJXuyX/IddOOPVjFFLATBvDbEPpIlHZZejU?=
 =?us-ascii?Q?3oTyXhcP1ojGR21gPeAQFUd9ayyP6fs7zsLDobccN7jjIdXM8vJNboHrWPv8?=
 =?us-ascii?Q?G3fO8TH23Ry/ZM2dktdSwXpvU325LyJ3bHqUiEVBebLfQg7unNh7WLZd9x4j?=
 =?us-ascii?Q?hru9OczcuCoZTKhfUWXN/dpbhoZgEA3sNoJaTMjgGgYIIN9hLrsM8AhykoFG?=
 =?us-ascii?Q?4qsX/A6ntk+9TfHkiKLjHWFtmYw63ZIgnrPZjJCwj0LQeN/S7F+TjvSvwqch?=
 =?us-ascii?Q?gktPFmDU7Vi/c+hO14SiGsj5PZuSdgjKQX1VS+BxOvY/TF7yXPqb75Vhopdo?=
 =?us-ascii?Q?93uaJrMPfoXWwL2j/BqnYXNJu2YiTXYuuv5TyLGkXENcZunuL5y2y1csNCN/?=
 =?us-ascii?Q?vxzHPPdQ2GV6FrXr//2zgGev6QZ/hT+I+cF8npPTV8owKNINCT71j5zglMqp?=
 =?us-ascii?Q?NW7k/THkC4WxXvxY/Rk9nZ3i9uwwqLV0s0taRD7lxK3SgmU1Ml4rziDb0Ceq?=
 =?us-ascii?Q?/fhgC6n7ZbOJ/LdtF7/3GGZ5gjrC2o6ExldxiWUppplgSG69z0n8HVRQXSUB?=
 =?us-ascii?Q?RewgMQFnrTM0ghHpSEvwSnc4Z4Amzlj8nHnRoK9EUD+92HIz3Malj3JniPtN?=
 =?us-ascii?Q?0YZ+GDFJInDU12N752Lr4M4OSRJ06rfI0U2VYql96xokCusvTbOZtp4kpw6g?=
 =?us-ascii?Q?DnJgC5Bxr/gfknZqhNAnwvTeBAoXenmARSDmYkWW06Fs5ZXYuCRtW8a7es6h?=
 =?us-ascii?Q?rCF4pk8XqLf0ieNt9C1ldHiwuyDUuKWdWoCORFNzbaavW2v9X1Uu0Cvx028H?=
 =?us-ascii?Q?aiRLZNrnqdGqQX+bHPgVoFtVK+1eZ1iuaTurJIT+ssBUpcd2F2hnu+zu4n3O?=
 =?us-ascii?Q?q5HmGK3FXwlVNp02WUs4Ab8e2hdb+ZQmtiKIZynLdlSe2ve/RLlGG2c3Z+sB?=
 =?us-ascii?Q?pF4H974iQHgm1ZsKujYwUhJKhBZroh/2E7Xs1CiNLtd/KWgCmbUQrikeZZlJ?=
 =?us-ascii?Q?zfj3fjU9M3F3ukW77b2VDvvXGQMy6S2PArZBJMBWLiqfAg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E95Ul0Ziqpktfv0fPSzdUvT6ZAKCDZCQfrMC6CBkLNp8ka6K/ffCFnFBrSGn?=
 =?us-ascii?Q?0X4efhRbCFLk/vC44e1VdEQ/SvxIlvqekqE3Aot9JuIgXZ3BWb1TpoRznWE/?=
 =?us-ascii?Q?ib3C/W8jOoCNWh2vljuNhSVXFdjb1b6hl6nlc5VygBKXKJu4M4O0LhIDAWUg?=
 =?us-ascii?Q?lTSMCyaput8zlmdMW0q2j7tqeZZDNyPv9HkunUjFmCII4y9XTFOCgO75lLyq?=
 =?us-ascii?Q?RLw4s3DyexOEKCM4E3PHmgeXztoyXP/xBO6IHL6gS+x51rYe/K2pAvKCBDCn?=
 =?us-ascii?Q?Z9NkFLU0vlPoc3AwR6JA2tKe6Zu1+ksSZYc1NHGn3q6UD9UoF9AoFPY+DR3w?=
 =?us-ascii?Q?fTbNrb/NtaB8i8xDejFQWu40cAZodIRHngyG0QvnZdQqVhQ6EMDwbTWnvxvV?=
 =?us-ascii?Q?CmKGv0gSVF2kT9pWkreI88dKgDz87naHIErVEvXD/KUMuFlxgM09uLB7KM0/?=
 =?us-ascii?Q?R4h3moZ/ZBkhByczOfiEWnzGA1opPZDYUkPJ13jq3AHadj2DUII6BVWQ7EXe?=
 =?us-ascii?Q?9KUCfiyVYafcgaGs1ZAXEnaEABnJCoJZBtCMAXDkd7yLdNbgRtsQG6e0kOBQ?=
 =?us-ascii?Q?DdW38NjgQ2CWIx0dpvy2FucSmQpYxEabKQ/qXgSCsBshHS9SHrTUL5cOdxFk?=
 =?us-ascii?Q?du48BVSkElcgX2J/qalH90+ct+aV7LqIuK/X8i/XnqZFkSYam8XHf7IQKw68?=
 =?us-ascii?Q?OJ1s87Ag05K6tO6HMgxJ4MWcCiUmDHb715K6+t2L+b+zQlglwQ8l8/dBCyTC?=
 =?us-ascii?Q?md5s8OKH4o+rJazvIu4hynEvpKEu7bs+ZulbhRZSc1m77yUm//IeloaX+RQs?=
 =?us-ascii?Q?0KNV+4sZWhiERG7dpIiHvzXymeehYr7I5YI29BlFte3dz79Qf/GuPCl/v85U?=
 =?us-ascii?Q?MOV0wewoA1yFVeN2qUPD1FoP5At3F3sUpXMZpdISz2vYRQCQWg3SQxKyayXB?=
 =?us-ascii?Q?P7vx3hmslhreEMmMhHMa21v+VIMu2qANNKvnec9wa5aHMd5BpURvTS52HnJX?=
 =?us-ascii?Q?e8lIVteDV+UlgHed0l05MBUJYe2hIGly+dqHav3V5KRkRzVUKzQmPNNqbM+H?=
 =?us-ascii?Q?myF/60VSrMnD94e5+VRO76E04hRT6h3rxwo/9tM9EbLKmUN2SJl6VY06dOP0?=
 =?us-ascii?Q?lsvGRB2dIlHCmDNHA2dFV5BA81fBihe7gFdCsaY6Rs3fjxXLnpgsBE38rap4?=
 =?us-ascii?Q?gOXQgwZBBnxEXIgIOKeipMn2Oc+I6F4p7LHrr+30gBVCxOiy87B5KcmiR+tF?=
 =?us-ascii?Q?wLB3nD6z5IkqCN1AnY5ojdxYskVKXFPJsbf37Tp4hNv7/ffbYGY3+DQBq588?=
 =?us-ascii?Q?VnYpYyNVvl3Nu4sMqBd2qwILt3++EmoQhgILaOn6/WUPBn+gQRS1VjbdB2fe?=
 =?us-ascii?Q?KMesC0gMcx/8+WHbDiVYo0LYFc+U+U3oglMdn4gabR+R9gfs2xZyY+/T3UgD?=
 =?us-ascii?Q?JgRdNn2jRHsXxQvSgByW4U95oiVrz07qrDDqMBTYL11hf8PwumHKbWUUiuX3?=
 =?us-ascii?Q?Uh8lb+d93KXa6kd8KanwQhnx+XlaZUCIQhHzXcWH5HWNbN1S7wqbCDYUsSzF?=
 =?us-ascii?Q?UGbXbzdkEVPINtuLRGlHTJL6v+dGabyb9LDmMcCLi/MbxVvfxLbIvotdMKtO?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MhUWGyNxO+TFIfj7NYhD9K9ScHp62wJ9k41Pt7SxRub0n7Of8oCj+loMA//bQbjkvHu7YNz5Ow3fG3LM/2ivrg22Hz2P+VqyPPEImq+B0clty9gnLA2qTpdCoBGmP+JsXi9iy1fB8FHe51oPrcgf7vsRHlSuG0QV/uAnr6QP4fkjUi5HLhOOI711kcgkZ0iQ/78t/Ck1kJr8VORa0qrLtrwCLVdcHuO7JygHNecozLbIwngouteuU/2Zbm8sdpFG6ZQ6A9kYPk1nqBOTz6tM8FjfQ8ChRlo/i+oFM4PeJIL74AjYZFr0AIFHK6IGVAJjfq+4YuZFe6dEPdorPOxc3xBOL6GJQqGTIH9ibMUtA0Hwjj5/PqmCpXUIuD6UyznDDSg3c3di826+f5zEvAxLUvDDQAgzHBy+yaR6cmkj6d4q72MYmGyYupgvzhQhMIhQ6/AEZ/3Y6JPsmC+rV7i7bSOZbrSmFNB93mQsW9x6x5QsN1NFr8lHz8YMSqHMgQVmJs54ZiruID0P1x4eqrHTybDbuTRERfEtnBGakED3tIewKjU/swefNh58ubpuptgNWBDgNfNQGLbNA6mnBhGnHTyLoy57es/w5wMLEYzZ+1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b9bbd7-1a97-49a1-3bc3-08dc62da1eac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:13.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9rvfqFrw060tYzilKes/QC45scvco4CbxbiEbXYoTXexk8JFcIRtDuazc1JTepY05TX9YEn473JDfXxoLCFNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220063
X-Proofpoint-ORIG-GUID: iqXLbMk5NuLwPn4L0zscdrP6LpPL6UaP
X-Proofpoint-GUID: iqXLbMk5NuLwPn4L0zscdrP6LpPL6UaP

This series introduces a proof-of-concept for buffered block atomic
writes.

There is a requirement for userspace to be able to issue a write which
will not be torn due to HW or some other failure. A solution is presented
in [0] and [1].

Those series mentioned only support atomic writes for direct IO. The
primary target of atomic (or untorn) writes is DBs like InnoDB/MySQL,
which require direct IO support. However, as mentioned in [2], there is
a want to support atomic writes for DBs which use buffered writes, like
Postgres.

The issue raised in [2] was that the API proposed is not suitable for
buffered atomic writes. Specifically, since the API permits a range of
sizes of atomic writes, it is too difficult to track in the pagecache the
geometry of atomic writes which overlap with other atomic writes of
differing sizes and alignment. In addition, tracking and handling
overlapping atomic and non-atomic writes is difficult also.

In this series, buffered atomic writes are supported based upon the
following principles:
- A buffered atomic write requires RWF_ATOMIC flag be set, same as
  direct IO. The same other atomic writes rules apply, like power-of-2
  size and naturally aligned.
- For an inode, only a single size of buffered write is allowed. So for
  statx, atomic_write_unit_min = atomic_write_unit_max always for
  buffered atomic writes.
- A single folio maps to an atomic write in the pagecache. Folios match
  atomic writes well, as an atomic write must be a power-of-2 in size and
  naturally aligned.
- A folio is tagged as "atomic" when atomically written. If any part of an
  "atomic" folio is fully or partially overwritten with a non-atomic
  write, the folio loses it atomicity. Indeed, issuing a non-atomic write
  over an atomic write would typically be seen as a userspace bug.
- If userspace wants to guarantee a buffered atomic write is written to
  media atomically after the write syscall returns, it must use RWF_SYNC
  or similar (along with RWF_ATOMIC).

This series just supports buffered atomic writes for XFS. I do have some
patches for bdev file operations buffered atomic writes. I did not include
them, as:
a. I don't know of any requirement for this support
b. atomic_write_unit_min and atomic_write_unit_max would be fixed at
   PAGE_SIZE there. This is very limiting. However an API like BLKBSZSET
   could be added to allow userspace to program the values for
   atomic_write_unit_{min, max}.
c. We may want to support atomic_write_unit_{min, max} < PAGE_SIZE, and
   this becomes more complicated to support.
d. I would like to see what happens with bs > ps work there.

This series is just an early proof-of-concept, to prove that the API
proposed for block atomic writes can work for buffered IO. I would like to
unblock that direct IO series and have it merged.

Patches are based on [0], [1], and [3] (the bs > ps series). For the bs >
ps series, I had to borrow an earlier filemap change which allows the
folio min and max order be selected.

All patches can be found at:
https://github.com/johnpgarry/linux/tree/atomic-writes-v6.9-v6-fs-v2-buffered

[0] https://lore.kernel.org/linux-block/20240326133813.3224593-1-john.g.garry@oracle.com/
[1] https://lore.kernel.org/linux-block/20240304130428.13026-1-john.g.garry@oracle.com/
[2] https://lore.kernel.org/linux-fsdevel/20240228061257.GA106651@mit.edu/
[3] https://lore.kernel.org/linux-xfs/20240313170253.2324812-1-kernel@pankajraghav.com/

John Garry (7):
  fs: Rename STATX{_ATTR}_WRITE_ATOMIC -> STATX{_ATTR}_WRITE_ATOMIC_DIO
  filemap: Change mapping_set_folio_min_order() ->
    mapping_set_folio_orders()
  mm: Add PG_atomic
  fs: Add initial buffered atomic write support info to statx
  fs: iomap: buffered atomic write support
  fs: xfs: buffered atomic writes statx support
  fs: xfs: Enable buffered atomic writes

 block/bdev.c                   |  9 +++---
 fs/iomap/buffered-io.c         | 53 +++++++++++++++++++++++++++++-----
 fs/iomap/trace.h               |  3 +-
 fs/stat.c                      | 26 ++++++++++++-----
 fs/xfs/libxfs/xfs_inode_buf.c  |  8 +++++
 fs/xfs/xfs_file.c              | 12 ++++++--
 fs/xfs/xfs_icache.c            | 10 ++++---
 fs/xfs/xfs_ioctl.c             |  3 ++
 fs/xfs/xfs_iops.c              | 11 +++++--
 include/linux/fs.h             |  3 +-
 include/linux/iomap.h          |  1 +
 include/linux/page-flags.h     |  5 ++++
 include/linux/pagemap.h        | 20 ++++++++-----
 include/trace/events/mmflags.h |  3 +-
 include/uapi/linux/stat.h      |  6 ++--
 mm/filemap.c                   |  8 ++++-
 16 files changed, 141 insertions(+), 40 deletions(-)

-- 
2.31.1


