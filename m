Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37006F5F88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjECUA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECUAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:00:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6A118;
        Wed,  3 May 2023 13:00:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HowO6000746;
        Wed, 3 May 2023 18:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fllPnR11Wwo3F2gEcgHtSOoIXsNuGphAfCgAa9ulrQg=;
 b=mF8Wae5GCSyCOST7xX7pFlFYZNBPOS/r+eCOmsxIZsOmw0SRAXpugk3PB9fo/LYILPaC
 ZHfqEg8qZ5j/uszYC0bvdc9gBis7lbP3ZnnKKVgqeZvq3BbWnR4/Gv++UNpbvDR59JdG
 KKAShyKdS3wV1VmozpnXmqyI9ItPM62UOSEblDuXM/aH29NOf9/Gqs70AoDUjjbUPtPg
 02i0brNj8CfYXOkfdH1FutCvGvy39hmtAsySLEKydUc4NsE7E0oOKmTApZwGT2omwr+I
 jap2GbcM9d0PLsF34rD7MZ1hH1IylXuFw3+JTMEhuKvsyyClC399+Scsr4nr7laHagQv TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv019c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HRjXe009885;
        Wed, 3 May 2023 18:40:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp805tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaBjACQwXu02oBKZQmnQn2a/5LrFWScrn2GXc3SyfA7yiqWFazbf+wK85C7cgTXlY3Jjm02z3mSFzzIkgHbpZw6vWT+9WKZaPO7xNAXqnu48AFU9UGYvC22HJTcDZLo5nlp0kZw2qjDqu0FgffykwlWY2W7rjqu5dh+pBrnQQa1Czsu6m1TEtvKUP9JyC3QcXeP5X8eWEyLH40P832kJrf7IzYlq1ZEwXS/pQ+5ggvI5u+j13hBrZzqIUw5Xs9EGX8/tr0nBHJuvCXDS+DmiNai4J6J04L+QbLmHP9M0RsplSjcYmmEuZ12mtHufRj6P74TmWE5hLyC9PizJl3kqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fllPnR11Wwo3F2gEcgHtSOoIXsNuGphAfCgAa9ulrQg=;
 b=XnxoDg2Y5Bw6jkh9FmxbWjwJ6fm0bZ+sRW0xm5QqHsCvng7yRYr6AnvA9VNGB7l11Vvzxud9uCAFFNrXx5/uWOPe3/f/KMfqNzLSulOfawVcnZpsI2AQgpSA0QHK41G6LxSGqX9t1MJz6xlSVx1YSZmuCXtC4rn9ZeZY/Mj313E7rgAfK+giscvU4FyNwqfsCAUcP++m2yIvB2+NEp5C0bLDNHEqJaJ5KKEAjS6oUHrMK3fBq9UnstqWNXkHMZp7NhcREnKpJpWwNVqF2XrXfHQ5eeo6dJmaiw1C/+vZjruPb8pJXl2s0XqdmamdRzLSuY3FiTNkChDF6SyTN1unjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fllPnR11Wwo3F2gEcgHtSOoIXsNuGphAfCgAa9ulrQg=;
 b=xX1nhE3k8rCDhVn2sxZMWXYnso8N58nIM4SHIwvGILn3l4f1fo8TWGUBZcHucuvJpi4feodDsgs/OYg/3W6zIHFT7MQg17TxhqxxPS2j5Vawzreu76oJPh08WCAl3CSYj2xJok2XDzGaIaJjbrtJ2AbHZSi5PFebhBfTkmTP8Ps=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:40:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:40:01 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 13/16] scsi: sd: Support reading atomic properties from block limits VPD
Date:   Wed,  3 May 2023 18:38:18 +0000
Message-Id: <20230503183821.1473305-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2e7ff2-6ef9-4e48-87e5-08db4c05cd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+w9BCO+v83Ywq2zuhgkxYSeMG6D2w6ylHm6h82M9CyGUi/uJJWiM+kVzdAzoazJMWV3aFZvsEKcOF2rhFfZUpUuroMzs+5JqbKF8MkyVNgZMU06xJxYVBsmdpSpEqzB84Vln/zwbbVm3l4kCaga4h5ZEDZui1tQcNilExd4uSBpuAz+9a5HeJZ73QCltY7N97I9FfLY5Z/uGetqz3rFqHuoEo+pCz2JZZUreMgHSV7Q5FACkRx2BeC0a19JkQncjTgsaeMgWQTG67r2+w0zVWHAMuGhArK3owqs7ZTpX13xlQ0o/jlxZeK3cSQ3VBrgHHCYMNXcVZPp+T1BpPTMWA3TYQWrkTmVH/rbwqLH2z00mrGpTeLbm4rZQLC2nDI/YyAf1QDMxMCvpYZqqB/eEvkkG1Jh8at2CCIiZTXXL+3LoiqXhN0BQa+uFaodjtY2NkKucd0Oqoa3z16isbcxNfL7eUjyjd6uFOLrU6msB+dWeKQr3m34aZsjs2PFNQ3HxGn3OEdPGUDFwAdOXnGch4cWgmxBXlKDqM6nt8wZYG9maaRosmLblOUVoBUn340q28Hwm/fmRasN1SAc7H39wAZhEIpyYm69OoGoAqj6T3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(107886003)(6512007)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(921005)(4326008)(316002)(66476007)(5660300002)(66946007)(2906002)(7416002)(8676002)(36756003)(86362001)(103116003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/JCbfNTZB4CxvdHf8xgPTPIvXsWzu9o7CK7FDdH74pDfxXFKnWeChKaVVkTF?=
 =?us-ascii?Q?ttq5mpa8EttNGiMpx5+PgtBeYUoPFxr+6LjYBZB1BRw2S0BpaBdmHoFXbuOx?=
 =?us-ascii?Q?bbSsddgYvtUkbjV5nmdG0RWWlwk6NE112ehMInE8X+Fr8MNvIRvLYtCsdLaW?=
 =?us-ascii?Q?m3qqbnwvH152sZwa2nfbB8lpva6XM/x+Vhcp88psRioILyKlVHcNlPCrpERe?=
 =?us-ascii?Q?tIEXqxoH4gYbEcDZ3BBHm5TMpRHH4DB4CNcWJDdqivdckysSeauXdgep8CeC?=
 =?us-ascii?Q?c9YSe+vhWHUJh4oouL7NVEnkq3eOhV8Y9FP0mbXMDAIis/ndBiaiMsjxGDox?=
 =?us-ascii?Q?p0LratbIEfd6N/a3RHiLR6nUvFAO2H7H9F2Msj5WVuR1ULd9EgSgZ2elXeHV?=
 =?us-ascii?Q?u0fdsqswdyxXA4RwWSp40q6b+c7Fwsgc6WJuSnz4xhUgp9FYJ5NqFk1rfX1W?=
 =?us-ascii?Q?wWHDT2mKLD43N++2B+QjyS5+YGoGND6Js1Ny5tzIpXK8F/AMEFaez++N+Jdh?=
 =?us-ascii?Q?T+4VhCs3JxYUF98ktwF9/8XoB4xoslLbQq+pNQtj35c5cN52AzsG7xpO+M6A?=
 =?us-ascii?Q?NUthuTEtuyUNLXd0AAWm4TL5UNMcuLdmobWwzKqfL+0HLlN2JgelwRbkVh22?=
 =?us-ascii?Q?15RZn8V2LQLSkZGGpP+QVEJTHRW+qh69oxKNY4Tc/1/vG70zLWdAOhQHPM0P?=
 =?us-ascii?Q?adfKAUTyn0eEsloT/0W8ITlrf8bTEpPQ9ZNGYDr/wAzshZTVbtHQxQqnSQIC?=
 =?us-ascii?Q?ZdWY0VDKfCqiKh/1tN2nFb5+F4GLF6mIyeN4pIto5ktmBikWgyz8AEtrIFII?=
 =?us-ascii?Q?Z09++Jdl2rRyDR8EmoCW41wCXptoMBqLDr9udAj3YGaiiP+ruHnP5+5BFGWD?=
 =?us-ascii?Q?CpPyfYhqpwkt33R7/cleRUCsSaACSDp7HKwI4VxekeUNcZXl4Qex2S2IPtob?=
 =?us-ascii?Q?SAgi91lKIK6pVc5IWVbIJr4w7Xa5WWL0CrwEdg3XyAALUYmy8yiNNDKAYE2R?=
 =?us-ascii?Q?R50MNKd1g9ELSwIp+Zi3hL8T6xqwXSOK9FIYk1u0au6tjE9AZlY3eu5gngoa?=
 =?us-ascii?Q?ANbCXYNgpqY5mBV6as7J0163rTXCsj1mxwFMq0P7E4l6HZ8PncVlh3Y/Fzlw?=
 =?us-ascii?Q?L7p26V0xsdtQGkVlo0mWOVjiQGwUosYedHKJoONPiFcV8XiUch0KRjGiXXVt?=
 =?us-ascii?Q?HmNzJriSw01gd5EAbeRiqXZFNMzDA3ux3F5qditMKyn56KLO0oQY39EcpxYy?=
 =?us-ascii?Q?lH6WnLs5Q8UBCmy5yklAiclTzu3GImzuz26nVzrQvQ8ycZjiCDDh56bW2bSV?=
 =?us-ascii?Q?zP7FdU8TnX1d3frk4hSkvKih2EWbDRxp34+Fm6TGdUBUrxuD8pyq5JIuaDgV?=
 =?us-ascii?Q?UrjlOMzJbKO1u/uzQlM2hUqdKdbgEP4ZYvt3B2XsI8oCzSYHJDhsLsPR1qDl?=
 =?us-ascii?Q?5rXAhS0whme/h7zbaiQoZWWO2ggxqMUv7YQqr0Mp/euAwW+P/y783Lx3kCyZ?=
 =?us-ascii?Q?nyTsCop880ElfUVmhtVWMtc2A8SGrZhbXyb+I55bfH14ixVweVp5drG8bMk9?=
 =?us-ascii?Q?q8FfBKXqxEm7/mkLUZ2WT+kELScYgtuk6TyEgxS0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?i4sfSQBJ0n1UUEXzEDPpakbk3DQqo0q2X8+0GMc4UGGm29xSFs0Nre663/vY?=
 =?us-ascii?Q?KmlgUNMjkLA3Nq5bBSOwfbr3BWWcmoBwXuVPv8c6gUg1ES12uL/eUtMfO4t9?=
 =?us-ascii?Q?wmZkBqAh/K+TI7GnQqyg7pz6UEIBRHRrS+M/g0n2ZIwXDHANb30nt/Njwkww?=
 =?us-ascii?Q?Dd4JoamgrpaHWG+edT4OT3mg4qbHL6Z0A9sLNOSlWWfFN3oe5Xro9GXl7AAF?=
 =?us-ascii?Q?DKnyRntf+dz+ie2mqYxbcRwuuK43aVFvaj3trqxJ0KcRiD/moBpo0vbX0WS5?=
 =?us-ascii?Q?uD5lvzQPo9nhjggmeuU3o+jbw08P83/HMyBbBGY0Y2KLYDz7gC7kYOLmHJ5j?=
 =?us-ascii?Q?KW7aaLUQfX2V7yzOuiCWC/81tLezL3+gDi0lxcJlMvHXl91HVwaJ4MUTebMS?=
 =?us-ascii?Q?f7y3Q4x9eW25k5bjy0u8z4plJ42DRV77/tdLaQkbRVxprnEgRrvIpK6Qcc4+?=
 =?us-ascii?Q?9ITqbIvzmd2ndPzi6AVnFR+70e4O4FpsyUDRB7gehQkvdqYaUvfd4PQkubds?=
 =?us-ascii?Q?+4sVRAHsPsYY0G+wBXkhd+RjNfRV/oRdaxRkkAK67SIe7TT6TSwRoaGffJoP?=
 =?us-ascii?Q?7TJqhCcfvQAGvM2Jt/9+sDaFoVr7vxqcj5S/Cw8KZJrT34tT6JAo1VMWKrqs?=
 =?us-ascii?Q?tigLS+XUzTis0GquZ4VHiLdWLP3WUvsFWBfRIlTLcffueKT859GA8tFMZtZf?=
 =?us-ascii?Q?s8oL8pEDU6h/hwNmUrrPa9Q6pMrUkHw9zbP2sVx5jyvIvEo5QhAUd1hHAr3d?=
 =?us-ascii?Q?N0SwqTLYgEIaFdlIziC199gJY0vQdlyVKnwcLC88C9r0RN4ZYRjCF/NTOtQE?=
 =?us-ascii?Q?fzqJTag4ABrvrLH+qy1EoMI7uxj2A92wB8IV3U1WoYNWJTgnl+bkxzRq9k6W?=
 =?us-ascii?Q?+DWkeWq3L8ZVdArr+Y5kJ2U9hBd2n1/tObrA9fvlPa60iskyLrVdv6vUfhIe?=
 =?us-ascii?Q?rRwubbYhGQFSL995TAOyFaorBUS4DJ7TW19f4n0Q7WsGx+jJyraUBtyzYeTi?=
 =?us-ascii?Q?5lUYeSUtYY8dbOPE3FYTe0nkEKgO2F8e2jGDGdVkHHv1B/4HOHBN2gxpt2M+?=
 =?us-ascii?Q?7TGAj0ISDaN4EabDGCY9UafRWDZJG8rkx3HzzId+4A2r/ZWmhNBYR+Xej3Wq?=
 =?us-ascii?Q?Hf2xsQS8Yu5W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2e7ff2-6ef9-4e48-87e5-08db4c05cd78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:40:01.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxZkoz+RL9CWELov2nC8CuEQutICvGNu4iKClT4ys0K5YSozem+TnTAytkvgYCE/3i6AHpPwyE84C0d4xvODjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-ORIG-GUID: IJFcth3jTV0HVgtkO27drV0DEN3ks5Mr
X-Proofpoint-GUID: IJFcth3jTV0HVgtkO27drV0DEN3ks5Mr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also update block layer request queue sysfs properties.

See sbc4r22 section 6.6.4 - Block limits VPD page.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/sd.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/scsi/sd.h |  7 +++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4bb87043e6db..8db8b9389227 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -876,6 +876,30 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	return scsi_alloc_sgtables(cmd);
 }
 
+static void sd_config_atomic(struct scsi_disk *sdkp)
+{
+	unsigned int logical_block_size = sdkp->device->sector_size;
+	struct request_queue *q = sdkp->disk->queue;
+
+	if (sdkp->max_atomic) {
+		unsigned int physical_block_size_sectors =
+			sdkp->physical_block_size / sdkp->device->sector_size;
+		unsigned int max_atomic = max_t(unsigned int,
+			rounddown_pow_of_two(sdkp->max_atomic),
+			rounddown_pow_of_two(sdkp->max_atomic_with_boundary));
+		unsigned int unit_max = min_t(unsigned int, max_atomic,
+			rounddown_pow_of_two(sdkp->max_atomic_boundary));
+		unsigned int unit_min = sdkp->atomic_granularity ?
+			rounddown_pow_of_two(sdkp->atomic_granularity) :
+			physical_block_size_sectors;
+
+		blk_queue_atomic_write_max_bytes(q, max_atomic * logical_block_size);
+		blk_queue_atomic_write_unit_min(q, unit_min);
+		blk_queue_atomic_write_unit_max(q, unit_max);
+		blk_queue_atomic_write_boundary(q, 0);
+	}
+}
+
 static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 		bool unmap)
 {
@@ -2922,7 +2946,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
 		if (!sdkp->lbpme)
-			goto out;
+			goto read_atomics;
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
 		desc_count = get_unaligned_be32(&vpd->data[24]);
@@ -2953,6 +2977,14 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			else
 				sd_config_discard(sdkp, SD_LBP_DISABLE);
 		}
+read_atomics:
+		sdkp->max_atomic = get_unaligned_be32(&vpd->data[44]);
+		sdkp->atomic_alignment  = get_unaligned_be32(&vpd->data[48]);
+		sdkp->atomic_granularity  = get_unaligned_be32(&vpd->data[52]);
+		sdkp->max_atomic_with_boundary  = get_unaligned_be32(&vpd->data[56]);
+		sdkp->max_atomic_boundary = get_unaligned_be32(&vpd->data[60]);
+
+		sd_config_atomic(sdkp);
 	}
 
  out:
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..bca05fbd74df 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -121,6 +121,13 @@ struct scsi_disk {
 	u32		max_unmap_blocks;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
+
+	u32		max_atomic;
+	u32		atomic_alignment;
+	u32		atomic_granularity;
+	u32		max_atomic_with_boundary;
+	u32		max_atomic_boundary;
+
 	u32		index;
 	unsigned int	physical_block_size;
 	unsigned int	max_medium_access_timeouts;
-- 
2.31.1

