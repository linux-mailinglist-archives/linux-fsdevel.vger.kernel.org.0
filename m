Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D33D6F967D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 04:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjEGCAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 22:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjEGCAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 22:00:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FC191EA;
        Sat,  6 May 2023 19:00:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3471lOTb020027;
        Sun, 7 May 2023 01:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=1+M197v32U4sRu5wkWonTKeeV0auMvNIyfpp1vmDBKs=;
 b=iCEi44wVvnWI7wgH17VYoTvSEInaX6utlfctocLcI/WCZUx9xknZpZ7PQV2otdnN+IyC
 wYnq/0+xvbGQTH1BkGF7uQh1aBm01rSAWM8nVwOiaiKXCnspMbUprW+7dTqIH7eZqV9R
 tM/f6lkn9Mjvh+EmApJmtnwRsUFRAGPtCcslf65Il++qWzmiu7ehtn3eALl2ogy5dGy1
 MPosk4EvQOXJd5o5bPsfpYMgM1Q8655onc7uGtP05DNUpuibdiwJ4HhbK7d7oeweJgrC
 IL1NG5MqhtjtiFSEZM15dAwl/3HowLNSRnE3uWk0YNx4axzy+yHVyJlBsWw35Gz6H9yk Gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qdegu92mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 May 2023 01:59:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34713L7V038310;
        Sun, 7 May 2023 01:59:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb3x5w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 May 2023 01:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQaDTTBHBBrlTW+u+NtBK7V6d+KdzJOBVg3p/uSLp/ppGJh2vrFdBF6ifkw9lO8NvCnEqN6YORrbR27gXEQCtSygp9f48NkqR+Xv6HnI+cH6XVv7jnPRu80VU7TfZbDyNPrGo/Z8k0ZpJqmnBlz4qBPWl5eMna4miwRA9ep9opMkNkavRJHWXcvGgkvC3FATxkDA0HB7fFJ+3O28VSgFZ2IyStDcoPgce4WsxzivnDuffFWNnO6pvN4jan1PGRgAiz7bZAGqkTY79bPg9OVS3GKFUhKHwDFCsKagAKwLBdMeC0fnIGFNXrZS81m0uKDPxP9q7rOPRtq7giq9B72Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+M197v32U4sRu5wkWonTKeeV0auMvNIyfpp1vmDBKs=;
 b=HWlJ0Kehu6shPnPPSW1/xQzspbvsXX7v9uwmb5xyBCMFSWKLOJPtlQ+PO6ZzrJtDZBNlcqaJ5kSX9rR8dlfKHRy2SJ4oUskxDZV/Iqqn7jaw6+iF5zIIHN7kNzGzT8Y15AVujmTQwc5fqa2TDl8La7f6lFgZ8ZPTkUNcNhD4CIG9UuOkTCkyd1oFhLs3j6bm0WbgKrNiVhlGGVu95lOJhrpzP3/wUn93DsMtWVjh0fKvPdNMwAq08OBmZF8m6uAzW/nW40sap3JZ5IrwjzaZLXXbHKDjQNWCBP59swqLVhGkzHVTshZUElUadHwF71rsIuUSs3SZSi3tD6biQYhLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+M197v32U4sRu5wkWonTKeeV0auMvNIyfpp1vmDBKs=;
 b=oYIYgzzGWTVUeDeEq5NfxvvQlYNOHyYV2TzmwQUNrBfa/reLZRh1A2eDjG6ct2qnw3HW9GgwcTyUN0B726IXxFacH1e2fyIzNVlhfu6pY/wFF40adIIGNyWua1xPsiUs9gbNwV0ph+ElAKeWKKojehbM9XvXdLBEmHNG6a02rNU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB7855.namprd10.prod.outlook.com (2603:10b6:806:3a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sun, 7 May
 2023 01:59:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6363.030; Sun, 7 May 2023
 01:59:36 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Dave Chinner <david@fromorbit.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1m10w0d.fsf@ca-mkp.ca.oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
        <20230503183821.1473305-2-john.g.garry@oracle.com>
        <20230503213925.GD3223426@dread.disaster.area>
        <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
        <20230504222623.GI3223426@dread.disaster.area>
        <90522281-863f-58bf-9b26-675374c72cc7@oracle.com>
        <20230505220056.GJ15394@frogsfrogsfrogs>
Date:   Sat, 06 May 2023 21:59:30 -0400
In-Reply-To: <20230505220056.GJ15394@frogsfrogsfrogs> (Darrick J. Wong's
        message of "Fri, 5 May 2023 15:00:56 -0700")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0380.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb842db-cbe3-48e3-a4b8-08db4e9eb5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHhiu+/SOkZcsnGQZGKAsqWzEPD1qib+dxTNuZlolK/XuqDweLwYhSnHUuXOyFwCZsYrsCJ7PPdMwFYkmjSUw8kdj3YzyKyGllfu4/YAu/TFQT5hdJlvHebvxKRmyP7lxWFNax6YtiXp1vPdm4v4J5MgTp0dGRb4Rd0S9xZGce7D1xN+g6mcd0j+kteXfVEB7EjDQVuTNJkg4ijlM+lD7TIKmYvBbGBtEjornzqHNTMnQMKlFmv+5Xi+QH/e4HF2KOF4hLDLVDEjAvaR7X8PVaAwsB3sQRdS1JWHD8rKtLsGo1YBotfbuWKWXD0FtnN17THFEzPdqw1hW75oPBPdeGvZshQRQJzheNHG8SxBczbGWHWVg50v+hippOsF0em9S6XBDeKzu5KAg8f51GJxIobtTxq6PBVbmBdw+fUVwGuDw5DFUuh7y2wkJwkwCdx6iMF5OfdZHF9tbhn1ooPMEu8wrpuwu6RTt3/ETjxVZLuAlOlR8/EzdnK5hjRSNhcZ/brX66IdYHtcdo9kgaAhTc3ZtA2Ge3k5kE/+4yTO8YeSwOg/SG7c3sd3ieOeiwNB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(6666004)(36916002)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(6486002)(316002)(54906003)(86362001)(26005)(83380400001)(107886003)(6512007)(6506007)(8936002)(5660300002)(8676002)(41300700001)(7416002)(2906002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pSLV3UFAozztxBerv5Bq/EFo9QDqI2rvL7b/SHRMAr2bPE/1v3fQ18bnBpqM?=
 =?us-ascii?Q?+AmoOzn2I5dq5h1lMY6VEnsyYgPiS0aX/gnPANoBCoPoHNjvrI2mjvO0E2OS?=
 =?us-ascii?Q?olFBoOVywWm02exw7swlIR8g+l8slmk6av5I7b0FPxk8DjwhXBcKXrhugfPW?=
 =?us-ascii?Q?PWt1Redb60ZgGR7JLwpqQ8g7ynPTFer7zRKkd1jYSdKQkalioA3KVr8k9D7R?=
 =?us-ascii?Q?LxFzPwG25bjiuBAtI5/ldg0Q2nBdewJnQPiX9mqsicApFY2Uli8MTLeOJQIN?=
 =?us-ascii?Q?IdB1kVmM6q59s43R38waZLVR9sS7gAkn5PL0AUCnH6iavGTHGu3zOpRxmmXM?=
 =?us-ascii?Q?tR0r/PhjKkUNkJWGaCNAGmaESyAClGlTKlIJd39Gs0DEA9SHk6pYFl6E4FyE?=
 =?us-ascii?Q?C8PtdrXK2rPFkTD9QO8EJpnWTb5m5z+VN/XtOIkk+Cf6B623nIaQ9S56Juhg?=
 =?us-ascii?Q?+1xWkN+yULn3080bdrcQrBtTFt0ZkkYGzYO7wq6mh/0c2ZVxd78Jp8QvO9pZ?=
 =?us-ascii?Q?UC7+6D9c84foyI0RyW+/7vNuQVh5POanl0n7gI54a46fCNNF7HZntFpYU6sr?=
 =?us-ascii?Q?d7AW/erSFWxPpnadptncJAqP+Yg3+r8AAaOW0VPOa/Z3tEUZpdT7BWHjruTJ?=
 =?us-ascii?Q?N7EPyUW0kvuw0kSxmunVD2KXfX29KyWHhu9qtwe26TL2bV7+j4WVSEHmXLCE?=
 =?us-ascii?Q?r/UrI0OT37iVIMf3FIUyG6rudf1RIv9BzjBrryIFXrmjMSPGqG8aTnCckq+3?=
 =?us-ascii?Q?ZPozHNKZDlLvyJyBlCSitHGgoxVvuO3M088DqrRtIz3qUjf4N41K7OLh+15p?=
 =?us-ascii?Q?J5Mxggzf+VCbRtlCgcykPINWt+EZhdzxplxzsm1yZKF/u+LKk7ugItcnC2Uz?=
 =?us-ascii?Q?z+MCoDiPvRCbMxtvVug+8rL8AHFSHXaMCpSbM5Gv/ObmDDClz9Yi8EpETq2J?=
 =?us-ascii?Q?KRdIfd1I1tHCC7zMdV6dN/NlOgsF70F8wEMkKZTi6fNZbzB2hk9s/17Fnaky?=
 =?us-ascii?Q?wq/F2LXEyzVTz7ORLbtqsMm4evx85CN3sisj3zSAjrSJlxYSEFLV2gVQTIBv?=
 =?us-ascii?Q?0twPcTpgzmBSFDlk+6y7Wl8GBpx1uCilNxylNZT9q8HCZseMc0KyFaj+skrg?=
 =?us-ascii?Q?yit0dk/8xH6ILU2u5lkPB3txJHyZy2R7fSU5MR8xYB+aDPLx9MCl0nMX8nnP?=
 =?us-ascii?Q?h2/wFb18spML0SoiCW6tuej7HGOeP3yL6BLeR00PpiiBH/CzgJnFZv0ipLzw?=
 =?us-ascii?Q?9Q2HhM+xssRfQYrb72aYJ6GnX9GJNZjmk18aUkzTFeZUshtPMoe6xOjWI1/R?=
 =?us-ascii?Q?UXE5l9fKjLfO/WqmAPsjyIVYqSncjI/xx6PHZpJgQKMsUM2Dybbnxc5m5vh5?=
 =?us-ascii?Q?BbSi+UTY9dsobGSYmc3/qPHPVqdvln627IE7GpI2L1BmUjmSME2msFPjS6L4?=
 =?us-ascii?Q?GVyaFeg2IRwSgEvgZuTqf1gu9IgSzWUsZyxJZ3wYsHNn5Sq4HoCfDgyaYhoQ?=
 =?us-ascii?Q?hEJ4EfImIyoD/XwpwZqRZNZrmjgXwacr8ovrc6fcsathWJKWoLw5g6Hixl1W?=
 =?us-ascii?Q?VwwlHvO4cUzLDAyQ/k0Q9lu9A3+L8LPTB/LXtY4qVRgUJ8C546kxzpv4GRR8?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kg2inku+yLUN7zYxxj4HFI7IkmxL0CNIu5bZEVVWp5fc/Mq2pH33R8wFEDo2?=
 =?us-ascii?Q?tU2CL16ya5ySUbhshZOL0dpjRydX5GBNBZYF+Y+1x57bYSpvjzJW/4eWP5Li?=
 =?us-ascii?Q?5SZE7bQGkl7Db7kspyHROzKmzou2N/qcn2MpdNtlXn9zZ4wnsUqjDsw86mUY?=
 =?us-ascii?Q?iQJyV8mfmJlm/M+k4ycJhgorr/j2yPQBqO1eOyG45ME5i0Vw5QhqWGZ1AgYO?=
 =?us-ascii?Q?0f9QMgRk3lfquq6uUH2R3T8Nvflp7CzwRqAmqkJiK1n9ojoF8TYXknsM176/?=
 =?us-ascii?Q?6JKEiYI4RLYEQMHcyGkZsOOA27pwvx4WqLMN5hcHtYLoUsId4JNNK76GSDNk?=
 =?us-ascii?Q?KRA5KQwUiX+lQAFM0Pdq6bYDQwnOeOx51EP4oq+XO7k5YG18Cl1i02HEhaPZ?=
 =?us-ascii?Q?iWBkm56kzJZq1LyFoWVJ2QCgJ0ICWy5ZZv8san06EIcFc6gJO9Ng+7aRq2h/?=
 =?us-ascii?Q?Qbn0Q3hKvkwOAWhzxSyZWHs8vmAuNtz8KHrC+EPoaVFHc52BasWEiVlfwpgs?=
 =?us-ascii?Q?ZC9dWGEbCAM6rk+KQ6cLS8k5eXZobXPCscLkC2eibApV6/jTkSWudsijz6Hu?=
 =?us-ascii?Q?Jnf4Rf6vd0viLgd27QLZ00r/77f8KjaWpgMGr7/48iGCCq2kwLQbTrptwvYZ?=
 =?us-ascii?Q?NSwRL1XRrxvt1ClO42rhH8UL+Wd5C1CKV8jM/65SQVCA7a59rIcD7BtOdCq9?=
 =?us-ascii?Q?WKt3Wh7jYjKvOrd9gHR4In7of01vzAO0WuC653xHglzgF86R9MMIDxM8oTI9?=
 =?us-ascii?Q?MSUqhibfQthp6Ua72AkQnf6U7Kw4GvyeMEzDgLh11pxn8IJmHjKn4EgFx/4K?=
 =?us-ascii?Q?TBp8OKOMna5BRs5+UxIbV89hlcy35Mq36rHj3OpZesi1yk8PhlH8Gx/UuD7A?=
 =?us-ascii?Q?ePeDtoJevOkHYLIfwP75ZBRRcTS5gWpMmBnrYaGERE3BzS9NIDrqcMR2yQ2A?=
 =?us-ascii?Q?QboV11tbbc6fBX/5WtWno3mMOob0+olFHed577ZnY1RY8LBb1BFyVe4tC0pM?=
 =?us-ascii?Q?+csM2v9pNKzBUtjEZxgH3KWFCemhu9l7cwNLmpk8cy4sVJZEb/p08Zjxhw43?=
 =?us-ascii?Q?4yo1DxKN5eq5ACJjZ/I5ajJExoOlpsyLcs1Ie/q/N3GYYFRmJdFd80YWc1/g?=
 =?us-ascii?Q?uiDcqZJ9WKGPgDiz4iMMxlwFr82sw/le8+lpVoBq/IzItKJPEeJv2xc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb842db-cbe3-48e3-a4b8-08db4e9eb5e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 01:59:36.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkWocgnAfIo6RscgA2ssJjap3t6SZViz/K2BIflkCTBRHaPciUL8oSvdXOZlJJRDqBdwA1xsBGy+i8/hJ7l/3qhH9G5oLHaGZRiZB+nvbkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305070015
X-Proofpoint-GUID: _spkcROly9jY8q1N1NLJvzLh8b4bMNLk
X-Proofpoint-ORIG-GUID: _spkcROly9jY8q1N1NLJvzLh8b4bMNLk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Darrick,

> Could a SCSI device could advertise 512b LBAs, 4096b physical blocks,
> a 64k atomic_write_unit_max, and a 1MB maximum transfer length
> (atomic_write_max_bytes)?

Yes.

> And does that mean that application software can send one 64k-aligned
> write and expect it either to be persisted completely or not at all?

Yes.

> And, does that mean that the application can send up to 16 of these
> 64k-aligned blocks as a single 1MB IO and expect that each of those 16
> blocks will either be persisted entirely or not at all?

Yes.

> There doesn't seem to be any means for the device to report /which/ of
> the 16 were persisted, which is disappointing. But maybe the
> application encodes LSNs and can tell after the fact that something
> went wrong, and recover?

Correct. Although we traditionally haven't had too much fun with partial
completion for sequential I/O either.

> If the same device reports a 2048b atomic_write_unit_min, does that mean
> that I can send between 2 and 64k of data as a single atomic write and
> that's ok?  I assume that this weird situation (512b LBA, 4k physical,
> 2k atomic unit min) requires some fancy RMW but that the device is
> prepared to cr^Wpersist that correctly?

Yes.

It would not make much sense for a device to report a minimum atomic
granularity smaller than the reported physical block size. But in theory
it could.

> What if the device also advertises a 128k atomic_write_boundary?
> That means that a 2k atomic block write will fail if it starts at 127k,
> but if it starts at 126k then thats ok.  Right?

Correct.

> As for avoiding splits in the block layer, I guess that also means that
> someone needs to reduce atomic_write_unit_max and atomic_write_boundary
> if (say) some sysadmin decides to create a raid0 of these devices with a
> 32k stripe size?

Correct. Atomic limits will need to be stacked for MD and DM like we do
with the remaining queue limits.

> It sounds like NVME is simpler in that it would report 64k for both the
> max unit and the max transfer length?  And for the 1M write I mentioned
> above, the application must send 16 individual writes?

Correct.

> With my app developer hat on, the simplest mental model of this is that
> if I want to persist a blob of data that is larger than one device LBA,
> then atomic_write_unit_min <= blob size <= atomic_write_unit_max must be
> true, and the LBA range for the write cannot cross a atomic_write_boundary.
>
> Does that sound right?

Yep.

> Going back to my sample device above, the XFS buffer cache could write
> individual 4k filesystem metadata blocks using REQ_ATOMIC because 4k is
> between the atomic write unit min/max, 4k metadata blocks will never
> cross a 128k boundary, and we'd never have to worry about torn writes
> in metadata ever again?

Correct.

> Furthermore, if I want to persist a bunch of blobs in a contiguous LBA
> range and atomic_write_max_bytes > atomic_write_unit_max, then I can do
> that with a single direct write?

Yes.

> I'm assuming that the blobs in the middle of the range must all be
> exactly atomic_write_unit_max bytes in size?

If you care about each blob being written atomically, yes.

> And I had better be prepared to (I guess) re-read the entire range
> after the system goes down to find out if any of them did or did not
> persist?

If you crash or get an I/O error, then yes. There is no way to inquire
which blobs were written. Just like we don't know which LBAs were
written if the OS crashes in the middle of a regular write operation.

-- 
Martin K. Petersen	Oracle Linux Engineering
