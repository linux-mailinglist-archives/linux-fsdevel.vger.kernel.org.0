Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01176F9DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 08:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjHDGKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 02:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDGKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:10:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735D1FF0;
        Thu,  3 Aug 2023 23:10:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373LDisi022716;
        Fri, 4 Aug 2023 06:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=LoHJK2ySiPV17YWVNkhehbyPa3xvk+KpdbaB37FREpI=;
 b=t1KE54jB6QHBf2bPu+peNaYKqIgrTrGcDYJL91L28cyz6UFzE48mzA/HwoN6gWyDb5mZ
 SbxMb2kmCdnvN/y1U1P6wsNsLymJaM/VsNMQV1s+ndIv4JLbJDQ1vJEYe5g3izXpB1yt
 5lahg9Gybi0JnkybtI8iwu0mPd1ziZDZ0Fu/N06ThCCHBUoRgH6TfkJ+AWdmmKsfAmIg
 x+fP98nsVvpZ475dUgwToVoTJRZGip1NaihDMXgwdiKqxFGM3xqyBHt85ZMn+qbLcbfv
 Zsfe2VPzG8X9b5G4z0aN8mK6MwElYQEvRKCELzk1ZNiSYQcjck1Xr0YHMQaA0dDCtF0f Mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbw62b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 06:10:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3745Ijt9006807;
        Fri, 4 Aug 2023 06:10:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8kfgudeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 06:10:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZqAmbzWiONgxdxwPUz4VFvEtaw7VWE/AfeoiX6nlTYHD75hTY82PqpZ5ulsO6WnpsnbTvXF0K/za2LEH+FlG9Qjb2ohix73adLb1yDzFjt2zhELOI3gI4cgQ+jkFiujFPNAPI/UxZW8Ne/CSY/jnQY6RvCEICNPZ8gwAusfBf+KtacFvJCbp3+g4tiw9BS2C0Z/L2sUDGL+TBUu4BHIAg3Tkl9B1gQMyhOhBiemM8Y31qgLbL2w7n6+zW8s2qgvKytyf0J/d2YiztUey8TjaK9rq1rNOSxTvf2D5WpYTFQwqyU8L7TreXZc6wOd7Q0b5OVnjPpPw/KUhycPiK1n0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoHJK2ySiPV17YWVNkhehbyPa3xvk+KpdbaB37FREpI=;
 b=GWUjcaadZK3Bqp1CIt7MmqXhAWNSoNERZnoD6snQSGgnWvKzhlXr17wk2RIxqFwaqnn8nFn9E8/ceNqkRzGUaTN7gwrXaFsiXR7EgjmFT6lgVM7WdB0xowWcd+R6F2nih3B+q1BNZ8nfBq0Xl4sPDb02dTNGHfZxZLdDAvDzTaL03x3oMF3NwcUOIdQf7NgYRImEwbFigM8FMZm5BJTsRoiUY2h2VfVCKl1GH5O/EuiVKfNeAY0GbRj/4Q6p3eUkhrQUvBeG/cHCp/LQrwrka3CDbQ3xzOYDtHnQYX2NA95DeLwJsJjmmCadAuQ5y2SebQVtD400lwILKvSdr5XvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoHJK2ySiPV17YWVNkhehbyPa3xvk+KpdbaB37FREpI=;
 b=Hhnww8v3WUW+eMjeFE9EEJbXpzMBEhmO4R+JcQs/avrIzl6N4l8MyKedjIdLlUroRe0Hr582CfqmiJi1B9eQROTVcWnffFYgz94thYgFdUsLg7j36biYnED20HI6kbrCb6mp6LibLE3pVB0GtpBQHpmkS8Yb6FyAa4ndKG9ULEk=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
 by CY8PR10MB7122.namprd10.prod.outlook.com (2603:10b6:930:70::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 06:10:12 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::707c:5a02:87a1:38e0]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::707c:5a02:87a1:38e0%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 06:10:12 +0000
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <20230804050938.GH11352@frogsfrogsfrogs>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     corbet@lwn.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, cem@kernel.org,
        sandeen@sandeen.net, amir73il@gmail.com, leah.rumancik@gmail.com,
        zlang@kernel.org, fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Date:   Fri, 04 Aug 2023 11:38:30 +0530
In-reply-to: <20230804050938.GH11352@frogsfrogsfrogs>
Message-ID: <87h6pfwd6s.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5867:EE_|CY8PR10MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc793ce-2438-40dd-ca38-08db94b17660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+slnAlIiW9CvGezF0vzLvRVXIhgaixvODvnCyLRrzfN8kBhdhIsF1B1VSuBmpwefGMIRtbkGIvMNgu7C56WGJVv5XrAXlGRbGJPUSdcM4YjEDt3tc+JloXALPTO82QJ1Zxg58548HQjmJVGljUvOahAeQaX9wwa2/IBtkTNaPdQ43Mm7yxZUj/v+ZeB7rdCh6fwkE/pL+la9HCCKTkU23dwkQWhH8v/2vXqgKqToeEXvWgXZIc4g9ntqlEJo7pbfpAXgWTw4HWxBzDh2L8tjn7n6s9uacLH/1hfFWAU7Im9aHuXZV/0tzRBLIq9Zi806lK0s0rgA4Ts0cq7RSKWZEQ5awSeCI3/4aaFzN1qQki9cYuL75xEV2lDI+7xUArHGtBMMnxEdnVJfjqaSiWxD5xnS30RBKtiYta2Ccg4zQCyknGgXeyKnPW9RlFmnnMMxswpmX3Y/6mKJwxevlVhIbUcxbAhxLMfBqDbkSpAyz9my2X0fDhn4NdLVszWtRQ2eMmqtURwE8hZ7wkfmQ3AmekgmN4NQ5QlNBLmq6C4O/g6XEpbBPeJIPfDbXi6Fiu5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(107886003)(53546011)(26005)(6506007)(8676002)(9686003)(66556008)(316002)(2906002)(66946007)(5660300002)(66476007)(6916009)(4326008)(7416002)(41300700001)(8936002)(6486002)(6512007)(6666004)(478600001)(38100700002)(558084003)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yf131NV1A5SYK37b0vGK/WWifflwzLQhYY/2i52SRvAkpNVq7/xvJjMJqjI1?=
 =?us-ascii?Q?owW7h/SH3LByMUDY617XDJIhTi2fq+8j1LwoVteoF6MKCMf2Zf30mjY3hXom?=
 =?us-ascii?Q?bs34BKZWqPf8Rq5I5IAuw+kV7m8+eU2LjXUlseDJgz+zlXi/7ub3ccz0ZLj9?=
 =?us-ascii?Q?zYReF1/XVijFLa94B1LDfcrw3NGpZBZhmo2zs06wIfENxIqO/jmu3bJ6vcMS?=
 =?us-ascii?Q?LNGa35lCu51DzdePYUfOBxSp0wW+2OKsQo9jegxXmIbCBSkvOokVvMCmshgr?=
 =?us-ascii?Q?wt/0rLj+bz4bhg1iNsJfl5aV4dHPvFKsQzpCiMGReCiGYbLxzVV9hP0SgcsP?=
 =?us-ascii?Q?HeNPicOm5E+SHtO3wTNgZso9kcOix6si9T6wWRxgWq5HU4O6jW5ATHXvNrpt?=
 =?us-ascii?Q?8/ojrucw1TRiP7eLTu0zznpuhoiHlAwWai9/vlUgoXoCwJmprIejshozKQQu?=
 =?us-ascii?Q?uQfbg9dYvOFfXBadZfk5xtsI6VW1ilPmGS2fo2s3bmxVzkmljqqkkVc+vm0a?=
 =?us-ascii?Q?nU18IzvbGS94knnmd9nvNpeViU/rQ9WpoHPUK/hakXyMC1xAzQXzb3DNno3k?=
 =?us-ascii?Q?gQvBbs0aYi5BWkXWxuPdmyQyDaZo+D9WegkXXWlqLgIf6VvNlGLGigUisxgI?=
 =?us-ascii?Q?G8kolTGtycf0YlSTwxw3nbsx6aa8mTRT+NEuDcm7h1cEHA4f6Fn14qzahPSC?=
 =?us-ascii?Q?bxhkftFkxyUke+Am1AE93IlXNFYVd3QQB3qirhi+aKjO5SQ6/w1bTmVxR1P1?=
 =?us-ascii?Q?5+nSmqZcnf8boxkFqWHkcVwjyhUUoaTO6OkDqOVlf/H6JFTGOajg8pm1obL9?=
 =?us-ascii?Q?iMYTGHKo8G0j36TUpmWWoFOVvDE84F2deA1X8M3igIsTyTZOALlGgPOyrnRC?=
 =?us-ascii?Q?iohsixapVwG0oU5CbP6RVglEUknR+iHIZ35KR6FbqLL5mbntYfGNaUIDbHDp?=
 =?us-ascii?Q?MpKYZcHZp+d1N47w580CHkE+naZCx9h9CClRqo99KNS72mvf1f1P5a0cLcGP?=
 =?us-ascii?Q?yKhlt7IM+mo48RGIrclxXAnnUOemVlxj6s7uyMdVti9O8yE7EOXh0LBeAJnt?=
 =?us-ascii?Q?6ic+x4+c5U3DZLl1GBxSvmB3o8VICZy20a06kgzCD/ZOYNPnTKg0R67RYEHd?=
 =?us-ascii?Q?hbbHikcfjhpxa5S5lOzwDZhvZWzYNnc64eb5TSeTisOvUuc1aKxdwr2qlOI/?=
 =?us-ascii?Q?v1WTQPvUKpiZp99Q+hV/IpWgXOERsQDR4tnsB8XHNXTSf6hRuGj+J3grBA5t?=
 =?us-ascii?Q?+pzuhiBFshODJh3UWBxhVhnlL5LiswcLLw0YDaoSuGQC0vEh7YJZK2wKBhe6?=
 =?us-ascii?Q?lDRHzKHcjvYRe5S9GfMEnwO1t8dpq4ljjV1txo8WvrvFJ0SwVqLv2ZF1QwZk?=
 =?us-ascii?Q?0hDdRYzvH2ODSxLSmRp2M6D1zaFBmrM9nplRiR4uJLaZ8xoGb/08vX3dJHTr?=
 =?us-ascii?Q?M1lkCSWL7Y1G0b0A25pmUemPb37UIXGH2YZ9zY+sWF9u+WNF9+5Sw/LooOOp?=
 =?us-ascii?Q?54PJB3jrPTjBr1EiUxU3bGRJGVug8ZoSkXoF9fsOnFxA+e8S1x/+mH/B+OTR?=
 =?us-ascii?Q?WEeEXTkl+TYtLfuuxdVkxneLSto0r5lwW2+9QhwM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9J+IYTLH6GB2LfEzPYVDR9h2wALuJTLX/mL8eoNW8VZxPJKcL3oL1W7/1HEJ?=
 =?us-ascii?Q?5dC73pcbALsazjUGi36m+hpd2JWa1LrS8zm9itq6rnYOxL6+8PoPgoQND2X1?=
 =?us-ascii?Q?+9V4cqN0D5h/0+7YT3s0X9tzIXaZrJu1Q+VYWIQV3pjSzLCvAg1TB56nzxQF?=
 =?us-ascii?Q?EjDRphfqeYpHnLHI/6alDzkqNo/A7jSPPMEKi/qKrSZmVuEHQnVguEqXFFow?=
 =?us-ascii?Q?iKS7UPADcMc2hOkg+NXyHcKvogmy1jhsnSLr/4fTmKYyIT8eCkwevvp5SDkp?=
 =?us-ascii?Q?60OIEtK7zGK5MqLYUVStRNZZevZzObDzYHj+wSIY0C3MuUR7O/u1o6aOgb0X?=
 =?us-ascii?Q?XiFJlEBBrHDj136/iR2293qk4BH73EzQ1uJddGDjef6vVp3vOAgAl9+9g7Tg?=
 =?us-ascii?Q?/U5uLVqMPT/cdVvceEiCh67sI8zb/x38xrByq588P/b0q+l1CXi8C0G8FEVq?=
 =?us-ascii?Q?1s7IoJJIcYAGRuqaa1WA0t6Z3cQ5HQGYerscpAvM4D1bMl04tPxAURw0wdk9?=
 =?us-ascii?Q?YK2UJLIjkkd9UhZzU5ByRo3BnC3jHq4VTU83jRMV1OivRDzWWCuaz/nzTFHo?=
 =?us-ascii?Q?8qq0PZDRXMLGV2L8+o5bw+/jPf88kCW+NpDtu6Go57K0tGuODx6h6WUfYtZg?=
 =?us-ascii?Q?SFdig3qvbwjWpPERcISyAzkjJX2E5hlhtQWH4KnHZvpUpbdyFM6aQZ0hkF4n?=
 =?us-ascii?Q?5/BMYjXkPhPHAXI4HQo6MI8iTQSZXbqf8/rCllP9F717SEB/un9Furr9wffc?=
 =?us-ascii?Q?c2xCg9dQpJXsAFp9eZgqjAYpBqFRr/oAb+yrd7sKL1bHCEnweTxQi4brf1Dn?=
 =?us-ascii?Q?ENarqvVx09GayG9KTHFYyE4QmeTM866oiLSLrnoSELJZk/N5wmlyY8b5rPDR?=
 =?us-ascii?Q?rMYsGtuu/lJPMFQZbVxYKl+E1XDsIiKOciCT/42xPGEr+49aYCyihilkLnBK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc793ce-2438-40dd-ca38-08db94b17660
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:10:12.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8aIZtTwbofGq2QHsHgoF8V57f+0JsEl7ZOEi1+LtYvMIkHRtmoj+OIf3wIbyP7QSsY8CcdJ+mJM69fhVlHeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=922
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040053
X-Proofpoint-GUID: 0z7NNt6VuPZnOha9j1kNT_PWmEdzSzVo
X-Proofpoint-ORIG-GUID: 0z7NNt6VuPZnOha9j1kNT_PWmEdzSzVo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:09:38 PM -0700, Darrick J. Wong wrote:
> Adding a few notes from a discussion I had with Chandan this morning:
>

The contents of the patch along with the changes mentioned look good to
me.

Reviewed-by: Chandan Babu R <chandan.babu@oracle.com>

-- 
chandan
