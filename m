Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E837B302E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjI2K3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjI2K2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:28:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA46CCC;
        Fri, 29 Sep 2023 03:28:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9Tna022482;
        Fri, 29 Sep 2023 10:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=KtPTSzdcV8V8QQwAZsysfSVzMBIG6Bu0nf5IFfytxI8=;
 b=fbAcyR22Gc1LEJvKVpaHJe3Q6/hoqm/NKgqPAJ3VFwxbJBIB59xVdwgcDDi1EIb0crK0
 6j9u1L1oAo8Mx4E2k0yPeFiFvSVU3HR+ybXL6KHV0t2agnJriPaFry5lhLiyec6EjJ0I
 3MscpDiFFU33v+B6zCiUWEtj5Y6+EPRdDxfM/U5+1wYL0t+6eo6Dsy2Bg+HnvOIO8BQm
 4B5dtKbL0h0rJ6j7u6xkUwnzSVWDfKTJTyiffLaxm5/3m+BCvTU1rT565m5Jl/flPJpq
 KiJscQQ3PidyT9p/ddnrrIxaw+mU9Op7I7OfBLKd7sW1lfQwnBXFpy1akJ0+LpkPf9iP Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbpbqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TAGM2H015792;
        Fri, 29 Sep 2023 10:28:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYQT0UCer5IyodTj3Rer5D3z9gJ+fvYvnAXgV1t9tu8BP7XbQtf2En5rr1dGAc1DOYPHfs/dL2wTuJ/f4PS6BSdMKQgDvuEvPuG04FboMz1ePWbtswvz1f25nEHq7pclz9LPiAeEvM/1YNDU8jgVSX7ayPv9/dktezprQc/LoxFHQYY9M7GBBZ33IUmxQ4TnH5D/EdprQBUyrIf3B/xkg997u/2wVcu64be66OyEWrF6o2wbK+Wr13vb8GGwuLq6V7BgmTPnqp3YEKtzWea4ExvU+MayT3QhdFRTGf/owM86mv5aHvA2tEJounlD7tDPGtlBLBYuT158MWE1Y95Jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtPTSzdcV8V8QQwAZsysfSVzMBIG6Bu0nf5IFfytxI8=;
 b=IISIWmrpMBGdYk6kcfik9ScQUebdswEZxAH2u4o1To0wR2z9WOFqHGz03eFkx+kkxscmQTyZVZs45d6No9mYE5PDKVt1hz4p13qVTomG7/Yc3SsDFW7zk/SiIFHZY6dpSPSdOJ+Is4Vm34LFNWIUZWD0JRBnQFhZs2sfQL2+DLVSu/EDa9OrzoRmyetC13NK+8aIWCw2Vsw1t5Qxc87QNdiHV7oOQm0V2I6adlKc3oWV0cgKVSQMQgvrBuxDQtPDVH0cku9kddnNbALpCFLc/Jjif/fgbO+pNz97zrow8bh00SNB/kQAPgB73lYMwaRYM8Q7/PPTZu3vacMF1X6t/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtPTSzdcV8V8QQwAZsysfSVzMBIG6Bu0nf5IFfytxI8=;
 b=seTKJA7iNTc9HVamUYyHNfw7HLcZhQPxRSJYz2bhFM77d+tNF40PhK1gmS8vP5u2WLDghSRFURDdxn5ZeLsiw5plki9ewWEsMlSxapOCxsvIy8kmcEvf2gV085iz6N6URNRtg29Iz6f/Bne/q5hF+gJDA6Adc3S1tyw77u5Y9n8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:04 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 04/21] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic write support
Date:   Fri, 29 Sep 2023 10:27:09 +0000
Message-Id: <20230929102726.2985188-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:510:23d::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2caefeab-1db7-4013-d4b5-08dbc0d6c3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XojNLjQp2KOQcAocMMe8sZveVdkIUVfR7l1kS0pLwLGm0sj9TNH7IgItiEfzsbW0hwBPda6pEZs3JD3rRWwGlfzuv5FMZwWmOR6M/RJcrqI6g1bUOsLLH0z7DqoIlBexi1ZwTCMEytsqZ1WL3OPcZQeHbv15tBmr21xliorQEpZl0tO1b1v74QOa3xT0Q1eNVsLTt58Iy3l53HnERdXBL9jrZ8ireZpWp6vJd5c1WBwcrbNSQtKlWr/eid7buzWfGHUV5M8yxxhIJjSDRQzbSo6omvoOavA287w28p6rOBRg/oWtMq2cywHfNnjBZrOgMFu3P4uSD3x/U3hUpvjUmmyqFRNIIaEcYnaVJ//GVY3VjLvy0cFfg6NFc4zjVOJ4qoRFltO5iHIG12R3c+G3gAYQX1w4xoKm40zNTfGaebWKcL4Zs3va0uHDjKzoj+RQfnvEUZHMEneTq3bU4Arlqnd+OXmHQHxKe6OeZdFuhw4Yp8r+xS2i/1QXn8TB1l5zKDwP+bm/MwBFbIK0j4nkvw8BgFhfKu05zQco5wIeE3U9TH+rvhoTM6Ob2yERVKINhuYDIpv2vNh7SQ1h27OOO4CNh/iZrNS3b1iYEv5Sx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(54906003)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WIdeYez5Uw+UAKTrFEnomzrdo66dNnWBhwAP1CvfJb4zLoS+WvzvueuflCgo?=
 =?us-ascii?Q?aHb981xbWXSUlmjz11QkC5JbSZV1sVZThWst8NpavaPhn0WZU5vJEWAfCKUK?=
 =?us-ascii?Q?q+FPZHaGjhfRDTCcf6hT4Bv6Pp96bYSj0FnBWreLocSnyVwqga96wcorURdn?=
 =?us-ascii?Q?GZyIZlVcUGC86biST+hb/b+F2eNA326251TUTv/VKcnDe7/wMw57hgMVxT+r?=
 =?us-ascii?Q?w24bHd+Pyw9M6rgFhfvfYOwYCx//N0Q20KYdIA+e0Idn/2iqHHD214tfgaT5?=
 =?us-ascii?Q?5pdM9NP0hjMqLVk1DxQbL2l/uStHLDZ7bHt/1yRwNZ3OFaBhDUGg8rmUNJ8H?=
 =?us-ascii?Q?xbS8bE6oBf8Y1XUacUjx80mQe6mX+dLt+YtPHXpF9dZDo1HsDDQ0D76hfG+L?=
 =?us-ascii?Q?nHd69VOhM6gbu8WDzVKIm5NC1aolmishV/jn3GiMrwRCvxf58tiG0yUQS8X6?=
 =?us-ascii?Q?y+r6a+GLvUTPFN3PcKxTMpj4uB7C8OKWMnYgQPVu/5enIDIbdaRibzR2v4s4?=
 =?us-ascii?Q?EYjoylSTuSyO4GPOTgPuZso2VHVqVtkN0oTMYbcGGx68fY9AXreOgCyYUZ+L?=
 =?us-ascii?Q?91ewCahcg/V0ctLMmZwBl5vZ4upJsL9UYWIlZwedARdvOY0NeGBIxxGZDWgo?=
 =?us-ascii?Q?xwv18nVOtrod7vB7MxPoTZrNPD6fBVxwxLUO6e4eC860HPbj4UaMoC3d32Gg?=
 =?us-ascii?Q?4SozQi7vVuFMM1t1C7VAL/B0dN1/B3c0tio2InrxVyEbpS+0EbMu7HQXVfIf?=
 =?us-ascii?Q?skfgHqx8GTg5UNjB0mWiJjWA4p9Ld94ybz/9GdDKg7PXAt7Psargyj9d3Vjg?=
 =?us-ascii?Q?yl1yjGLylXr74LitIhoN79BarvzMiHnBHlxex9/vR4aOmqaRaFAdZ95T0kWf?=
 =?us-ascii?Q?BQZ9hi1BSdgqPgWOKIvT0wOxrhEUioBGudJi4Xz1rZCxHmMXE7rzyaORkBwq?=
 =?us-ascii?Q?bNDunUQ/FF7HOLWEHZyxWJcd+EEzAu7eA/a4yJU7pVPcepPIpsYLt5yurvXx?=
 =?us-ascii?Q?pT7refFlJjP2ET6CNPFtFfyrfWIul2r4YqgQfS4kp0x6ptgHERy3iBGrZh6D?=
 =?us-ascii?Q?1kTuZsQeQy0MmN4iOtdFvrLtEV6rbdLkBY9PPoOLnXLc34b+WXkQrcXXAiMx?=
 =?us-ascii?Q?kLdZsYrfxvsN+GsCgMJq6y8M80UJ0Rg4g3g1HsnOFBDWdlvHbcWAL6yADbrF?=
 =?us-ascii?Q?rWBiX9qrj/Rdt1NvMV+IgU8P1nsgAOz9glmAxbsRu0ZdS4lo+uTetVDvkO4Q?=
 =?us-ascii?Q?jE0JCYcxnZggGLNSZmYrp+XUPPIwfxaFyEqGNoZYodvZeWDE8VIejsaIfcIZ?=
 =?us-ascii?Q?SpQPtha/ryUyCC2uy44jlkHfX0IxUceEB4v5HXi3Oip98Q3uGyxbQkkcToJq?=
 =?us-ascii?Q?Dh86CbzS4KGOwjxVgTfvtPPq1Y7HXrMETRm4qiX0/hIcaZ7UEshX2RVK/sRd?=
 =?us-ascii?Q?hVlE+JEuAsmixfzHd2XIZUjN+qdmvocu1jIWIm2z2+MdGcuOqdVUeaagHo/N?=
 =?us-ascii?Q?vpWs0MW6fuB8JgDandY0CHiwN9Na8PHXx6s+0WIgX7Yf+8GEtPmVePpe63fd?=
 =?us-ascii?Q?fbowJN36INMLiPUopDbW7oDIme4VdpoS+luIJzhRR+xOyYwIr5X2wJ7JAg9N?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fwzMv9JcOmV/uMdFDZGcDqpTF5evxOQCqYsWfZKnczierXtTYGpRChHQzpxI?=
 =?us-ascii?Q?ojUjilwvnhzm3KdgK5xWfkr7R2CwBx/Dr1TKsrBxG7wHOO/X77M9xsAKLa45?=
 =?us-ascii?Q?PNXHZ0SCpkNpTtfzzOHXhoKURL6QjaGbBAuEcFIaqkApx7QkkK6Kde89mSJM?=
 =?us-ascii?Q?sK6Io9FPmn0pz4+BQRuKitcURiJQysDp1lQOvGf+9kPaNFUEY4P+OvrPDpcE?=
 =?us-ascii?Q?MeCLw7D0jhbvUKa/u8Zj6bEHDoGNJeDsDa52lYFy+uKUcj2d0kKBybaGJm5+?=
 =?us-ascii?Q?UPNqVdj/ewWFydtyzhCcyoHbtkNnrO70oXZ0YsJ8V2m74QsNYCl2PqSIvEX9?=
 =?us-ascii?Q?u+sw66nKp5p980nnTgsLvHRSx007pHLV5kXQf7GkfhLHIMT2NqY37h86UKDf?=
 =?us-ascii?Q?h4BG+tpEULKUdISS8978w+0XDcPZcTR4jiXwXBPaNVojTah8T8/nUrWvlNzY?=
 =?us-ascii?Q?duVB68yKaSnIRxkHmmTZpU1YEKGuvilp3aDen7awt+4h8Z9n5lQYTdVSzlnd?=
 =?us-ascii?Q?Y58OwY/Z5MXSzaceOrPZaK2agq4se/NT6feAO2JH9gw5ARVTZ5fEtVKJUm63?=
 =?us-ascii?Q?/JO1h7Yzx4jwN5rXagzZ5cM4ZVjUYc0FMU/XwiWOUZ+BfdZ6a34UJOZWq3g9?=
 =?us-ascii?Q?R3Be3evdR2CKE+Aa+p3T7rdycmlU8e3eRu41QvgcN+JzYBQO9BG/TBq/TqQ/?=
 =?us-ascii?Q?gZRiVWzIjEYKzjGu/4VhYLnaEzHNZ8qnK8vhUoH43rkghir8nhzr7l5SR/qy?=
 =?us-ascii?Q?nbZUuxVG5qUXFPo+2N9vBJwRzKXBuf4BLyWkcVPoOszLEmrsRpbEAE/5eFbn?=
 =?us-ascii?Q?CyUaqZ99GAdXayCclEXh7Ky5A/EouSYncRKGV+se3dDxN5DoWLICxfM/qTsB?=
 =?us-ascii?Q?/Cb+CutyvdrT82TletU6p5i/5Rlh4l9LOsl0KnN1U6M2LTKoR8en3fcQ0Sy7?=
 =?us-ascii?Q?c8EhltxswRhrbeO0jAto5H21DLyQhcNxmbhqJfWXxSu/n74OjQt2mSVFF/BO?=
 =?us-ascii?Q?/dINIMjmXe7phaI6+BLhrEVVY6ntQZPOYb9zb0b6Mbc9VS3SK2pV6/RThz55?=
 =?us-ascii?Q?fvF/E+iXj+zAxOejIhNgf7r0zvhDGg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caefeab-1db7-4013-d4b5-08dbc0d6c3e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:04.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /H1OEu1u3OWtgisvEf3u6ziR8hG9z5qbkMp/okR00K3I5OmkiUUj7sGKwscMqqVA387xDwN+kRcFVDckANa4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290089
X-Proofpoint-GUID: q17oT2fE9g3F2plciu8-Fk2NJ9yyT5FA
X-Proofpoint-ORIG-GUID: q17oT2fE9g3F2plciu8-Fk2NJ9yyT5FA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Userspace may add flag RWF_ATOMIC to pwritev2() to indicate that the
write is to be issued with torn write prevention, according to special
alignment and length rules.

Torn write prevention means that for a power or any other HW failure, all
or none of the data will be committed to storage, but never a mix of old
and new.

For any syscall interface utilizing struct iocb, add IOCB_ATOMIC for
iocb->ki_flags field to indicate the same.

A call to statx will give the relevant atomic write info:
- atomic_write_unit_min
- atomic_write_unit_max

Both values are a power-of-2.

Applications can avail of atomic write feature by ensuring that the total
length of a write is a power-of-2 in size and also sized between
atomic_write_unit_min and atomic_write_unit_max, inclusive. Applications
must ensure that the write is at a naturally-aligned offset in the file
wrt the total write length.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/fs.h      | 1 +
 include/uapi/linux/fs.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..898952dee8eb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -328,6 +328,7 @@ enum rw_hint {
 #define IOCB_SYNC		(__force int) RWF_SYNC
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
+#define IOCB_ATOMIC		(__force int) RWF_ATOMIC
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..e3b4f5bc6860 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -301,8 +301,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* Atomic Write */
+#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_ATOMIC)
 
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.31.1

