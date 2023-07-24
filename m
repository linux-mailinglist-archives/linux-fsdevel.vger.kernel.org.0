Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE2175F8C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGXNrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjGXNq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:46:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69544A4;
        Mon, 24 Jul 2023 06:44:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6o6YZ009823;
        Mon, 24 Jul 2023 13:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=hRZMgkCDZ13hzNDKrhzpERAj3+WkBbpe5SjQ63ADeIo=;
 b=zY8/SmT8JdXyBb+zkjr7Nbr7S8D9cXllZjkYQyja0jM31vdMkjAtNmS1asdgG6OhevJE
 RagnnzEZ83Bt6DGyGlsxs3zWpTNkeY1IkVzvDBUvJC7+B/cH6iuVcZBcJ4ecr2Pn/1nN
 YSWyUnJKli+QDrNyQO7EotGYPKA4hns0IIrz2hfbYqEOStMGKPyGOn8w4SH+OK9tf8DG
 akKhoKdV3nsioXIR0LPihQDFT0iV9LSQ/DBKenKqp13vjk7a+I7NuJgc6uX84l3CN2zm
 zg5C+lFLS5SPywdIw6eVY+GsoQ/FbXZkxHUDVOLVlxdsETLxrWHZO+xFzhUfay/MJVXi VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1trtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:44:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OCCE7B003765;
        Mon, 24 Jul 2023 13:44:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3ekef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVOgm2iJVr+baVAJhkBujjjd/7jk8IJFy3X0QrMlEGo1rX3TBdaZc2+TH9l+y6CzJIFSvMSZphkOeXhwoNl7qTynYR2VDwA1WMMMejiMrwukngVzanzeBwZ75VvnhgshZFhWW1SRqujI1nGN30LjcvaZAaslSHV8S/3VnHA/83OxnQ+h6c0xaqUMWEfo9vSG5CYCiWIDXLDfU/ANwFKHF38ZTPaYDvIbU9ZVnZbKLe4qAfCrj3gIEyyRDo2sM3QsOeNMA9ReZELc0KCLbMVmNrRjfCL9JFhU6LlqhhU0irt8ywQl7GZJm+MgDllMgvAKUA/SZwQE8FLztulUtKFgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRZMgkCDZ13hzNDKrhzpERAj3+WkBbpe5SjQ63ADeIo=;
 b=Mcd2/+1YkMZWIHMk512QUNNRd3BQorFgtafSz8fKNr/PlQBf0eH4Hv3FJQiBEUBolCQ5bBvBR6mDnnVDHp/25rorj//SPfGD/CTtKyltAPWCD1rqaSoIQE2fnM4A9O9OKgf0S4cLJys4ucqEn8iRiS1XySuvRf8oGDGn84JJMdu/V6WF1hx63/VarVXjOcO9l+H/ysDSM1X56FhT3Tnpud4QlGPfG31yZcO7EWwkJsqdGh3MuL92yU6ORMdCMQfyYEoVG0Mmjf0lB3v7ILsNuP/fEH3o58pCteTG3SJEDZzoHh3allrEy+ueVdQHI85qFrc4YB0FweGLqeh7Si2wBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRZMgkCDZ13hzNDKrhzpERAj3+WkBbpe5SjQ63ADeIo=;
 b=or4QH42tovaMyh0Gx696Im2nRPvcd319EgU2V2e2RQGsgEKskJz1XEj4fvahXit2ca+QRyFnROq8FIM7gliOI3GiJt9vSUnnOe7eNeIllnNt2xBax5b31DIxy1Tp9SvkCY4k2Far654y/eSPH+iTOx0sI4Avi1kPM/2sY3DJAl4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6916.namprd10.prod.outlook.com (2603:10b6:208:430::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 13:44:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:44:16 +0000
Date:   Mon, 24 Jul 2023 09:44:10 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek@diasemi.com>
Subject: Re: [PATCH v2] nfsd: inherit required unset default acls from
 effective set
Message-ID: <ZL6AKlkloZQwlmPG@tissot.1015granger.net>
References: <20230724-nfsd-acl-v2-1-1cfaac973498@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724-nfsd-acl-v2-1-1cfaac973498@kernel.org>
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 1725ab79-cec1-4183-8477-08db8c4c12d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWrfEkELoSJdchlHZK7Kkq9Pl7RxDDIoL0nGPrJnKw1kQArpAFzwjxtOqjaApngWkfvN5PIHF3YjwNrTplKrug1yWeJ7CvD0/OzO2yzFMGVo85bsslVfLUroeM5/RRrf2CxHP7YqsPEsiuFxBKz9EX4qTujvu5QqQI8Gv49oZW8IvEXarHwKrcuU31cV0vFfa95IaTD0KO1377arvL9Z0V/fdj8hmArcJ3NoTQ4heW721UI//QXSLZCQrThP9vAnt2k+IsRFSiNxKuZlTw1CiZP7RznHMHoRnLQRLpoWk4UJOFruQS6Z+LkDhc0wTmoob3pnxLDe9DZEkdsFkNs/inB2pijYwQQpLBzWgbYKeb8qEtpumbW8Vr4dJxhHx6KSkn/JVZraFlX5gs3nIGHJrfd1ob0gwIxppLi9MQM4yi990NXaryijmDu5c4p5wnr2ldK27BDl6DifuJWVYVE0+VU0kFsvroWwxXXEQYG+TcRxI0bNOlcjghI2V+6Dk9YLR0ptoPC9Pl8WQ27HN+oodsDt/mIBbo0JRbBts983hJ+sKF/8oL1Y8fa5r7jp549/hT4JNH6H7k3WaNT6EHNntw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(38100700002)(83380400001)(44832011)(8676002)(8936002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(26005)(186003)(6506007)(966005)(6486002)(6666004)(6512007)(9686003)(66476007)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PuAdjjBEKTtiKypNAN9FUqGJkOj74B5pwTuyLCDb5Jqy8NBJey9hSAGks0Yw?=
 =?us-ascii?Q?16NVKPLePeECaghL9c/b7vginQ8JwJuUUA/gooPV2pTg6nv6CamzSYTO/CTi?=
 =?us-ascii?Q?oBqfj/UprBAS8GfcmmD993dpsJmWkdmgNFdrSGNxJE8OZI0dr9KQ/jEeKRbv?=
 =?us-ascii?Q?tSCT39K4gmwmf4hR1urQvGYryECMpsvLf+BtcHWBn3BYl4kSI8ye1C7yXmAA?=
 =?us-ascii?Q?S+r/3ukBNuh07mJOYna/iPFMylFRNqZYS1h38Ih9eJ+C2FnOCpTal9eMXFRq?=
 =?us-ascii?Q?BGqQ7+8tF1jv7xILo2FOjpElGbIF4t1SFZcq4qHWiYIzdgTa2HOeSLtrrdoG?=
 =?us-ascii?Q?ZchXj3knjX+rDNCqH6kWG2Do5q+RUpaCkeMY/TIaca6vNpmduFs4I154a0eh?=
 =?us-ascii?Q?QDtARJFSA0++vZXMLqG0+Y8ZAZvEYcaDDp+hxKEHZQDu5zSGFSo+5hCmtgxB?=
 =?us-ascii?Q?06VU4zsCPY+cbxEm5cFoHBzhcrrXGsQ8uFRe69+mWXHL5r11xitBaU7xvs0x?=
 =?us-ascii?Q?aqz4fNWyoVOh50Vh8qATegYPJDvpEbHuYOHQFR894iK/8bcp9iq8Y/8gsha7?=
 =?us-ascii?Q?1Yb4Y6WRLrN8vnBDu/ofG+n/7oq2D76WNDpZJf9nAD7jyX76uCCoxGMn8G5r?=
 =?us-ascii?Q?3mx198oKOYk/KNe4YZJ8xtDEAJrKw83lhwBxLFbFbfGKOPYzM8JBzZNZqBHQ?=
 =?us-ascii?Q?TpCs1QLW/jhRPzfUKm5gmeZ0TqlKfYdoOQuh/eQ1bAe6ZfbMy8f6t148Ladk?=
 =?us-ascii?Q?60wY/bTo79fJQfKAnhck94i8nWtAOSxosnPoyY5hbptLljhJdv3Vxm145lj/?=
 =?us-ascii?Q?QTXZgo3dutolnJ7FRmm4Zy4WUWaW+mhKjysIV+qAJdMaLBI6i42mZMfb/8Yr?=
 =?us-ascii?Q?qVgfgU4+2gXPM2mkdEcgH95Gg/ta4QLJM7uA+68eWbn2nb61FwrxQa6h3SBM?=
 =?us-ascii?Q?TOoGfe/lcnomx7yBdMu9S29ejQ5xD+5RcunuhX6eq+HZCVZlRxqzG5lU4CO6?=
 =?us-ascii?Q?lfp3CFomtlZbv6ls+bIxcsztJi7a2ZmYss/jdcd2KuLUejWq6utQy+sODdr7?=
 =?us-ascii?Q?f+LkLp60lTVO9cM1vGyFxDwcy2R+a7SJsvz808Udypl4L8I6tS5ezz6+aAtO?=
 =?us-ascii?Q?NCafHYpPZgn2xt60AyNKlOtTB/awS1czezQRbZxy5h+RGYkvM4Rus6lTXhzs?=
 =?us-ascii?Q?vffgUyv2Ni9AkOIVAhydITQ/mtWtZpWskac8buDp9S9sEjJe3gvO1y5ynIx5?=
 =?us-ascii?Q?0hZ24JuPpHDmoJWRzXcB5CUSyte2fll6Rhwl2uE9+eiPdTRAy89aMo2b4MGK?=
 =?us-ascii?Q?zBQWKoK6/oQORAchtnz793s1JhuYD+d6NpZ4VsQxTE798t/+Gj5QT9VKul30?=
 =?us-ascii?Q?5JYmtE8ojSH81o60FC0tMdgJjSOnexzUUPbzs621bsBXS0O5SCp4zfcMHOmv?=
 =?us-ascii?Q?pEdamO+1ePlCT4wEbQ8VYt+sUID4PmObWxau3z66I3IZvG4p+SD2TFu/cQZ1?=
 =?us-ascii?Q?u3Lg9XxOEVogeMQL/KKho55MyAMWmMPV6pJbG9V3DslXzAJ4KVKLbXyHiRPI?=
 =?us-ascii?Q?LdCEG5NVGNxo3GIgQ6CGPqZoYtYDDNUL9/JRoObV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eIAhGYrSb+2V7Ubz7sfYonfYmpEWlKpVxC3aAcO+z+Fg+QUJPJ7YSQsNUDjk?=
 =?us-ascii?Q?a3zEBT8E2T4oRfoGWIi2y22QRIYI8Rp8zQSpF54Aqw4DGS4G0eZQYM/otwV6?=
 =?us-ascii?Q?/wgawLN5XMYmrBZYqZhAzppHcLkktBVhiHdTCzjC2FjF3qd8gKpepk+544aS?=
 =?us-ascii?Q?1DGonV+QiZSfJjyZtbu8GgbFg9Kit/9+iXkvcd4rq3nnze2yqwrbKSRG+c/e?=
 =?us-ascii?Q?M5ZsgdjVmwA1MQBbzbensoVrY+m0v+azce43Lj/rHV38JP3IaJCiNnSeFSy+?=
 =?us-ascii?Q?pl3+ZC6rdoym/CPl8hwdlq/V707kaqjODsI+unkgRGA8nqL0DIjhfxdP/Nku?=
 =?us-ascii?Q?uVk6UHy1feaSb8SumuUTpumn8oeI3O3APBJoygLV6wwfjavbOzuGv/f09Hia?=
 =?us-ascii?Q?wM7MJOyCvDtiv7a8fF9NwA+55bwhHdveQcxxA8stCIy47a/yCSss+0eu2lrR?=
 =?us-ascii?Q?U7cuwQG6d/h1cxJm31SXd2uf2gnA53px7zHgmdE5/zHJ4kjbABACWD8LxVwh?=
 =?us-ascii?Q?McX1TZxUogy79bjLN71A9vSVh0rHy9sggt3w+VZPvHW+vvzb5y5DBPQraQby?=
 =?us-ascii?Q?fRv8/CR1eyUh2QOAgAVOMhczSpIDr+UoAcsLAa+HH4Tug44iFrcON4U3ELjf?=
 =?us-ascii?Q?rYj/jfw1dEMbT9Fn5nY4IjxcOqU7aH3KxwJn5EsIiIirL1ddtgQK77tHLyr0?=
 =?us-ascii?Q?M7wMnRn5IC6xD6KOud937qDbLFcnlETlubYlYfE8RzyDxKNSahGnZ9xHZlaS?=
 =?us-ascii?Q?OBCDvaMSoS+ycXCz4Qklc9sIYvmBptXxMAswoqTH0puuj1JAZypckeimGHCk?=
 =?us-ascii?Q?d+AmvWO6uEmQmwg0YEZId3yPC3qVvbJsOZUzqebpOd6yEqedWLSW5xIJA63f?=
 =?us-ascii?Q?5UgcxL90ZOt5jC7qISA6KTrD8ch35UziYt4v8HKkhMdrK3ditP89bxkf2bjR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1725ab79-cec1-4183-8477-08db8c4c12d3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:44:16.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3skL1ov7CuSNitgWzZzIHEJjnlOIR4klnqGyxUWA3NwUUYyUaTn8f6Cbon2fCzj/fMteJyAm0N9sgwlfA3MCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_10,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240121
X-Proofpoint-GUID: b4u9aP5L-_KJk2Jn7qbsR2xIJOmaHWZv
X-Proofpoint-ORIG-GUID: b4u9aP5L-_KJk2Jn7qbsR2xIJOmaHWZv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:13:05AM -0400, Jeff Layton wrote:
> A well-formed NFSv4 ACL will always contain OWNER@/GROUP@/EVERYONE@
> ACEs, but there is no requirement for inheritable entries for those
> entities. POSIX ACLs must always have owner/group/other entries, even for a
> default ACL.
> 
> nfsd builds the default ACL from inheritable ACEs, but the current code
> just leaves any unspecified ACEs zeroed out. The result is that adding a
> default user or group ACE to an inode can leave it with unwanted deny
> entries.
> 
> For instance, a newly created directory with no acl will look something
> like this:
> 
> 	# NFSv4 translation by server
> 	A::OWNER@:rwaDxtTcCy
> 	A::GROUP@:rxtcy
> 	A::EVERYONE@:rxtcy
> 
> 	# POSIX ACL of underlying file
> 	user::rwx
> 	group::r-x
> 	other::r-x
> 
> ...if I then add new v4 ACE:
> 
> 	nfs4_setfacl -a A:fd:1000:rwx /mnt/local/test
> 
> ...I end up with a result like this today:
> 
> 	user::rwx
> 	user:1000:rwx
> 	group::r-x
> 	mask::rwx
> 	other::r-x
> 	default:user::---
> 	default:user:1000:rwx
> 	default:group::---
> 	default:mask::rwx
> 	default:other::---
> 
> 	A::OWNER@:rwaDxtTcCy
> 	A::1000:rwaDxtcy
> 	A::GROUP@:rxtcy
> 	A::EVERYONE@:rxtcy
> 	D:fdi:OWNER@:rwaDx
> 	A:fdi:OWNER@:tTcCy
> 	A:fdi:1000:rwaDxtcy
> 	A:fdi:GROUP@:tcy
> 	A:fdi:EVERYONE@:tcy
> 
> ...which is not at all expected. Adding a single inheritable allow ACE
> should not result in everyone else losing access.
> 
> The setfacl command solves a silimar issue by copying owner/group/other
> entries from the effective ACL when none of them are set:
> 
>     "If a Default ACL entry is created, and the  Default  ACL  contains  no
>      owner,  owning group,  or  others  entry,  a  copy of the ACL owner,
>      owning group, or others entry is added to the Default ACL.
> 
> Having nfsd do the same provides a more sane result (with no deny ACEs
> in the resulting set):
> 
> 	user::rwx
> 	user:1000:rwx
> 	group::r-x
> 	mask::rwx
> 	other::r-x
> 	default:user::rwx
> 	default:user:1000:rwx
> 	default:group::r-x
> 	default:mask::rwx
> 	default:other::r-x
> 
> 	A::OWNER@:rwaDxtTcCy
> 	A::1000:rwaDxtcy
> 	A::GROUP@:rxtcy
> 	A::EVERYONE@:rxtcy
> 	A:fdi:OWNER@:rwaDxtTcCy
> 	A:fdi:1000:rwaDxtcy
> 	A:fdi:GROUP@:rxtcy
> 	A:fdi:EVERYONE@:rxtcy
> 
> Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2136452
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - always set missing ACEs whenever default ACL has any ACEs that are
>   explicitly set. This better conforms to how setfacl works.
> - drop now-unneeded "empty" boolean
> - Link to v1: https://lore.kernel.org/r/20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org
> ---
>  fs/nfsd/nfs4acl.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index 518203821790..b931d4383517 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -441,7 +441,7 @@ struct posix_ace_state_array {
>   * calculated so far: */
>  
>  struct posix_acl_state {
> -	int empty;
> +	unsigned char valid;
>  	struct posix_ace_state owner;
>  	struct posix_ace_state group;
>  	struct posix_ace_state other;
> @@ -457,7 +457,6 @@ init_state(struct posix_acl_state *state, int cnt)
>  	int alloc;
>  
>  	memset(state, 0, sizeof(struct posix_acl_state));
> -	state->empty = 1;
>  	/*
>  	 * In the worst case, each individual acl could be for a distinct
>  	 * named user or group, but we don't know which, so we allocate
> @@ -500,7 +499,7 @@ posix_state_to_acl(struct posix_acl_state *state, unsigned int flags)
>  	 * and effective cases: when there are no inheritable ACEs,
>  	 * calls ->set_acl with a NULL ACL structure.
>  	 */
> -	if (state->empty && (flags & NFS4_ACL_TYPE_DEFAULT))
> +	if (!state->valid && (flags & NFS4_ACL_TYPE_DEFAULT))
>  		return NULL;
>  
>  	/*
> @@ -622,9 +621,10 @@ static void process_one_v4_ace(struct posix_acl_state *state,
>  				struct nfs4_ace *ace)
>  {
>  	u32 mask = ace->access_mask;
> +	short type = ace2type(ace);
>  	int i;
>  
> -	state->empty = 0;
> +	state->valid |= type;
>  
>  	switch (ace2type(ace)) {

Mechanical issue: the patch adds @type, but uses it just once.
The switch here also wants the value of ace2type(ace).


>  	case ACL_USER_OBJ:
> @@ -726,6 +726,30 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
>  		if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
>  			process_one_v4_ace(&effective_acl_state, ace);
>  	}
> +
> +	/*
> +	 * At this point, the default ACL may have zeroed-out entries for owner,
> +	 * group and other. That usually results in a non-sensical resulting ACL
> +	 * that denies all access except to any ACE that was explicitly added.
> +	 *
> +	 * The setfacl command solves a similar problem with this logic:
> +	 *
> +	 * "If  a  Default  ACL  entry is created, and the Default ACL contains
> +	 *  no owner, owning group, or others entry,  a  copy of  the  ACL
> +	 *  owner, owning group, or others entry is added to the Default ACL."
> +	 *
> +	 * Copy any missing ACEs from the effective set, if any ACEs were
> +	 * explicitly set.
> +	 */
> +	if (default_acl_state.valid) {
> +		if (!(default_acl_state.valid & ACL_USER_OBJ))
> +			default_acl_state.owner = effective_acl_state.owner;
> +		if (!(default_acl_state.valid & ACL_GROUP_OBJ))
> +			default_acl_state.group = effective_acl_state.group;
> +		if (!(default_acl_state.valid & ACL_OTHER))
> +			default_acl_state.other = effective_acl_state.other;
> +	}
> +
>  	*pacl = posix_state_to_acl(&effective_acl_state, flags);
>  	if (IS_ERR(*pacl)) {
>  		ret = PTR_ERR(*pacl);
> 
> ---
> base-commit: 7bfb36a2ee1d329a501ba4781db4145dc951c798
> change-id: 20230719-nfsd-acl-5ab61537e4e6
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever
