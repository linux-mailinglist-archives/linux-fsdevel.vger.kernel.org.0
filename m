Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF846738916
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjFUPaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjFUP36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:29:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BBC2;
        Wed, 21 Jun 2023 08:29:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAoh5003672;
        Wed, 21 Jun 2023 15:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=AVvfWEMRRP7KjBMmHObpyhgXk6ooqtAzu6LbPoIaCK4=;
 b=GI8mmxyEQo2Va/m7khLNSqAiKDfDtmhbkBYs7jQCm/OkTlBCHsYpZeZ469pMtkZVq8Vn
 rKB2ci+PGp3wWzic4dfHx06awrY2VbWcXHOjbBqo2rJqke6BsNWBkpqkJfaX7pjQIE9r
 IZlvTNaoIcagXQSN97mNu+/IStji3uVL8YpBUbULRlOfg3m4YNsG7q+K1EQVv5puNlzA
 H+wOAkUO9BKhOjD9yzfVM/ErX5NFNmADk00ksokS9dIShe4gBeXyn8A2xLOwUVQee7BC
 tx4cGyfiASpYlU2oBDZormQI9OzcnCJ+cyeL1d1i1b0Yq/3A6rKNk+Fc85JbPC9Dnk6Y 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95ctyr1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 15:29:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LEmHZf028849;
        Wed, 21 Jun 2023 15:29:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939c6th4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 15:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYI83DpQtJ2cM2eYYcj5fDRnj+Z21loeU0PoMpUdGVvqLwc4lbqnJzHrhMye748cusACoHh7MqrXG9NFgyVTTw0nXIJizi3rs7HHpW0Jbm/SAxNogpOVl1TquWcWdjkzwutd3OYVG6R5lXSuLfiqB5vwLCIn9i1F9bkaUKtB7sY6VOonxoNQ2R31MZjgWp6j24jfZExYIQdH8JSzoOJYRWOx3GpszPH9BlbhR98jZrcjX3zgQpgVj/LZ7d580XBwuVdFqRRU4dbNwsRIPRLnOGw5MGSpS1mrGCBfmsQDLZz3JEGh1u/mdU2hpShcLY4PFAaJ45TokGwuP6SXoFZIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVvfWEMRRP7KjBMmHObpyhgXk6ooqtAzu6LbPoIaCK4=;
 b=VwumWhRbalb+BOdvqbY2l6KfsCVg7qkZPIa/L+yt/CbmQSP7kcdgncEd3Z/4SUksTbrEFs+9gg5JYUjSBZ0j1WjY+iUApnJzq1TH+DNaWiJHlBPDiufw6J4bT6sLQtxFkm7gFV1FiOuBdgIaJvqoouLMmXtWyfutbtDRMKhsQgtQbkQI+aw2Fj7AmzT/wAor0Dz1hCAHRZHv9qC+Tf1FDvBAbCLM5C7c2RZspjIcQ7cVlNL9y5TqzY5Say1TgYorL3HWLDAz8QWG1aYeJwJrfV/amuzouCn4OPBckHvhcUKScdBuuNB3JSJcsVgw8+qO6fLXhXonI6iLihTl7t0bgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVvfWEMRRP7KjBMmHObpyhgXk6ooqtAzu6LbPoIaCK4=;
 b=uyknwW0PdBa8mn2lwFbhgsJvMvKZYiQwURXqyUvC/UMsFx6ADgpnnw8HchbJ8BSPQanp66ApxJFC4KaB/eqdnTgJx9Tf/nYqmn/HNuwHgksds013SGtj9LSMqolf4gwBOnFh17rb5Qy3ifsNLv0ooXO+pb3zQ/WHeBA76w1+s6c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 15:28:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 15:28:57 +0000
Date:   Wed, 21 Jun 2023 08:28:54 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [page cache]  9425c591e0:
 vm-scalability.throughput -20.0% regression
Message-ID: <20230621152854.GA4155@monkey>
References: <202306211346.1e9ff03e-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306211346.1e9ff03e-oliver.sang@intel.com>
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7890a4f2-11f1-4a63-b3e9-08db726c3b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDXlroLHIP8nRMF4IT24cndEXywyaKr3ipB8gPJXQJkMnh+Dcv8wfkH++ckGt1v+iyMdjDRI0h37W/0vYyP/f7/o57Z62VQdAU1NljpoNONDr3Y4AQLKc/2AhZoUFrxubbsp+t2/sRCW3ogQPdGeG1SZkSzH+j5Pa2Q3zsTNERUOoChshrKRAbs0/g4VjKPlN5ltq6BtB1bkkA8GcpZErXEEVekNoi+nBiq0DRap5X0BZY/oNDTQy/Dom/qfEz3Y8HwlrK28PPqHp8ewjm8GM7FXRenLS1H6z7Lyua5E/S10UK6L/IJC4fOc2tMZEgzMcigvM1Gf26rlc1GcFBUr9xpLftmZdGiWHSk4N9yQKFGQQtS8p8AJMXr82kwVXfLE1is2oBJyvFuLKHw20zQ9fJBTTlhoh9iYnhGqNpsJKdR+MSsdy0tQtzvSn+kucqW6D0MiokWGxFkDggWqL9b/+lz2wIzdAeWPxNBn2UuETi+Z+FPf73sp8/ChqEi2c/xIpmlsvOnYdCMga8y/9tKzEgu4BLML1XU4reWGW9ST08uaO+Ig02dbUAbjhXDpoiQEAdH+hNHKGjTFBv3+Hjt94w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(478600001)(66556008)(66476007)(6916009)(66946007)(6666004)(33656002)(54906003)(316002)(33716001)(86362001)(6512007)(83380400001)(6506007)(966005)(26005)(9686003)(186003)(6486002)(38100700002)(53546011)(8936002)(8676002)(41300700001)(5660300002)(1076003)(2906002)(4326008)(44832011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zbxa0kXpvGoNdRd92QbpO1wfmRtoOx7TsOHIqT1PC7CfJ9uSflTKAgHsjpGb?=
 =?us-ascii?Q?Z3wOPRY5m/TGcoMtS+CMYH7P2tJq1Sv3lnUAEK5KM0BH5MJJBdFgRGgGoplc?=
 =?us-ascii?Q?pf66ziukxxy2aV/k57uGyrARcbk11hn+qHD2tEd6/fjdSknygcn95I2dpeBz?=
 =?us-ascii?Q?iUs0jPFtsK5Q6uDkdPxe7RK9ryuUpiRsjfowVCvBpt2M27s+UYgJrURrKoaT?=
 =?us-ascii?Q?veZEoYj7rJ1WkwPIbuBDslgzbU64Y4NXXYRnPynbjtoTgHhIJuc6bijrqRja?=
 =?us-ascii?Q?R/S30Cr10EtCr4CrRRgJqZWMWLQDWQC/b64dNLtLKPtIrhzU1g4TkhnDSakV?=
 =?us-ascii?Q?1w8cMFLnIOVoGjs/Yy0tmTTxi5Opyt2grGj6A9pLRFdfoiT7I++gaeOUTQb5?=
 =?us-ascii?Q?Tu9xu2MpupdTfaCY1UTnM5T8ccEU+8X6fpu8hWhI+g5yhYc8e9N9VoWS4qfg?=
 =?us-ascii?Q?JWXgJYEb+RYY1tY6a5TFnuxJ0Iz8/bnKNhvY/hxKB/3yo8vgDgOm5bLuZs4H?=
 =?us-ascii?Q?950+1QL9ObjGygb5iGI6BooD1TXVSTqqD1lnaGVyDTYT61S0teCcUbZgrqlh?=
 =?us-ascii?Q?slLKaWryc9G/xzevu5Vg6ymWt8b+3TNCd1bJ/ADSnbuOKOfurmKzMKwXYfxP?=
 =?us-ascii?Q?E2rU/Uzza0m3EXN4hCCYLvmT6WPUsQ3iSDbuWrgVAf2yhInWIASD+itZyCf0?=
 =?us-ascii?Q?i4mz6zpSY3LpcXiiWVVS2dQcXh3uPDT6ifvYj2B7fnoqIuGPtDFKFDpq0wbL?=
 =?us-ascii?Q?ni+fpbSCjku13y1DYQ/4WRokHSIoqWxZ6qr+ItHCZgyN+/TKs8qVUT8xO8FS?=
 =?us-ascii?Q?IXAXRWdejzhDSvTHHVdVIaxfdiMVLZxRVU+Uff+rbkD92ej6B+wVzorCyzIz?=
 =?us-ascii?Q?zRcz3WZi+PoqjAHVdpo1c8V1GMqp5/Rjac5pge298Sh2cZ8HBXV+SvHSjwVL?=
 =?us-ascii?Q?7EhSF3Zq7Zfp+4Q4cg3fLs44odIvNy2lBxov4ykhyYTPzaQyWQpgo2gyB4sg?=
 =?us-ascii?Q?CfgZdOvqPgSodcOVthDAoOzbj/RRtC1kt0ZmoHb1LTXNkwx3L3DAkkE3Ny4Y?=
 =?us-ascii?Q?xpLQd/VqgiBYFWrFDXXUBWCr7Ve0h7S6pNcYsFg8oxzUKkWjaANZWe6Rp1ko?=
 =?us-ascii?Q?sme9Q/gCJDoVBzTLQCkLI5hA0s5iAO77ANSEBBgEKraiH0DZ++ggxOBPU3Se?=
 =?us-ascii?Q?fJN2HKHeVxA1SZh0f+bhRasqWFA6oxGhqlC0zklAeQt97qlQSTLSYVwgaL7Q?=
 =?us-ascii?Q?wkVHWDmwyDVl5ux9WnPimobC6Jn8gW0lTGtyTpnSBlZ0a7DtqcXPaZ0eTnHW?=
 =?us-ascii?Q?XG/sD7D/75FbV/4pUSQowib2bMxOuvE8Dncb8n1tXOUlxJnhXeAasj4svLGu?=
 =?us-ascii?Q?2xF9aXZyV42PF01iLSLRfG4IETR7roxUsUheYwvJ0e3bg7krM11YO7VBVfwr?=
 =?us-ascii?Q?Yw6CxYU9WDqqwT9baV1XNS+n0pEBvusy5CHPm12sY34hitiT8S8bz+rj1ZvA?=
 =?us-ascii?Q?xDmplbLl+5XfAxlga+/Axf9tgxgcL3BLnyohcU72lnBSDGRx+IXd+SMpyMGu?=
 =?us-ascii?Q?HcMW+JSizcy9rlf56c109H2dJFzecf4gbQ/0pLjk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cfTL1aINgtHct5n0kLh5P9oUIgCBwzvBenasTS3MXB8jcYtX+w0umG2fbaXW?=
 =?us-ascii?Q?6+BXT9Ij9cboEYjOCaoyAcNFZeY4KjCxNIZt6BcfVDQF8gAkkeTETGRt8Le8?=
 =?us-ascii?Q?x6X0g9puF7wE7hlF3U7t0qhqXvev+XlB1QYWSNYD9elVX0PTY+5f5UqjKsAm?=
 =?us-ascii?Q?C4HlCfXOZsKgYEBIShBuUDudKAaqu73KycHqqiE1eRr3lHjE3xHB8EgKpARv?=
 =?us-ascii?Q?L+lGVCl/0hUZxgEPYaFiJZXuJ84ClkNJoJn8UB74He1rRq96COLO+JoYDS8+?=
 =?us-ascii?Q?4u0mQqw5O7UfqZWEYDZa3N356N8hSdumXcWp3kXwEoGE5q3F9r0y4nJwT9BH?=
 =?us-ascii?Q?/ENLlfPg6PG377mH/pp4acLwXddv94ZvheOQOpimGSrc6b0kN36piYayZqKH?=
 =?us-ascii?Q?RKIQ4lfUL6LxpPSo9iG4TwJm7dUydKIHl/W6iNxdC5kiX1m6z8VzKEu/FEVN?=
 =?us-ascii?Q?6LiWBKBgAUGWikkech7K0FxrgcUyRMUx/fzPj6oQ0HUgdAWbXHg56IrIAA5n?=
 =?us-ascii?Q?OzTbAOyM65WSR5pVh1M+8TejaX3cpqrSi20TfrGLCBD0YOByB61g6dh3b1wy?=
 =?us-ascii?Q?ra1SMrTowDiISlgC9G9qdTlshF0BIrnoAarhhS9hozpYA2FsyUKTwkLZ6KX7?=
 =?us-ascii?Q?RaA0gKWSCpejWdYyXruyrDWIX3jLMbdSSuifuO4Napu4lGDpBazb9ciGSaiq?=
 =?us-ascii?Q?1+TiagYypQzfoUS1mZJbYfJTqN5B+puJ1vJMAbDMwRSnCTv3KLIV7O8TOoGV?=
 =?us-ascii?Q?UIsbQ7fxaVon64+MJRCToKjohK+rjBtEHt9BWa0sQux8QDJ8OdcvoRti6AYE?=
 =?us-ascii?Q?0ss3+HqLIxD6PhDdEMonmlrku3I9dj47udqPUoLYJ4TFD45jGXZbqGEd6+mE?=
 =?us-ascii?Q?UR4rVBLklK4wY/RNbFmxaHedfNB4KRlNyr3E8YPASyDni5PImmWxWuiBSicf?=
 =?us-ascii?Q?nKxZy/vRVu9sWsCcvpKWA7Y1c/xqmm/M+G5l5C8MHAstIO3mUX4dpgwb0dWg?=
 =?us-ascii?Q?8X1J7WKTjVcisDOV5HuGEkH7I0Ch+RZ2iZAd3+Zb5HC0EJI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7890a4f2-11f1-4a63-b3e9-08db726c3b00
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:28:57.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8tEJ1Szd3LSAx/y+dtP5svQgfzDXqKVQl26n0pZobLB7ppIguEBsRQwWhBGbzePk6REZm7Z4KVUG9eRjaP4yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210130
X-Proofpoint-GUID: AGRd1rb12D98pcHQaaIxuyfxUKB0AEpg
X-Proofpoint-ORIG-GUID: AGRd1rb12D98pcHQaaIxuyfxUKB0AEpg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/21/23 15:19, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -20.0% regression of vm-scalability.throughput on:
> 
> 
> commit: 9425c591e06a9ab27a145ba655fb50532cf0bcc9 ("page cache: fix page_cache_next/prev_miss off by one")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: vm-scalability
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> parameters:
> 
> 	runtime: 300s
> 	test: lru-file-readonce
> 	cpufreq_governor: performance
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput -18.9% regression                                        |
> | test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | debug-setup=no-monitor                                                                             |
> |                  | runtime=300s                                                                                       |
> |                  | test=lru-file-readonce                                                                             |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput -52.8% regression                                        |
> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory        |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | runtime=300s                                                                                       |
> |                  | test=lru-file-readonce                                                                             |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput -54.0% regression                                        |
> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory        |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | debug-setup=no-monitor                                                                             |
> |                  | runtime=300s                                                                                       |
> |                  | test=lru-file-readonce                                                                             |
> +------------------+----------------------------------------------------------------------------------------------------+
> 

Ouch!

I suspected this change could impact page_cache_next/prev_miss users, but had
no idea how much.

Unless someone sees something wrong in 9425c591e06a, the best approach
might be to revert and then add a simple interface to check for 'folio at
a given index in the cache' as suggested by Ackerley Tng.
https://lore.kernel.org/linux-mm/98624c2f481966492b4eb8272aef747790229b73.1683069252.git.ackerleytng@google.com/
-- 
Mike Kravetz
