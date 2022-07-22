Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9515057E5A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiGVRck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiGVRch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:32:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B279688E1F;
        Fri, 22 Jul 2022 10:32:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MH49EN003973;
        Fri, 22 Jul 2022 17:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kIRdjKv2grJcepnOGjbhh/xATu1BaKwpHGSzaIQdIXU=;
 b=egTen4op7lUwtRotRz8YLAwcSNNGTW6/OqMlhqmVphh6aF8/OKH7yDPQnc7dxKKywx/R
 dnNc1i3fUqQOLX8fCvg0xyd7YissanMGBuKyDH+EAauRegk98Qb1Cc1jb/LpvJssegUN
 NaGkA6uO36YocOH0fq9QQSDE+D/OV/6rocN3JbkksF/aMlM+FvIKBbyH28FlT4Nl9yB+
 IU5tj4+iQFW/ELYyJQR2iNhmC6vuC+q/VINxb9mZdlXj+vHtXkKEmQ/cDYS8yKzCcMED
 Jg9uDvwmZLKB0RLa1YhnIGgLLVTlikmxF3TjzwB9CWOfYyHpetyO3U00XXq2kakFWBwo oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsg31c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 17:32:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MFX7s6022155;
        Fri, 22 Jul 2022 17:32:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hvc2n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 17:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl+6f3sCMG48B7rCVJuTdYJMfuGXsqiPOo0n186+Gha6SRBMd9hrQXnE8sccq2i52VZJEbuQdqpUnmmmzWvEJoJ8t2Z7R0rxBcn/FpQr0W5pO55UxClN+y+5GVowB3w9W26W7mfoJdAA6aoasBa37V8XC8q6HB9vwgBKP/PoplghUnWcdX1DPTh5t2PBFvJSGIv9ODnoyDbqUFc4CXU61WXeMwYoE7/YPKadAVKcxpeG5qDzAyam96c1EEoPTx5y4iw6fxHPgcL3+olPg8K4jvL6vpg63bytTddiIT2c1wcvRdQqUxe2wgsBchlvSAyt5c+vLGjcgKVLOSwdUBe+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIRdjKv2grJcepnOGjbhh/xATu1BaKwpHGSzaIQdIXU=;
 b=gwJGjRccyKcCmkq2RbLYHIyRCTvtRIOGvPdntqMwcQ7m0fhqCgrKH9EZB6b3bRW/cCoMdFzBFHZFaPMlaB+Toe5yfCxZhTFAfCePpiR1IQ1tryVzvbJOruw/xgJoRPr0n5JR79kmxBckhMU17EgnxZ6tUFgR0+SW9HZC5k5oNGB6O4ucNZ6lk94Mp4SSfMP89TfXc4WALFKJOzMg1DToNuIAGCSrO68WKXcM/84TFfNjPzX9KHQKoslcMCXHy1jvRnAS8201VhamDetoByYzUq+1Hy/TZveszSRiHxLn4ZlDKPbkwpvpbsolKcpOBKSFdEoCr9cwDkO+sEqupSUhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIRdjKv2grJcepnOGjbhh/xATu1BaKwpHGSzaIQdIXU=;
 b=e2R9Ay+3I7Ehn6di08SHLci3Q3rD6mi2D70LHsDaG0lqzzrTy5W6Kp7Ht95sQvxYOwK+cqxl/OS7wWP3nEMC5IEVrNVKymDqxd6WwsWWIe0AKtQigjijVvbuD9nD3lqqO0juiFkvpChNqlDnhnpeVNgOvQfn//6fuPgKT0yUOxM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB3828.namprd10.prod.outlook.com (2603:10b6:a03:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 17:32:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 17:32:17 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 2/9] vfs: support STATX_DIOALIGN on block devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a691jbou.fsf@ca-mkp.ca.oracle.com>
References: <20220722071228.146690-1-ebiggers@kernel.org>
        <20220722071228.146690-3-ebiggers@kernel.org>
Date:   Fri, 22 Jul 2022 13:32:15 -0400
In-Reply-To: <20220722071228.146690-3-ebiggers@kernel.org> (Eric Biggers's
        message of "Fri, 22 Jul 2022 00:12:21 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:802:20::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b3155d8-149f-47ae-e0fc-08da6c081fd8
X-MS-TrafficTypeDiagnostic: BY5PR10MB3828:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWiuquTR3OJEVeCHvbwZiUflfPOufbxK5P3SIWylj+PQ8eJh+b5T9oH4oKQTwYgTqFPMGGs+sDpxnVHKWIsA+uq67Clx5A4tx7WsAogkJUTAeOpae5BbO8ryM8Q2Xtw5AoT+xTWTz9yqDX0JDPF65KQvtp9zP6ZF/9I9u8WpQChey3qT3OBPugb3E95fJ8yTtmwMgxLpeUuXi67UHeJysDUWos9/LIq7Jmgn+FIWAamy7kQP46EvoQphye92AuuDiZ8FABMtkmYO7CneRnnJbs+G51IHIt43iLd+6RTQepKR6mTI4oT5vZDdMQLIz9LMrnjqhs3O/LCfvVcjhVLomCIXpbl2QVEhhTzfJTy8ob6sxVA6Z6cBqm1hH7y+mlBQw4iF1STjQMmmC8ypwOi7a8rwsekO7w57z8RRG8libdVvkeqzVz6WWKYkxSTql6kA8f7JkNg9XExdNjiWEALZ5Xh2uksjS31oFujIEtXieSYqmYKGz+bmddu06NIfooz3jYpJAIEIEgrxHBl29dT74152lKLfn8ztPMw/iYW/2JnMcWlbHYRNSQizKzxHPugxmMYd1TC+Mb24GfzUfDeeJ3iI9Ak/4Cty/3X9cKGz4KHzL9hNIWfI9gct236P/5XPonpM7/JegPmtfq4s+5QDPza13WJFtccFAw54ARGwpcnPEGVJygR+YR6ALi75H1laL8AYD+VzxBZwYjZ0E2G+yyfBo7A5UFpV6eDjko3/eJB9M+7+ZlAGiSMQjuWHRqnEvz40pyA+JL4hGrjxh7Zch6kuqDMAWHvBNIp3R9yHjhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(396003)(39860400002)(366004)(6916009)(8936002)(4326008)(7416002)(316002)(8676002)(66946007)(5660300002)(558084003)(478600001)(66476007)(66556008)(6486002)(41300700001)(52116002)(2906002)(6506007)(186003)(83380400001)(86362001)(38100700002)(36916002)(38350700002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JF7AhlgijuafUyklmcNs0IisBDp2o9w3ggxK7KvK+FdSqKTqeaFt61zJSTvY?=
 =?us-ascii?Q?WRiEEJed5SUiqTSpuF8SKeu19wXqUY4KJTHCu7+tYZBX2zzRwCyqB+t4OAgB?=
 =?us-ascii?Q?YgqYGISh7yUabxMfjy+DM/y+no3kbQUqZVpKbsxCz1a9pZab6sQ3O0GTaiqH?=
 =?us-ascii?Q?xpoQuR0S9TKRwJWcj36+AFzCh6uP08GK9p2z7qG19jVDHXA8ZEtLt6AtxKr8?=
 =?us-ascii?Q?nV1epFXQke3Bbw6waTN2O5Nm7ppQuuR3H7FuRyQCGN3UP0Hiq/Uhe0S9Vg0g?=
 =?us-ascii?Q?sTT4ssy7/Wvo+8nZ7p7jSsMBzH5MG/LA5YwPd88sZjAZu3EtdCkonpgLSASM?=
 =?us-ascii?Q?Tyk+muZOpAbyO/OEyjUFJ1dgnPBAKEn1U8rYQjy4fx2cgE6QVl5641h9QGbN?=
 =?us-ascii?Q?8U2ieMrkt/ieOs5umYyPyafy77N2Cc8GqHzDC9/fMi72hwTTQKHPuHM74H+E?=
 =?us-ascii?Q?2Fd+PBhdi++TkpdxyWAFBnRNJp2jCc7Txlm+N2f7P982H7vKPNCtKcbCIT62?=
 =?us-ascii?Q?qeqDbAKqr4Aldr3OpucOVZnMbnjYtEZp9xtBbZzO3AGESBiLOotSn3iNISBM?=
 =?us-ascii?Q?QQYxc9qn/x9bhDqEbcbmpsioevEcCf1fILnbwxqG7DB2I2lqhg/tnNAUUGYk?=
 =?us-ascii?Q?aPoqqUblkCtLN+cZcnL3St4YPxQrp2JjH5z4EzfW6Q93ohXL7gJaucysHuoU?=
 =?us-ascii?Q?woZkt8KD3clb0kgGmURApBY9haMVL+GW2hnNoWyytFcqvexh+BILVP23+pcK?=
 =?us-ascii?Q?da7mFz+cNC4Lle88C1lNOL6oTyVV3WeWcXQm6uazE04F1ZynkClPIxoDm49E?=
 =?us-ascii?Q?0f1K2t+arwEm1Bn1kAdKEwDoRyTEb4HZBWAEKPv+Q0dMWSkgjhkQ1Np0fziW?=
 =?us-ascii?Q?Y29uSjKa6d3S4D/SoqNMqZNYi8gbEgnW5lTrtqbB8xe1kC4TTEGvXA/v96Wb?=
 =?us-ascii?Q?18vube2RAtW21lOtZt0YmSX24RIPLvs6zCL9K52xeVU8G0TwZF6SFxCMkNRK?=
 =?us-ascii?Q?/0O7RWpexYgfdZ9yxPTiPzMJdR6mwGq9LDQvgYMhJ5k/KEABQvPvz5Hm77gy?=
 =?us-ascii?Q?8FMCSlrC9L+2TkiqJlkrvY9RWbpElyoOMD3KO6+Ud62XTZHcKfimqCUhKXCu?=
 =?us-ascii?Q?gJAFb/EkYQGIrNSDvt51UkUC40A3nh4xrq1L+ynFGAnFxrLtlwUhrizQUiDM?=
 =?us-ascii?Q?1hjlACunR1GaDN6gcGwq+SavuSkz2+lPGTcLV9ZnxNQ8FWFx32LKMFssOFX6?=
 =?us-ascii?Q?+ZoUVhHGrZoF86u361OhD8cXXS6uIcx/VL7JydGb5nnriZk3qRqeYzV50eD2?=
 =?us-ascii?Q?MiPLK+jBMKRPrY9koMJR2LwuIk7ExXs+XSp1JmB05rJp6MPvZBUQ7F40+FMf?=
 =?us-ascii?Q?FnJ1HEvh0T6fAKTUAeMHPjxxPJNUSCrQabyJYSQylTNxj8gokq31+eYCk/Eq?=
 =?us-ascii?Q?t6qmddTnYkqy7qEkR8TBVldcnWaC3y4pmHsvVMMfeMcS6Io30mqsmfuBaV1n?=
 =?us-ascii?Q?Uo4aM3vivvh7HkK15MLQebBVY78vIzIMy0xg3GNMRwRQg39d4XrThsADalUO?=
 =?us-ascii?Q?Ls1bBIQWN7ne7pvX3o99l06kw5Wqohl2mQ55AxKUS/cw8gz2QuEv0lVd46oA?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3155d8-149f-47ae-e0fc-08da6c081fd8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 17:32:17.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubCrhKQpUGAPvTs8PlzIH5CqAR28GSd2Qr4nqnlza2dfGnnAndM6eHVOBjxROavxr4vpsfBbvfbYNWZLfgSkf0xKFaajyrkUs/fb0rMiblw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220073
X-Proofpoint-GUID: U_fLovPyCSjB9GGjJ_AynAXVQ9nvCZjH
X-Proofpoint-ORIG-GUID: U_fLovPyCSjB9GGjJ_AynAXVQ9nvCZjH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Eric,

> Add support for STATX_DIOALIGN to block devices, so that direct I/O
> alignment restrictions are exposed to userspace in a generic way.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
