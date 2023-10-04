Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5E7B8897
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbjJDSRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjJDSRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:17:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BEA6;
        Wed,  4 Oct 2023 11:17:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FIl0Y021370;
        Wed, 4 Oct 2023 18:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=t5sOw9Ra8MR/4oVsCwXz9GWJ/9zkMEs3hNJglWywwYM=;
 b=LOaij6UepFP9YgBgL4G6MtQZ6ei4sqI3ceSXMPsUrnvXW2OLgfuvBLiJnbkM+F9/Wq0R
 MB+28nYtNd4zi84yRJ+Ol3LRWJlcO/a/yP5m+hPWMuPyQD5DRrAQYt1gCQ735RWhAo6W
 HJMoPIJmE2nOHd15Ti3El+9CzP/fvPMepyQfbhqqQqKiXnnNrwATAkCCgSdQf99s8A4e
 xPSEAXnrhbaeyBhhKDP4j5dyVUk21CnKw88oZ01H0XmEf1KlL17f2AqgmtitpPCznGl8
 vn3bGOf3CjNNZS1kM0B2qlwOTkTfSK4MgBRtFUpMwAZvAz1AFoL/gfvgxZVixaVIi8mw +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdysvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 18:17:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394IG1eF000397;
        Wed, 4 Oct 2023 18:17:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47vwgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 18:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3uP4yuNfkasUhYE3vLFuOAvOeKZ9xj9Eeo8oHaEfphzZCNH0lNnoGjjZWy/bwTg+SL6pvyg4OsbzgIU0qxJH+GELGv7L4ZgGUqsfqcXEp8ZsZAa/MxhyMwIMWcKQq7XBhtRaz2rsGETPJS494i+E0IHjnO/abiz0q7fD0dJwtt+m8r4VehJIRVp+DsjgrdH2mjwkE/JqrrPF4uNHyTuSlyxGUFWZrzZIHOIYEP3A7sUiewTWlw1KQ1l7Yb5IHSe8qyrEB/PQH8wsgZ7SYVi9L2WfjrgtbSVsymxb0Hx+6dLBNpOyP0TSoCwRXm417DkRChqXE6yaIBgCNprKHbTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5sOw9Ra8MR/4oVsCwXz9GWJ/9zkMEs3hNJglWywwYM=;
 b=IeHsSav6w9XcJ3dXfep6E1Bo33EPz84z/r/7JckETW1IvREBeWpJuz61TfsxE+jY9qxVqXW6knSGQ3de0FE3q7KSrAOsI4oEUIhPgWuZCkpf3q9RhO9ZM6B4MW7BVDz/BwRDptpaKQKpQfDTsXZ6jGqB+hGes26NyoCff8Z/B1kELe2oIZ2foBE8KdtJL7GewpRUU0izv7HKXN3LA8lsE8tHOXo873srf8oh0B6X+OzNOIlnS5/Tcgg+tnS05q3dXinj+MaHNiVzVAf+juPqrls6DFjE6ZgaTS4D7/Td0sKGj5TvwazrGxbK1+MdiPe57hweI5hQfZeR6p4ZWK1qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5sOw9Ra8MR/4oVsCwXz9GWJ/9zkMEs3hNJglWywwYM=;
 b=JegxQ3GxpIh4M8c8uCCKb7kGMyyYCul4+T9LnSrjlC1tyReEBXJNtPPiX1zjdMrM78mvE9hqxiP9XD6tCaBDfbMpeb9UiQGOaZa59YQ02PzF+Yf69/h7YR7daB7EBht8jGeq2nAYBq/oMcsixaq6bb955KpEmzHUly5gO6THn5U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6657.namprd10.prod.outlook.com (2603:10b6:930:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 18:17:03 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 18:17:03 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
        <20230929102726.2985188-11-john.g.garry@oracle.com>
        <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
        <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
        <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
        <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
        <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
        <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
        <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
Date:   Wed, 04 Oct 2023 14:17:02 -0400
In-Reply-To: <34c08488-a288-45f9-a28f-a514a408541d@acm.org> (Bart Van Assche's
        message of "Wed, 4 Oct 2023 10:22:23 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: f85b30d9-5326-4eaa-e442-08dbc5061c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atqxAVK8/E8q9n6kPXTL+q5LaxB3rklDLZT2idP1Zutbt8E15GgsBXzQ95VTKl0j7jMn8kuNxgL0EHW5WQwq8mn3oH1G15zati4+Q50NaDy9KijSDuPaHke/xjb0KdA5NfIWxKIisplB9e93xdHuKRMNq53Yu/tO1JbjR+uBG2gBWv65cRb11RC2O3CDUwRPJLBkHfA4iIOXyK6L8+BIyI40mJveeBoZra6nQGJ9eVDVxadUEdqSObrnVgpCTKWhUDImjzqGY6/pvNIF2lsb5rqJn8H1kwt7I/N5o/7OzzkAvmtKLfvevIeW2WkovCG8MZijR/TjweQzTJlrGDHT+eiW55+zmZkXp1s8GCnUTcAI1lSDfVWY7F5Oc4xQSeGEkQVW5NPbyyqxNYewwy+eUM9oqX5UmH5569eqQCcQUvGRn1IIx2Dj/poAOD0zTqSi/CBsCFAntomAa0vcTKUPzyRMhBsNZja21BIibd2AOPdefCYE3jT3uSzZnLNkNJdrr/TgsecAD18rgFb8HrHY4YMoo3ZnnWYe5uXN3czwuZkKMZL4G6mKM8U+xbQ+ug1L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(66476007)(316002)(41300700001)(8676002)(478600001)(54906003)(66946007)(36916002)(6486002)(4326008)(6506007)(6512007)(38100700002)(83380400001)(26005)(8936002)(7416002)(5660300002)(86362001)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijZU6ythLOuPfDbDmoK52RxoK7zr2WiUpTg42xgxkVtlEaQ7xWxeVDPSuvCw?=
 =?us-ascii?Q?ow6jP8/xPZxqDcT8/AKoRzoj6Jo+e3fVwiYOzwPpSA6kuvwIO5S/cVcoCZpN?=
 =?us-ascii?Q?1CdPBtqcWMsE6cd/6gidKlGS4ScGUjovhHETtcT2Bq7nLLWAtUVSZ5eBPTBz?=
 =?us-ascii?Q?Kf7l91EPcOFQiHa9M+zdPzA1VPMHvQCvKAxm3QJgfuh43h9I/++Z0Vp3bSrB?=
 =?us-ascii?Q?ufArToBzc6UBvU4sYyWFjHE3F50XFTeb8J8RwE84e1IsKSATa6p5GCE23lTG?=
 =?us-ascii?Q?AN6W059aIc5A/FHfA3tOp+cWRqE84yJABD9Dzjstty39ii08pgNgXkX3jx14?=
 =?us-ascii?Q?wSMMxmqsj4O/yK0TdbI2Lz6OTzILZN3WcP7/UrpcmsT2lFa2DcHvLeBctWeL?=
 =?us-ascii?Q?Cuyk986xi5V2qqCuBKf9hESRR+u3qO5Nat9L9hR42r8fOhz2Svrl+rTbr6Fs?=
 =?us-ascii?Q?INjkey6QIzhg7blgNV97vSoPdZdsxzppPwOtCZAtCWkXcJx9Iqz38GmYER8Q?=
 =?us-ascii?Q?sxv6ERsDo2QQvxk0QTy77g+AztCuwVu4+OwdaTfqOSdbrU/faRmGatQJu86S?=
 =?us-ascii?Q?LQ627RUSarRX0jcsAs0bQeHphSFYSXIP7FWNxUlAT0Sf9PlwoEPu11MqegMY?=
 =?us-ascii?Q?BqZluVr6tZaNC+pAtuBQoFaqVuEfu6/sGKB1nkTBXtwCVTiAIfdazL8Axrbu?=
 =?us-ascii?Q?99XUiqxlzK8OgZEnF5RcUo5Rrsf7f5asj/faWEHCQkDLKRnpsqOkRs5DOXnf?=
 =?us-ascii?Q?0BI8koV2aQC95G1WqObeGjhUCJ3P256viucJgvc4gx4239w2FcUvQx7groQZ?=
 =?us-ascii?Q?f5ssZivU5zMtA1MzSltX5MFQlLMPSmVYV8wX+FQ4NHQc/QB4QlRZHLK0atJl?=
 =?us-ascii?Q?xvgffyA0SqudyHQWjIXfL+oUVGaMOYPd60E1/0Hix52UC1qQd9VrLH4Gdxt7?=
 =?us-ascii?Q?jylkkwbwBqMnlUdNuW2+Xg6SEsq1d9RU9QhWaiQpC3J9oBvdu5/1lAWPUuVX?=
 =?us-ascii?Q?fTwgjLd6rfQ4m1Q/gMsqf8mE/AvwaC/Xa9ACnXCQUypLjL2DirqbkBAMKAFE?=
 =?us-ascii?Q?ppiZvfzyMuN4kbxL0ej0KoqeeiNo9OndzX92lKFgslgXHzGa1YL6la/oxAsS?=
 =?us-ascii?Q?ppo9DOaP00inY1HVaReTBnyHaFwLPH6ZrQkAEdw8WqZrP+uJZ7c2VZ5nVCF/?=
 =?us-ascii?Q?6jiVT4qEBlFs83dKtLlGL9+wJAmDqYmGrtMSGxAN4ue5AbflKZu7xMsw9uU9?=
 =?us-ascii?Q?0AV/ZiBdZQc6Z+KDftKBvlllDQHShXRuDAkvZb+45wJnFHaJa31IOoy2dqTJ?=
 =?us-ascii?Q?2v3NC9RHnQZ11AllqQsxd5CZ9Yv2H1Gyvl4BTwEoI5W9QeZ/mfNQqFrlhtbT?=
 =?us-ascii?Q?Z4OtzMwgeSQQaY7tZY9/fuL7oRDboAS3LMKFgnZDGUC6VfON3JGaXNMlnYnZ?=
 =?us-ascii?Q?ZUM+a8T4Hw915GdD9KSqhCqHILHGEQMinUBGi7mNEUQGaJnNoqaZLd8aMuxS?=
 =?us-ascii?Q?miQ6tjLJwyUCKzlqcWIbm1u360Y1ruaWEJ3LZRcOZHdklC6Dl6JDXsWuJwpt?=
 =?us-ascii?Q?kBlMAu2ytgmyvsyWsharGXB1g32oSJAwbplHwrLugz0Rt5cLPU6tqRv09pwt?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?spXu634edBvOyXPgGdWtQtTNATM3tcwXP+I2M3MEyWGw8aqtP/vCrQjfgdGO?=
 =?us-ascii?Q?45ZoXMyW2jpDF57x3hT65TrdwsNRbAkUNS03ANU2V1a4Uo2xuNrlbZDM9TVn?=
 =?us-ascii?Q?yguouX9DZAUsIGGvfqn8kejT4A7RQuWy1/j/rrG63WKsTiCBAZUNPxlVhhcv?=
 =?us-ascii?Q?0jwtv1m+bJfNWPl3OWL/kXBooLVm6xKBrpqzLFEfr6dv6ENu74WvL/OPtMWo?=
 =?us-ascii?Q?0JGkyJ0cKy9sm4banFGT9u+JmAYWCRbgOVzY9iuP1StrjE5szM+fiQ3lmBdS?=
 =?us-ascii?Q?V9aWwuhRjql+okCyUMhD8P+WMDdNJ3IugSVjm4cuHJgFVLYSpsSwbfGG8k4p?=
 =?us-ascii?Q?u9hnCn6XuNpF12OfF888U9lBA8gPFoJckzpcGLago302i2cBo9EUVZdC3vHW?=
 =?us-ascii?Q?9EuXYirpuIjQMxKguOTAjAdB9pF3qn2az7N2WV4tgY2Inz5HAa+uFIsmHbXG?=
 =?us-ascii?Q?ZswreYTvAX/qEm5lYP8OuMD5AdQ/hgtZzkK0q/6+pXRd1rAHPDKXshynNTOp?=
 =?us-ascii?Q?I+OBrx/uUhqO7erJG9CTbswSiux9fog40HgvreQ8pUR6Z+7i/ET8gTWNdK3R?=
 =?us-ascii?Q?hxqnQATbRhYGJ4E8iWh+1ilgWj+IpIA4/OYLjUiSpdMud+30hvel3K67JJUu?=
 =?us-ascii?Q?ERaXtQ/pki1LfPSRUtxKt+a58l9g3t8aLnNL6dUOvN/lOrg79d9DBt1XRVZS?=
 =?us-ascii?Q?+5mcaIsvZ1AYe06dNN0f1TNQBcIC/kNstUwIatuTEcCu/NI/MomsRBUj1Z1B?=
 =?us-ascii?Q?tdK9UvZxNxBhXbeG8iCqCPfCTFMSxRq28L6Xawt64xY/H9T+r+1gmw9TLAV8?=
 =?us-ascii?Q?WMoAoDt/GGdd+4N1Uw9KOV/VHAVSNTG5rrBcrJ2BqLJnb2IaWlhXsEJyuClo?=
 =?us-ascii?Q?MFq7VwIxuZp+4mW2Y5q7IijVkQf4OkM65NNPyLzBmv2qC84VLc3XJDGVeiRu?=
 =?us-ascii?Q?OiZX77I7f8HyF2WtPNAmQxTs6LDnFrUclwjdGgIGLzr4t7i0NBQB5RZzQKG5?=
 =?us-ascii?Q?82MhCv0SsQ50TKbjUnCBXroWdSRBO1BMkedIoBhAGkBe+MYPtPNKypdnyGok?=
 =?us-ascii?Q?r+OVVtmrbgNS/yhQs/BmFMlpC4VVLJpjfwqTWNNFXelIMlZ0+sU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85b30d9-5326-4eaa-e442-08dbc5061c28
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:17:03.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrtQQGdoqkU2PIV5xwIlHyy9dTrKsG7XiIedV8WP3rxsfevqXOZYPDqLRi4kJBZmxZmYgo4u7CYqP7HcKR4sJhGlRkei3eltf4aQMQBRahU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=815 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040133
X-Proofpoint-GUID: OBei8h-di2YjYuxmyzN4aDnjfsiCBdeX
X-Proofpoint-ORIG-GUID: OBei8h-di2YjYuxmyzN4aDnjfsiCBdeX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Bart!

> In other words, also for the above example it is guaranteed that
> writes of a single logical block (512 bytes) are atomic, no matter
> what value is reported as the ATOMIC TRANSFER LENGTH GRANULARITY.

There is no formal guarantee that a disk drive sector read-modify-write
operation results in a readable sector after a power failure. We have
definitely seen blocks being mangled in the field.

Wrt. supporting SCSI atomic block operations, the device rejects the
WRITE ATOMIC(16) command if you attempt to use a transfer length smaller
than the reported granularity. If we want to support WRITE ATOMIC(16) we
have to abide by the values reported by the device. It is not optional.

Besides, the whole point of this patch set is to increase the
"observable atomic block size" beyond the physical block size to
facilitate applications that prefer to use blocks in the 8-64KB range.
IOW, using the logical block size is not particularly interesting. The
objective is to prevent tearing of much larger blocks.

> How about aligning the features of the two protocols as much as
> possible? My understanding is that all long-term T10 contributors are
> all in favor of this.

That is exactly what this patch set does. Out of the 5-6 different
"atomic" modes of operation permitted by SCSI and NVMe, our exposed
semantics are carefully chosen to permit all compliant devices to be
used. Based on only two reported queue limits (FWIW, we started with way
more than that. I believe that complexity was part of the first RFC we
posted). Whereas this series hides most of the complexity in the various
unfortunate protocol quirks behind a simple interface: Your tear-proof
writes can't be smaller than X bytes and larger than Y bytes and they
must be naturally aligned. This simplified things substantially from an
application perspective.

-- 
Martin K. Petersen	Oracle Linux Engineering
