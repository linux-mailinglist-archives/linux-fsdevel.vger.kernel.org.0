Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CF6868B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 15:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjBAOoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 09:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjBAOnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E226602C;
        Wed,  1 Feb 2023 06:43:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311EOPDN001485;
        Wed, 1 Feb 2023 14:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=KDzU4naYRNjRDik3BH+mcRhK8nHD33szPLU/N/1zRKk=;
 b=LmRh3djtbNS2PdqX3GcOvIKBtI+++UPXsgHkubI1oMcAar9bBuDTDXdc1NwCGxo3f/0D
 D8fD/IpNLfinGR2oIuh+4bIb5ZqGGyQQN3aEg7I1os200HMy7vqRw0ZdeKKznMipLJz7
 KBFG5ZJGhgbevFgQ2kzaGOjGEpANSuuk+E4zR022OeUxf8Cnr9Qt/sfSMY/WU78PDgMO
 aWKxiiZtsqb9r7Exm4eegeDCZL6CAnt6OnWgzjMTpoitWZZpmUBFzOsps0BNPE580z1q
 kBBo8MTt6DJhbQ1w/fItrlEwLgn/ndjpWmX9bnq09o3GS2XHaOZbha/TegBgRFqYxMAL Nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk648vc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 14:43:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311D88C0024955;
        Wed, 1 Feb 2023 14:43:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct57km29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 14:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OywT4kjCaD6Tf8ScTf3nCPd/o2EKMFtuZ0eWnihLNQshW+Q06xS1vQtcfqJkW4Isk0xRlno4DTEFc3X8Hslak7V3FifMeeW43ozVqfwiN0CDE60VUNIHrl2BFLBFHPYTZ6tEYZeeFF1bUmKLRF/yD/p8SdWa0zEv0wFK85rs/4wQ/C7joz/1exInod7KX5UCcdRNNDlTWXaett0v6WlfIZzRcpASwWOO7bc1AU0Rx8P/QAYOMyHz8fq10Sv/ItlivcJcbFxKHFXD9Ti7FqOyXj9CE1NpOhJRy9aAomuTeaukimZjckmhPHurq0gBOhqbyHjAVHbqS2puKBnGzxec9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDzU4naYRNjRDik3BH+mcRhK8nHD33szPLU/N/1zRKk=;
 b=hbPlUOyVeXGGyhcVYJG8LbWbUoQfMjB08L5h9WM/1kuhRQgj6hbNCdS+dqa/NJ8wi8RIlfh5KYmiDAWKzFOdLiA4cuMxoa9uS+z5ufibwjkcbnrq9qjNoq5dRcrImWIhZRabjwpqYYpQzjs3TIP3ycAsmv/yB86oNOrc95HzwndoGZ9DtqG+jkhxQNOCy7s1MJoODfhkTPZQCuRAOGDy5zRyga8TN1zG9Z+utW0+7jF0gz1wb++K1QTkh1GH1eSoQfOomt+6aneqef5Iw7Ooen5aqqMfH1fIRmiXb5XNmG4vysbZQ3g9uU7JF34Gk3sWwoRtBWd36LhUVEGQ6yq2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDzU4naYRNjRDik3BH+mcRhK8nHD33szPLU/N/1zRKk=;
 b=n4lKaADWb//qCcN+pZZjNjoUcEgPddwB4rf058c7mPwn4PumOy6tYSkf2BAhsYJkB29QSc2GoBQN9izutFGvwmFCjxaNv2ypynViNYfqXx8fBrVIYPihZ0H2sQtxTR6K8AEH5xJ5aV03qd8vijASvfIP/953dnFSQKvSnIkwDMA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 14:43:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6064.024; Wed, 1 Feb 2023
 14:43:17 +0000
Date:   Wed, 1 Feb 2023 09:43:14 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yujie Liu <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [maple_tree] 120b116208:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <20230201144314.ukbaxy7vbgftaebr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <202301310940.4a37c7af-yujie.liu@intel.com>
 <20230131202635.GA3019407@paulmck-ThinkPad-P17-Gen-1>
 <20230131204520.ad6cf4lvtw5uf27s@revolver>
 <20230131205221.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9okrO+GOYP2Gh4K@yujie-X299>
 <20230201143655.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201143655.GE2948950@paulmck-ThinkPad-P17-Gen-1>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 6375e949-2a04-4afc-6d9b-08db0462a7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+ZCQ9Na0RmKAd0pS4sZWPtY4sYY1dcmw0YuFo8WSlWrgZ0DueYeeGvcGhGLctbrwYheGoe8r8/u8zxafqErOs15EmvQ4mHyoNIQ/lLqXEkQ14IyPi9MqUh2JDuQQq3aG2NJrtcknp4Cyl7c2g1+IFItbHU2P/uMLzC6FJBHGtoJZvrdZ1zZD3xRjYMiuiZFHe2vG0LfPZYnL/wwygmQW3dso44y7RbnJgDC//08TuxZLVbMPxMyrpDKewxIt/GXuMNbuE/ef6xMSdcvlzgRdSUWwIvGe36IHgnvVa9YUkBJb3QZEeZ2opIUjFoDv/rZNp9n5UkBN1JZtEfqMJJ2L6nYVRyKkapq6qLG+cPoUpLcal0+ar0401VlqJPrQEKmQZuGfAOpqS0apw5cntPZz+sIm2LewE3piXSaSva4nbjJyizQ2Twyi5QxDSC7CdbT25ha13t1DiVHWAalldWDK0StNfZfV/C1z/E1XQvAWbyglZzJZyENh1cuPBfqDfjLkRKt7FRH3FZgguJUeDq3rR2Lb0uitGGJTHTvY5RSmdSVJey1V6fOCcXbl5Noo/bURBybGWkgWp5L6KL9zf6sQIHchvd0k4GG/Vrvmsfv5qdfBlponLugniYufHljmP8DbZlLXSyMfV4nX++muLHkI7n3VTSX2/Sp0FgnWPUWL1S7jASJ8jnOFD07lGSeRq1iUvvOX2TOEGt39eVC5tk9pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199018)(5660300002)(2906002)(38100700002)(66899018)(6486002)(966005)(86362001)(9686003)(6506007)(1076003)(478600001)(186003)(26005)(33716001)(6512007)(316002)(83380400001)(54906003)(66476007)(6666004)(8676002)(66946007)(6916009)(66556008)(4326008)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sa3hPk7YLwXqMHNhMl77FgJxc0TUVr8jmlMRV8cRI51zBGmhcROgxc9Li+fY?=
 =?us-ascii?Q?1jxpC/sl9VEA/OeRV1CbC96B0meeqfinheb2zsTs5OIYy5QXBObbwW/FKqo2?=
 =?us-ascii?Q?fyjtyBkXSUEKGaNN/4UKowLjPi+1t6Va+vRSaIZwuMvdqV0MOLRqMN0FD33V?=
 =?us-ascii?Q?7TwIXmDlXViKdteIkq84uL7whBLnSNVktaj2YU867MwKiG4RZaGWhfZoZcYc?=
 =?us-ascii?Q?rwkxmUjdYTzZgyMU9GY1SHeFKRzMKqfXAmqyiHOEHXiXAjqrqF2v+hlCl0Zy?=
 =?us-ascii?Q?Lf5voJ0VsXtfomjJRAX/b8Jw6/GTc+gOb+G31/wT/6RRBxsqjxxcrq43qY5g?=
 =?us-ascii?Q?ennnk7JqqHjoxX9yZaYctF0E9oJfr6LaC6baQFrxx48AafH8+pyMWGEmjWCd?=
 =?us-ascii?Q?+34pbsZDo7HOMVwOC5kRa6pjba8w5FTqZBz0I7eSWwFmaKcpTnagup/0bBFV?=
 =?us-ascii?Q?FVaUGqlZHICeqfFgA75SRe6WKPQT1WqF8OfNbddIe5mjwORiHxjtubtBuq+b?=
 =?us-ascii?Q?5yAJsTsFFboD7mk1Eclo8CyUkPmxSnjYJVi06bFc7ynM4XcA59+WDkBMZNs/?=
 =?us-ascii?Q?BnAYChoChrhBfoit2rJSgURXLUMDFyIrFJpvI5BGA1aR4iqeMVMD5L+EhBBF?=
 =?us-ascii?Q?vWzDbqUUEILJN/qDjskuocu2HOnoB+nYtKGtbya5iaLZCwTVSgmPpy7FapFy?=
 =?us-ascii?Q?pdprkfbz6YGIGFyEapHegmVETNrnzrehTvfByhXMkNK6gjOrRQ3420c3qeve?=
 =?us-ascii?Q?teM1mhz1Irq4ASnajaFfc0nM0Er1I0Y4WwZjtMKXYW/AOKgRv7NhZMuvjjO7?=
 =?us-ascii?Q?iH6uZWXTtj9yeLKYTAuZ7zHqgZ/pKBf0Uirqr9Vd5Eo6N23fpZIaWhtVSdkv?=
 =?us-ascii?Q?EgMUVPBNYpq8q/MC3XA3mxOCRIv5tnIU/Q96SKX3/oag7SJFjLmtnPDE6NX+?=
 =?us-ascii?Q?BwyN1RqJPiFA0Uq0dw8rJjm/T/+hGjAc60v8zLXGbzs9yaWOACOXORnOS616?=
 =?us-ascii?Q?BOS+qm+AyQvqKhU9gQqAC6tamMKR1mys238Mxth8l4X2y+zG7UzJ2mQeywif?=
 =?us-ascii?Q?BvRbx9XemIMNSzWqzhMaef+1EocoO+W1lPk2kCvvDadxnxAk/9Vo3hO7HOQQ?=
 =?us-ascii?Q?i1BuqvrmJQYbRISXSDorH5aAS6oRp/ZtVpzpDGQoymbVStkfpGZyiBQwMQ/2?=
 =?us-ascii?Q?ZVXgYb+4AfNln1b6FNzc+JACdbhdycAtQiC+4MsHhxWllqCN2wwD8PlSAoGX?=
 =?us-ascii?Q?sg/Qb743v74L94UEHFDY0GqYEJu0I2pVblk28kWbtTs4DaXHyYBt8w9Jm5Ml?=
 =?us-ascii?Q?6ieUs0NHMid6/K1u1fiXFAA5yLIiiBzGTm3IBVf3PgcAq9TcIuLEePl/hKYI?=
 =?us-ascii?Q?cYe+3TIxaAAN4I5D44DuZDtk/5GvjOWdx+5qTPzNnwqv3eV+FljSu25+h+FI?=
 =?us-ascii?Q?OssoB2KSlwYWkq29EoFXEXe/GWwQmBGd3SHaUIFx3ROlHJy8mt903+GEburN?=
 =?us-ascii?Q?jYTbsgsnx9bxzgLECOdakaZKEdb2qdgZUuT+x2i5FTGSDDA8b+zIA3pP0rin?=
 =?us-ascii?Q?2KObZELk3rXVRxs2PlCWxnGK1FZ+5Ilj0bABYjb+aqZ/zpM/uPIBaqsLJC+e?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rxAt6v6YWkjPueQiEaZSJPsJLLB2wp/HbcoqdAOoO5BTyr+4TLktMS9pwLI4?=
 =?us-ascii?Q?Xz2eGRCREznsLAgjulaW1LJcWI5SJaStnAGmX2aOc5SBxvL+N8x4B6gqYSSG?=
 =?us-ascii?Q?r/IWfRA7wyUGjGdZOREy+WNXCKlRInK7Ka5xwPEZdZ80RuCLBu0VIGXSzoaW?=
 =?us-ascii?Q?MMkWPQtK/Y+p8pF8uefTOdrCGnzMM1bDyiGuaWqfc7qWxi9DqqrVhd+KY2FH?=
 =?us-ascii?Q?eIW6uHhaz+hrj1o7LeA/A5pbnoRNGMApp2vLOHa5879ky6zO4XP8pDxtUj0B?=
 =?us-ascii?Q?OvWm5GISHXHLm/SPRkQ2eJBzcxg9HupZtPCjj6Uh2tqQtUpalC3OhhVFCqFn?=
 =?us-ascii?Q?Q7hjyMjdBU56oMwgJqNpKqh4oefR2Z/Rj0wJbvAL9IVf2sugkitdSXPGnIFI?=
 =?us-ascii?Q?0y0d02KyJ5nknZuJexoMV862gz0woUuhskv5BQee2ySUsjbApLX700GqSeXm?=
 =?us-ascii?Q?JeMiEu1NezyVgS0NLJo9sfjP7VFaaK0upJqIGw7VHztdhev+rlQo8p5VYmLL?=
 =?us-ascii?Q?A1QAycuQuo/8b3vckSaV1mUb+XV6CQRBX0OPPJzoVAyXdzo9876yZvX8n9h+?=
 =?us-ascii?Q?l0QKSZK1wrWorSFAnwy17FGU98HLj8Iv7zpXi6SmhAphZ/wnUbL8hAOxC+OD?=
 =?us-ascii?Q?RsyR5jAWQjO2qFH1TtUFVpoPWplQZcNZfe/TSk2py+OyP+wl8WPM1nc54+Gw?=
 =?us-ascii?Q?iG5y76X28zUjDqapTegQZwqzVSi7fcuy9hB2LrbA03qFOCU5gYJSLxOxCe8G?=
 =?us-ascii?Q?T4Qz92x8vFp3xkzocRVWHpy5cHe0hl4v4NB7jhXW3ZV0o5QVfhsw7ZfwzvUr?=
 =?us-ascii?Q?gw9t46P3rXnC4r/e7DAWIr5DlLaYbSojPmCaAuY4xUa77Cehz4f7Cv567j/7?=
 =?us-ascii?Q?Z+zAszVNOomgBssrC+JNka5wqXYsBM/Ff/efWNZUYPfLE4Gmn/bGcn5iQD9X?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6375e949-2a04-4afc-6d9b-08db0462a7c2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 14:43:17.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usKgNW+eOH9MK4Lf7YcP7VgKQt+EzuZdxrRoSSNrQjANdWMRXTfrJ/uZ8xuWN8i2lgk4BUyuX8RRVfaSXC9TWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010127
X-Proofpoint-ORIG-GUID: B5-6Kw7ykIt7c3ke09_59i49uNvDOBjk
X-Proofpoint-GUID: B5-6Kw7ykIt7c3ke09_59i49uNvDOBjk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...

> > > > > > 
> > > > > > FYI, we noticed INFO:task_blocked_for_more_than#seconds due to commit (built with clang-14):
> > > > > > 
> > > > > > commit: 120b116208a0877227fc82e3f0df81e7a3ed4ab1 ("maple_tree: reorganize testing to restore module testing")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > > 
> > > > > > in testcase: boot
> > > > > > 
> > > > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > > > > 
...

> > > > > > If you fix the issue, kindly add following tag
> > > > > > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > > > > > | Link: https://lore.kernel.org/oe-lkp/202301310940.4a37c7af-yujie.liu@intel.com
> > > > > 
> > > > > Liam brought this to my attention on IRC, and it looks like the root
> > > > > cause is that the rcuscale code does not deal gracefully with grace
> > > > > periods that are in much excess of a second in duration.
> > > > > 
> > > > > Now, it might well be worth looking into why the grace periods were taking
> > > > > that long, but if you were running Maple Tree stress tests concurrently
> > > > > with rcuscale, this might well be expected behavior.
> > > > > 
> > > > 
> > > > This could be simply cpu starvation causing no foward progress in your
> > > > tests with the number of concurrent running tests and "-smp 2".
> > > > 
> > > > It's also worth noting that building in the rcu test module makes the
> > > > machine turn off once the test is complete.  This can be seen in your
> > > > console message:
> > > > [   13.254240][    T1] rcu-scale:--- Start of test: nreaders=2 nwriters=2 verbose=1 shutdown=1
> > > > 
> > > > so your machine may not have finished running through the array of tests
> > > > you have specified to build in - which is a lot.  I'm not sure if this
> > > > is the best approach considering the load that produces on the system
> > > > and how difficult it is (was) to figure out which test is causing a
> > > > stall, or other issue.
> > > 
> > > Agreed, both rcuscale and refscale when built in turn the machine off at
> > > the end of the test.  For providing background stress for some other test
> > > (in this case Maple Tree tests), rcutorture, locktorture, or scftorture
> > > might be better choices.
> > 
> > Thanks for looking into this. This is a boot test on a randconfig
> > kernel, and yes, it happend to select CONFIG_RCU_SCALE_TEST=y together
> > with CONFIG_TEST_MAPLE_TREE=y, leading to the situation in this case.

Ah, I see.  Thanks for that information, this makes more sense now.

> > 
> > I've tested the patch on same config, it does clear up the "task
> > blocked" log, though it still waits a long time at this step. The test
> > result is as follows:
> > 
> > [   18.397784][    T1] calling  maple_tree_seed+0x0/0x15d0 @ 1
> > [   18.398646][    T1]
> > [   18.398646][    T1] TEST STARTING
> > [   18.398646][    T1]
> > [ 1266.450656][    T1] maple_tree: 12610686 of 12610686 tests passed
> > [ 1266.451749][    T1] initcall maple_tree_seed+0x0/0x15d0 returned 0 after 1248053116 usecs
> > ...

Thanks.  Yes, I have a lot of tests in there that add up to taking a
while.  This is the expected output.

...

Thanks,
Liam
