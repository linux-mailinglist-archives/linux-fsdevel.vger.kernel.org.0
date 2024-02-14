Return-Path: <linux-fsdevel+bounces-11566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C1854C6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4C01C27D68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CC45C906;
	Wed, 14 Feb 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1ez0CcO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Telcr7Nb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF805A7B4;
	Wed, 14 Feb 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923886; cv=fail; b=WkV3nCJlA218LfEMMo4rFIG8F9zebyCWA9FjriC+SWQtLYb45cl0USE6yxZRst9cHEHOgzKSgJlr637MwU8+UirDQkQ6B9CQ9LltrX1jbSsEfcN860MTB+axY7lopdquhtRnXLUxNngIp4QqTF2mJWOkfpBe0m+AVTk00sLBqws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923886; c=relaxed/simple;
	bh=K3CLD7U3MNxARMalS52BfLAiobtD/YWrqzCAh/oPReM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nV1R/TCmdOUYTcfeQOoKw9ZN/0IwenLgw+VVLmNxQszXkchJHGfCNrJwcXC5awS51bQLK9MMs+rYqc8YaAbTm98lzfj54Pn60qaRBaLvDhRsuYncgnAPMyFxG5vfwJzs6xMSPqDXlWDe7gUVjbumHRfxkG+kyi1LGX3QuHL6JOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1ez0CcO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Telcr7Nb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EEwx2s016977;
	Wed, 14 Feb 2024 15:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=MlwgP+R8uhr4lwIQd+4EG19FOktqew2Gkg1LEMFoeGU=;
 b=I1ez0CcOrVJSfU5b0nUFfQFHW1Y+NV6fb22T8hbNm9K06K1CGMy/eFJyx0cLPQscUtwI
 jZLHmKPU7faSh0mjklyIr3iyLYiuyhxRShPNnhxVGXedi/FYYo2pzhrucerPNUN4EMax
 xYeP7dACh4d+5dP4e2s0ofujSg9RyYYGfVnYWzoHJ0Vx9dP+HtxheH0rQG5HqxrOhSnF
 91+t/YmUG9j6o6ENlaBWNTFaSLR9l2R16VS+0kz/wAkiJU4CDOodQIZXMI+1TLJMrU21
 d+pO8AMC2UKsNKpnMDUzRtwco6sVeNMImkkS33IPNk/t0tck5uEBJzzoTCDW13qDL3Pw /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8x9xgcr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 15:17:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EDnd1B000883;
	Wed, 14 Feb 2024 15:17:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk93c8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 15:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfoxAEgxF/paEssyg6sgl+CJ0n7Y9SOaEl5uyly+8NeNje/0st5ZtvzGa9rOuo8PRtsWREhKYWQ13aBCQCjc/ODc+EjA2Lo8dGzfQWiMK0dGF8aMWYmWSevE4yoy818yiO/j4gjVVUWuTdaDgD53k2LY2TnxnANk++iUNCkS13jWVRZvgQhYegEGq8V0IYjtKYqHjpssufsy3gNzs3rV3frMTAomS7AYyxLwfT4eqWyUz9neQIcgo8KdIuf9gETao15rRhVa5ZiAlFA2HmnJptU3GZke8SFNOgdFtNs+Kw9DDPXHXHUFwr9Vo4bxmXWF2Zi8NbIyxPaVu0VEDf2Eyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlwgP+R8uhr4lwIQd+4EG19FOktqew2Gkg1LEMFoeGU=;
 b=KMQQS+786DZtNuKaLzg1RMsV3bx/XbU5FVPH5d+MWTyHlDYmL0q93/w6xIcLU38kWPz5v18HAtAYu/P1C31srQmUTsrBU7b82rPcvO8tWLdeIhqKboj0t33K7TtVQWomq58WdwV4JWc29GyCgcBptdqfNNL4cQMThB/u+A/UQZiCK5M/qioBDJPvE5DnhFnbp1f/IT67QtnDqgvLocMONFijTPouKJNB5X9uBzyfpX5iwBMWGatgcBh7Or9IUW+fJ4WssytTYKIRp4g4qyaS7ygS7lwE4Co7gO7JU67VTQnbl2Wc6OUrIDCFDc7p67MzrsjQw57eIyLPM9Nt8LhfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlwgP+R8uhr4lwIQd+4EG19FOktqew2Gkg1LEMFoeGU=;
 b=Telcr7NbmK1b5Sl2gNwNTlZTprFpOC3YJ8c3HpZqV66ckcWndVWO+7GDmupP2s6Bge89V0m8syXwT/iqrtzRx7UsDYu6W9fqeesYVzxw/93rOS02M+4Ez1wQ0IR2jz4zP7gvuzm2hmzEbVkPfoP1jeptGMIdwSfp2DanZG9xb6E=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 15:17:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Wed, 14 Feb 2024
 15:17:41 +0000
Date: Wed, 14 Feb 2024 10:17:38 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v6 0/3] per-vma locks in userfaultfd
Message-ID: <20240214151738.v5uj4v35oj43wzal@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240213215741.3816570-1-lokeshgidra@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213215741.3816570-1-lokeshgidra@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 0122c010-2073-4dd5-88ac-08dc2d7015fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+HTAGZ560qAz96vRT+JGlsitdvKhwnzuWQk8lYc2yZP+XpHgUvTlZ43t9voET6CwJIi+0NGaqXxp7b+TnDEHRZa6qpI5mGnxHa5VPtOeE7BF/bAUdsER1cADmwxme4jD67f0U/Eb0Jq4aFv6HM5q8i7oFhYwOD8BB9TI6DoNlNfQ0leZDpeMH24zqXuQ3zfA7uG5kbuM+Vu0ToJBtHOGwxMvETOFDyR/EAfM2ZvM4xWjkeDuVUWj1Hbmm+pfhDh+YVe5tlNJGRATPTHxzdsApilBQ+K/HOA6chTqoX0FrcTWSsQ5ZQaRPcryglNlHaKChAtevgCxe9tI/lJErN38fLJ3I+3l+Zz8q/cQaxHppOiVaORodaqhMAaHmcUxhPvDHgjehamQzPlBosy9+uaWoFCX3IAwFLjINbz1x0LHTqIyjk1CWXo9zkyWDhlATbSWEd+ySWh5ALoEaI/6+6R1Xw1T7BkG/emrW6bQ2JUzY+O6IrLML7Jyto0jpcesupkln5hhlvPG9TUaaypYNPePVrWF3ce559KKCin/g3j0Flo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(8936002)(8676002)(4326008)(7416002)(5660300002)(33716001)(83380400001)(26005)(38100700002)(1076003)(86362001)(316002)(6916009)(66476007)(66556008)(66946007)(6506007)(6666004)(9686003)(6512007)(966005)(478600001)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6/F/QSub9sGRRLeHpGVfEuhg/esItDsYEiL0F+/DYZLBcakFeOUM2TECR/qp?=
 =?us-ascii?Q?D08l9HDwE5aQatDwTZ70Y1SAv4xXs0y5YUtUP9nyLDo850TqSQjvNytRJTyR?=
 =?us-ascii?Q?02ZH9CZsYzROs+W5S5M8lTBFgo34xNzMY7CVyUT8eNFHr7imevp4mgNvAYex?=
 =?us-ascii?Q?hRuyQemHQ0k2UQqP2hwbzdnxcgGnwAx/13+tyf0D8WQAMEEnxf+bOibDSwnD?=
 =?us-ascii?Q?qgNiy8sdYh/SqO5AzsbakPplbXuKUWtXbIlhiGHUHDW84IVkY39wF1HdXOEt?=
 =?us-ascii?Q?8Oo6XuVUUDfjw3dy9Cn7Cosz4vKemjDIJLGWKyjD9D5UqwopF8cltZKXakeV?=
 =?us-ascii?Q?va0oGP5Wm/CUSZCuPqvJEmXWC6UW53uLi+Y+djMqRR8v82z8gwBSAM2T+IqY?=
 =?us-ascii?Q?dbXhyqq1M7TjRAu6sIH+FIPvzRjM5bP35wDm5GR/+sonUS3UG8uMPbuvBQF8?=
 =?us-ascii?Q?pZhy4q+3IHcA3OjP9fkj04TvH9QZ+Qn1l76zq8JFN29f/9JUOqKbdVxjUDUx?=
 =?us-ascii?Q?vkQpAHEZy5oAa/I0jO/yskBGhHYKhbfNw1+Uw7iItFLtxbG1drTfbAyxm+4K?=
 =?us-ascii?Q?m34eQvUtF0DvP1ALOzhJZSZQLsJ/FlS8fT5jNe8AR9bvVio90N6GY4kRcBXH?=
 =?us-ascii?Q?BzvICv7cdjwvzyLMvNl8qlKHMxUxIwSoqzBRVAQnemHZxQuSccGyjK1ltxIJ?=
 =?us-ascii?Q?SHzACPfdsxsSCzqVSG0D3Vyg9ekJ5YjbtcpbKsySctELMFebb/Z5yPhAJz+V?=
 =?us-ascii?Q?P7J0y2T0r9BayfI/Sfz54by8p47FzCp+Of7oJS1HOqtBmc6u9draj9nCHvp2?=
 =?us-ascii?Q?T6wPAouOc/ZUfKxWFsfXv6Co9F1wPvmYDLOZKgHjju+jMVPzeu5bEKnbUi7Y?=
 =?us-ascii?Q?X6xISzmRGnDMJyGYX4p5haWt/ZMPJDf324eOhYvn2faTJgrC0rO9th9iWLkq?=
 =?us-ascii?Q?2Wh0OavCP8TZYnsbOyNr7GRdupQ74t4VXZusfn1pX5Xgk/0Qw1ooHwz4eEK/?=
 =?us-ascii?Q?FiqPbcXLtkePlnxwcsoxOqS2ll2Q3ZmdKpND7zqEC5YA2fwDFTtZkeJEDXzM?=
 =?us-ascii?Q?lcnAmQbRL6Fw1+fKi2IJAAyP/awho6lvwLHSISM2BPxIDaXWdmb+PFwijiQs?=
 =?us-ascii?Q?yOomuOjJ12ypFHvIbohL+6Q7hz4gfzUyvKSOgXqxlEXIJfdh8lR+irMA0VrR?=
 =?us-ascii?Q?21nRtTyL9ocp5hRdD092q9nS5ioat7Yx8NVSgtEC09RqNIFBaFUCrAipigOq?=
 =?us-ascii?Q?eiw+ndb3Eh82h1+P+q7LujIE2JbzHmJYY+wqBAFgqO5tl9udZWZQbZNR47d4?=
 =?us-ascii?Q?T2aI85sX1swndgzHBV+Nn1RJIBjXubeYFRjRSC6NSc/ptEety/B4e7xlJT8A?=
 =?us-ascii?Q?rfasu7mFMcw4KVWZfmDbatVFZ1CNwgsrcZiI87BnbgmcanB5U3iNH5TfKkVi?=
 =?us-ascii?Q?/sqwbhVmOSbtTk8bRTDO/iKToFEm8FgIuzHQG65EEJa2w16/RmorJcApVhMT?=
 =?us-ascii?Q?SqcL52+NMEJPB+9kiFIcvvpqn52FSD8EHAXMduWlfeD5ilWx6uUFEMyVV86+?=
 =?us-ascii?Q?PvXiG/qca4RLkj8raLtfDjOs42D5l/lFhv4XOsmX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M0a4ogt0+NKyg3udi74hMgaYfUry3GgfTVXqgXHJd9izBH/tdrK9Txf8t+0OfHKV8Pbh+G4FRv3rV7uGu1QFPVOd+9kymP5gBO7zHlUDJLBqtj5JXd9beBCrrmsBmaUVkxkMSfCPIFGlqkYqya2wXaWnJYN9Lszkr3x6xvw3Ucth4DWnDuilwN65cYUn+A5RPn1EJRaqz4HdORcqdyXH0OdXorCDMlT4LjE4azff4Au0nnh5lbB9SfVADaonQky/JejwNxTHOa9VKolIm11zrSLtX6Os9mk1Ld428b4Upwo89Bmv3U1aFyhNtQUu9n2/9+/++sXFs59gZg/FS3vzKrPzWtzIDgU/9EiV3mHECzECbCUTFiNnpDDtNP3ow/J/u1G+B3H4gnergYJSJxzLwf+NlZSX8DsckjhfjiS2iLyhCixiYJnSE9TKb/2cVTiMsLGEF/LiFPToTB8N9dtZ8lKkhP/4omV66N5nIeQ83WRitSfiIZGjNJKM1WUtIPsNWqql+61AcRiBYZMm3iLpUyacWZlXecmJ78P2GCLEC3yQhz0oBOWieqxtNDwwpTOzUbsxJQLNYsK5gX7FX+OjIp8VIDuKtyihtCZBAdA4Mk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0122c010-2073-4dd5-88ac-08dc2d7015fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:17:40.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reQnD8vZZ2OfLBUF+FC8zlDif3yQRw0hYUEjuUT1WN8qwq2DycS6dpLWJ4Ydq0ivCta4ep3PJC4S7R+0ckMW4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140118
X-Proofpoint-GUID: xVCOK9MMweAJmPJlYCEd14B6v-cT-B-6
X-Proofpoint-ORIG-GUID: xVCOK9MMweAJmPJlYCEd14B6v-cT-B-6

* Lokesh Gidra <lokeshgidra@google.com> [240213 16:57]:
> Performing userfaultfd operations (like copy/move etc.) in critical
> section of mmap_lock (read-mode) causes significant contention on the
> lock when operations requiring the lock in write-mode are taking place
> concurrently. We can use per-vma locks instead to significantly reduce
> the contention issue.
> 
> Android runtime's Garbage Collector uses userfaultfd for concurrent
> compaction. mmap-lock contention during compaction potentially causes
> jittery experience for the user. During one such reproducible scenario,
> we observed the following improvements with this patch-set:
> 
> - Wall clock time of compaction phase came down from ~3s to <500ms
> - Uninterruptible sleep time (across all threads in the process) was
>   ~10ms (none in mmap_lock) during compaction, instead of >20s

This series looks good, Thanks!

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
> Changes since v5 [5]:
> - Use abstract function names (like uffd_mfill_lock/uffd_mfill_unlock)
>   to avoid using too many #ifdef's, per Suren Baghdasaryan and Liam
>   Howlett
> - Use 'unlikely' (as earlier) to anon_vma related checks, per Liam Howlett
> - Eliminate redundant ptr->err->ptr conversion, per Liam Howlett
> - Use 'int' instead of 'long' for error return type, per Liam Howlett
> 
> Changes since v4 [4]:
> - Fix possible deadlock in find_and_lock_vmas() which may arise if
>   lock_vma() is used for both src and dst vmas.
> - Ensure we lock vma only once if src and dst vmas are same.
> - Fix error handling in move_pages() after successfully locking vmas.
> - Introduce helper function for finding dst vma and preparing its
>   anon_vma when done in mmap_lock critical section, per Liam Howlett.
> - Introduce helper function for finding dst and src vmas when done in
>   mmap_lock critical section.
> 
> Changes since v3 [3]:
> - Rename function names to clearly reflect which lock is being taken,
>   per Liam Howlett.
> - Have separate functions and abstractions in mm/userfaultfd.c to avoid
>   confusion around which lock is being acquired/released, per Liam Howlett.
> - Prepare anon_vma for all private vmas, anonymous or file-backed,
>   per Jann Horn.
> 
> Changes since v2 [2]:
> - Implement and use lock_vma() which uses mmap_lock critical section
>   to lock the VMA using per-vma lock if lock_vma_under_rcu() fails,
>   per Liam R. Howlett. This helps simplify the code and also avoids
>   performing the entire userfaultfd operation under mmap_lock.
> 
> Changes since v1 [1]:
> - rebase patches on 'mm-unstable' branch
> 
> [1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@google.com/
> [2] https://lore.kernel.org/all/20240129193512.123145-1-lokeshgidra@google.com/
> [3] https://lore.kernel.org/all/20240206010919.1109005-1-lokeshgidra@google.com/
> [4] https://lore.kernel.org/all/20240208212204.2043140-1-lokeshgidra@google.com/
> [5] https://lore.kernel.org/all/20240213001920.3551772-1-lokeshgidra@google.com/
> 
> Lokesh Gidra (3):
>   userfaultfd: move userfaultfd_ctx struct to header file
>   userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
>   userfaultfd: use per-vma locks in userfaultfd operations
> 
>  fs/userfaultfd.c              |  86 ++-----
>  include/linux/userfaultfd_k.h |  75 ++++--
>  mm/userfaultfd.c              | 438 +++++++++++++++++++++++++---------
>  3 files changed, 405 insertions(+), 194 deletions(-)
> 
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

