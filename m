Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C67B4207
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjI3QQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjI3QQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:16:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5141AE;
        Sat, 30 Sep 2023 09:16:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38U9gNA2022987;
        Sat, 30 Sep 2023 16:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=0TQER8WE8CYx0fZeAOi6s55jPkqcvDEsZeNwPRiM0cE=;
 b=g8RhEZoD3QbJ27Qd9WQFJQ5aVNLiL7buxWJIXP1JhAOHNq6h56C6wSqRhe+6zNqptC+f
 pSFN8cH4Pw7NGfFRDAWOiifTDzp2GOYC1iyh+JUzNhdBK6Vm5PuhDjRVsmHBf6rCzjYQ
 5w8WVnF/92NhsUxRImQqZPo02M/PcQ5Lj7NTn3TdfXo/2G/3OQ4LntWNo1CzIKagwJn5
 Xg++GTe0fnwbOe2pW57vUCxlR7dSGhkcg0bwp9T9dDbQ+DaLVGM7MCALcN+7S7Lm2/56
 LkCEmotvsQ0VtmF8/TgSZ/Voy0pGgkJaFaL384jshCQOz6m+7OIlVCF3TmoNqtzvH2Au TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3e8j75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 16:16:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38UEoUkS035561;
        Sat, 30 Sep 2023 16:16:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea439bf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 16:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeHgtt+ZKE1ReCAlcqPBQtb5UY4UGZ29XRuKvU597+V+1aAWUSFdLhEYm66KElrtIS2DemDsc1+1KcxlUvsvg060MoadhC42S9uBNX1vJapU0GIVQanzjDNoVmqOvx1FcZPOxZfDkLpE3hBN43XbIQIIKqdlSBT29ifIbpy/LrM7YW9mnbamQjZ0iJNm/f7lm6KjFREvnnibHOLCosOJCLLP6tHhAuxpxJY1axJf7gWksIN5vt1aDfTehGdveApn6YXAgbeZ2GZv18yoIz4xCs+D4h1mg5J7cHqxLZybQNOZK96LNlCFzczsqP8vdWJUZB29Ia8H41rsuuy5aiF3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TQER8WE8CYx0fZeAOi6s55jPkqcvDEsZeNwPRiM0cE=;
 b=Mf/VGPLxiIqXSYFZtkto/Y4UsE9AWke37AG1PCvUrQxyR9hLuHon78rsrw5gmZneTqA4fO8cICdaM50fjj3Q9v5JPw/RmtaGnz465YdgpKrNRiXb8z44FimmTO78SMi1JIVG4ANYODESR0AF/38G2SrFVoKrlb8f2MONqkm7pNrKH0Th7mcpFzSdaT702r1WQvN67Em1nJ9zBNySrjwqN1j6YI71nyGRxg4zeyMnM3WPcUwQz0Bq7z0Nmx3Dz6I+uaYGmhdCYD8cp5MMugYdDtdmYEDNV3sQq42qs/7Gqq1QExlcHFNCXnDDVOAJ9bCM6/28vYlj0hvwxxdBEq1t6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TQER8WE8CYx0fZeAOi6s55jPkqcvDEsZeNwPRiM0cE=;
 b=KsekPHv5BWmZNNjovv0eTkVwCtROA4Pkorr2D/ZFxy69ML4IEBbV56X6SWKhFU1YvsUt0F4E8Llk4l5g188jDcZrL69c/GzpW2kOJM15vcJ8L1GDaBASO7sW5x5ktyxGKaOzFL0t7zEvqggqKqOBhcQeDQTrEv4Nz4ry8f46C1w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Sat, 30 Sep
 2023 16:16:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Sat, 30 Sep 2023
 16:16:04 +0000
Date:   Sat, 30 Sep 2023 12:16:01 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/8] shmem: shrink shmem_inode_info: dir_offsets in a
 union
Message-ID: <ZRhJwZNbvmp53vZV@tissot.1015granger.net>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <86ebb4b-c571-b9e8-27f5-cb82ec50357e@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ebb4b-c571-b9e8-27f5-cb82ec50357e@google.com>
X-ClientProxiedBy: CH5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff137af-1a43-4ef1-23ef-08dbc1d08b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nEvQjG51WMlAX5Y0d1D6A7vHVaOilg+N1XZC8IMl85cCFlAIUqi3RDtNXqxVj5RmqG73NA5zqRlqWEy0LLnOUd2BgCEB9peWkY3WlAE+kd3zHwliVG4YYS8aznWRsUnwRMQXm9UWT7fTRj7AARr4CwDYTOdvEJt1vgYZeRi3S7XtcrqMi9daab3ilhGELF/w57v2m2Wvo1+vj140vF9x0VFNRp+SOWiGs6HRVhUFh8xIxeEPJfa3wH+vThonjPT3hX/ACQew2eeCABAQJ3G+WfMMz1+ho6kc5U5rkucFgfPkdWsPmxjPL1+sBedVmCfDEae1EMsGysRp1GSeWYEpzLOEF7/k4Rr6kwixTT9UlyjpJCi2/xbeKfuhzCAV1DNBz2n9rY3tBIqgwxo0u/dlSl+5XsxMBrdTcbnjQy162qc4UZMKYBkwTTobqkPnTnY1872Hwas/41kIE8LANqrJMh6tA+HJQfBUt99JdKNQ78tsmW9FzM0I7Wq36hTgW/RtRMmUm1kHJP/vJuD7YheeLWkW/apoi7GH2jqIgLS4aUNuMSgX6n03kUYakCxj4EMS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(316002)(66556008)(66476007)(54906003)(26005)(8676002)(4326008)(8936002)(41300700001)(6916009)(6486002)(6666004)(478600001)(83380400001)(86362001)(9686003)(38100700002)(6506007)(6512007)(2906002)(7416002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XTBKE5NL8Tnl95I2rk11jxSp6AMz1LtxCZE3yTAKctZ8LPGpZ2XSpk9wx87S?=
 =?us-ascii?Q?D2J4upnWuzb9/rdmn+nF3+8oHjqnd+bJCbZqdym6pYkx7ExCuxThXyrwwBXh?=
 =?us-ascii?Q?G2gzS1F4xjqerDhytgezmQa/JGnL0QQmV1eyH8dGRB5875l2zoulSN64dbYG?=
 =?us-ascii?Q?6BxOadoPtaxXoiQDodleVf9MpRepXD+EPRkLvfDBdlyfhI9inyXfr0rwWr27?=
 =?us-ascii?Q?q2FZ8G9VDsGjFyGnYB9utFk+F14HSIfBSuR/unOhhDF/Ak+KSV9Lo0S5tJlO?=
 =?us-ascii?Q?qFZK92ow8t2y8OezRGcjA1L5CjlWGKDbhPpWF81B56weQBCntmx8eWxLdf9I?=
 =?us-ascii?Q?etJTMjjvl8N3dDTfDoS5MlL3MIXYIoLX31aeHuFc+f0Z9Y0C2LmKRuTCoxou?=
 =?us-ascii?Q?XOGP6bid1odZX1AH4M7ZQ2zOhjfz6XPFEmeNjDI28Ca4mi8rI9R7g5omoJjT?=
 =?us-ascii?Q?E8a+h97NiaHtJqz8XSt67rrsxt29OlHfHrtyKpYOPNYHRyHMroLqRNMhp63r?=
 =?us-ascii?Q?QtZeMvvqWkoCcXMHhyEKaURf7h8lkJok87PHUbffKKsnxpJRSwd0ZabL6wtH?=
 =?us-ascii?Q?SIFGeZe5JLiEN/uBAX00UUjks8DB3or0YwI7FrM8WbJikH//LqdaByRM6HGd?=
 =?us-ascii?Q?CdVuIlBvbV9tvD4JDJZ0eoyf2yLC/uuOjAbyC49P6ER1fBJ0hRjQ4es8ABcV?=
 =?us-ascii?Q?nAf56gr5lZQTGRMUq03Wwz+Qz4j2TrKn17K/TByPvbbwOoKGgQzWANzBPO05?=
 =?us-ascii?Q?g3RCDVcyTsSdInTGSUSp+dsdB8eYrpAAGW6Nr34qFAU3KAsVMK6KjDJQM8HE?=
 =?us-ascii?Q?teLD9JZcw4IuoxBSLio8LhB5g048hn1T5CYzEkSVhP8wjI1rd4126/+YP8VE?=
 =?us-ascii?Q?AI+5zeZxAoOr8T5rCDYZ06CZBPFyWTSKQ1GXaxVP6AY0VNbcBo5TvlUgZBhx?=
 =?us-ascii?Q?TuYxi7xIyqdGt5ZWNiYfqP8MHjQPE2G2L0K9yg8RioaiAqnXzxbv2f8DryJm?=
 =?us-ascii?Q?L4lmGcSNQxYYMo/QUoHJQfoXgjOx1E8lbPM88/OvQS/netE5rbVUwPtKYFvy?=
 =?us-ascii?Q?uY7t29LjNdHJ9y7rKKdOzyNfA2CUw76Af3mX/y8oa3BGE/EWgILKZWsz/9sW?=
 =?us-ascii?Q?VE11ITqg7BfHLz6pkW0g8bgtb6Eb5OkjkIKQA4qVOjF3hZmhAll8gWthA+Nv?=
 =?us-ascii?Q?yP7wZE1xo93N5zDqb8wv/s5VMgZTj7F2A4gpRyjLruifpDAguu+9qy5U1/ml?=
 =?us-ascii?Q?DV/s/77mS9hayWRqaC92hWFpkO1dx3ZD548h6DCwyPJgpMKphhNq+0AYdEzA?=
 =?us-ascii?Q?wtHFIpm1Bp0BoYdHvDpndV/TzRgdE+UEOoyvWESvKqckMUaN/qKkxNRAkh6u?=
 =?us-ascii?Q?N7WlLcGItW8i8Y40CL4ms/4IrXVCTTzwsJ5ijSi8jYFnwejebbRCMX75IQj8?=
 =?us-ascii?Q?9MNFGcK80aktHdwZPv+Rss0y8n9LmakTlux+pAehYZDxffYRlR7KKnwuwsrk?=
 =?us-ascii?Q?yW56wocWOSsOrMAwzMp2b/Kr6BpIAa/pctLUSfw2YZpLdVF/JVKYVMMeraWC?=
 =?us-ascii?Q?3Rb/FthySs+b+pENQJqdlRfbjO+FpK99JCXRG3QDm+o9an5Eqm8AeKEefUCP?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EJ5I2gq+Th/AAAmLxvyLKWDP/cBG9W93QOT18XKJDce+IamrFfypUHBcIIk9?=
 =?us-ascii?Q?894n9YvUTrAMiG8KfzXGrqVF0FpkyH9rC6F2zwppMd1/2ag69IgcqG9+Ec8B?=
 =?us-ascii?Q?An1QnLUM5PonfMEXFa0ohg/qcy+csKGFAlJATP7zSr9ElzfDxf7/bmh78ZMj?=
 =?us-ascii?Q?9sYuitTwPgNLhQD/XbHQFxUIG3faZKvzoQ3DWZsXRIAkOh9fft3kLAwO3jCj?=
 =?us-ascii?Q?0JQ//LomRCiRhTcW0TJt/DXiU+/CXfNbOAD6Qhzykjuz52ykFUIuV0FJG9RZ?=
 =?us-ascii?Q?GRvtkDW0c5IlcLt2dUJr9x+jCwpJ6Lbji60s+WLQMMtuJvB0IgC5wfGdoamv?=
 =?us-ascii?Q?l1wqJ51DDsKQIeLqgmpWVnhyfC8uxzqRrWK9nrzEaz8N8dV8/FJUZ8S7LXnM?=
 =?us-ascii?Q?nhjYNfPTSm5gi+Yvd1aQ40OKs2qIwv7zig85AQnk04TCOTig6QyLG1aMLro6?=
 =?us-ascii?Q?T1oms5wde/3EdXEtqiGHJZKkNCEGQF9JqX6p7h2rfhwHcCcS9wcnLXUzhTj9?=
 =?us-ascii?Q?vHsHlydyTZx3H29O47BKCmhrXfORWhx7rcNBhyDH2Z1au2VWD1dK8+bt1Acn?=
 =?us-ascii?Q?Yq71yhskLrk3LYB9jQOmUntX3jq3demSxUgqXkZqP5l6QzXFGd7qhsmRuHfi?=
 =?us-ascii?Q?sUHY+bEV6BgdkDMSBASZoU6f/4y12lCcgrXEbfG/VGxQVRooTPFO56tC2j/3?=
 =?us-ascii?Q?aVNSNfi6zADK8emPB4npDI3OVdrfl6tbZ28OW6TvLdL8bPPVKOt1+P1McD40?=
 =?us-ascii?Q?VfoF3p/Zg9zQOFM/kTH+hrmgCk97iBEeYm3ldjUowIZPa1b8cha1ZTZSCDzd?=
 =?us-ascii?Q?4fa7ktJ1AymZwJbtHip2UGR5BhzMO5Vo12W9yTCU35U+I8wvBmx8zjI+JPiK?=
 =?us-ascii?Q?DFI/upJ7GwswS84Fn4/Pjf9DMFpguPQ/nXnRDxmVSKOZCDfzVV5EvI1I8SrA?=
 =?us-ascii?Q?P3Mh67rHE58jIRt8NKi7mynSjSd2HSR9jnqBMaZB0Us4Wt2L6C92uTuzV2zY?=
 =?us-ascii?Q?FQr4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff137af-1a43-4ef1-23ef-08dbc1d08b80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 16:16:04.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ebq/okYD25TSNdn2hq4/4iyMqxDDMJqihLBEw19LWpKPFycVwIXMDijUvPP49cjEowXmAIxyJ1swO8cLdywnvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-30_14,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309300134
X-Proofpoint-ORIG-GUID: u_mJ-E-7q19aO8hW4fmpBGglKXepqbg7
X-Proofpoint-GUID: u_mJ-E-7q19aO8hW4fmpBGglKXepqbg7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 08:25:38PM -0700, Hugh Dickins wrote:
> Shave 32 bytes off (the 64-bit) shmem_inode_info.  There was a 4-byte
> pahole after stop_eviction, better filled by fsflags.  And the 24-byte
> dir_offsets can only be used by directories, whereas shrinklist and
> swaplist only by shmem_mapping() inodes (regular files or long symlinks):
> so put those into a union.  No change in mm/shmem.c is required for this.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  include/linux/shmem_fs.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 6b0c626620f5..2caa6b86106a 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -23,18 +23,22 @@ struct shmem_inode_info {
>  	unsigned long		flags;
>  	unsigned long		alloced;	/* data pages alloced to file */
>  	unsigned long		swapped;	/* subtotal assigned to swap */
> -	pgoff_t			fallocend;	/* highest fallocate endindex */
> -	struct list_head        shrinklist;     /* shrinkable hpage inodes */
> -	struct list_head	swaplist;	/* chain of maybes on swap */
> +	union {
> +	    struct offset_ctx	dir_offsets;	/* stable directory offsets */
> +	    struct {
> +		struct list_head shrinklist;	/* shrinkable hpage inodes */
> +		struct list_head swaplist;	/* chain of maybes on swap */
> +	    };
> +	};
> +	struct timespec64	i_crtime;	/* file creation time */
>  	struct shared_policy	policy;		/* NUMA memory alloc policy */
>  	struct simple_xattrs	xattrs;		/* list of xattrs */
> +	pgoff_t			fallocend;	/* highest fallocate endindex */
> +	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
>  	atomic_t		stop_eviction;	/* hold when working on inode */
> -	struct timespec64	i_crtime;	/* file creation time */
> -	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
>  #ifdef CONFIG_TMPFS_QUOTA
>  	struct dquot		*i_dquot[MAXQUOTAS];
>  #endif
> -	struct offset_ctx	dir_offsets;	/* stable entry offsets */
>  	struct inode		vfs_inode;
>  };
>  
> -- 
> 2.35.3
> 

-- 
Chuck Lever
