Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C26F5F99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjECUDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECUDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:03:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4777DBD;
        Wed,  3 May 2023 13:03:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HoZaE024249;
        Wed, 3 May 2023 18:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=6mPv6eOU8ryp+NvgTR5LIqhwUlXegmHvF4DUl/Hq4K4=;
 b=GjxhuqNP2CZniIyG9pYMxiFCsnnkWTSXcKNS4ZRrQtxQP5Wz15rJP8DeMaj5DOuAg3br
 ncVE/16E2Tlx70ToWPbvVf602+il4qNp+QoYFYysib8ZwYKMf8KFCdNAfVfcB6o1Ff74
 3KGA4XD4ivWwDuZ2lWTEde+JabjIMIMthhFFJf2fYz19qOTe1skDGuQKirs6s04stD25
 8dmM75lQXRdtOi6DYBm6odypz60EuOfrHLySneRMQfi9XMWbJ1019ZAS9nxMCJPZlclz
 PngMgkyyuXJMM/b4lnllcGlYeaGQL0GKV8D56DPT/t0/A9EXwNwRYkG8jdTExevwmixA 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1r3n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HABrT020757;
        Wed, 3 May 2023 18:39:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7g9ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWb+yCtC5ZDbfV1WM9wT0EhTXQpzTmiZmJFPUiYwaWL8++4S5PEenmgUNhFwhnmWU52qYdtcvEZs0SEd/r/vhf7pwD3686l2aHezaLENGk8DnEvHH1I2S2ig4LQT5+NnaNqGdmZSiqOwwKZMGZVJttKps9QxojWsOHYFGdNxxCjx+zLGNWgDOmkvIRQDkyAST7qVt0767QfLjkkofd/rIng4tytIQBcf9Juz0kXVwC/v6qJTLZAbY+/6Cov22E/h0uEeJD4tNSFrX+1MoTcT+1yY2ghW763hs8pYRb2M46d2UcQVJLt9qAMbQVI9FO+P+H8XdQxgdiaLQpT9/Tlazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mPv6eOU8ryp+NvgTR5LIqhwUlXegmHvF4DUl/Hq4K4=;
 b=PkMGWmRQs/2RxTmB+y/b+RUMa3ZuzDhBdRBMWUkfN2gF9r3KQGKRdNR/fH1osvLAFYcrSAxJfyjssUbMBG96WS9HJhv2XQCJyOKDn6jLmyIbCFyMkRjitg1wOtxMk6upYtatX0292ys/Rhe7Q6n4erQtfsuJXILBYWGTXQVIYCYkdNA5P/q6w8Uadw+u5Tsx6eccJBhNgkxbxYdvO4hwKplhnb+IdpHZsDJJPe1ymTyH7uAt6kqjBEhf/uKie3dXkKy66gddAlGgQQ5ec49Ez+SVXcxOmj2R8DSUKhqHC/WxLemAmYVCz9yytBrdGGA03dVeR2OLSUnJ91s2b/j47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mPv6eOU8ryp+NvgTR5LIqhwUlXegmHvF4DUl/Hq4K4=;
 b=GxumOssUq7/HDIt4W4xDG9K9nzTdR7EX3OTCHtjfOxG2tGTaS1Cb7kmkpYHtUvZA4yewJbvJ4Pst1k4lHFq7LE519m2t23du/JDQoT1Gi7MxAKko4Ix+Jauh3TLT9M7T5cpJFaZd8P5bUk32h/0hVoVwlfYN8dshPOhQS+nf//I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:44 +0000
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
Subject: [PATCH RFC 10/16] block: Add fops atomic write support
Date:   Wed,  3 May 2023 18:38:15 +0000
Message-Id: <20230503183821.1473305-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef1e3c7-8663-4807-d0d6-08db4c05c3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQXioYQkvS2bketECbnPbfm74H/oQKPZSTPz/mrCkvzOsHwjT9jId5rXwb6Ll04mg42J9My3kZutOB80DsRSSlMtIZjp4pttdBfjIlSCriwtpwJxgWYBasOUccur/815ScAiR8y/D1vrfRh65ACaiY/6ksLUNt1Nyi2Xcs4k4zjITf567kzqmyBvuJm7Ra+W+vmPITAe04f9jkXYi/lUrAvnWO3SNDBYt7+Zd2OzYVJea5hxORXvy9qSutCfTFADt/dv2jwI1S5MOhBcFpiaX/YR1FayYKmtMidfdtfAt3N9B0TVSgvsCqZ2hyF0PN6dXZthKoluifLasPkb7dH2lBvr8IjnFVsJlX503Sj70pd2MPxen7JyE6S0fEXEEwTeuyGHvMcCXncDlQcd4Ac2rwrJmtF5Yc7yGKDq998928OV0ZM30ZRRoA8d9T3RU8DWe/9dcfE3oL5U0/H8ryeL+Nbqx9mrcEwMRmy9dE9/PVHJojTVsX2VPHqUAGJHqzMazN/2oRzOAurwMnX6TR6iMaoY67QpUIPezs87EFDcVMOCNMQve35FD0nzXDKRmtbiwWc9vHajAfEJNslZBwT4GmJnIkC9/VmIvrVlayXPd0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUV1jHIo2jy0PL2FnjiNjv6SiOv1u9DdChFIpKtkESt1iwZ0lJDPY4AVPNai?=
 =?us-ascii?Q?f0UiwG4gfFsGupAVhsb+lo4AD6+Npr46xIiLwmQvLdH7coHERbCJkAD9Ab89?=
 =?us-ascii?Q?N2L9VLjrhNhGAYqtHu72Mg1LPrPWnPfh+h+DQdzC5XoJE50KxzQfNVoKFmlt?=
 =?us-ascii?Q?DqiH8bsSb1dhDTeFRFk9bMxS0jRD7JQKAe7oi/6/vVrs4t9xwSLoaQ86qQVo?=
 =?us-ascii?Q?Qy2EUJOHApXa1Tpquyyp0/sNQl0Od0FgjZjHjChUO9MDGdqdD+IPo03xI5Tx?=
 =?us-ascii?Q?tzNVKl4snuvcGt4ZyS2WUFGobW0YRU23QSs+llhjqly2A/+6Ufz2wBzp1v6D?=
 =?us-ascii?Q?dLnH6+PNkjtbcjn49q2X+5M2ZxYNY7QGSBUBrl0XszavlyPAwSEIgY364wL7?=
 =?us-ascii?Q?n2wY1kBY1vkbnEgBbWuptc0ek+6hG/p/VWuPirF4TwPY3ddHBHh6XPyUI1sM?=
 =?us-ascii?Q?qFlK785FNh9HQEIO8TayPSyZ0j5+taZFLLbcsV+09oTKQIVgmBzH3hi8xtVJ?=
 =?us-ascii?Q?e7yG+DU9SGIacfKouhz2JyDcEZ/YDS3zAAWkWxXUoCCWdTSO+2Tx4MS67cPg?=
 =?us-ascii?Q?BJ498+akjClpMDj/DDi8GDGh4BngGtlTQR9f8OTpfVgGI9OzUseJvYAltXhS?=
 =?us-ascii?Q?1pcf69tZBplfffYfTQXh8Z12larSaX85VMobcgdhk2PEuFP4L7ApaRrta2u8?=
 =?us-ascii?Q?LxRfXGECiJyuR/GII867++XKqj4JHOltTfT0G1LK3ZrEP95osOZsEQqG9ela?=
 =?us-ascii?Q?w3fl4EtPo+OeUlJA8wMhXdtX1JzO+ATkvNNRxe1wWHO/IzyugT5LhlOk5NrY?=
 =?us-ascii?Q?zbdoLiNC5+LjqktXcydNz9zTleI/FCBVEQMfuTRziqQPz62xteGBqUQSM3uv?=
 =?us-ascii?Q?0NxmlcwnLViBtfdtn2BEx/42FQ6Q0Z/214je9a3CKF+5d7iOCx/U8y60CZOG?=
 =?us-ascii?Q?5kprGuanHPw9uMlLuCKiHgARgBknmJ1cvZYQV0Zuxm9u57TJ4N2eoGwWBucH?=
 =?us-ascii?Q?sYO4liTSJpBsMyZMZfULMgkh+2PJ6Rfp3UWa/vRv1NxQN4jwy88g+HvbzJCh?=
 =?us-ascii?Q?LlDq9zdtponvvuquF5bOHN6ZEA3uq3c5NN8W2Gs/SB3G56L6k7omB4cOHQwl?=
 =?us-ascii?Q?9AKPr+3Dmr8MrEzC5yPeh/gopi5DYCji6LbEubMRpuPBq+HUYB1mRqQtapPS?=
 =?us-ascii?Q?5LOBfpR824TTnSyJf6lnqwCCz/zgRDH1+7ROW8mZYFA6T423YwsxGP1V5LMe?=
 =?us-ascii?Q?nn2qEGQUNxB7mQ9JEq6NxVVoxe4fRvKSzjpi8PAGWiLugMFj9F5V4r/wpB9F?=
 =?us-ascii?Q?c1HSq4wvg4NN4ON4KrJREC9w258KRXHVSwzdG8+mWlhY+PFKU9t+r6InTDxM?=
 =?us-ascii?Q?03PEtwnf5GNMPS8Ggtg5m5g6I1yJMdbNW05h62pP8K+mFmzbXrsLc/bzXYQ0?=
 =?us-ascii?Q?ofnwVgVv98GHGNj96OoWe0CAKLj/kXucSSm88I8qckSamOW72iA9MI2XYk5P?=
 =?us-ascii?Q?a1ZSmJHkWlo/A/LzV+UglvVmPptqIfrEzGfI7UPaZxXdDDR/dGrJqkRkUwTx?=
 =?us-ascii?Q?2AlTVQB0DetM1o6FIlNxkKmwuGp1YFD5X46cTzWK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cl8QuDRI0am97//c1FncTYNQud3uWsKZIj3NIKsOOB5yD6/pTW+s7wmzULtU?=
 =?us-ascii?Q?6zM9ernRTFClj0+P4vnbfGOcypVNhDNqXJ2X7tm/FHWBUi3Fpevsg5+NaJsJ?=
 =?us-ascii?Q?PEzaimX36LbwEIjmtKcfFbYFDdQ/IcjOQ9lmyhRT47DEj8et9wHdtDKxvrtj?=
 =?us-ascii?Q?hRPgJHvcXpeaiIVmpEAXs2iRO3sYAqIJqgE7ub9MIf74n+nUspzPA0xVr3bK?=
 =?us-ascii?Q?vxK3KEohelPleuefihUGFuRk4otp14nVKQJdrSf2QfD3WezDoxMOUBsdvtNM?=
 =?us-ascii?Q?KXmMMFB8+XzDqt1vqIAYhgJYsDgqR1syojk+E1HH0S/ip4N5oYQtKubTJytP?=
 =?us-ascii?Q?d3hv3zG+5VBvgI8HFqHR0sUy2HGyjsLryE3jEBc+VxNBAWeej+TFqXz/s/MI?=
 =?us-ascii?Q?uvTMGI+o7SLD1YYf3MyPNdGCvospLOf/8hQn1Gkn3kxOdsxzvir1OEUm3X0n?=
 =?us-ascii?Q?06PZp/ssXMTVbVWg+Okkc4B+x5QEDx2gxp/sFAbyP6E6R2E7usRosd86tFhy?=
 =?us-ascii?Q?JDD7jF6GhPij+IC0YC29AJ/88Qkgh9AyCTIszBmxAujTG36EnxdIWkmymyrh?=
 =?us-ascii?Q?0nXbUDfWzuIESUU/l0/wPPQXmcXJkZHODgS3GR9vsJJpJzEslckxWMiWa6uk?=
 =?us-ascii?Q?GajZTrhurZCGUZm0JbwZ/IX4yhDckQapdrskTRt61BxXekX3kx1smEbTpHa/?=
 =?us-ascii?Q?Uy2nNebTP287GVpq9BJGkqnFhf1b0N22oD34JvHjGxF9FTmXv3O3P7Yevwun?=
 =?us-ascii?Q?iXq2y2/UCjHKH0lV11nNRUwOvuE2CvER2jhdWpDS6NB3FsZoqRfTd94nqFco?=
 =?us-ascii?Q?gXLPwtZLX0GHJM3RVXUj877WrMFLCDahccOM8MP7p6QJV5v8WF0ZbmyY5ka+?=
 =?us-ascii?Q?kHljrTSmR6yC4TLGngv5OvM82OMV3YdHvhmVlq5VDTLQbj1rBQhV0DdQd6vn?=
 =?us-ascii?Q?UP4m+rH6u+llo+LHukS5cu121TEqWHyyf/uEASahdFcNGjavNDfjakVNdQCC?=
 =?us-ascii?Q?BQz3Q1EqWaNhCzEz5XnKPP0H1/qqRSlYXGJAqhowm++poICXt1mzVHHBFN/3?=
 =?us-ascii?Q?pdS3j4Qpg9x3Ue3VrlUYqIdpVUYzK0w9Mpl5qd16NB0dyJq5CZUgR1ybncRH?=
 =?us-ascii?Q?hlHY3swKpqvx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef1e3c7-8663-4807-d0d6-08db4c05c3cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:44.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHUTRoNIHfVZrU8zx+D6DQyhrxBg8x5CoXdQJQ4V7+rWYz8oijEd8qxKxL03/AF6fbo/zxtCIxuqBus6GtQAxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: p-bjNdDG3RxZgFULqNXCe-D9R7uDw_y5
X-Proofpoint-ORIG-GUID: p-bjNdDG3RxZgFULqNXCe-D9R7uDw_y5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to set bio->atomic_write_unit

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..9a2c595cd93d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -43,8 +43,17 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 }
 
 static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
-			      struct iov_iter *iter)
+			      struct iov_iter *iter, bool atomic_write)
 {
+	if (atomic_write) {
+		unsigned int atomic_write_unit_min =
+			queue_atomic_write_unit_min(bdev_get_queue(bdev));
+		if (pos % atomic_write_unit_min)
+			return false;
+		if (iov_iter_count(iter) % atomic_write_unit_min)
+			return false;
+	}
+
 	return pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
@@ -56,12 +65,21 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
+	bool is_read = iov_iter_rw(iter) == READ;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
+	unsigned int max_align_bytes = 0;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
 	ssize_t ret;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
+	/* iov_iter_count() return value will change later, so calculate now */
+	if (atomic_write) {
+		max_align_bytes = bdev_find_max_atomic_write_alignment(bdev,
+					iocb->ki_pos, iov_iter_count(iter));
+	}
+
+	if (blkdev_dio_unaligned(bdev, pos, iter, atomic_write))
 		return -EINVAL;
 
 	if (nr_pages <= DIO_INLINE_BIO_VECS)
@@ -73,7 +91,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 			return -ENOMEM;
 	}
 
-	if (iov_iter_rw(iter) == READ) {
+	if (is_read) {
 		bio_init(&bio, bdev, vecs, nr_pages, REQ_OP_READ);
 		if (user_backed_iter(iter))
 			should_dirty = true;
@@ -82,6 +100,10 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_ioprio = iocb->ki_ioprio;
+	if (atomic_write) {
+		bio.bi_opf |= REQ_ATOMIC;
+		bio.atomic_write_unit = max_align_bytes;
+	}
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -175,11 +197,19 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	unsigned int max_align_bytes = 0;
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
+	/* iov_iter_count() return value will change later, so calculate now */
+	if (atomic_write) {
+		max_align_bytes = bdev_find_max_atomic_write_alignment(bdev,
+					iocb->ki_pos, iov_iter_count(iter));
+	}
+
+	if (blkdev_dio_unaligned(bdev, pos, iter, atomic_write))
 		return -EINVAL;
 
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
@@ -214,6 +244,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
+		if (atomic_write)
+			bio->atomic_write_unit = max_align_bytes;
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
@@ -244,8 +276,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			if (dio->flags & DIO_SHOULD_DIRTY)
 				bio_set_pages_dirty(bio);
 		} else {
+			if (atomic_write)
+				bio->bi_opf |= REQ_ATOMIC;
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
+
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
@@ -313,14 +348,21 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	struct block_device *bdev = iocb->ki_filp->private_data;
 	bool is_read = iov_iter_rw(iter) == READ;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
+	unsigned int max_align_bytes = 0;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
+	if (blkdev_dio_unaligned(bdev, pos, iter, atomic_write))
 		return -EINVAL;
 
+	if (atomic_write) {
+		max_align_bytes = bdev_find_max_atomic_write_alignment(bdev,
+					iocb->ki_pos, iov_iter_count(iter));
+	}
+
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -331,6 +373,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
+	if (atomic_write)
+		bio->atomic_write_unit = max_align_bytes;
 
 	if (iov_iter_is_bvec(iter)) {
 		/*
@@ -355,6 +399,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 			bio_set_pages_dirty(bio);
 		}
 	} else {
+		if (atomic_write)
+			bio->bi_opf |= REQ_ATOMIC;
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-- 
2.31.1

