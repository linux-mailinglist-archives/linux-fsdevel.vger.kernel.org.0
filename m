Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51037465D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGCWsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 18:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjGCWsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:48:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A092AE71;
        Mon,  3 Jul 2023 15:48:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8Uox029774;
        Mon, 3 Jul 2023 22:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=JRIEUmoGXevEdPQfY24Dyk1z83mGmmqZu91/V945zg8=;
 b=t1LCmK7YCjSUfxuPR79GmpJtyVEXcP9Yz9w0bKOfkVdGHxWOJ3sU2YDU1KyjxhLBbqjK
 0JWHZafi4U8iIBBjWoFDaR7NBZeuTrSVBAiT/2CRokgSd6VZjRj1Upn5ZQIYFGeElRTy
 0+yFvmjCXk/DWWO7oiksdtmC9d7WJWJW/5zRMwXgjb9PrXBp0IKYnrqFdwfUU6dn0+C8
 c/bFnfHQFCAFQnb7wmrgWub9aQMNflE79stY6B69vW9O55nm0t8M2Ym/1sveuwsGFeuU
 scBA5QmWjsPaBEhs5D0MiC3VO4yzFwUQzZ3LKOeJrksSqxzKidwwyxpHhxjiCFuZRolO Gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjar1bhwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 22:48:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363KCxGv010886;
        Mon, 3 Jul 2023 22:48:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3v8dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 22:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8wkdRh6VDEp/jDkJFaffe7cCBvLkgL0qeV3FlgL7XjR6yV0dyI8Z6V8unuEPtD6D/wULGL2kn1CIkTy7DjpwqdVF/fpJl/sv2cQN52COkANOgRzRH+UuYl30evYmWUgF1l2F2rCI9E7PH7qexZfXZGGdUHDmwzDhtjJLvsgBKzQvBHOFir1EQldgpfxqApOCfST84KXt/n1Sct/ws/LOAYiV021nvjys9Al6ILJP0Xkl8veVEA8KGxOh6u+QDdDGFRRpX4XM0Uu8QK+Oo8IL/uCGZqU33t/e9CKLJGIbLOqsY/GhKpMg98KxKrdI9ZTXOLk5l0oqppyrdP++ON4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxvCz5jfaSbNAAmDKAtsgxNv7UkqMsr0TuTfQiF2ofw=;
 b=oDwpUxnq6XbLmixl/R+BUbhBvlSKxY5CpGGYmo0hDOqJP73GyR6wdWf8YnqqyMhwokz2Y9qaSTUlQeOWko8TA3ADz0gKj4Q4e3ILaYkJCGzYh415DdpEv8YZYrIkE0M0cBFR1LXaYasN+rhsfrFBCrD8drU2GR/T9OkgRr4FANGwedc7RYPDKfvX3Bw6T/LdfN+Fzwl3yWwC8Xb6FrpTWcB40o2Op9r2vTkf/wRhDGAPab7YWKyOZFAUD/sJsQWfW6Fy7cFIX52ttSsbaqQNCO5ASQIOMIw+/mcQpv70VkBuo5wZgiQrYY0a8gUCeZBv1Q+7br8BmHFRCLNWcP8w/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxvCz5jfaSbNAAmDKAtsgxNv7UkqMsr0TuTfQiF2ofw=;
 b=dP072b19CjxqpzJph85ToRDN84WRM6np5lTOe88vkf/jzJO0KoeR9uLT1Sq+BDBwmA3eDvxBGqHZkb4dsjnrxLceK6jVSoIgRdOrnIIEmdDZtnmCqThNIM3cWGUxtvmBvYjRFOXNFTT9Bg3qoQvYFH25iSnWbstQqSuF+fvDO7o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW6PR10MB7640.namprd10.prod.outlook.com (2603:10b6:303:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 22:48:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 22:48:06 +0000
Date:   Mon, 3 Jul 2023 15:48:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Willy Tarreau <w@lwt.eu>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH] mm: make MEMFD_CREATE into a selectable config option
Message-ID: <20230703224803.GF4378@monkey>
References: <20230630-config-memfd-v1-1-9acc3ae38b5a@weissschuh.net>
 <20230630153236.GD11423@frogsfrogsfrogs>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630153236.GD11423@frogsfrogsfrogs>
X-ClientProxiedBy: MW4PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:303:84::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW6PR10MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: d6003f97-c625-4c11-8f06-08db7c179107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TniWnPla8z02L6XXA6hJTMwdy18ZU9R4vxsw66zJTS3Oe06i+UYM16LASgNR9yHvKiStlNDrTJNsWVW0K/1FN38Tqsp1VN5I/rvPg23y5RtttsRoD8PWkykS/dN2RHfKwLhA5dVPmUS8zcJMupcEOxODxE+ODd06mjJE20NrGc/edIRJTCK1BePfB7U54Tb325p/KCYHjqzUDkF7OCySX0Yc48NyC+zI0WNc/Xa28/Vckqgh8KU04QDKE2me6ZPlZSndk6lJJn9GN/IvLayDCpwee9dYAmqMbetIAKxcfClrbS//82k9lqkgYxQqImja7lF+buo+CZUokS093ZZ4v5EOfg3OR0MMuj4os8YI/X2MmosBw+2IXI9hVwMTrrs806GgXgeu+ZOtbnZDuzxy64wFazHyx7deQiuJDFhZWx+BD22RNuBc2jJGwFxmtQRc9mZ6VDicQcewRsikLyzGyS4+ShfkNXi+ab76M3omacjCS6FqMmLvnpfxN9jnt0rvSJNlx1uvpLRDX58xWDqEh1cxXz61VmgjzQID4euzdC7rXfP8faCSxjNm+VPi9G6W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(54906003)(9686003)(26005)(6512007)(44832011)(53546011)(186003)(5660300002)(8936002)(33656002)(86362001)(8676002)(6666004)(2906002)(7416002)(6486002)(4744005)(41300700001)(478600001)(38100700002)(6506007)(66556008)(1076003)(66476007)(6916009)(66946007)(4326008)(33716001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bKbRZu4DXiybB3ST1VOcFai46XbLr1FjDAsQ3kOCqHpZ4ASUS595M40EUR?=
 =?iso-8859-1?Q?NQbFxuxcedN2FaWNYk2ZjFH++ye+pByu21qPX2qeoFeUVjhcIMq5UJlo8U?=
 =?iso-8859-1?Q?gfNSia6tRMV9ZtbuINzui/rgSZ+zywnlEXgzwMycR2/L3x6zCwbesMUZVV?=
 =?iso-8859-1?Q?6PI1Ro0upHU7zicRuW9tsvbrkpH+LsCdAhyTkckWhRO65kYpvTR/brTGqg?=
 =?iso-8859-1?Q?QbRqmCgoUrZb9T5z9NccTIhCAOnNpkPj9t0QAAK0h4UxKfPXUcxkL+04dv?=
 =?iso-8859-1?Q?1K/bwNY4xZL3QmttPYftZvyoZUmEiQaGgNsrcO3gjVRsMBoA1p3FLvjEpV?=
 =?iso-8859-1?Q?Hc8lWDhw8V9woipQrJCH9LgC4Rq+T+BtWfk1xvpZi/dIQKy/0P931gxNvN?=
 =?iso-8859-1?Q?Ausme1BZSP5bfjTtHqiribyYd4v1u2pmdPydUNgdwQT7yLiKY18kkE4W/F?=
 =?iso-8859-1?Q?AvTy8FXnUMJ9UHV+Zx0uVqy3Iumc33KWNY1Rr9OrshV8aBNqdpfR9Nuqsv?=
 =?iso-8859-1?Q?hTZNkNRhRzXVJBY28/JVBqqZ8GZE89m/DjHA/h6VzbrGVFS70HrxW1jzBq?=
 =?iso-8859-1?Q?Z7WqI+PrvXeV0MinfI/lik3VXuMB1E0A1Esq3iv8h1hP6m0ID6LOspg+9k?=
 =?iso-8859-1?Q?vnLfJtxtJoVO/H3mCwVYbCX4dAt8traLAZ4jo1O0kfcUf0rNcO/kyBRXzp?=
 =?iso-8859-1?Q?UrqPCQJ84NKVtq319Qt/6pQsVUAnsUkcyl0j0HGm4hlxNjtWERyZNQPgG8?=
 =?iso-8859-1?Q?qSqqkV9yr2K7ukXgg7Bh+NQrDsevHyaJy6mNY+WCjhxuTYZ6IwI2LHIKnG?=
 =?iso-8859-1?Q?FgmPYREvrwuzZBV5svkmxeSIGWSN0YLCgAMLe9GgNF2frE3I46Ed+xIGnV?=
 =?iso-8859-1?Q?jyZOf+7WUmyQGGtWBRLG5ctXMBJrE0253zz6tFqKqQTykfWxTsn6/eLuQ4?=
 =?iso-8859-1?Q?9sj3CBip0h5sLo/uxYZ9o8hoyZKfmS5I8Cw+COx6HVnu+DUliL63KEGPKe?=
 =?iso-8859-1?Q?JS2SLpAWvCC1hyxmfTUYStlJ8P62rpp/D7LxfYbCnb/4jLmbdbjt6WWvr6?=
 =?iso-8859-1?Q?WvHG/xyGuAXXCFLo8uD80HOxeIj0fEKMAZbFe/QleUxjs7sIalb0091npd?=
 =?iso-8859-1?Q?zLzDzdekIskM/d5RhLIAbE650C6sCNeGgkf03H7fTdZ2Jmb0j3kvn/1C65?=
 =?iso-8859-1?Q?GINAVBqsIdPicH2IgbV4l1UgYCHkhuj4yx67HwhAQvfkTtymNNBes2YSZ/?=
 =?iso-8859-1?Q?DUMuac+Jg+n50unt7O+kK5GU/6giT7LMqu1zgl0T8hZNiwlkk9ZesMYUHD?=
 =?iso-8859-1?Q?FD7jSWssnaL36xui033zD6+p852kiMphXfGHyHDkLjUJbYuNdT70tRz8zI?=
 =?iso-8859-1?Q?YiYbUCqJB5y5plxQKVg0oHZL8/xJjm91k8auLj0DsgQXSx3XwJEBxNQU6D?=
 =?iso-8859-1?Q?cStWRgb9hOUbYU6xqLqwMYoPXHsTx5SyHx19nU5RIFp7QixGI0KSSSObRg?=
 =?iso-8859-1?Q?W+RQiewcnYtPrm0XejC1HD8LeqmBiqKCjKU9zAE+TfKNh360vTbBo7FhGM?=
 =?iso-8859-1?Q?/i4l/IVTs1eITqJzmSRkMCQUk06EG5KVlYcS2rsyIY+KFiBg/5Xd2lrkl2?=
 =?iso-8859-1?Q?lZgg3jo4Z2zQpFSIPKq/Mj5kXih2qvkTEG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?vf5WT1doqH01s6+iaZs+R0iwiMWtCuL1GE5M/u/Umw+sqE3Co9rMd8kBqU?=
 =?iso-8859-1?Q?Jqd69na+aQxqRgxogw746KjEAYrAg7zFDxCcj2LPGrSldMY8E5JC3x9FBe?=
 =?iso-8859-1?Q?i1z2IJeHcrCWZcdhHe5FT3NMGpHW58yvQrk6/FdDJ1EjFhrxXj/tA+Sivr?=
 =?iso-8859-1?Q?uy7ohk5ueSTx92FmME6f2/hEk3ZKIxJJworUVRlbvfXBE9F/dklxgZkb+n?=
 =?iso-8859-1?Q?Uja2rjzaoju9FFV1aWwstZDD+Fbmp0GuXMfzoth1WVoJ76oyT/F/RTQwAz?=
 =?iso-8859-1?Q?ppxRPmYr8FZhh1EFeMFK3JSHt2Pcpo7Or8O3RyPA9qid9pQHzHa1kRaPpQ?=
 =?iso-8859-1?Q?mWWYq0uM3Bxtllh/1g1ZjjdsnDXf5H9oJGkihnwMggve9BhQyBc8b9tF24?=
 =?iso-8859-1?Q?VwfpAyxs+/p6t75eyj3S9TYRhOq86WKGXGMHtd5p2vaBchUcb85OnDUh6/?=
 =?iso-8859-1?Q?+YOxZ59FUmAD2DIEYxzispkRZBQHlyI0tAtZKTkLa3tnN5UbuvubMKlxzP?=
 =?iso-8859-1?Q?OYOyCad6AO5iKkMqMmiOFvmxS3E9yy8LmGeoh5tw3s0ZnwTID4AstydN6j?=
 =?iso-8859-1?Q?PN7bJDshelRNkAl9Qzj/ZxaH+ZynGfEMNp2vgDzcDHNUf+oPTHfzByCM7L?=
 =?iso-8859-1?Q?D1FoRxLWSbRJmv41jZ4Cix7CXL3O1IygeixBVkmxLQFVp+6dR3JURU/qro?=
 =?iso-8859-1?Q?x4//mvSefT4sOoP73mbrCEOxuNJS7MDdD++dPpeqk3uEtqyJuA/cXAmqeD?=
 =?iso-8859-1?Q?IHrFmhnliR0hyotclxyt9t7xVc15lUjxNgud70MRJhbf2j/xckLN8yfuZZ?=
 =?iso-8859-1?Q?/BWB0Ceze4JZ9W9Ugydcak9xkH97Bd2hjzZnCzJuvlWtNIDRUZ+YYwSejl?=
 =?iso-8859-1?Q?FhbF/0MUkDmwCHLHIfBGrKu1eJXNzUSnoHHdSMV2TDt/mxFi90d/sBISd4?=
 =?iso-8859-1?Q?o5yMp+EcWbte3Nq7uXUyszm4zaYFFVgwJPOR85i04z1ZYQjcidXdbxQ8l+?=
 =?iso-8859-1?Q?TkK3S8p+B4ak+b5oFzaW0igqiLfpbalo4SzYX5sQdx33HBExoJxCvXVHR5?=
 =?iso-8859-1?Q?jA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6003f97-c625-4c11-8f06-08db7c179107
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 22:48:06.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFU2O0TN62VICsxUW05QTGkGlEJ2VLwt49Vgub8745Xi3dGCWKbhHE6Pui+5B7zQ2Nv4PdtDdDgBqQ7TpBs8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=705
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030207
X-Proofpoint-ORIG-GUID: diuUtej3S4PRqh-aiEgq4KVo7zKceQKc
X-Proofpoint-GUID: diuUtej3S4PRqh-aiEgq4KVo7zKceQKc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/30/23 08:32, Darrick J. Wong wrote:
> On Fri, Jun 30, 2023 at 11:08:53AM +0200, Thomas Weißschuh wrote:
> > The memfd_create() syscall, enabled by CONFIG_MEMFD_CREATE, is useful on
> > its own even when not required by CONFIG_TMPFS or CONFIG_HUGETLBFS.
> 
> If you don't have tmpfs or hugetlbfs enabled, then what fs ends up
> backing the file returned by memfd_create()?  ramfs?
> 
> (Not an objection, I'm just curious...)
> 

It looks like shmem/tmpfs falls back to ramfs?

-- 
Mike Kravetz
