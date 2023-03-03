Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B056A8FAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 04:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCCDGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 22:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCCDF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:05:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FC857D38;
        Thu,  2 Mar 2023 19:05:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6hRi005309;
        Fri, 3 Mar 2023 03:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=PVHhsmzcbN4vLOS1aCr4umapNOColsYg4+qEVcYFwM4=;
 b=HiYGgXeCYJx++WIgh8+gpJbVIHsVzMNbjQ6G3pS54UnBcLmE3w9tqT7jHj4TRvOP4+Mz
 hUrzb7c/y+camTpHToHOchzKhwrVefVslCeYc5KKdppmwGa3gizNW/iYVygD53LHMtmw
 h/tbilK55TvmSoLzLiJufAcQt0SExyuwHC7egBMjPto+GN+EypKR0eRFY5TBrEhkJcKX
 KMsdDi4+xrrLbvKxXTzPvFwK+ha9HA81Yp/tZ+GORDIrbmXBbuJxaKSxD7GR72eJkiQN
 LaT/lvoMvfhWndKC8tIN/9YD0ddrFpoLZ8+wYVGoc54mjnlVJD9iqFRHeoaSohtBORy1 rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7nb0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 03:05:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3231EXT7034817;
        Fri, 3 Mar 2023 03:05:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sh19ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 03:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV4/qt1zRCwSdYeDL5Uua0TNLTU9mOJt6DbO0tHKgy1ePGXZKv2mEunXusLzAWZ4lln+fEQNruOe4Izb2OIymSDH6b7BZ1nAOa4Hssgbd6BYZMP34MZQ1ygN2cFuAK7j6rvEDF5qJdcH7cHlnGe1uaiNpqUaapWbu4COr+j5zlT+rpa1zXjf/bvTr5SGUWxBPyeBDXLdmGx2Wy1qGBF+MYxSQCSBg27M3HBrJ03anM+rUkizqNsxxUT5pcXHzvtTwi34ZwWKwASnopXDd7VPuoVStaw2hLQ+RR/JcyBGU0QXPhXXXNugd/733BcquzBfA3OtwSvTiZwxRH/BTgkWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVHhsmzcbN4vLOS1aCr4umapNOColsYg4+qEVcYFwM4=;
 b=lVSRzTQK+XaVYB9oNcO8w9Gk8e52oP0CXYfOFVKjss62NWlAeUuzkNbBKnFc/jJ5FcEOekSiAcHcSRnS3c2Mvazqokb8QV6YtNYO67qyR422L+Dom8QQ+NeIhoM6Zx4WZCQReTeXmOzHjXP0w8byk0hFfjb6Nj18uE2BqkJlz1IRx1VEzziqn/NEUeYOjrr9YzRLa+FnmeFxFla8VqIQZJ1Psd3okvu2JVe17oAZiugBKCamfz3N+rKwUXlVU6BrqpsKej/luTFGj+fBWHSHpt3WJ723rS8RzILeT2FMg723mjejLkYYwnYwU9iufv9lVyL5fSYX73Rr5rnTmCEr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVHhsmzcbN4vLOS1aCr4umapNOColsYg4+qEVcYFwM4=;
 b=d+bTXZVG/jPTlTrBhsDhOYf9inzYII2CBd1TVZtyKI2nEdqKjKuD81slaMF03DWcMLA+k+6/GeDmjBTjuDiYmC2oItWnRBK5JoIs9P6SJsRKh7WxoNq5CLuqdyoBLDxX0vx/qqMMSHAw/7V0BzkDxez6fZ7b4yYQvO5WVV8yXZo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5236.namprd10.prod.outlook.com (2603:10b6:208:321::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 03:05:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 03:05:44 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0u6fsdi.fsf@ca-mkp.ca.oracle.com>
References: <Y/7L74P6jSWwOvWt@mit.edu>
        <cd00d1bc-3646-a465-920a-110b80cb887c@acm.org>
Date:   Thu, 02 Mar 2023 22:05:38 -0500
In-Reply-To: <cd00d1bc-3646-a465-920a-110b80cb887c@acm.org> (Bart Van Assche's
        message of "Thu, 2 Mar 2023 12:30:47 -0800")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0374.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: eae1384c-4c93-4d41-33a1-08db1b942e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8OOOcGTDMlwwvRNAuWASlvG+JH2MhAw+acRbgkxJFJEsZJ7SuaotbGvj8ETjP7F3dXleYpwZBcjJ63HRcuuNE4cOCsP+irxSvNmb/IoMWNotrnZ8Jk08PLySVXJ4oe2HhA3GItwd1iOkNNwNul9Yf4S/WUiIIn4bT4sO7O/gVFGqZvgZo0d2Ji5HGvwzpOIyrVOlIoJGaB1o0V6kaqwL6RhWgROQBtFCDbuZZGBRBK4YArg3JJZYAv+nZwy8E/KdJuUsuVjo3W75WyTp1xcCWOXYoI/sGqVkiq/FEnUOWyBkDnJWWtqpsGQYSoC+FjBIGyVGB6stqFSYndmH81FEtiUPKm1d7aMryF/khKN5pFwyqfTCXZ9k6MHN9dFdYGj30yByy1W6SvrFG2pAj2YZWGaFmQbWcEAICAkP/x3wU7fSLXo8EFoo94zVE78UK+GH38ULojvzaMIZluFXMf8TA/lEKNBCUSq3bOwaT2N+jEPEpc+UiPK9K0miQ/eea09DlmtSQJmvKwqKoIuq+PSTdPxjHWjGhLyfG9WeEw74hQu0WJegE3N8ArT8nVcOaEK+4qheaaJjYD/TK4ITIT2vjXmNx3oehzWJwrl+jUAtBF41JXaFoRTYpJ64MHcmvyf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199018)(5660300002)(83380400001)(41300700001)(8676002)(66476007)(8936002)(66946007)(66556008)(4326008)(4744005)(6916009)(316002)(38100700002)(2906002)(6486002)(86362001)(6506007)(26005)(478600001)(36916002)(6666004)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VCkZWUwxFHuOwo8RmBTs8dyG0FfmIj/Qv83PJm69iW8/h1Um4Y+RySLksEO/?=
 =?us-ascii?Q?ne1sVpRr27ixN8ulDOO8IJ/cMtezKaafdjFXWXZW80UzCpgZgZIXMxictlka?=
 =?us-ascii?Q?tEsRfn3AVwGJ8Cej75ZYptEZUB+DiEZBeZ+iil+E4qdJAQDwGNhLFoB9eOEM?=
 =?us-ascii?Q?LaBd/S1ToTHZG1q7x2jYIwVqEnalfyfnDJHxU4LfqrLB0pcRRJK5qxjzrVCT?=
 =?us-ascii?Q?LLARlmBPSl4HwLVYsACkdKrwyIpTIwNGdFYjiZnV+d8NOHpaVMLz/9cJScHV?=
 =?us-ascii?Q?2LQDjAYekGUxx7hhEjqV+/jWPDKuiCSyK+eDP34K2IKAC6d7qPNabDV6Rv9S?=
 =?us-ascii?Q?1iOdXpn10apoQz0WllTL4wP1HdAKvDfb9sCrH/NTuTFXJw0wCoJh3O4GZ41e?=
 =?us-ascii?Q?VXc9Ci00/+VTSbSuJCNOMRMFjaebMroZiBnz45jVHRVQuLZMb16HFewPx8+K?=
 =?us-ascii?Q?XITU+GDukVfkYzbI8hwB+C2qx+ROYrzTxB0x0ekmOpJpBt27nsKAB7Mcu2rB?=
 =?us-ascii?Q?exfmkVNoAn6+IzZHy8UDLY3iVw6LOq9APBbSBEOKqIElg6+25qriCZS1Ex8X?=
 =?us-ascii?Q?hG7HiDjWqlwmjYNyPZSb0BIwDbLqBKTMt2RloPVjxSw4ySDj9oG1OC3UGJ47?=
 =?us-ascii?Q?ZNTEeiOWsPzQ3pu/IrhYEE48TF+79LLkQnR2MIgSWbNl5Ut8awZo4aY8y4uq?=
 =?us-ascii?Q?DxYZjUlAhm1a9SQpDAHvGP4d7hgAHTNg7ygv5cDIFIEN8CG5zyR+YKbQNbWF?=
 =?us-ascii?Q?nGK8PubK+l8Mt75SnyzJkK8iXoToveMgeJ2lqwoQ/rU6iw0AsNt24r7wh5y9?=
 =?us-ascii?Q?RUV3LJueLnKxbSsS/mbHKO1rtus0hFOI+oMcsCL6qV6jq3GFfn2ZTXRVMpSE?=
 =?us-ascii?Q?vaAGhbxVmSikrBi/0iuH1nIuGKCGuJbgAiNhIGDu5Gum9bBGEPum/qCBRibF?=
 =?us-ascii?Q?RgRWgNJybUPRbBjjg5PwKdeAi2BHDSHwxlbFUV+xTPyZ7a1IS6on+MGq7g7f?=
 =?us-ascii?Q?8ripEiVXFcglIYMPWBohlltv21fNOR1vlCnvAIjXpFrRHVtxa3puDdQhNaCY?=
 =?us-ascii?Q?PhsHt+2R3OvOvxDyk1/P0U+5k+WMOB4scXQlHeKytBhOqjXjT+DmjYSI7I/+?=
 =?us-ascii?Q?VkCPryikWL1voYJnNYL65e0lMD2cRGukk94pcf7jIzPXmxt1u2Gy5fJtn3DL?=
 =?us-ascii?Q?IRdH8MCH9uU4XwV/y6cOQuqXMfqt3Ztn85fzXLRfinClaUZtDldlTv7fgUSq?=
 =?us-ascii?Q?82xmuNo8qtHTE700VG33mvPmJqSvjKR6DXaxEisyw+mbBdrPqdDLznlJp/ru?=
 =?us-ascii?Q?FtoG1C5heTGI9ZwfuqApszalYOXm9rFSfWK3/C+uedIoGNOe+4s1f/gHTjT7?=
 =?us-ascii?Q?3vtpEZhNZZ4DiGYCqYubsxHkbesMefJXdcQHLPXfkdKqPL4xBmSikrGrdK9s?=
 =?us-ascii?Q?y7/V6G3wkBsMzOWj6mEZvesHRyH50TzKh2w1td9B4YmsgHFEjet1WQTvnAuZ?=
 =?us-ascii?Q?ePHZMpTyc08QpQ9BokRht054fSmYc8oGxU2/wRRVucxBLfAmGb1vKOJMThzU?=
 =?us-ascii?Q?5JqQTukdSAtwjBgjCuHSLFyHyq0A/uh+vsli3RDW2LeznqT173NEC1pdJBOg?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y8GwQ4HpwxfE1wHvExKluucPc5eQcKgOjDmruIQHgVMt9yCerVIc7gNGDCDYyGLV9TnRFn6iP8pnFLpYXCcRsT9Z/9nz2Kd50F96DV/VA2DY1EbcXTuwCO+ZjN1mBegfqpkkGNfAz+aCc8S3iml8Op3AdQKp+nkYseFU7QhbklelCO7x4Oe90cB1Cf7pxbCY3HLm0nHyhdNLOFerxj7uIv79kWylyFrnxXiLqAx+dilTkqDjbib9d3LfX0eYN1orgZCN3+NP8A/LCS/OQqvQKHv5XKCRGwgPYTkSXy3SuctWu4nUmk6lZRnwEsbmpanTBpOkQEuEO1DqGWqQCjZQqqsbHPSCbkzR4bbAG8gSjL68i7CB14DaFur+v8uc3lARaSthP9ibuSdGlv9JFLGC1l0qQfOEUxAob+QlbzVPr7hkMnL6FyxvER0qwpvl0izmYy7yjnAgbXq+kqsrBl8hkYrLsCo1H81XWuE4nOiD9dWCmwLmcMp+ck9Ks1ZBjAcWIVhpVAG/U8BFNIrsFRaqzLBrLULuzenT6rzh3Rl7DotROldUHI8osYoVDkcy5zJeem2sTXPNLisAATMkMsflJI0V5fYssDaTF5PQcTrK+1/88kU6XWIH7rxAibtCr7O+zVCIrOSy4gpbIc/UnyQJmfole/5csV7W8y6YoNTrpC4MVag3MOstZTXQaIe0Rpin5YfL+dcXM3YnZafjOCNGkt22VjjmDTsU7P2rJBupkwn/WcnUWUkKN8mEMOtxCq4Pqhd8s88SfegHFiaU9Wv5ujOcWtwlQT6i7mPYJR4CCm02XiXxJjP/sjMQEFJTtdl7OqVfWXmqGDmP9YFnsva6jpb5NwXIGUh/nZjFDw+LYSDo5cLfTl73gfP6rxAjnHkWtd3aXIJkDxnb8wLnNjypnA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae1384c-4c93-4d41-33a1-08db1b942e16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 03:05:44.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eM47Zy0B19svz15JcxsSsSEtXt5NDHWUxmTWTyxLYPT+fAfwzsgwIo1jL3k4MSMZb5E7MeTRVGLGOIVjikwS17EZn0x85yNmm+4k07mJ2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=590 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030024
X-Proofpoint-ORIG-GUID: dTXr_oQrHvD8o7-yE4RH1CwlGbf-PdZA
X-Proofpoint-GUID: dTXr_oQrHvD8o7-yE4RH1CwlGbf-PdZA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Bart,

> Work is ongoing in T10 to add write hint support to SBC. We plan to
> propose to restore write hint support after there is agreement in T10
> about the approach. See also "Constrained SBC-5 Streams"
> (http://www.t10.org/cgi-bin/ac.pl?t=d&f=23-024r0.pdf). This proposal
> has been uploaded yesterday.

Why have the streams dependency?

-- 
Martin K. Petersen	Oracle Linux Engineering
