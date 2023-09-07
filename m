Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4664797D3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbjIGUOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjIGUOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:14:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777D1BCD;
        Thu,  7 Sep 2023 13:14:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387JtfEN004411;
        Thu, 7 Sep 2023 20:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=5QO/gAliQMb8dsT1JQNS1NZcBLvw1xEHh2fozXyQeBU=;
 b=06ww+2ZsZ9db4evLwsCvDPmww8zX8YD+XXmXnsBmWeUsrYWISIec6kOhdXDV4xD/HBTS
 rYruT+XwRrS73+kxeUe+3HVnP7A+CYxV9SzjNAt9FLL8Ts32/TjSXsq/kE1Nt8aLHcV1
 Yybq67Tpdy9k7sRaNl2AXeoA5GXGp8E4SHXXDIrog+Wpg4ykkRiqhBB+wGlzWqd5n2A+
 zUIXgb/ufFxaCmHUFkFXzMUYk9m131QttPxHrwgeqWOxAzfnzmS/ZoOhxfKSMZhU94zB
 aFf9aPxWwrna8j8hrV+KwYA2imTja5Ac8qEgpfK7UJ8O2vzMDTm/ki0wLVl21EPS0BwT RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syn3c018m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:13:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387J5Y5A013243;
        Thu, 7 Sep 2023 20:13:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugefcmx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTLHUqXD/tqOZHY3LlWgKQtbEgoCxyNSnaEW7QO37eDOoGJ2p0PSDWyIYwhPqW20RGswKYayVaE/OaGRLKi55WigVMjnyIEwZfuXDtXYaDn9LuRep3OQziqDggwWPPIF6OGg5LobI5gz/pmxEQtH5CwWmBr6HNpQlu1/SzTN60E5mVYIqhZ8la8Yf29Fm73q54/pue/4k+5lmKdFdBbOfx39QGbJ3DxruRr/opEGVMmy8xJELXS8Ktd/ECq/nH53ueW9L1cCZATc/kbA1RSv9Nc6HJ+HV1nzjogoiwHr0rDWNXagyAv6q4oYR2m6DHHqVQV1wy1IYH5kkQU0JaCeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QO/gAliQMb8dsT1JQNS1NZcBLvw1xEHh2fozXyQeBU=;
 b=LeLEYmOB9pSecGur29ZiEdb96BVB785HJRGpPLgtsr9CsNel77hhs4Dm0NFw0sfBqPJrCyU28OLHrjSZJm9LvY6s7VSHL5XQE1L89ETg7ymDrluD1Tsep12A4xZj4Xz4tnhJQzKFv5vkOs+tvbeZSMPdvgelbIZYSkScxmWc4ZDwORDedPm1380mDM4LDwA0D1FIlLlfNu42C6qIjKlizl9GUEgHUIDKxXDVNgowg9AowZLGwy48VSKufkcv7OLqIo7LkCt42c6OlGjl8xA/ztvL/b6RtczIxY8lkn/ObAXw9zaULIVb2uQOQQCYq738o5Da2YSf6WFAx4GrFyzJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QO/gAliQMb8dsT1JQNS1NZcBLvw1xEHh2fozXyQeBU=;
 b=v/jpRHXjAJPCad9Ycn9vRst4oHp02LC+H+pVf0FpGLgW3BofQKDZtXe8qfLtSgdoNk1JWvnfd5bAF7bBz9TGqUWCiwXZdPg6kqyyVTylzdEKRwpgZpe4p0wXwSO+8FKkegr5r5/v3VDgVUtfnRuSuNBlESLOFZ7yewEoiqSeAwQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 20:13:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 20:13:37 +0000
Date:   Thu, 7 Sep 2023 16:13:33 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <20230907201333.nyydilmlbbf2wzf7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-3-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830125654.21257-3-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 05785a55-ac8f-4958-c336-08dbafdeeb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdYzAxWkV6bvovKx8V9ZK7F6I8r+Fzd0ul05aYr4ugsKTlOsvUJAzY5cEkPYlJEXLTn9d2ZbrRpdmrgjLkaSbkIoA6qRg3kznp4VT8xky5IUmP0lFv4Ug3gJn/nKaykI2lmaCCYdty3P5mSPHH2MXEUcC1OcfBld4cw1rl5+xCyB2ahJGerlRok4o01sG2EqAqYZ5zGfQaMmlhqfrZ2NRzMDdHu5aN7hqshYyVNpicULRINBv/RRUJ8uGcJFdpo8KBBZiQvX21XvvinoThUZ0H0IzDVFkpBJ0l5LlW9MzXrKFVLfhz0COj/6EmZ4g77Bwp6C160qdZD25UgUpTLVK8p9WgXthy4gqnhFKN1L88cyM9MPnldlGUlSAGKgRwqRVHQaFmFdCGdxgx0O7018NKlQA/eGjKjGn1yjXDIV7qoZniObl4vCNnnf0f8zPQWjABO5welqL8xzDLqs+IC47A9JOMmcpGF0bYGEXwsTnVzOPmV44yiyj3Qv9YginWm14br03kgE0gDgUTg8DjiYDGJA0eDG8LfKP0aNLsQpRwXF4HwCHmwDHZQq46N/Rr17
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(33716001)(2906002)(30864003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(8676002)(8936002)(83380400001)(4326008)(26005)(1076003)(9686003)(6506007)(6512007)(316002)(6486002)(66476007)(6666004)(478600001)(66946007)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1WndY81pHgOJ4k27zolwm7J/SMBFKfPuvW8ZUaUYJKOsp+9jqxLbwIVRsAR?=
 =?us-ascii?Q?95/fzzjgoqoBL9kTGRVDNaYAGyIZC7sA/Fg4LlMgpZGM75TMlRTwg6sRJvWl?=
 =?us-ascii?Q?hDRzsYW7A45sUhY3CmdoJo+olV+vyAJUlbc/Rfc/Q9trqFmTNXLIoFSMRkTW?=
 =?us-ascii?Q?KICdjqDbutgX0cpHbCru2EuDA3OLZODZBcQnnFn+QugGMUO3Mm+iOEqDw35T?=
 =?us-ascii?Q?Cwpz1IfhJdnlQ4B1pqoDnvkDM9DdNZG10hPM1t+1670VtEbwFhcurNMUy01c?=
 =?us-ascii?Q?PEUWSjlOor0n5xNhn/Q5Awzywdh86g3BND2qz/Ki8ZnhwYvsne8ce6ATfAST?=
 =?us-ascii?Q?bJlWdnhbDXzR+cj4xsRS+gw+wbVvxcDOQIew2unZB/BmNSiLuajd75lznWxh?=
 =?us-ascii?Q?KnJikwekxLa0O01WRRwb1unAT8LSWN28wPmhoUC8QzngBuMOtlsbQ8Sd6EQC?=
 =?us-ascii?Q?3l/jk4iltMqph1ncw1ebfzA7oIlZGbcj1dgY7aB0BnszCsxhNC4B4mtSnBvW?=
 =?us-ascii?Q?TRjGH8AMLYPOu/n3HeVblbOr+ghcoohHD1Pzf2ulkWWTtG7kjXzuoYtBjt2u?=
 =?us-ascii?Q?axYU1kfIZa9dAQdOlFy54Gdy1AUYILvIdxDcIEGuByY76lzts5emqHaTMeU7?=
 =?us-ascii?Q?J4ufqwb//dmud5nKykFhK9slBuctC+AAjfJHqR7I1tsIrLngOFb/R/kvi7Po?=
 =?us-ascii?Q?EIFnnAwKM7qOKSY+md+hWHXsmv6T9TUbHQhckBbVFpvsjM6ia1jHNI3Y88Q4?=
 =?us-ascii?Q?I+cZsmC7rRVr0lHuqEU2lS1E0l/dA+4smfQC6W/79dQfyzTw0fks829+/tAQ?=
 =?us-ascii?Q?YMigideBafogwJLvVNXWKkogINKXAsPyXS8BcQitEXk1Nf5lkF9wuV/9xojM?=
 =?us-ascii?Q?cc9gcE33gUlC0td/Rz9BonoX0CU+jvJeUwKi5Wwu4J2LNPZ5sEYbrsnoZHDx?=
 =?us-ascii?Q?mzH2EtpWCgYZ9Uv8T3GYSufhg/piG64YNA/SfrtVd7UZHVFGQS5OcO2HWeWl?=
 =?us-ascii?Q?0sfzhprus/FdzJ6AmpCH+IOgg0Gg3aXC+smL83TjOQHro3qQ21G+uY0s3/PF?=
 =?us-ascii?Q?UjlB4KrUT29ILS+iKSDc/9L5dPAWPuix/wJcpbxh0Fx85DzqR0j4oSm2Y5w+?=
 =?us-ascii?Q?6sMXrcgXWK4H7DFsPojfTE3Zhn62yqPCjJR8T9CNGcndasxMtzB/6/rMOEPR?=
 =?us-ascii?Q?pOlNy8DDSYA04rTfYZPGyBydc9So1tWQ+ifywB2er19mYPIGSJUie4jTtghq?=
 =?us-ascii?Q?ZLEOqO/mgOEPLC7C1mzJiWGUvNQr17s4cnjhRM+U9JQILRYg0BXvVh10cSr+?=
 =?us-ascii?Q?D4BGA9yRPVD/lR5YeVV6J1w6Qq2O4qeGmohpgql/HlR94fCmi1wxkMdgvQxA?=
 =?us-ascii?Q?a5B3bkdvLZ5CodUjvFN9ibIuiWItdptor5LqDKpqDUWHMkDvTlp2E9v3hjEl?=
 =?us-ascii?Q?qci4zcvFWti0wqsDaxQpHUmX/oak4X9j+tyCZ2j9s/rEGR5OjVO4zZseEpCM?=
 =?us-ascii?Q?4h3bOFsQAGDo9zQQUZ0dHCC4JwzuPxqQzsT4xikgiNM6fN5VnyvLqXPQ+HUA?=
 =?us-ascii?Q?sm6LS1cEwPz59AK/IZq5GXO0HXW/WpPUr02vg30XW1xGDIxlFD/9NSdxLjiL?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tfRm8VnuNxn+pgkO7mhb2FzG8xCwoKMbhK47bdJEsGdY95cAfOheXU9xYsm8?=
 =?us-ascii?Q?WaERzi3QJ4Xk0vRmxH56sPG6DTUEQqzsuKPWFvJXJFLlNmwgiKQmAyprAdsy?=
 =?us-ascii?Q?7gsivddIvJipuJ87Rc/umsmYZ4m1ACFVfWgH9gGQyuDU1VepJgqLldPicMlm?=
 =?us-ascii?Q?CtlkDNDKvvO1/dsyfl8vRoOUKkzkfUFWoaHFT3PVyVmYJXJPCErYRyQdEEwo?=
 =?us-ascii?Q?lnrvt81RhRCwZ8cQ+KShCDXQjEAmdzJgijLRG84gV1vQWljhNXy08v/9+Hn5?=
 =?us-ascii?Q?BpYO1Wb0sRKcfXnqEmho66HooPW7WW9tHTXStnkGAk01+aTIEPE/LxoJSi2f?=
 =?us-ascii?Q?S7mEtLi7yiWkB0dMyuLgHfqirq1g+21JAtmM3XJa2QSwjzxS7gJ5mFJC0pz8?=
 =?us-ascii?Q?fu/pK3/WtIrkpZr301KL+onJA1FNXwaXEu+g9bgdNALjvsTZbDFSwzzqIKqW?=
 =?us-ascii?Q?TDyAANyWMVTaFlciLsW+gyq1wHXsce2I3eGDHVUGBhu306Q0STxFlWKDGvEv?=
 =?us-ascii?Q?6YOXO8OOp8UpHTgAxHCYc0Lym0SnhSnSL/s8A1mUxWPdqcT352CBqLIGLGnj?=
 =?us-ascii?Q?oiZkQNFINLauTONVnuRUFdTHeC8gcVuDrCVauxZdEN6AS1oIzMYRdVmsr8zH?=
 =?us-ascii?Q?MW6+mm7NHglN5jZ6uLfqFaitoEqNndNFR3UeARyycQHBNOKkscGgohxg7IFj?=
 =?us-ascii?Q?ZVugOHXtDPKnONSIgBmXd9TBwU7EMqX6ouYbY5FnlOdoXHnqdHA8KzRin+xy?=
 =?us-ascii?Q?Li4w0fEsWd7tnNup/jO+3EXR6cgCZLrk4KFn9hEISodN1jg1ZRPcWYZ1Oc8G?=
 =?us-ascii?Q?uxfFTTYWVDdtYcjTp2doy4hr+DJWWKHUtKaDKtNTM7HyXhjYjaA1IjJRvxh2?=
 =?us-ascii?Q?KROneB+7u/9DYI+v2H0NtWklzeVL0FBDHBCz6FWOv8bbqesHwMbNpYasw/0j?=
 =?us-ascii?Q?x5AkzMr2KBQo39Pet+4PUuZ6AQpiSin4VjjWU7Zu0wFfro2D1iC/ojtS27Ag?=
 =?us-ascii?Q?DlJdxddAcseQxQF0UA5BVOGSluALuv1hdqiY3hVr1JEVQVVtySLGHlNSiAXn?=
 =?us-ascii?Q?GnMAPE4A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05785a55-ac8f-4958-c336-08dbafdeeb5c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:13:37.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE+C4lGDcHJ05tX3t3AHSO0EIZbhcufWfgzykaXE2SRsaNyVAjOP0k7w88VOqH4ScuCXpzT+yfnAW++6hvah8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070179
X-Proofpoint-GUID: LFkxPrX_ehmc4WIPAj82cbUOTWczmRHq
X-Proofpoint-ORIG-GUID: LFkxPrX_ehmc4WIPAj82cbUOTWczmRHq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:57]:
> Introduce interfaces __mt_dup() and mtree_dup(), which are used to
> duplicate a maple tree. Compared with traversing the source tree and
> reinserting entry by entry in the new tree, it has better performance.
> The difference between __mt_dup() and mtree_dup() is that mtree_dup()
> handles locks internally.

__mt_dup() should be called mas_dup() to indicate the advanced interface
which requires users to handle their own locks.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/maple_tree.h |   3 +
>  lib/maple_tree.c           | 265 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 268 insertions(+)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index e41c70ac7744..44fe8a57ecbd 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -327,6 +327,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
>  		void *entry, gfp_t gfp);
>  void *mtree_erase(struct maple_tree *mt, unsigned long index);
>  
> +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
> +
>  void mtree_destroy(struct maple_tree *mt);
>  void __mt_destroy(struct maple_tree *mt);
>  
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index ef234cf02e3e..8f841682269c 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6370,6 +6370,271 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
>  }
>  EXPORT_SYMBOL(mtree_erase);
>  
> +/*
> + * mas_dup_free() - Free a half-constructed tree.

Maybe "Free an incomplete duplication of a tree" ?

> + * @mas: Points to the last node of the half-constructed tree.

Your use of "Points to" seems to indicate someone knows you are talking
about a "maple state that has a node pointing to".  Can this be made
more clear?
@mas: The maple state of a incomplete tree.

Then add a note that @mas->node points to the last successfully
allocated node?

Or something along those lines.

> + *
> + * This function frees all nodes starting from @mas->node in the reverse order
> + * of mas_dup_build(). There is no need to hold the source tree lock at this
> + * time.
> + */
> +static void mas_dup_free(struct ma_state *mas)
> +{
> +	struct maple_node *node;
> +	enum maple_type type;
> +	void __rcu **slots;
> +	unsigned char count, i;
> +
> +	/* Maybe the first node allocation failed. */
> +	if (!mas->node)
> +		return;
> +
> +	while (!mte_is_root(mas->node)) {
> +		mas_ascend(mas);
> +
> +		if (mas->offset) {
> +			mas->offset--;
> +			do {
> +				mas_descend(mas);
> +				mas->offset = mas_data_end(mas);
> +			} while (!mte_is_leaf(mas->node));

Can you blindly descend and check !mte_is_leaf()?  What happens when the
tree duplication fails at random internal nodes?  Maybe I missed how
this cannot happen?

> +
> +			mas_ascend(mas);
> +		}
> +
> +		node = mte_to_node(mas->node);
> +		type = mte_node_type(mas->node);
> +		slots = (void **)ma_slots(node, type);
> +		count = mas_data_end(mas) + 1;
> +		for (i = 0; i < count; i++)
> +			((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
> +
> +		mt_free_bulk(count, slots);
> +	}


> +
> +	node = mte_to_node(mas->node);
> +	mt_free_one(node);
> +}
> +
> +/*
> + * mas_copy_node() - Copy a maple node and allocate child nodes.

if required. "..and allocate child nodes if required."

> + * @mas: Points to the source node.
> + * @new_mas: Points to the new node.
> + * @parent: The parent node of the new node.
> + * @gfp: The GFP_FLAGS to use for allocations.
> + *
> + * Copy @mas->node to @new_mas->node, set @parent to be the parent of
> + * @new_mas->node and allocate new child nodes for @new_mas->node.
> + * If memory allocation fails, @mas is set to -ENOMEM.
> + */
> +static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
> +		struct maple_node *parent, gfp_t gfp)
> +{
> +	struct maple_node *node = mte_to_node(mas->node);
> +	struct maple_node *new_node = mte_to_node(new_mas->node);
> +	enum maple_type type;
> +	unsigned long val;
> +	unsigned char request, count, i;
> +	void __rcu **slots;
> +	void __rcu **new_slots;
> +
> +	/* Copy the node completely. */
> +	memcpy(new_node, node, sizeof(struct maple_node));
> +
> +	/* Update the parent node pointer. */
> +	if (unlikely(ma_is_root(node)))
> +		val = MA_ROOT_PARENT;
> +	else
> +		val = (unsigned long)node->parent & MAPLE_NODE_MASK;

If you treat the root as special and outside the loop, then you can
avoid the check for root for every non-root node.  For root, you just
need to copy and do this special parent thing before the main loop in
mas_dup_build().  This will avoid an extra branch for each VMA over 14,
so that would add up to a lot of instructions.

> +
> +	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
> +
> +	if (mte_is_leaf(mas->node))
> +		return;

You are checking here and in mas_dup_build() for the leaf, splitting the
function into parent assignment and allocate would allow you to check
once. Copy could be moved to the main loop or with the parent setting,
depending on how you handle the root suggestion above.

> +
> +	/* Allocate memory for child nodes. */
> +	type = mte_node_type(mas->node);
> +	new_slots = ma_slots(new_node, type);
> +	request = mas_data_end(mas) + 1;
> +	count = mt_alloc_bulk(gfp, request, new_slots);
> +	if (unlikely(count < request)) {
> +		if (count)
> +			mt_free_bulk(count, new_slots);

The new_slots will still contain the addresses of the freed nodes.
Don't you need to clear it here to avoid a double free?  Is there a
test case for this in your testing?  Again, I may have missed how this
is not possible..

> +		mas_set_err(mas, -ENOMEM);
> +		return;
> +	}
> +
> +	/* Restore node type information in slots. */
> +	slots = ma_slots(node, type);
> +	for (i = 0; i < count; i++)
> +		((unsigned long *)new_slots)[i] |=
> +			((unsigned long)mt_slot_locked(mas->tree, slots, i) &
> +			MAPLE_NODE_MASK);

Can you expand this to multiple lines to make it more clear what is
going on?

> +}
> +
> +/*
> + * mas_dup_build() - Build a new maple tree from a source tree
> + * @mas: The maple state of source tree.
> + * @new_mas: The maple state of new tree.
> + * @gfp: The GFP_FLAGS to use for allocations.
> + *
> + * This function builds a new tree in DFS preorder. If the memory allocation
> + * fails, the error code -ENOMEM will be set in @mas, and @new_mas points to the
> + * last node. mas_dup_free() will free the half-constructed tree.
> + *
> + * Note that the attributes of the two trees must be exactly the same, and the
> + * new tree must be empty, otherwise -EINVAL will be returned.
> + */
> +static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
> +		gfp_t gfp)
> +{
> +	struct maple_node *node, *parent;

Could parent be struct maple_pnode?

> +	struct maple_enode *root;
> +	enum maple_type type;
> +
> +	if (unlikely(mt_attr(mas->tree) != mt_attr(new_mas->tree)) ||
> +	    unlikely(!mtree_empty(new_mas->tree))) {
> +		mas_set_err(mas, -EINVAL);
> +		return;
> +	}
> +
> +	mas_start(mas);
> +	if (mas_is_ptr(mas) || mas_is_none(mas)) {
> +		/*
> +		 * The attributes of the two trees must be the same before this.
> +		 * The following assignment makes them the same height.
> +		 */
> +		new_mas->tree->ma_flags = mas->tree->ma_flags;
> +		rcu_assign_pointer(new_mas->tree->ma_root, mas->tree->ma_root);
> +		return;
> +	}
> +
> +	node = mt_alloc_one(gfp);
> +	if (!node) {
> +		new_mas->node = NULL;

We don't have checks around for node == NULL, MAS_NONE would be a safer
choice.  It is unlikely that someone would dup the tree and fail then
call something else, but I avoid setting node to NULL.

> +		mas_set_err(mas, -ENOMEM);
> +		return;
> +	}
> +
> +	type = mte_node_type(mas->node);
> +	root = mt_mk_node(node, type);
> +	new_mas->node = root;
> +	new_mas->min = 0;
> +	new_mas->max = ULONG_MAX;
> +	parent = ma_mnode_ptr(new_mas->tree);
> +
> +	while (1) {
> +		mas_copy_node(mas, new_mas, parent, gfp);
> +
> +		if (unlikely(mas_is_err(mas)))
> +			return;
> +
> +		/* Once we reach a leaf, we need to ascend, or end the loop. */
> +		if (mte_is_leaf(mas->node)) {
> +			if (mas->max == ULONG_MAX) {
> +				new_mas->tree->ma_flags = mas->tree->ma_flags;
> +				rcu_assign_pointer(new_mas->tree->ma_root,
> +						   mte_mk_root(root));
> +				break;

If you move this to the end of the function, you can replace the same
block above with a goto.  That will avoid breaking the line up.

> +			}
> +
> +			do {
> +				/*
> +				 * Must not at the root node, because we've
> +				 * already end the loop when we reach the last
> +				 * leaf.
> +				 */

I'm not sure what the comment above is trying to say.  Do you mean "This
won't reach the root node because the loop will break when the last leaf
is hit"?  I don't think that is accurate.. it will hit the root node but
not the end of the root node, right?  Anyways, the comment isn't clear
so please have a look.

> +				mas_ascend(mas);
> +				mas_ascend(new_mas);
> +			} while (mas->offset == mas_data_end(mas));
> +
> +			mas->offset++;
> +			new_mas->offset++;
> +		}
> +
> +		mas_descend(mas);
> +		parent = mte_to_node(new_mas->node);
> +		mas_descend(new_mas);
> +		mas->offset = 0;
> +		new_mas->offset = 0;
> +	}
> +}
> +
> +/**
> + * __mt_dup(): Duplicate a maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree using a faster method than traversing
> + * the source tree and inserting entries into the new tree one by one.

Can you make this comment more about what your code does instead of the
"one by one" description?

> + * The user needs to ensure that the attributes of the source tree and the new
> + * tree are the same, and the new tree needs to be an empty tree, otherwise
> + * -EINVAL will be returned.
> + * Note that the user needs to manually lock the source tree and the new tree.
> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
> + * the attributes of the two trees are different or the new tree is not an empty
> + * tree.
> + */
> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> +{
> +	int ret = 0;
> +	MA_STATE(mas, mt, 0, 0);
> +	MA_STATE(new_mas, new, 0, 0);
> +
> +	mas_dup_build(&mas, &new_mas, gfp);
> +
> +	if (unlikely(mas_is_err(&mas))) {
> +		ret = xa_err(mas.node);
> +		if (ret == -ENOMEM)
> +			mas_dup_free(&new_mas);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(__mt_dup);
> +
> +/**
> + * mtree_dup(): Duplicate a maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree using a faster method than traversing
> + * the source tree and inserting entries into the new tree one by one.

Again, it's more interesting to state it uses the DFS preorder copy.

It is also worth mentioning the superior allocation behaviour since that
is a desirable trait for many.  In fact, you should add the allocation
behaviour in your cover letter.

> + * The user needs to ensure that the attributes of the source tree and the new
> + * tree are the same, and the new tree needs to be an empty tree, otherwise
> + * -EINVAL will be returned.
> + *
> + * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
> + * the attributes of the two trees are different or the new tree is not an empty
> + * tree.
> + */
> +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> +{
> +	int ret = 0;
> +	MA_STATE(mas, mt, 0, 0);
> +	MA_STATE(new_mas, new, 0, 0);
> +
> +	mas_lock(&new_mas);
> +	mas_lock(&mas);
> +
> +	mas_dup_build(&mas, &new_mas, gfp);
> +	mas_unlock(&mas);
> +
> +	if (unlikely(mas_is_err(&mas))) {
> +		ret = xa_err(mas.node);
> +		if (ret == -ENOMEM)
> +			mas_dup_free(&new_mas);
> +	}
> +
> +	mas_unlock(&new_mas);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mtree_dup);
> +
>  /**
>   * __mt_destroy() - Walk and free all nodes of a locked maple tree.
>   * @mt: The maple tree
> -- 
> 2.20.1
> 
